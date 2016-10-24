package com.wangfj.edi.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.URI;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.DateUtils;
import com.utils.StringUtils;
import com.wangfj.edi.bean.Member;
import com.wangfj.edi.bean.MemberInfo;
import com.wangfj.edi.util.HttpUtils;
import com.wangfj.edi.util.PropertiesUtil;
import com.wangfj.edi.util.RequestUtils;
import com.wangfj.order.controller.OmsOrderController;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/ediOrder")
public class EdiOrderController {
	
private static final Logger logger = LoggerFactory.getLogger(EdiOrderController.class);
	
	public static final String FROM_SYSTEM = "ORDERBACK";
	/**
	 * 查询订单信息（带分页）
	 * @Methods Name selectOrderList
	 * @Create In 2016-01-21 By dingjf
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderList")
	public String selectOrderList(String status,String tradesource,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String json1 = "";
		Integer pageSize = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currentPage = Integer.parseInt(request.getParameter("page"));
		if(pageSize==null || pageSize==0){
			pageSize = 15;
		}
		int start = (currentPage-1)*pageSize;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("tid", request.getParameter("tid"));
		paramMap.put("ispreSale", request.getParameter("ispreSale"));
		paramMap.put("ordersId", request.getParameter("ordersId"));
		paramMap.put("receiverName", request.getParameter("receiverName"));
		paramMap.put("title", request.getParameter("title"));
		paramMap.put("tradesource", tradesource);
		paramMap.put("receiverMobile", request.getParameter("receiverMobile"));
		paramMap.put("symbol", request.getParameter("symbol"));
		paramMap.put("totalAmount", request.getParameter("totalAmount"));
		
		if(request.getParameter("exceptionType") != null && request.getParameter("exceptionType") != ""){
			paramMap.put("exceptionType", request.getParameter("exceptionType"));
		}
		
		
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		
		if(request.getParameter("status")!=null||request.getParameter("status")!=""){
		paramMap.put("status",request.getParameter("status"));
		}else{
		paramMap.put("status",status);
		System.out.println(status+">>>>>>>>>>>status");
		}
		paramMap.put("startDate", request.getParameter("startDate"));
		paramMap.put("endDate", request.getParameter("endDate"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		Map<Object, Object> orderVo = new HashMap<Object, Object>();
		String tid=request.getParameter("tid");
		String action = request.getParameter("action");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			orderVo.put("orderVo", jsonStr);
			logger.info("jsonStr:" + jsonStr);
			
			if(tid !=null && tid!="" && "obtain".equals(action)){
				String url1=	(String) PropertiesUtil.getContextProperty("edi_order_catch")+tid;
				json1 =HttpUtilPcm.doPost(url1, jsonStr);
				System.out.println(json1);
			}
			
			String url=	(String) PropertiesUtil.getContextProperty("edi_order");
			paramMap.put("currentPage", currentPage);
			paramMap.put("pageSize", pageSize);
			JSONObject jo = JSONObject.fromObject(paramMap);
			json =HttpUtilPcm.doPost(url, jo.toString());
			logger.info("json:" + json);
			paramMap.clear();
			if (!"".equals(json)) {
				JSONObject jsonPage = JSONObject.fromObject(json);
				if (jsonPage != null) {
					paramMap.put("list", jsonPage.get("list"));
					paramMap.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0) : jsonPage.get("pages"));
				} else {
					paramMap.put("list", null);
					paramMap.put("pageCount", Integer.valueOf(0));
				}
			} else {
				paramMap.put("list", null);
				paramMap.put("pageCount", Integer.valueOf(0));
			}
		} catch (Exception e) {
			paramMap.put("pageCount", Integer.valueOf(0));
		}
		
		String js = (String) PropertiesUtil.getContextProperty("log_js");
		paramMap.put("logJs", js);
		
		String url = (String) PropertiesUtil.getContextProperty("memberUrl")+CookiesUtil.getUserName(request);
		String s = HttpUtils.HttpdoGet(url);
		JSONObject obj = JSONObject.fromObject(s);
	
		Map<String, Class<Member>> classMap = new HashMap<String, Class<Member>>();
		classMap.put("data", Member.class);
		MemberInfo memberInfo = (MemberInfo) JSONObject.toBean(obj, MemberInfo.class,classMap);
		if(StringUtils.isNotEmpty(memberInfo.getSuccess())){
			if(memberInfo.getSuccess()=="true"){
				paramMap.put("memberInfo", memberInfo.getData().get(0).getSysValue());
			}
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println(gson.toJson(paramMap));
		return gson.toJson(paramMap);
	}
	/**
	 * 查询订单信息（带分页）
	 * @Methods Name selectOrderList
	 * @Create In 2016-01-21 By dingjf
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderCatchList")
	public String selectOrderCatchList(String status,String tradesource,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String json1="";
		Integer pageSize = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currentPage = Integer.parseInt(request.getParameter("page"));
		if(pageSize==null || pageSize==0){
			pageSize = 15;
		}
		int start = (currentPage-1)*pageSize;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("tid", request.getParameter("tid"));
		paramMap.put("skuid", request.getParameter("skuid"));
		paramMap.put("tradesource", tradesource);
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		Map<Object, Object> m = new HashMap<Object, Object>();
		Map<Object, Object> orderVo = new HashMap<Object, Object>();
		String tid=request.getParameter("tid");
		String skuid=request.getParameter("skuid");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			orderVo.put("orderVo", jsonStr);
			logger.info("jsonStr:" + jsonStr);
			if(tid !=null && tid!=""){
				String url1=	(String) PropertiesUtil.getContextProperty("edi_order_catch")+tid;
				json1 =HttpUtilPcm.doPost(url1, jsonStr);
				System.out.println(json1);
			}
			String url=	(String) PropertiesUtil.getContextProperty("edi_order");
			paramMap.put("currentPage", currentPage);
			paramMap.put("pageSize", pageSize);
			JSONObject jo = JSONObject.fromObject(paramMap);
			
			json =HttpUtilPcm.doPost(url, jo.toString());
			logger.info("json:" + json);
			paramMap.clear();
			if (!"".equals(json)) {
				JSONObject jsonPage = JSONObject.fromObject(json);
				if (jsonPage != null) {
					paramMap.put("list", jsonPage.get("list"));
					paramMap.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0) : jsonPage.get("pages"));
				} else {
					paramMap.put("list", null);
					paramMap.put("pageCount", Integer.valueOf(0));
				}
			} else {
				paramMap.put("list", null);
				paramMap.put("pageCount", Integer.valueOf(0));
			}
		} catch (Exception e) {
			paramMap.put("pageCount", Integer.valueOf(0));
		}
		
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}
		String js = (String) PropertiesUtil.getContextProperty("log_js");
		paramMap.put("logJs", js);
		
		String url = (String) PropertiesUtil.getContextProperty("memberUrl")+CookiesUtil.getUserName(request);;
		String s = HttpUtils.HttpdoGet(url);
		JSONObject obj = JSONObject.fromObject(s);
	
		Map<String, Class<Member>> classMap = new HashMap<String, Class<Member>>();
		classMap.put("data", Member.class);
		MemberInfo memberInfo = (MemberInfo) JSONObject.toBean(obj, MemberInfo.class,classMap);
		
		if(StringUtils.isNotEmpty(memberInfo.getSuccess())){
			if(memberInfo.getSuccess()=="true"){
				paramMap.put("memberInfo", memberInfo.getData().get(0).getSysValue());
			}
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println(gson.toJson(paramMap));
		return gson.toJson(paramMap);
	}
	
	/**
	 * 查询订单明细
	 * @Methods Name selectOrderItemList
	 * @Create In 2016-01-21 By dingjf
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderItemList")
	public String selectOrderItemList(String tid,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("tid", tid);
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=	(String) PropertiesUtil.getContextProperty("edi_order_findChild");
			json = HttpUtilPcm.doPost(url, jsonStr);
			logger.info("json:" + json);
		/*	JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>)jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}*/
			if (!"".equals(json)) {
				JSONObject jsonPage = JSONObject.fromObject(json);
				if (jsonPage != null) {
					paramMap.put("list", jsonPage.get("list"));
				} else {
					paramMap.put("list", null);
				}
			} else {
				paramMap.put("list", null);
			}
		} catch (Exception e) {
			m.put("success", "false");
			e.printStackTrace();
		}
		String js = (String) PropertiesUtil.getContextProperty("log_js");
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}
		paramMap.put("logJs", js);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println(gson.toJson(paramMap));
		return gson.toJson(paramMap);
	}
	
	
	/**
	 * 导出excel
	 * @Methods Name selectRefundApplyList
	 * @Create In 2016-01-21 By dingjf
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/exportExcle")
	public String exportExcle(String status,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String secertFlag = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		paramMap.put("tid", request.getParameter("tid"));
		paramMap.put("ordersId", request.getParameter("ordersId"));
		paramMap.put("receiverName", request.getParameter("receiverName"));
		paramMap.put("title", request.getParameter("title"));
		paramMap.put("tradesource", request.getParameter("tradesource"));
		
		paramMap.put("symbol", request.getParameter("symbol"));
		paramMap.put("totalAmount", request.getParameter("totalAmount"));

		if(request.getParameter("status")!=null||request.getParameter("status")!=""){
		paramMap.put("status",request.getParameter("status"));
		}else{
		paramMap.put("status",status);
		System.out.println(status+">>>>>>>>>>>status");
		}
		paramMap.put("startDate", request.getParameter("startDate"));
		paramMap.put("endDate", request.getParameter("endDate"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		Map<Object, Object> orderVo = new HashMap<Object, Object>();
		
		String url1 = (String) PropertiesUtil.getContextProperty("memberUrl")+CookiesUtil.getUserName(request);
		String s = HttpUtils.HttpdoGet(url1);
		JSONObject obj = JSONObject.fromObject(s);
	
		Map<String, Class<Member>> classMap = new HashMap<String, Class<Member>>();
		classMap.put("data", Member.class);
		MemberInfo memberInfo = (MemberInfo) JSONObject.toBean(obj, MemberInfo.class,classMap);
		if(StringUtils.isNotEmpty(memberInfo.getSuccess())){
			if(memberInfo.getSuccess()=="true"){
				secertFlag = memberInfo.getData().get(0).getSysValue();
			}
		}
		
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			orderVo.put("orderVo", jsonStr);
			logger.info("jsonStr:" + jsonStr);
			String url=	(String) PropertiesUtil.getContextProperty("edi_order_export");
			json =HttpUtilPcm.doPost(url, jsonStr);
			String tradeSource = request.getParameter("tradesource");
			excelOrderDetailReport(json,tradeSource,secertFlag,request,response);
			logger.info("json:" + json);
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		return json;
	}
	
	/**
	 * 解除黑名单关系
	 * 
	 */
	@RequestMapping("/blacklistRemove")
	public void blacklistRemove(String tid,String channelCode,HttpServletRequest request, HttpServletResponse response) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		paramMap.put("tid", tid);
		paramMap.put("channel", channelCode);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url = "";
//			if("M4".equals(channelCode)){
//				url = (String) PropertiesUtil.getContextProperty("edi_blacklist_yzrelieve");
//			}else if("JM".equals(channelCode)){
//				url = (String) PropertiesUtil.getContextProperty("edi_blacklist_jmrelieve");
//			}else{
				url = (String) PropertiesUtil.getContextProperty("edi_blacklist_relieve");
//			}
			HttpUtilPcm.doPost(url, jsonStr);
		} catch (Exception e) {
			map.put("pageCount", 0);
			map.put("success", "false");
		}
	}
	
	/**
	 * 修改异常订单
	 * @Methods Name selectRefundApplyList
	 * @Create In 2016-01-21 By dingjf
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updatechild")
	public String updatechild(String status,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		paramMap.put("tid", request.getParameter("tid"));
		paramMap.put("oid", request.getParameter("oid"));
		paramMap.put("outerSkuId", request.getParameter("outerSkuId"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		Map<Object, Object> orderVo = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			orderVo.put("orderVo", jsonStr);
			logger.info("jsonStr:" + jsonStr);
			String url=	(String) PropertiesUtil.getContextProperty("edi_order_update");
			json =HttpUtilPcm.doPost(url, jsonStr);
			logger.info("json:" + json);
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		return json;
	}
	
	private void excelOrderDetailReport( String json, String tradeSource,String secertFlag, HttpServletRequest request,
			HttpServletResponse response) throws IOException, FileNotFoundException {
		List ordersDetailList = new ArrayList();

		if("C7" == tradeSource || "C7".equals(tradeSource)){
			tradeSource = "天猫";
		}else if("CA" == tradeSource || "CA".equals(tradeSource)){
			tradeSource = "爱逛街";
		}else if("CB" == tradeSource || "CB".equals(tradeSource)){
			tradeSource = "全球购";
		}else if("M4" == tradeSource || "M4".equals(tradeSource)){
			tradeSource = "有赞";
		}else if("C8" == tradeSource || "C8".equals(tradeSource)){
			tradeSource = "聚美";
		}
		
		if (!"".equals(json)) {
			JSONObject jsonPage = JSONObject.fromObject(json);
			if (jsonPage != null) {
				ordersDetailList = (List) jsonPage.get("list");
			}
		} 
		
		String fileName = "ediTmallOrders.xls";

		String outFile = tradeSource + "数据交互订单明细报表.xls";

		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(request.getRealPath("/") + fileName));
		HSSFSheet sheet = wb.getSheetAt(0);
		
		
		fillContent(ordersDetailList, sheet,secertFlag);
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		wb.write(byteArrayOutputStream);
		
		response.reset();
	    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
	    response.addHeader("Content-Disposition", "attachment;filename="
	        + new String(outFile.getBytes("gbk"), "iso-8859-1"));
	    response.setContentLength(byteArrayOutputStream.size());

	    ServletOutputStream outputstream = response.getOutputStream(); // 取得输出流
	    byteArrayOutputStream.writeTo(outputstream); // 写到输出流
	    byteArrayOutputStream.close(); // 关闭
	    outputstream.flush(); // 刷数据
	}
	
	private void fillContent(List ordersDetailList, HSSFSheet sheet,String secertFlag) {
		HSSFCellStyle style1 = sheet.getRow(2).getCell(0).getCellStyle();
		HSSFCellStyle style2 = sheet.getRow(2).getCell(2).getCellStyle();
		HSSFCellStyle style3 = sheet.getRow(2).getCell(4).getCellStyle();
		HSSFCellStyle dateStyle = sheet.getRow(2).getCell(6).getCellStyle();
		HSSFCellStyle partNumberStyle = sheet.getRow(2).getCell(7).getCellStyle();
		HSSFCellStyle descStyle = sheet.getRow(2).getCell(8).getCellStyle();
		HSSFCellStyle numStyle = sheet.getRow(2).getCell(9).getCellStyle();
		for (int i = 0; i < ordersDetailList.size(); i++) {
			Map<String, Object> map = (Map) ordersDetailList.get(i);
			String receiverName = "";
			String receiverMobile = "";
			String tid = map.get("tid") == null ? "" : map.get("tid").toString();
			String ordersid = map.get("ordersid") == null ? "" : map.get("ordersid").toString();
			if("1".equals(secertFlag)){
				receiverName = map.get("receiverName") == null ? "" : RequestUtils.hideSecret(map.get("receiverName").toString(),1,0);
				receiverMobile = map.get("receiverMobile") == null ? "" : RequestUtils.hideSecret(map.get("receiverMobile").toString(),3,4);
			}else{
				receiverName = map.get("receiverName") == null ? "" : map.get("receiverName").toString();
				receiverMobile = map.get("receiverMobile") == null ? "" : map.get("receiverMobile").toString();
			}
			
			String payment = map.get("payment") == null ? "" : map.get("payment").toString();
			String tradeStatus = map.get("tradeStatus") == null ? "" : map.get("tradeStatus").toString();
			String createDate = map.get("createDate") == null ? "" : map.get("createDate").toString();
			String outerSkuId = map.get("outerSkuId") == null ? "" : map.get("outerSkuId").toString();
			String title = map.get("title") == null ? "" : map.get("title").toString();
			String num = map.get("num") == null ? "" : map.get("num").toString();
			String payment1 = map.get("payment1") == null ? "" : map.get("payment1").toString();
			String logisticsNo = map.get("logisticsNo") == null ? "" : map.get("logisticsNo").toString();
			String logisticsCompany = map.get("logisticsCompany") == null ? "" : map.get("logisticsCompany").toString();

			HSSFRow row = sheet.createRow(i + 2);
			int currRow = row.getRowNum();
			row.setHeightInPoints(20);

			if (i != ordersDetailList.size() - 1) {
				Map<String, Object> nextMap = (Map) ordersDetailList.get(i + 1);
				String nextTid = nextMap.get("tid") == null ? "" : nextMap.get("tid").toString();
				if (tid.equals(nextTid)) {
					Region region0 = new Region(currRow, (short) 0, currRow + 1, (short) 0);
					Region region1 = new Region(currRow, (short) 1, currRow + 1, (short) 1);
					Region region2 = new Region(currRow, (short) 2, currRow + 1, (short) 2);
					Region region3 = new Region(currRow, (short) 3, currRow + 1, (short) 3);
					Region region4 = new Region(currRow, (short) 4, currRow + 1, (short) 4);
					Region region5 = new Region(currRow, (short) 5, currRow + 1, (short) 5);
					Region region6 = new Region(currRow, (short) 6, currRow + 1, (short) 6);
					sheet.addMergedRegion(region0);
					sheet.addMergedRegion(region1);
					sheet.addMergedRegion(region2);
					sheet.addMergedRegion(region3);
					sheet.addMergedRegion(region4);
					sheet.addMergedRegion(region5);
					sheet.addMergedRegion(region6);
				}
			}

			createCell(style1, tid, row, 0);
			createCell(style1, ordersid, row, 1);
			createCell(style2, receiverName, row, 2);
			createCell(style1, receiverMobile, row, 3);

			HSSFCell cell4 = row.createCell(4);
			cell4.setCellValue(Double.parseDouble(payment));
			cell4.setCellStyle(style3);

			createCell(style2, tradeStatus, row, 5);

			HSSFCell cell6 = row.createCell(6);
			cell6.setCellValue(DateUtils.formatStr2Date(createDate, "yyyy-MM-dd HH:mm:ss"));
			cell6.setCellStyle(dateStyle);

			createCell(partNumberStyle, outerSkuId, row, 7);
			createCell(descStyle, title, row, 8);
			createCell(numStyle, num, row, 9);

			HSSFCell cell10 = row.createCell(10);
			cell10.setCellValue(Double.parseDouble(payment1));
			cell10.setCellStyle(style3);

			createCell(style1, logisticsNo, row, 11);
			createCell(style1, logisticsCompany, row, 12);
		}
	}
	
	private void createCell(HSSFCellStyle style, String cellValue, HSSFRow row, int cellNum) {
		HSSFCell cell0 = row.createCell(cellNum);
		cell0.setCellValue(cellValue);
		cell0.setCellStyle(style);
	}
	
	
	/**
	 * 添加黑名单
	 * 
	 */
	@RequestMapping("/blacklistAdd")
	public void blacklistAdd(String tid,String channelCode,HttpServletRequest request, HttpServletResponse response) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		paramMap.put("tid", tid);
		paramMap.put("channel", channelCode);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url = "";

			url = (String) PropertiesUtil.getContextProperty("edi_blacklist_add");
			HttpUtilPcm.doPost(url, jsonStr);
		} catch (Exception e) {
			map.put("pageCount", 0);
			map.put("success", "false");
		}
	}
	
}
