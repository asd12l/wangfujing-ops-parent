package com.wangfj.order.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.util.HttpUtilPcm;

/**
 * 
 * @Comment	针对网站后台-销售-OMS订单管理
 * @Class Name OmsController
 * @Author tangysh
 * @Create In 2015-8-13
 */
@Controller
@RequestMapping("/oms")
public class OmsController {
	
	private static final Logger logger = LoggerFactory.getLogger(OmsController.class);
	
	public static final String FROM_SYSTEM = "ORDERBACK";
	
	/**
	 * 查询销售单信息（带分页）
	 * @Methods Name selectSaleList
	 * @Create In 2015-8-13 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectSaleList")
	public String selectSaleList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_sale_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			paramMap2.put("typeValue", "sale_status");
			jsonStr2 = JSON.toJSONString(paramMap2);
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_codelist_selectBox"), jsonStr2);
			logger.info("json2:" + json2);
			JSONObject jsonObjectJ2 = JSONObject.fromObject(json2);
			String codeData = jsonObjectJ2.getString("data");
			JSONArray json2Object = JSONArray.fromObject(codeData);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
//			for (int i = 0; i < json2Object.size(); i++) {
////				JSONObject jsonObject3 = JSONObject.fromObject(object2);
//				JSONObject jsonObject3 = (JSONObject) json2Object.get(i);
//				String codeValue = jsonObject3.getString("codeValue");
//				String codeName = jsonObject3.getString("codeName");
//				for (Object object : list) {
//					JSONObject jsonObject4 = JSONObject.fromObject(object);
//					String saleStatus = jsonObject4.getString("saleStatus");
//					if(saleStatus.equals(codeValue)){
//						saleStatus = codeName;
//						jsonObject4.put("saleStatusDesc",saleStatus);
////						object = JSONObject.toBean(jsonObject4, Object.class);
//						list3.add(jsonObject4);
//					}
//				}
//			}
			for(int i=0; i<list.size(); i++){
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String saleStatus=null;
				try {
					saleStatus = jsonObject4.getString("saleStatus");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String codeValue = jsonObject3.getString("codeValue");
							String codeName = jsonObject3.getString("codeName");
							if(saleStatus.equals(codeValue)){
								saleStatus = codeName;
								jsonObject4.put("saleStatusDesc",saleStatus);
								list3.add(jsonObject4);
								break;
							}else if(j==json2Object.size()-1){
								JSONObject jsonObject5 = JSONObject.fromObject(object);
								list3.add(jsonObject5);
							}
						}
					}else{
						list3.add(jsonObject4);
					}
				} catch (Exception e) {
					list3.add(jsonObject4);
					
				}
			}
			list=list3;
			
			//渠道字段转换(PCM接口)
			String jsonStr22 = "";
			Map<Object, Object> paramMap22 = new HashMap<Object, Object>();
			jsonStr22 = JSON.toJSONString(paramMap22);
			String json22 = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmAdminChannel/findListChannel.htm", jsonStr22);
			logger.info("json22:" + json22);
			JSONObject jsonObjectJ22 = JSONObject.fromObject(json22);
			String codeData2 = jsonObjectJ22.getString("data");
			JSONArray json2Object2 = JSONArray.fromObject(codeData2);
			
			List<Object> list41 = new ArrayList<Object>();
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				JSONObject jsonObject41 = JSONObject.fromObject(object);
				String channelName =null;
				try {
					channelName = jsonObject41.getString("saleSource");
					if(null!=json2Object2){
						for(int j=0; j < json2Object2.size(); j++){
							JSONObject jsonObject31 = (JSONObject) json2Object2.get(j);
							String codeValue = jsonObject31.getString("channelCode");
							String codeName = jsonObject31.getString("channelName");
							if(channelName.equals(codeValue)){
								channelName = codeName;
								jsonObject41.put("saleSource",codeName);
								list41.add(jsonObject41);
								break;
							}else if(j==json2Object2.size()-1){
								JSONObject jsonObject51 = JSONObject.fromObject(object);
								list41.add(jsonObject51);
							}
						}
					}else{
						list41.add(jsonObject41);
					}
				} catch (Exception e) {
					list41.add(jsonObject41);
				}
			}
			list=list41;
			
			Integer count = jsonObject2.getInt("count");
			int pageCount = count % size == 0 ? count / size : (count / size + 1);
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("pageCount", pageCount);
				m.put("success", "true");
			} else {
				m.put("pageCount", 0);
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 签收退货（已签收销售单状态）
	 * @Methods Name selectSaleList3
	 * @Create In 2016-4-5 By chenHu
	 * @param request
	 * @param response
	 * @return
	 * @throws ParseException String
	 */
	@ResponseBody
	@RequestMapping("/selectSaleList3")
	public String selectSaleList3(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("saleStatus", "08");
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_sale_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			paramMap2.put("typeValue", "sale_status");
			jsonStr2 = JSON.toJSONString(paramMap2);
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_codelist_selectBox"), jsonStr2);
			logger.info("json2:" + json2);
			JSONObject jsonObjectJ2 = JSONObject.fromObject(json2);
			String codeData = jsonObjectJ2.getString("data");
			JSONArray json2Object = JSONArray.fromObject(codeData);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
//			for (int i = 0; i < json2Object.size(); i++) {
////				JSONObject jsonObject3 = JSONObject.fromObject(object2);
//				JSONObject jsonObject3 = (JSONObject) json2Object.get(i);
//				String codeValue = jsonObject3.getString("codeValue");
//				String codeName = jsonObject3.getString("codeName");
//				for (Object object : list) {
//					JSONObject jsonObject4 = JSONObject.fromObject(object);
//					String saleStatus = jsonObject4.getString("saleStatus");
//					if(saleStatus.equals(codeValue)){
//						saleStatus = codeName;
//						jsonObject4.put("saleStatusDesc",saleStatus);
////						object = JSONObject.toBean(jsonObject4, Object.class);
//						list3.add(jsonObject4);
//					}
//				}
//			}
			for(int i=0; i<list.size(); i++){
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String saleStatus=null;
				try {
					saleStatus = jsonObject4.getString("saleStatus");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String codeValue = jsonObject3.getString("codeValue");
							String codeName = jsonObject3.getString("codeName");
							if(saleStatus.equals(codeValue)){
								saleStatus = codeName;
								jsonObject4.put("saleStatusDesc",saleStatus);
								list3.add(jsonObject4);
								break;
							}else if(j==json2Object.size()-1){
								JSONObject jsonObject5 = JSONObject.fromObject(object);
								list3.add(jsonObject5);
							}
						}
					}else{
						list3.add(jsonObject4);
					}
				} catch (Exception e) {
					list3.add(jsonObject4);
					
				}
			}
			list=list3;
			
			//渠道字段转换(PCM接口)
			String jsonStr22 = "";
			Map<Object, Object> paramMap22 = new HashMap<Object, Object>();
			jsonStr22 = JSON.toJSONString(paramMap22);
			String json22 = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmAdminChannel/findListChannel.htm", jsonStr22);
			logger.info("json22:" + json22);
			JSONObject jsonObjectJ22 = JSONObject.fromObject(json22);
			String codeData2 = jsonObjectJ22.getString("data");
			JSONArray json2Object2 = JSONArray.fromObject(codeData2);
			
			List<Object> list41 = new ArrayList<Object>();
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				JSONObject jsonObject41 = JSONObject.fromObject(object);
				String channelName =null;
				try {
					channelName = jsonObject41.getString("saleSource");
					if(null!=json2Object2){
						for(int j=0; j < json2Object2.size(); j++){
							JSONObject jsonObject31 = (JSONObject) json2Object2.get(j);
							String codeValue = jsonObject31.getString("channelCode");
							String codeName = jsonObject31.getString("channelName");
							if(channelName.equals(codeValue)){
								channelName = codeName;
								jsonObject41.put("saleSource",codeName);
								list41.add(jsonObject41);
								break;
							}else if(j==json2Object2.size()-1){
								JSONObject jsonObject51 = JSONObject.fromObject(object);
								list41.add(jsonObject51);
							}
						}
					}else{
						list41.add(jsonObject41);
					}
				} catch (Exception e) {
					list41.add(jsonObject41);
				}
			}
			list=list41;
			
			Integer count = jsonObject2.getInt("count");
			int pageCount = count % size == 0 ? count / size : (count / size + 1);
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("pageCount", pageCount);
				m.put("success", "true");
			} else {
				m.put("pageCount", 0);
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询销售单明细
	 * @Methods Name selectSaleItemList
	 * @Create In 2015-8-13 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectSaleItemList")
	public String selectSaleItemList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("saleNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_saleItem_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询异常信息（带分页）
	 * @Methods Name selectExceptionLog
	 * @Create In 2015-8-13 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectExceptionLog")
	public String selectExceptionLog(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<String, String> paramMap = this.createParam(request);
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_exceptionLog_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			Integer count = jsonObject2.getInt("count");
			int pageCount = count % size == 0 ? count / size : (count / size + 1);
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("pageCount", pageCount);
				m.put("success", "true");
			} else {
				m.put("pageCount", 0);
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

	
	/**
	 * 查询退货单信息（带分页）
	 * @Methods Name selectRefundList
	 * @Create In 2015-8-13 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectRefundList")
	public String selectRefundList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refund_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			paramMap2.put("typeValue", "refund_status");
			jsonStr2 = JSON.toJSONString(paramMap2);
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_codelist_selectBox"), jsonStr2);
			logger.info("json2:" + json2);
			JSONObject jsonObjectJ2 = JSONObject.fromObject(json2);
			String codeData = jsonObjectJ2.getString("data");
			JSONArray json2Object = JSONArray.fromObject(codeData);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
//			for (int i = 0; i < json2Object.size(); i++) {
////				JSONObject jsonObject3 = JSONObject.fromObject(object2);
//				JSONObject jsonObject3 = (JSONObject) json2Object.get(i);
//				String codeValue = jsonObject3.getString("codeValue");
//				String codeName = jsonObject3.getString("codeName");
//				for (Object object : list) {
//					JSONObject jsonObject4 = JSONObject.fromObject(object);
//					String refundStatus = jsonObject4.getString("refundStatus");
//					if(refundStatus.equals(codeValue)){
//						refundStatus = codeName;
//						jsonObject4.put("refundStatusDesc",refundStatus);
////						object = JSONObject.toBean(jsonObject4, Object.class);
//						list3.add(jsonObject4);
//					}
//				}
//			}
			for(int i=0; i<list.size(); i++){
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String refundStatus=null;
				try {
					refundStatus = jsonObject4.getString("refundStatus");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String codeValue = jsonObject3.getString("codeValue");
							String codeName = jsonObject3.getString("codeName");
							if(refundStatus.equals(codeValue)){
								refundStatus = codeName;
								jsonObject4.put("refundStatusDesc",refundStatus);
								list3.add(jsonObject4);
								break;
							}else if(j==json2Object.size()-1){
								JSONObject jsonObject5 = JSONObject.fromObject(object);
								list3.add(jsonObject5);
							}
						}
					}else{
						list3.add(jsonObject4);
					}
				} catch (Exception e) {
					list3.add(jsonObject4);
					
				}
			}
			list=list3;
			
			Integer count = jsonObject2.getInt("count");
			int pageCount = count % size == 0 ? count / size : (count / size + 1);
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("pageCount", pageCount);
				m.put("success", "true");
			} else {
				m.put("pageCount", 0);
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询退货单明细信息
	 * @Methods Name selectRefundOrderDetail
	 * @Create In 2015-8-13 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundItemList")
	public String selectRefundItemList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("refundNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundItem_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询款机流水信息
	 * @Methods Name selectPosFlowList
	 * @Create In 2015-8-24 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPosFlowList")
	public String selectPosFlowList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("saleNo"))){
			paramMap.put("saleNo", request.getParameter("saleNo"));
		}else{
			paramMap.put("saleNo", request.getParameter("refundNo"));
		}
		paramMap.put("isRefund", request.getParameter("isRefund"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_posFlow_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询款机信息（带分页）
	 * @Methods Name selectSalePosFlowPage
	 * @Create In 2015-8-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectPosFlowPage")
	public String selectPosFlowPage(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_posFlow_Page"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			Integer count = jsonObject2.getInt("count");
			int pageCount = count % size == 0 ? count / size : (count / size + 1);
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("pageCount", pageCount);
				m.put("success", "true");
			} else {
				m.put("pageCount", 0);
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	
	
	/**
	 * 流水明细
	 * @Methods Name selectFlowItemList
	 * @Create In 2015-9-8 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectFlowItemList")
	public String selectFlowItemList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_flowItem_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询发票信息
	 * @Methods Name selectInvoiceList
	 * @Create In 2015-8-24 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectInvoiceList")
	public String selectInvoiceList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("saleNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_invoice_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询销售单信息
	 * @Methods Name selectSaleInfoList
	 * @Create In 2015-8-25 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectSaleInfoList")
	public String selectSaleInfoList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_saleInfo_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询退货单信息
	 * @Methods Name selectRefundInfoList
	 * @Create In 2015-8-25 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectRefundInfoList")
	public String selectRefundInfoList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundInfo_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	

	/**
	 * 查询退货单历史信息
	 * @Methods Name selectRefundHistory
	 * @Create In 2015-9-1 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundHistory")
	public String selectRefundHistory(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("refundNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundHistory_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询销售单历史信息
	 * @Methods Name selectSaleHistory
	 * @Create In 2015-9-1 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectSaleHistory")
	public String selectSaleHistory(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("saleNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_saleHistory_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 对账
	 * @Methods Name checkAccountsList
	 * @Create In 2015-9-9 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/checkAccountsList")
	public String checkAccountsList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("startFlowTime", request.getParameter("startFlowTime"));
		paramMap.put("endFlowTime", request.getParameter("endFlowTime"));
		paramMap.put("isRefund", request.getParameter("isRefund"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(paramMap.get("shopNo")==null || paramMap.get("shopNo").equals("")){
			m.put("list", new ArrayList());
			m.put("totalPaymentAmount", 0);
			m.put("success", "true");
		}else{
			paramMap.put("fromSystem", "PCM");
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				json = HttpUtilPcm.doPost(CommonProperties.get("check_accounts_list"), jsonStr);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				Object data = jsonObject.get("data");
				JSONObject jsonData = JSONObject.fromObject(data);
				List<Object> list = (List<Object>) jsonData.get("allPaymentlist");
				Object posPaymentAmountDto = jsonData.get("posPaymentAmountDto");
				JSONObject dto = JSONObject.fromObject(posPaymentAmountDto);
				Object totalPaymentAmount = dto.get("totalPaymentAmount");
				if (list != null && list.size() != 0 && StringUtils.isNotEmpty(String.valueOf(totalPaymentAmount))) {
					m.put("list", list);
					m.put("totalPaymentAmount", totalPaymentAmount);
					m.put("success", "true");
				} else {
					m.put("success", "false");
				}
			} catch (Exception e) {
				m.put("success", "false");
			}
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	@ResponseBody
	@RequestMapping("/checkOnLineAccountsList")
	public String checkOnLineAccountsList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("startFlowTime", request.getParameter("startFlowTime"));
		paramMap.put("endFlowTime", request.getParameter("endFlowTime"));
		paramMap.put("isRefund", request.getParameter("isRefund"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(paramMap.get("shopNo")==null || paramMap.get("shopNo").equals("")){
			m.put("list", new ArrayList());
			m.put("totalPaymentAmount", 0);
			m.put("success", "true");
		}else{
			paramMap.put("fromSystem", "PCM");
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				json = HttpUtilPcm.doPost(CommonProperties.get("checkOnLine_accounts_list"), jsonStr);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				Object data = jsonObject.get("data");
				JSONObject jsonData = JSONObject.fromObject(data);
				List<Object> list = (List<Object>) jsonData.get("allPaymentlist");
				Object posPaymentAmountDto = jsonData.get("posPaymentAmountDto");
				JSONObject dto = JSONObject.fromObject(posPaymentAmountDto);
				Object totalPaymentAmount = dto.get("totalPaymentAmount");
				if (list != null && list.size() != 0 && StringUtils.isNotEmpty(String.valueOf(totalPaymentAmount))) {
					m.put("list", list);
					m.put("totalPaymentAmount", totalPaymentAmount);
					m.put("success", "true");
				} else {
					m.put("success", "false");
				}
			} catch (Exception e) {
				m.put("success", "false");
			}
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 对账所展现款机流水信息
	 * @Methods Name selectAllPosFlowList
	 * @Create In 2015-9-9 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectAllPosFlowList")
	public String selectAllPosFlowList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 5;
		}
//		int start = (currPage-1)*size;
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("startFlowTime", request.getParameter("startFlowTime"));
		paramMap.put("endFlowTime", request.getParameter("endFlowTime"));
		paramMap.put("flowStatus", request.getParameter("flowStatus"));
		
		paramMap.put("isRefund", request.getParameter("isRefund"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(paramMap.get("shopNo")==null || paramMap.get("shopNo").equals("")){
			m.put("pageCount", 0);
			m.put("success", "true");
		}else{
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				json = HttpUtilPcm.doPost(CommonProperties.get("select_posFlow_Page"), jsonStr);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				String data = jsonObject.getString("data");
				JSONObject jsonObject2 = JSONObject.fromObject(data);
				List<Object> list = (List<Object>) jsonObject2.get("list");
				Integer count = jsonObject2.getInt("count");
				int pageCount = count % size == 0 ? count / size : (count / size + 1);
				if (list != null && list.size() != 0) {
					m.put("list", list);
					m.put("pageCount", pageCount);
					m.put("success", "true");
				} else {
					m.put("pageCount", 0);
					m.put("success", "false");
				}
			} catch (Exception e) {
				m.put("pageCount", 0);
				m.put("success", "false");
			}
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 对账支付介质详情
	 * @Methods Name selectAllPosFlowPayments
	 * @Create In 2015-9-9 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectAllPosFlowPayments")
	public String selectAllPosFlowPayments(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
		if(size==null || size==0){
			size = 5;
		}
//		int start = (currPage-1)*size;
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("startFlowTime", request.getParameter("startFlowTime"));
		paramMap.put("endFlowTime", request.getParameter("endFlowTime"));
		paramMap.put("flowStatus", request.getParameter("flowStatus"));
		
		paramMap.put("paymentType", request.getParameter("paymentType"));
		paramMap.put("isRefund", request.getParameter("isRefund"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(paramMap.get("shopNo")==null || paramMap.get("shopNo").equals("")){
			m.put("pageCount", 0);
			m.put("success", "true");
		}else{
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				json = HttpUtilPcm.doPost(CommonProperties.get("select_allPosFlow_payments"), jsonStr);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				String data = jsonObject.getString("data");
				JSONObject jsonObject2 = JSONObject.fromObject(data);
				List<Object> list = (List<Object>) jsonObject2.get("list");
				Integer count = jsonObject2.getInt("count");
				int pageCount = count % size == 0 ? count / size : (count / size + 1);
				if (list != null && list.size() != 0) {
					m.put("list", list);
					m.put("pageCount", pageCount);
					m.put("success", "true");
				} else {
					m.put("pageCount", 0);
					m.put("success", "false");
				}
			} catch (Exception e) {
				m.put("pageCount", 0);
				m.put("success", "false");
			}
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	
	/**
	 * 查询换货单信息（带分页）
	 * @Methods Name exchangeList
	 * @Create In 2015-9-15 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/exchangeList")
	public String exchangeList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("exchange_list_page"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			Integer count = jsonObject2.getInt("count");
			int pageCount = count % size == 0 ? count / size : (count / size + 1);
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("pageCount", pageCount);
				m.put("success", "true");
			} else {
				m.put("pageCount", 0);
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	
	/**
	 * 查询销售单促销分摊信息
	 * @Methods Name selectSalePromotionSplit
	 * @Create In 2015-9-21 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectSalePromotionSplit")
	public String selectSalePromotionSplit(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("salesItemNo", request.getParameter("salesItemNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_sale_promotionSplit"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询退货单促销分摊信息
	 * @Methods Name selectRefundPromotionSplit
	 * @Create In 2015-9-21 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundPromotionSplit")
	public String selectRefundPromotionSplit(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundItemNo", request.getParameter("refundItemNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refund_promotionSplit"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询支付介质
	 * @Methods Name selectPayments
	 * @Create In 2015-9-21 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPayments")
	public String selectPayments(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_payments"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
			logger.info("json2:" + json2);
			JSONArray json2Object = JSONArray.fromObject(json2);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
			List<Object> list4 = new ArrayList<Object>();
			for (int i = 0; i < json2Object.size(); i++) {
//				JSONObject jsonObject3 = JSONObject.fromObject(object2);
				JSONObject jsonObject3 = (JSONObject) json2Object.get(i);
				String code = jsonObject3.getString("code");
				String name = jsonObject3.getString("name");
				for (Object object : list) {
					JSONObject jsonObject4 = JSONObject.fromObject(object);
					String paymentClass = jsonObject4.getString("paymentType");
					paymentClass= paymentClass.substring(0,2);
					if(paymentClass.equals(code)){
						paymentClass = name;
						jsonObject4.put("paymentClass",paymentClass);
//						object = JSONObject.toBean(jsonObject4, Object.class);
						list3.add(jsonObject4);
					}else if(StringUtils.isEmpty(paymentClass)){
						list3.add(jsonObject4);
					}
				}
			}
			list=list3;
			for (int i = 0; i < json2Object.size(); i++) {
//				JSONObject jsonObject3 = JSONObject.fromObject(object2);
				JSONObject jsonObject3 = (JSONObject) json2Object.get(i);
				String code = jsonObject3.getString("code");
				String name = jsonObject3.getString("name");
				for (Object object : list) {
					JSONObject jsonObject4 = JSONObject.fromObject(object);
					String paymentType = jsonObject4.getString("paymentType");
					if(paymentType.equals(code)){
						paymentType = name;
						jsonObject4.put("paymentType",paymentType);
						list4.add(jsonObject4);
					}else if(StringUtils.isEmpty(paymentType)){
						list4.add(jsonObject4);
					}
				}
			}
			list=list4;
			
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	private Map<String, String> createParam(HttpServletRequest request){
		request.removeAttribute("_method");
		Map<String, String> paramMap = new HashMap<String, String>();
		Enumeration enumeration = request.getParameterNames();
		while(enumeration.hasMoreElements()) {
			String paramStr = (String)enumeration.nextElement();
			if("orderSid".equals(paramStr)) {
				paramMap.put("orderSid", request.getParameter(paramStr));
			}else if("orderNo".equals(paramStr)) {
				paramMap.put("orderNo", request.getParameter(paramStr));
			}else if("state".equals(paramStr)) {
				paramMap.put("orderStatus", request.getParameter(paramStr));
			/*}else if("endSaleTime".equals(paramStr)) {
//				paramMap.put("endSaleTime", request.getParameter(paramStr));
				
				SimpleDateFormat formatter; 
			    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
			    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		    	Date date;
				try {
					date = sdf.parse(request.getParameter("endSaleTime"));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.HOUR_OF_DAY, 0);
					Date date2 = calendar.getTime();
					String endDate = sdf.format(date2);
					paramMap.put("endSaleTime", endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			    
			}else if("startSaleTime".equals(paramStr)) {
//				paramMap.put("startSaleTime", request.getParameter(paramStr));
				
				SimpleDateFormat formatter; 
			    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
			    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		    	Date date;
				try {
					date = sdf.parse(request.getParameter("startSaleTime"));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.HOUR_OF_DAY, 0);
					Date date2 = calendar.getTime();
					String startDate = sdf.format(date2);
					paramMap.put("startSaleTime", startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}*/
			}else if("endFlowTime".equals(paramStr)) {
				
				SimpleDateFormat formatter; 
				formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				Date date;
				try {
					date = sdf.parse(request.getParameter("endFlowTime"));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.HOUR_OF_DAY, 0);
					Date date2 = calendar.getTime();
					String endDate = sdf.format(date2);
					paramMap.put("endFlowTime", endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if("startFlowTime".equals(paramStr)) {
				
				SimpleDateFormat formatter; 
				formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				Date date;
				try {
					date = sdf.parse(request.getParameter("startFlowTime"));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.HOUR_OF_DAY, 0);
					Date date2 = calendar.getTime();
					String startDate = sdf.format(date2);
					paramMap.put("startFlowTime", startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			/*}else if("endRefundTime".equals(paramStr)) {
				
				SimpleDateFormat formatter; 
				formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				Date date;
				try {
					date = sdf.parse(request.getParameter("endRefundTime"));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.HOUR_OF_DAY, 0);
					Date date2 = calendar.getTime();
					String endDate = sdf.format(date2);
					paramMap.put("endRefundTime", endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if("startRefundTime".equals(paramStr)) {
				
				SimpleDateFormat formatter; 
				formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				Date date;
				try {
					date = sdf.parse(request.getParameter("startRefundTime"));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.HOUR_OF_DAY, 0);
					Date date2 = calendar.getTime();
					String startDate = sdf.format(date2);
					paramMap.put("startRefundTime", startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}*/
				
			}else if("endTime".equals(paramStr)) {
				
				SimpleDateFormat formatter; 
				formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				Date date;
				try {
					date = sdf.parse(request.getParameter("endTime"));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.HOUR_OF_DAY, 0);
					Date date2 = calendar.getTime();
					String endDate = sdf.format(date2);
					paramMap.put("endTime", endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if("startTime".equals(paramStr)) {
				
				SimpleDateFormat formatter; 
				formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
				Date date;
				try {
					date = sdf.parse(request.getParameter("startTime"));
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(date);
					calendar.add(Calendar.HOUR_OF_DAY, 0);
					Date date2 = calendar.getTime();
					String startDate = sdf.format(date2);
					paramMap.put("startTime", startDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}else if("saleNo".equals(paramStr)) {
				paramMap.put("saleNo", request.getParameter(paramStr));
			}else if("saleStatus".equals(paramStr)) {
				paramMap.put("saleStatus", request.getParameter(paramStr));
			}else if("orderId".equals(paramStr)) {
				paramMap.put("orderNo", request.getParameter(paramStr));
			}else if("cardId".equals(paramStr)) {
				paramMap.put("cardId", request.getParameter(paramStr));
			}else if("saleSid".equals(paramStr)) {
				paramMap.put("saleSid", request.getParameter(paramStr));
			}else if("page".equals(paramStr)) {
				paramMap.put("page", request.getParameter(paramStr));
				paramMap.put("pageNumber", request.getParameter(paramStr));
			}else if("pageSize".equals(paramStr)) {
				paramMap.put("pageSize", request.getParameter(paramStr));
				paramMap.put("fetchSize", request.getParameter(paramStr));
			}else if("start".equals(paramStr)) {
				paramMap.put("start", request.getParameter(paramStr));
			} else if("limit".equals(paramStr)) {
				paramMap.put("limit", request.getParameter(paramStr));
			} else if("refundApplyNo".equals(paramStr)) {
				paramMap.put("refundApplyNo", request.getParameter(paramStr));	
			}else if("cashierNumber".equals(paramStr)){
				paramMap.put("cashierNumber", request.getParameter(paramStr));
			}else if("orderSourceSid".equals(paramStr)){
				paramMap.put("orderSourceSid", request.getParameter(paramStr));	
			}else if("companyCode".equals(paramStr)){
				paramMap.put("companyCode", request.getParameter(paramStr));
			// start添加的销售单来源saleSource refundType
			}else if("saleSource".equals(paramStr)){
				paramMap.put("saleSource", request.getParameter(paramStr));
			}else if("refundType".equals(paramStr)){
				paramMap.put("refundType", request.getParameter(paramStr));
			//  end
			}else{
				paramMap.put(paramStr, request.getParameter(paramStr));
			}
		}
		return paramMap;
	}
	
}
