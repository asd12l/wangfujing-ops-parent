package com.wangfj.edi.controller;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.edi.bean.ExcelField;
import com.wangfj.edi.bean.ExprotVo;
import com.wangfj.edi.bean.Member;
import com.wangfj.edi.bean.MemberInfo;
import com.wangfj.edi.util.HttpUtils;
import com.wangfj.edi.util.PropertiesUtil;
import com.wangfj.edi.util.RequestUtils;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/ediYzOrder")
public class EdiYzOrderController {

	private static final Logger logger = LoggerFactory.getLogger(EdiYzOrderController.class);
	
	private final static String[][] OS = new String[][] {
	      new String[] { "M", "待支付" },
	      new String[] { "C", "已支付" },
	      new String[] { "A", "已取消" },
	      new String[] { "S", "已出库" },
	      new String[] { "EA", "异常" },
	      new String[] { "EB", "异常" }
	};
	
	@ResponseBody
	@RequestMapping("/selectYzOrderCatchList")
	public String selectYzOrderCatchList(String status,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String json1="";
		Integer pageSize = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currentPage = Integer.parseInt(request.getParameter("page"));
		if(pageSize==null || pageSize==0){
			pageSize = 15;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		if(request.getParameter("tid") != null && request.getParameter("tid") != ""){
			paramMap.put("tid", request.getParameter("tid"));
		}
		if(request.getParameter("skuid") != null && request.getParameter("skuid") != ""){
			paramMap.put("skuid", request.getParameter("skuid"));
		}
		if(request.getParameter("ordersId") != null && request.getParameter("ordersId") != ""){
			paramMap.put("ordersId", request.getParameter("ordersId"));
		}
		if(request.getParameter("receiverName") != null && request.getParameter("receiverName") != ""){
			paramMap.put("receiverName", request.getParameter("receiverName"));
		}
		if(request.getParameter("receiverMobile") != null && request.getParameter("receiverMobile") != ""){
			paramMap.put("receiverMobile", request.getParameter("receiverMobile"));
		}
		if(request.getParameter("goodName") != null && request.getParameter("goodName") != ""){
			paramMap.put("goodName", request.getParameter("goodName"));
		}
		if(request.getParameter("status") != null && request.getParameter("status") != ""){
			paramMap.put("status", request.getParameter("status"));
			paramMap.put("tradeStatus", request.getParameter("status"));
		}
		
		paramMap.put("symbol", request.getParameter("symbol"));
		paramMap.put("amount", request.getParameter("amount"));
		
		if(request.getParameter("exceptionType") != null && request.getParameter("exceptionType") != ""){
			paramMap.put("exceptionType", request.getParameter("exceptionType"));
		}
		
		if(request.getParameter("amount") != null && request.getParameter("amount") != ""){
			paramMap.put("amount", request.getParameter("amount"));
		}
		if(request.getParameter("startDate") != null && request.getParameter("startDate") != ""){
			paramMap.put("startDate", request.getParameter("startDate"));
		}
		if(request.getParameter("endDate") != null && request.getParameter("endDate") != ""){
			paramMap.put("endDate", request.getParameter("endDate"));
		}
		Map<Object, Object> orderVo = new HashMap<Object, Object>();
		String tid=request.getParameter("tid");
		@SuppressWarnings("unused")
		String skuid=request.getParameter("skuid");
		String action = request.getParameter("action");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			orderVo.put("orderVo", jsonStr);
			logger.info("jsonStr:" + jsonStr);
			if(!"query".equals(action)){
				if(tid !=null && tid!=""){
					String url1 =(String) PropertiesUtil.getContextProperty("edi_yz_order_catch")+tid;
					json1 =HttpUtilPcm.doPost(url1, jsonStr);
					System.out.println(json1);
				}
			}
			
			if(StringUtils.isNotEmpty(json1)){
				JSONObject json1Reulst = JSONObject.fromObject(json1);
				if((Boolean) json1Reulst.get("success")){
					tid=(String) json1Reulst.get("msg");
					paramMap.put("tid", tid);
				}
			}
			
			String url =(String) PropertiesUtil.getContextProperty("edi_yz_order");
			
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
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}
		paramMap.put("logJs", js);
		//添加隐藏私密信息
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
	
	@ResponseBody
	@RequestMapping(value = "/exportExcleYz")
	public void exportExcleYz(HttpServletRequest request, HttpServletResponse response) {
		
		String json = "";
		String title = "有赞数据交互订单明细报表";
		String jsons = "";
		List<ExprotVo> epv = new ArrayList<ExprotVo>();
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		if(request.getParameter("tid") != null && request.getParameter("tid") != ""){
			paramMap.put("tid", request.getParameter("tid"));
		}
		if(request.getParameter("skuid") != null && request.getParameter("skuid") != ""){
			paramMap.put("skuid", request.getParameter("skuid"));
		}
		if(request.getParameter("ordersId") != null && request.getParameter("ordersId") != ""){
			paramMap.put("ordersId", request.getParameter("ordersId"));
		}
		if(request.getParameter("receiverName") != null && request.getParameter("receiverName") != ""){
			paramMap.put("receiverName", request.getParameter("receiverName"));
		}
		if(request.getParameter("goodName") != null && request.getParameter("goodName") != ""){
			paramMap.put("goodName", request.getParameter("goodName"));
		}
		if(request.getParameter("status") != null && request.getParameter("status") != ""){
			paramMap.put("status", request.getParameter("status"));
			paramMap.put("tradeStatus", request.getParameter("status"));
		}
		
		paramMap.put("symbol", request.getParameter("symbol"));
		paramMap.put("amount", request.getParameter("amount"));
		
		if(request.getParameter("amount") != null && request.getParameter("amount") != ""){
			paramMap.put("amount", request.getParameter("amount"));
		}
		if(request.getParameter("startDate") != null && request.getParameter("startDate") != ""){
			paramMap.put("startDate", request.getParameter("startDate"));
		}
		if(request.getParameter("endDate") != null && request.getParameter("endDate") != ""){
			paramMap.put("endDate", request.getParameter("endDate"));
		}
		if(request.getParameter("count") != null && request.getParameter("count") != ""){
			paramMap.put("pageSize", request.getParameter("count"));
		}
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url =(String) PropertiesUtil.getContextProperty("edi_yz_order_export");
			
			json =HttpUtilPcm.doPost(url, jsonStr);
			JSONObject js = JSONObject.fromObject(json);
			Object objs = js.get("data");
			// 得到JSONArray
			JSONArray arr = JSONArray.fromObject(objs);
			if(arr.size()>0){
				for(int i=0;i<arr.size();i++){
					JSONObject jOpt = arr.getJSONObject(i);
					ExprotVo exportYzvo = (ExprotVo) JSONObject.toBean(jOpt,ExprotVo.class);
					epv.add(exportYzvo);
				}
			}	
			String result = allProSkusToExcel(response, epv, title);
			jsons = createSuccessResult(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return jsons;
	}
	
	public String allProSkusToExcel(HttpServletResponse response,List<ExprotVo> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("订单编号");
		header.add("EC订单编号");
		header.add("收货人");
		header.add("联系方式");
		header.add("订单金额(元)");
		header.add("状态");
		header.add("下单时间");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExprotVo vo:list){
			List<String> inlist = new ArrayList<String>();
				
			inlist.add(vo.getTid()==null?"":vo.getTid());			
			inlist.add(vo.getOrdersId()==null?"":vo.getOrdersId().toString());
			inlist.add(vo.getReceiverName()==null?"":RequestUtils.hideSecret(vo.getReceiverName(),1,0));
			inlist.add(vo.getReceiverMobile()==null?"":RequestUtils.hideSecret(vo.getReceiverMobile(),3,4));
			inlist.add(vo.getPayment()==null?"":vo.getPayment().toString());
			inlist.add(vo.getStatus()==null?"":getOrderStatus(vo.getStatus()));			
			inlist.add(vo.getCreateDate()==null?"":vo.getCreateDate());
			data.add(inlist);
		}
		ExcelField ef = new ExcelField(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			 response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			    response.addHeader("Content-Disposition", "attachment;filename="
			        + new String((title+".xls").getBytes("gbk"), "iso-8859-1"));
			//response.setContentType("APPLICATION/OCTET-STREAM"); 
			//response.setHeader("Content-disposition",
			//		"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	
	public String createSuccessResult(Object obj) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", "true");
		resultMap.put("obj", obj);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("/selectYzOrderItemList")
	public String selectOrderItemList(String tid,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}
		paramMap.put("tid", tid);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url =(String) PropertiesUtil.getContextProperty("edi_yz_order_findChild");
			json = HttpUtilPcm.doPost(url, jsonStr);
			logger.info("json:" + json);
			if (!"".equals(json)) {
				JSONObject jsonPage = JSONObject.fromObject(json);
				if (jsonPage != null) {
					m.put("list", jsonPage.get("list"));
				} else {
					m.put("list", null);
				}
			} else {
				m.put("list", null);
			}
			
		} catch (Exception e) {
			m.put("success", "false");
			e.printStackTrace();
		}
		String js = (String) PropertiesUtil.getContextProperty("log_js");
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			m.put("userName", CookiesUtil.getUserName(request));
		}else{
			m.put("userName", "");
		}
		m.put("logJs", js);
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        System.out.println(gson.toJson(m));
        return gson.toJson(m);
		
	}
	
	/**
	 * 修改异常订单
	 * @Methods Name updatechild
	 * @Create in 2016年3月15日11:02:35 hht
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
			String url =(String) PropertiesUtil.getContextProperty("edi_yz_order_update");
			
			json =HttpUtilPcm.doPost(url, jsonStr);
			logger.info("json:" + json);
		} catch (Exception e) {
			m.put("success", "false");
		}
		return json;
	}
	
	private String getOrderStatus(String sc) {
	    for (String[] ss : OS) {
	      if (ss[0].equals(sc)) {
	        return ss[1];
	      }
	    }
	    return sc;
	}
}
