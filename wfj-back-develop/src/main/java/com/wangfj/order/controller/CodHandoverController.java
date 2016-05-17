package com.wangfj.order.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.order.entity.CodHandover;
import com.wangfj.order.entity.RefundApply;
import com.wangfj.order.entity.RefundForExcel;
import com.wangfj.order.entity.Sale;
import com.wangfj.order.service.IExcelService;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.order.utils.HttpUtilForCore;
import com.wangfj.wms.util.ResultUtil;


@Controller
@RequestMapping("/cod")
public class CodHandoverController {
	private static Logger log =  LoggerFactory.getLogger(CodHandoverController.class);
	
	@Autowired
	@Qualifier("excelService")
	private IExcelService excelService;
	
	@ResponseBody
	@RequestMapping("/selectListByParam")
	public String selectOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_codHandover_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		log.info(json);
		return json;
	}

	/**
	 * 导出Excel
	 * @Methods Name exportExcel
	 * @Create In 2013-10-15 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/exportExcel")
	public String exportExcel(HttpServletRequest request, HttpServletResponse response) {

		String jsons = "";
		
		List<CodHandover> listCods = new ArrayList<CodHandover>();
		String title = "cod";
		try{
			String l;
				// 得到返回的String字符串
				l = this.selectOrder(request, response);
				// 对得到的Sting字符窜进行处理
				JSONObject js = JSONObject.fromObject(l);
				Object objs = js.get("list");
				// 得到JSONArray
				JSONArray arr = JSONArray.fromObject(objs);
				SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if(arr.size()>0){
					for (int i = 0; i < arr.size(); i++) {
						String jsonarr = arr.getString(i);
						JSONObject jsonobj = JSONObject.fromObject(jsonarr);
						CodHandover t = (CodHandover) JSONObject.toBean(jsonobj,
								CodHandover.class);
						if(jsonobj.containsKey("saleTime"))
							t.setSaleTime(s.parse(jsonobj.getString("saleTime")));
						if(jsonobj.containsKey("sendTime"))
							t.setSendTime(s.parse(jsonobj.getString("sendTime")));
						if(jsonobj.containsKey("confirmTime"))
							t.setConfirmTime(s.parse(jsonobj.getString("confirmTime")));
						if(jsonobj.containsKey("refundTime"))
							t.setRefundTime(s.parse(jsonobj.getString("refundTime")));
						if(jsonobj.containsKey("checkTime"))
							t.setCheckTime(s.parse(jsonobj.getString("checkTime")));
						if(jsonobj.containsKey("backMoneyTime"))
							t.setBackMoneyTime(s.parse(jsonobj.getString("backMoneyTime")));
						if(jsonobj.containsKey("printTime"))
							t.setPrintTime(s.parse(jsonobj.getString("printTime")));
						if(jsonobj.containsKey("backTime"))
							t.setBackTime(s.parse(jsonobj.getString("backTime")));
						if(jsonobj.containsKey("sendMoneyConfirmTime"))
							t.setSendMoneyConfirmTime(s.parse(jsonobj.getString("sendMoneyConfirmTime")));
						listCods.add(t);
					}
				}
			String result = excelService.exprtExcel(request,response,listCods,title);
			log.info(result);
			jsons = ResultUtil.createSuccessResult(result);
		}catch (Exception e) {
			System.out.println(e);
			jsons = ResultUtil.createFailureResult(e);
			return jsons;
		}
		return jsons;
	}
	@ResponseBody
	@RequestMapping("/exportSaleExcel")
	public String exportSaleExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		String doMethod = CommonProperties.get("query_select_sale_order_list_new");
		Map<String, String> paramMap = this.createParam(request);
		String resJson = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		
		List<Sale> list = new ArrayList<Sale>();
		String title = "";
		try{
			JSONObject resObject = JSONObject.fromObject(resJson);
			String listObject = resObject.getString("list");
			JSONArray resArr = JSONArray.fromObject(listObject);
			SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			if(resArr.size()>0){
				for (int i = 0; i < resArr.size(); i++) {
					JSONObject saleJson = resArr.getJSONObject(i);
//					没效果
//					String[] dateFormats = new String[] {"yyyy-MM-dd", "yyyy-MM-dd HH:mm:ss"};
//					JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher(dateFormats)); 
					Sale sale = (Sale) JSONObject.toBean(saleJson,
							Sale.class);
					if(saleJson.containsKey("draftTime"))
						sale.setDraftTime(s.parse(saleJson.getString("draftTime")));
					list.add(sale);
				}
			}
			String result = excelService.exprtExcel(response,list,title);
			jsons = ResultUtil.createSuccessResult(result);
		}catch (Exception e) {
			jsons = ResultUtil.createFailureResult(e);
			return jsons;
		}
		return jsons;
	}
	/**
	 * 导出退货单
	 * @Methods Name exportReturnExcel
	 * @Create In 2013-10-25 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/exportReturnExcel")
	public String exportReturnExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		String doMethod = CommonProperties.get("query_return_fin_list_byparam");
		Map<String, String> paramMap = this.createParam(request);
		String resJson = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		
		List<RefundForExcel> list = new ArrayList<RefundForExcel>();
		String title = "";
		title = request.getParameter("title");
		try{
			JSONObject resObject = JSONObject.fromObject(resJson);
			String listObject = resObject.getString("list");
			JSONArray resArr = JSONArray.fromObject(listObject);
			if(resArr.size()>0){
				for (int i = 0; i < resArr.size(); i++) {
					String returnJson = resArr.getString(i);
					
					JSONObject jsonobj = JSONObject.fromObject(returnJson);
					
					RefundForExcel refund = (RefundForExcel) JSONObject.toBean(jsonobj,
							RefundForExcel.class);
					list.add(refund);
				}
			}
			String result = excelService.exprtRefundExcel(response,list,title);
			log.info(result);
			jsons = ResultUtil.createSuccessResult(result);
		}catch (Exception e) {
			jsons = ResultUtil.createFailureResult(e);
			return jsons;
		}
		return jsons;
	}
	/**
	 * 导出
	 * @Methods Name exportRefundApplyExcel
	 * @Create In 2015-5-14 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/exportRefundApplyExcel")
	public String exportRefundApplyExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		String doMethod = CommonProperties.get("query_select_refund_apply_for_fin_list");
		Map<String, String> paramMap = this.createParam(request);
		String resJson = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		
		List<RefundApply> list = new ArrayList<RefundApply>();
		String title = "";
		title = request.getParameter("title");
		try{
			JSONObject resObject = JSONObject.fromObject(resJson);
			String listObject = resObject.getString("list");
			JSONArray resArr = JSONArray.fromObject(listObject);
			if(resArr.size()>0){
				for (int i = 0; i < resArr.size(); i++) {
					String returnJson = resArr.getString(i);
					
					JSONObject jsonobj = JSONObject.fromObject(returnJson);
					
					RefundApply refund = (RefundApply) JSONObject.toBean(jsonobj,
							RefundApply.class);
					list.add(refund);
				}
			}
			String result = excelService.exprtRefundApplyExcel(response,list,title);
			log.info(result);
			jsons = ResultUtil.createSuccessResult(result);
		}catch (Exception e) {
			jsons = ResultUtil.createFailureResult(e);
			return jsons;
		}
		return jsons;
	}
	@ResponseBody
	@RequestMapping(value={"/excelImport"},method={RequestMethod.POST})
	public String excelImport(HttpServletRequest request, HttpServletResponse response) {
		Map<String,Object> resMap = new HashMap<String, Object>();
		String json = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		resMap.put("success", false);
		if(isMultipart==true){
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<?> items = upload.parseRequest(request);
				Iterator iter = items.iterator(); 
				while (iter.hasNext()) { 
					String tempUrl=System.getProperty("user.home");
					FileItem item = (FileItem) iter.next(); 
					File fullFile = new File(tempUrl+"/"+item.getName());
					item.write(fullFile);
					List<CodHandover> list = this.getCodInfo(tempUrl+"/"+item.getName());
					resMap.put("list", list);
					resMap.put("success", true);
					json = ResultUtil.createSuccessResult(list);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value={"/checkMoney"},method={RequestMethod.POST})
	public String checkMoney(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String, String> paramMap = this.createParam(request);
		String data = paramMap.get("data");
		String[] dataArray = data.split(";");
		for(int i=0;i<dataArray.length;i++){
			String[] array = dataArray[i].split(",");
			if(array[0]!=null&&!array[0].isEmpty()){
				String reqStr = "{'fromSystem':'web','orderNo':'"+array[0]+"','sendMoneySum':"+array[2]+"}";
				String rsp =  HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), CommonProperties.get("check_money"), reqStr);
				if(rsp.isEmpty()){log.debug(array[0]+"订单对账失败");};
			}
		}
		json = "对账完成";
		return json;
	}
	@ResponseBody
	@RequestMapping(value={"/returnMoney"},method={RequestMethod.POST})
	public String returnMoney(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String, String> paramMap = this.createParam(request);
		String data = paramMap.get("data");
		String userName = paramMap.get("user");
		String[] dataArray = data.split(";");
		for(int i=0;i<dataArray.length;i++){
			String[] array = dataArray[i].split(",");
			if(array[0]!=null&&!array[0].isEmpty()){
				String reqStr = "{'fromSystem':'web','orderNo':'"+array[0]+"','backOptUser':'"+userName+"'}";
				String rsp =  HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), CommonProperties.get("return_money"), reqStr);
				if(rsp.isEmpty()){log.debug(array[0]+"订单回款失败");};
			}
		}
		json = "回款完成";
		return json;
	}
	private List<CodHandover> getCodInfo(String path){
		List<CodHandover> list = new ArrayList<CodHandover>();
		try {
			InputStream in = new FileInputStream(path);
			try {
				Workbook wb =null;
				if(path.endsWith("xls")) {
					wb = new HSSFWorkbook(in);//xls
				} else{
					wb = new XSSFWorkbook(in);//xlsx
				}
				Sheet hssfSheet = wb.getSheetAt(0);
				//遍历行
				for(int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++){  
					Row hssfRow = hssfSheet.getRow( rowNum);  
					if(hssfRow == null){  
						continue;
					}
					CodHandover codHandover = new CodHandover();
					Cell hssfCell = hssfRow.getCell(1);
					if(hssfCell==null) continue;
					String cellStr = hssfCell.getStringCellValue().trim();
					if(cellStr!=null&&!cellStr.trim().isEmpty()){
						codHandover.setOrderNo(hssfCell.getStringCellValue().trim());
						codHandover.setDelivetyNo(hssfRow.getCell(2).getStringCellValue().trim());
						codHandover.setSendMoneySum(hssfRow.getCell(3).getNumericCellValue());
						list.add(codHandover);
					}else{
						continue;
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return list;
	}

	private Map<String, String> createParam(HttpServletRequest request) {
		request.removeAttribute("_method");
		Map<String, String> paramMap = new HashMap<String, String>();
		Enumeration<String> enumeration = request.getParameterNames();
		while(enumeration.hasMoreElements()) {
			String paramStr = (String)enumeration.nextElement();
			paramMap.put(paramStr, request.getParameter(paramStr));
		}
		return paramMap;
	}
	private Date str2Date(String time){
		Date date = new Date();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(time!=null&&!time.isEmpty()){
			try {
				date = s.parse(time);
				return date;
			} catch (ParseException e) {
				return null;
			}
		}else{
			return null;
		}
	}
	
}
