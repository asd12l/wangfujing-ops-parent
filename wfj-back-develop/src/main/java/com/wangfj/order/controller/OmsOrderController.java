package com.wangfj.order.controller;

import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.thoughtworks.xstream.alias.ClassMapper.Null;
import com.wangfj.order.controller.suppot.ExcelAllPosPlatformVo;
import com.wangfj.order.controller.suppot.ExcelOrderPosPlatformVo;
import com.wangfj.order.controller.suppot.ExcelOrderVo;
import com.wangfj.order.controller.suppot.ExcelPosPlatformVo;
import com.wangfj.order.controller.suppot.ExcelRefundMonVo;
import com.wangfj.order.controller.suppot.ExcelRefundVo;
import com.wangfj.order.controller.suppot.ExcelSaleVo;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.ResultUtil;
import com.wfj.netty.servlet.util.StringUtil;

/**
 * 
 * @Comment	针对网站后台-销售-OMS订单管理
 * @Class Name OmsOrderController
 * @Author tangysh
 * @Create In 2015-10-26
 */
@Controller
@RequestMapping("/omsOrder")
public class OmsOrderController {
	
	private static final Logger logger = LoggerFactory.getLogger(OmsOrderController.class);
	
	public static final String FROM_SYSTEM = "ORDERBACK";
	
	/**
	 * 查询订单信息（带分页）
	 * @Methods Name selectOrderList
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectOrderList")
	public String selectOrderList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderSource", request.getParameter("saleSource"));
		paramMap.put("isCod", request.getParameter("isCod"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("orderStatus", request.getParameter("orderStatus"));
		paramMap.put("payStatus", request.getParameter("payStatus"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("receptPhone", request.getParameter("receptPhone"));
		paramMap.put("memberType", request.getParameter("memberType"));
		paramMap.put("paymentAmountStart", request.getParameter("paymentAmountStart"));
		paramMap.put("paymentAmountEnd", request.getParameter("paymentAmountEnd"));
		
		SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    if(StringUtils.isNotEmpty(request.getParameter("startSaleTime"))){
	    	Date date = sdf.parse(request.getParameter("startSaleTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, 0);
	    	Date date2 = calendar.getTime();
	    	String startDate = sdf.format(date2);
	    	paramMap.put("saleTimeStartStr", startDate);
	    }
	    if(StringUtils.isNotEmpty(request.getParameter("endSaleTime"))){
	    	Date date = sdf.parse(request.getParameter("endSaleTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, 0);
	    	Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
	    	paramMap.put("saleTimeEndStr", endDate);
	    }
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_order_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			paramMap2.put("typeValue", "order_status");
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
//					String orderStatus = jsonObject4.getString("orderStatus");
//					if(orderStatus.equals(codeValue)){
//						orderStatus = codeName;
//						jsonObject4.put("orderStatusDesc",orderStatus);
////						object = JSONObject.toBean(jsonObject4, Object.class);
//						list3.add(jsonObject4);
//					}
//				}
//			}
			for(int i=0; i<list.size(); i++){
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String orderStatus=null;
				try {
					orderStatus = jsonObject4.getString("orderStatus");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String codeValue = jsonObject3.getString("codeValue");
							String codeName = jsonObject3.getString("codeName");
							if(orderStatus.equals(codeValue)){
								orderStatus = codeName;
								jsonObject4.put("orderStatusDesc",orderStatus);
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
			
			String jsonStr21 = "";
			Map<Object, Object> paramMap21 = new HashMap<Object, Object>();
			paramMap21.put("fromSystem", "OMSADMIN");
			paramMap21.put("typeValue", "order_type");
			jsonStr21 = JSON.toJSONString(paramMap21);
			String json21 = HttpUtilPcm.doPost(CommonProperties.get("select_codelist_selectBox"), jsonStr21);
			logger.info("json21:" + json21);
			JSONObject jsonObjectJ21 = JSONObject.fromObject(json21);
			String codeData1 = jsonObjectJ21.getString("data");
			JSONArray json2Object1 = JSONArray.fromObject(codeData1);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list4 = new ArrayList<Object>();
//			for (int i = 0; i < json2Object1.size(); i++) {
////				JSONObject jsonObject3 = JSONObject.fromObject(object2);
//				JSONObject jsonObject3 = (JSONObject) json2Object1.get(i);
//				String codeValue = jsonObject3.getString("codeValue");
//				String codeName = jsonObject3.getString("codeName");
//				for (Object object : list) {
//					JSONObject jsonObject4 = JSONObject.fromObject(object);
//					String orderType = jsonObject4.getString("orderType");
//					if(orderType.equals(codeValue)){
//						orderType = codeName;
//						jsonObject4.put("orderType",orderType);
////						object = JSONObject.toBean(jsonObject4, Object.class);
//						list4.add(jsonObject4);
//					}
//				}
//			}
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String orderType =null;
				try {
					orderType = jsonObject4.getString("orderType");
					if(null!=json2Object1){
						for(int j=0; j < json2Object1.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object1.get(j);
							String codeValue = jsonObject3.getString("codeValue");
							String codeName = jsonObject3.getString("codeName");
							if(orderType.equals(codeValue)){
								orderType = codeName;
								jsonObject4.put("orderType",orderType);
								list4.add(jsonObject4);
								break;
							}else if(j==json2Object1.size()-1){
								JSONObject jsonObject5 = JSONObject.fromObject(object);
								list4.add(jsonObject5);
							}
						}
					}else{
						list4.add(jsonObject4);
					}
				} catch (Exception e) {
					list4.add(jsonObject4);
				}
			}
			list=list4;
			
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
					channelName = jsonObject41.getString("orderSource");
					if(null!=json2Object2){
						for(int j=0; j < json2Object2.size(); j++){
							JSONObject jsonObject31 = (JSONObject) json2Object2.get(j);
							String codeValue = jsonObject31.getString("channelCode");
							String codeName = jsonObject31.getString("channelName");
							if(channelName.equals(codeValue)){
								channelName = codeName;
								jsonObject41.put("orderSource",codeName);
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
	 * 查询订单信息（带分页）(手机号查询)
	 * @Methods Name selectOrderListByPhone
	 * @Create In 2016-7-17 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectOrderListByPhone")
	public String selectOrderListByPhone(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("supplyProductNo", request.getParameter("supplyProductNo"));
		paramMap.put("orderSource", request.getParameter("saleSource"));
		paramMap.put("isCod", request.getParameter("isCod"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("orderStatus", request.getParameter("orderStatus"));
		paramMap.put("payStatus", request.getParameter("payStatus"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("receptPhone", request.getParameter("receptPhone"));
		paramMap.put("memberType", request.getParameter("memberType"));
		paramMap.put("paymentAmountStart", request.getParameter("paymentAmountStart"));
		paramMap.put("paymentAmountEnd", request.getParameter("paymentAmountEnd"));
		
		SimpleDateFormat formatter; 
		formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		if(StringUtils.isNotEmpty(request.getParameter("startSaleTime"))){
			Date date = sdf.parse(request.getParameter("startSaleTime"));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.HOUR_OF_DAY, 0);
			Date date2 = calendar.getTime();
			String startDate = sdf.format(date2);
			paramMap.put("saleTimeStartStr", startDate);
		}
		if(StringUtils.isNotEmpty(request.getParameter("endSaleTime"))){
			Date date = sdf.parse(request.getParameter("endSaleTime"));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.HOUR_OF_DAY, 0);
			Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
			paramMap.put("saleTimeEndStr", endDate);
		}
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_order_list_phone"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			System.out.println(jsonObject2.get("list"));
			if(null == jsonObject2.get("list")||jsonObject2.get("list").equals(null)){
				m.put("pageCount", 0);
				m.put("success", "true");
			}else {
				List<Object> list = (List<Object>) jsonObject2.get("list");
				
				String jsonStr2 = "";
				Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
				paramMap2.put("fromSystem", "OMSADMIN");
				paramMap2.put("typeValue", "order_status");
				jsonStr2 = JSON.toJSONString(paramMap2);
				String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_codelist_selectBox"), jsonStr2);
				logger.info("json2:" + json2);
				JSONObject jsonObjectJ2 = JSONObject.fromObject(json2);
				String codeData = jsonObjectJ2.getString("data");
				JSONArray json2Object = JSONArray.fromObject(codeData);
//				List<Object> list2 = JSONArray.toList(json2Object, Object.class);
				
				List<Object> list3 = new ArrayList<Object>();
//				for (int i = 0; i < json2Object.size(); i++) {
////					JSONObject jsonObject3 = JSONObject.fromObject(object2);
//					JSONObject jsonObject3 = (JSONObject) json2Object.get(i);
//					String codeValue = jsonObject3.getString("codeValue");
//					String codeName = jsonObject3.getString("codeName");
//					for (Object object : list) {
//						JSONObject jsonObject4 = JSONObject.fromObject(object);
//						String orderStatus = jsonObject4.getString("orderStatus");
//						if(orderStatus.equals(codeValue)){
//							orderStatus = codeName;
//							jsonObject4.put("orderStatusDesc",orderStatus);
////							object = JSONObject.toBean(jsonObject4, Object.class);
//							list3.add(jsonObject4);
//						}
//					}
//				}
				for(int i=0; i<list.size(); i++){
					Object object = list.get(i);
					JSONObject jsonObject4 = JSONObject.fromObject(object);
					String orderStatus=null;
					try {
						orderStatus = jsonObject4.getString("orderStatus");
						if(null!=json2Object){
							for(int j=0; j < json2Object.size(); j++){
								JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
								String codeValue = jsonObject3.getString("codeValue");
								String codeName = jsonObject3.getString("codeName");
								if(orderStatus.equals(codeValue)){
									orderStatus = codeName;
									jsonObject4.put("orderStatusDesc",orderStatus);
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
				
				String jsonStr21 = "";
				Map<Object, Object> paramMap21 = new HashMap<Object, Object>();
				paramMap21.put("fromSystem", "OMSADMIN");
				paramMap21.put("typeValue", "order_type");
				jsonStr21 = JSON.toJSONString(paramMap21);
				String json21 = HttpUtilPcm.doPost(CommonProperties.get("select_codelist_selectBox"), jsonStr21);
				logger.info("json21:" + json21);
				JSONObject jsonObjectJ21 = JSONObject.fromObject(json21);
				String codeData1 = jsonObjectJ21.getString("data");
				JSONArray json2Object1 = JSONArray.fromObject(codeData1);
//				List<Object> list2 = JSONArray.toList(json2Object, Object.class);
				
				List<Object> list4 = new ArrayList<Object>();
//				for (int i = 0; i < json2Object1.size(); i++) {
////					JSONObject jsonObject3 = JSONObject.fromObject(object2);
//					JSONObject jsonObject3 = (JSONObject) json2Object1.get(i);
//					String codeValue = jsonObject3.getString("codeValue");
//					String codeName = jsonObject3.getString("codeName");
//					for (Object object : list) {
//						JSONObject jsonObject4 = JSONObject.fromObject(object);
//						String orderType = jsonObject4.getString("orderType");
//						if(orderType.equals(codeValue)){
//							orderType = codeName;
//							jsonObject4.put("orderType",orderType);
////							object = JSONObject.toBean(jsonObject4, Object.class);
//							list4.add(jsonObject4);
//						}
//					}
//				}
				for (int i = 0; i < list.size(); i++) {
					Object object = list.get(i);
					JSONObject jsonObject4 = JSONObject.fromObject(object);
					String orderType =null;
					try {
						orderType = jsonObject4.getString("orderType");
						if(null!=json2Object1){
							for(int j=0; j < json2Object1.size(); j++){
								JSONObject jsonObject3 = (JSONObject) json2Object1.get(j);
								String codeValue = jsonObject3.getString("codeValue");
								String codeName = jsonObject3.getString("codeName");
								if(orderType.equals(codeValue)){
									orderType = codeName;
									jsonObject4.put("orderType",orderType);
									list4.add(jsonObject4);
									break;
								}else if(j==json2Object1.size()-1){
									JSONObject jsonObject5 = JSONObject.fromObject(object);
									list4.add(jsonObject5);
								}
							}
						}else{
							list4.add(jsonObject4);
						}
					} catch (Exception e) {
						list4.add(jsonObject4);
					}
				}
				list=list4;
				
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
						channelName = jsonObject41.getString("orderSource");
						if(null!=json2Object2){
							for(int j=0; j < json2Object2.size(); j++){
								JSONObject jsonObject31 = (JSONObject) json2Object2.get(j);
								String codeValue = jsonObject31.getString("channelCode");
								String codeName = jsonObject31.getString("channelName");
								if(channelName.equals(codeValue)){
									channelName = codeName;
									jsonObject41.put("orderSource",codeName);
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
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询订单明细
	 * @Methods Name selectOrderItemList
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderItemList")
	public String selectOrderItemList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNo", request.getParameter("orderNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_orderItem_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>)jsonObject.get("data");
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
	 * 查询订单支付信息
	 * @Methods Name selectPaymentList
	 * @Create In 2015-12-8 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPaymentList")
	public String selectPaymentList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}/*else{
			paramMap.put("orderNo", request.getParameter("refundNo"));
		}*/
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_payment_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8081/oms-core/selectPayment/selectPaymentList.htm", jsonStr);
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
	 * 查询订单支付介质信息
	 * @Methods Name selectPaymentItemList
	 * @Create In 2015-12-8 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPaymentItemList")
	public String selectPaymentItemList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("salesPaymentNo"))){
			paramMap.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		}
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_paymentItem_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8081/oms-core/selectPayment/selectPaymentItemList.htm", jsonStr);
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
	
	/**
	 * 查询退货申请单信息（带分页）
	 * @Methods Name selectRefundApplyList
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectRefundApplyList")
	public String selectRefundApplyList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("receptPhone", request.getParameter("receptPhone"));
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("refundStatus", request.getParameter("refundStatus"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("refundClass", request.getParameter("refundClass"));
//		paramMap.put("startRefundTime", request.getParameter("startRefundTime"));
//		paramMap.put("endRefundTime", request.getParameter("endRefundTime"));
		
		SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    if(StringUtils.isNotEmpty(request.getParameter("startRefundTime"))){
	    	Date date = sdf.parse(request.getParameter("startRefundTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, 0);
	    	Date date2 = calendar.getTime();
	    	String startDate = sdf.format(date2);
	    	paramMap.put("startRefundTimeStr", startDate);
	    }
	    if(StringUtils.isNotEmpty(request.getParameter("endRefundTime"))){
	    	Date date = sdf.parse(request.getParameter("endRefundTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, 0);
	    	Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
	    	paramMap.put("endRefundTimeStr", endDate);
	    }
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundApply_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			paramMap2.put("typeValue", "refund_apply_status");
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
//						jsonObject4.put("refundStatus",refundStatus);
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
								jsonObject4.put("refundStatus",refundStatus);
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
	 * 查询退货申请单明细信息
	 * @Methods Name selectRefundApplyItemList
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundApplyItemList")
	public String selectRefundApplyItemList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("applyNo", request.getParameter("refundApplyNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundApplyItem_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("packimgUrl", SystemConfig.PACKIMG_URL);//www.wangfujingtest.com 域名地址
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
	 * 
	 * 查询退货明细信息
	 * @Methods Name selectRefundItemListByNo
	 * @Create In 2016-7-9 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundItemListByNo")
	public String selectRefundItemListByNo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("refundNo"));
		paramMap .put("fromSystem", "OMSADMIN");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundItem_list_byNo"), jsonStr);
//			json = HttpUtilPcm.doPost("http://192.168.6.125:8087/oms-core-sdc/ofSelect/selectRefundItem2.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("packimgUrl", SystemConfig.PACKIMG_URL);//www.wangfujingtest.com 域名地址
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
	 * 查询包裹信息
	 * @Methods Name selectPackage
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPackage")
	public String selectPackage(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("saleNo"))){
			paramMap.put("saleNo", request.getParameter("saleNo"));
		}
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_package_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://172.16.255.169:8087/oms-core-sdc/omsPackageInfo/selectListOmsPackage.htm", jsonStr);
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
	 * 查询包裹单明细
	 * @Methods Name selectPackageItemList
	 * @Create In 2016-2-17 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPackageItemList")
	public String selectPackageItemList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("packageNo", request.getParameter("packageNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_packageItem_list"), jsonStr);
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
	 * 查询包裹物流信息
	 * @Methods Name selectPackageHistoryList
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPackageHistoryList")
	public String selectPackageHistoryList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("packageNo", request.getParameter("packageNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_packageHistory_list"), jsonStr);
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
	 * 查询退货申请单历史信息
	 * @Methods Name selectRefundApplyHistory
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundApplyHistory")
	public String selectRefundApplyHistory(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundApplyHistory_list"), jsonStr);
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
	 * 查询定单历史信息
	 * @Methods Name selectOrderHistory
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderHistory")
	public String selectOrderHistory(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNo", request.getParameter("orderNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_orderHistory_list"), jsonStr);
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
	 * 查询定单促销分摊信息
	 * @Methods Name selectOrderPromotionSplit
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderPromotionSplit")
	public String selectOrderPromotionSplit(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderItemNo", request.getParameter("orderItemNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_order_promotionSplit"), jsonStr);
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
	 * 查询退货申请单促销分摊信息
	 * @Methods Name selectRefundApplyPromotionSplit
	 * @Create In 2015-10-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundApplyPromotionSplit")
	public String selectRefundApplyPromotionSplit(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("applyItemNo", request.getParameter("applyItemNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundApply_promotionSplit"), jsonStr);
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
	 * 根据订单号查询销售单信息
	 * @Methods Name selectSaleByOrderNo
	 * @Create In 2015-12-8 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectSaleByOrderNo")
	public String selectSaleByOrderNo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotBlank(request.getParameter("saleSource"))){
			paramMap.put("saleSource", request.getParameter("saleSource"));
		}
		if(StringUtils.isNotBlank(request.getParameter("shopNo"))){
			paramMap.put("shopNo", request.getParameter("shopNo"));
		}
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_sale_orderNo"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8081/oms-core/ofSelect/selectSaleByOrderNo.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			
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
	 * 查询订单推送ERP异常信息（带分页）
	 * @Methods Name selectExceptionOrder
	 * @Create In 2015-12-11 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectExceptionOrder")
	public String selectExceptionOrder(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
//		if(StringUtils.isNotBlank(request.getParameter("startTime"))){
//			paramMap.put("startTime", request.getParameter("startTime"));
//		}
//		if(StringUtils.isNotBlank(request.getParameter("endTime"))){
//			paramMap.put("endTime", request.getParameter("endTime"));
//		}
		
		SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
	    	Date date = sdf.parse(request.getParameter("startTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
	    	String startDate = sdf.format(date2);
	    	paramMap.put("startTime", startDate);
	    }
	    if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
	    	Date date = sdf.parse(request.getParameter("endTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
	    	paramMap.put("endTime", endDate);
	    }
		
		paramMap.put("exceptionType", "PUSHERP");
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
	 * 查询退货申请推送ERP异常信息（带分页）
	 * @Methods Name selectExceptionRefund
	 * @Create In 2015-12-11 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectExceptionRefund")
	public String selectExceptionRefund(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
//		if(StringUtils.isNotBlank(request.getParameter("startTime"))){
//			paramMap.put("startTime", request.getParameter("startTime"));
//		}
//		if(StringUtils.isNotBlank(request.getParameter("endTime"))){
//			paramMap.put("endTime", request.getParameter("endTime"));
//		}
		
		SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
	    	Date date = sdf.parse(request.getParameter("startTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
	    	String startDate = sdf.format(date2);
	    	paramMap.put("startTime", startDate);
	    }
	    if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
	    	Date date = sdf.parse(request.getParameter("endTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
	    	paramMap.put("endTime", endDate);
	    }
		if(null==request.getParameter("exceptionType")||"REFUNDPUSHERP".equals(request.getParameter("exceptionType"))){
			paramMap.put("exceptionType", "REFUNDPUSHERP");
		}else if("EDIREFUNDPUSHERP".equals(request.getParameter("exceptionType"))){
			paramMap.put("exceptionType", "EDIREFUNDPUSHERP");
		}
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
	 * 查询异常销售单(线上)
	 * @Methods Name selectPushErpException
	 * @Create In 2016-2-26 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectPushErpException")
	public String selectPushErpException(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
//		if(StringUtils.isNotBlank(request.getParameter("startTime"))){
//			paramMap.put("startTime", request.getParameter("startTime"));
//		}
//		if(StringUtils.isNotBlank(request.getParameter("endTime"))){
//			paramMap.put("endTime", request.getParameter("endTime"));
//		}
		
		SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
	    	Date date = sdf.parse(request.getParameter("startTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
	    	String startDate = sdf.format(date2);
	    	paramMap.put("startTime", startDate);
	    }
	    if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
	    	Date date = sdf.parse(request.getParameter("endTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
	    	paramMap.put("endTime", endDate);
	    }
		
		paramMap.put("exceptionType", "ONLINEPUSHTOPOS");
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
	 * 查询异常销售单(线下)
	 * @Methods Name selectPushErpOffLineException
	 * @Create In 2016-2-26 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectPushErpOffLineException")
	public String selectPushErpOffLineException(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
//		if(StringUtils.isNotBlank(request.getParameter("startTime"))){
//			paramMap.put("startTime", request.getParameter("startTime"));
//		}
//		if(StringUtils.isNotBlank(request.getParameter("endTime"))){
//			paramMap.put("endTime", request.getParameter("endTime"));
//		}
		
		SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
	    	Date date = sdf.parse(request.getParameter("startTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
	    	String startDate = sdf.format(date2);
	    	paramMap.put("startTime", startDate);
	    }
	    if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
	    	Date date = sdf.parse(request.getParameter("endTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
	    	paramMap.put("endTime", endDate);
	    }
		
		paramMap.put("exceptionType", "OFFLINEPUSHTOPOS");
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
	 * 根据订单号重新推送ERP
	 * @Methods Name orderSendErp
	 * @Create In 2015年12月11日 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderSendErp")
	public String orderSendErp(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String orderNo = request.getParameter("orderNo");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("orderNo:" + orderNo);
			json = HttpUtilPcm.doPost(CommonProperties.get("order_sendErp_url"), orderNo);
			logger.info("json:" + json);
			if (json != null && json.length() != 0) {
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
	 * 处理异常销售单(线下)
	 * @Methods Name saleSendErp
	 * @Create In 2016-2-26 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/saleSendErp")
	public String saleSendErp(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String salesPaymentNo = request.getParameter("orderNo");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("salesPaymentNo:" + salesPaymentNo);
			json = HttpUtilPcm.doPost(CommonProperties.get("saleNo_sendErpOffLine_url"), salesPaymentNo);
			logger.info("json:" + json);
			if (json != null && json.length() != 0) {
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
	 * 处理异常销售单(线上)
	 * @Methods Name saleSendOffLineErp
	 * @Create In 2016-2-26 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/saleSendOffLineErp")
	public String saleSendOffLineErp(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String saleNo = request.getParameter("orderNo");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("saleNo:" + saleNo);
			json = HttpUtilPcm.doPost(CommonProperties.get("saleNo_sendErp_url"), saleNo);
			logger.info("json:" + json);
			if (json != null && json.length() != 0) {
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
	 * 根据退货申请单重新推送ERP
	 * @Methods Name refundSendErp
	 * @Create In 2015年12月11日 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/applySendErp")
	public String applySendErp(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String refundApplyNo = request.getParameter("orderNo");
		String exceptionType = request.getParameter("exceptionType");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("refundApplyNo:" + refundApplyNo);
			if(exceptionType.equals("EDIREFUNDPUSHERP")){
				json = HttpUtilPcm.doPost(CommonProperties.get("apply_sendErp_url"), refundApplyNo);
			}else if(exceptionType.equals("REFUNDPUSHERP")){
				json = HttpUtilPcm.doPost(CommonProperties.get("apply_EdisendErp_url"), refundApplyNo);
			}
			
			logger.info("json:" + json);
			if (json != null && json.length() != 0) {
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
	 * 退款单查询
	 * @Methods Name selectRefundMonList
	 * @Create In 2016-1-13 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectRefundMonList")
	public String selectRefundMonList(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("refundMonNo", request.getParameter("refundMonNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("saleNo", request.getParameter("saleNo"));
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("refundNo", request.getParameter("refundNo"));
		paramMap.put("orderSource", request.getParameter("orderSource"));
		paramMap.put("reMonStatus", request.getParameter("reMonStatus"));
		paramMap.put("refundClass", request.getParameter("refundClass"));
		if(StringUtils.isNotEmpty(request.getParameter("confirmRefundMonTimeStartStr"))){
			paramMap.put("confirmRefundMonTimeStartStr", request.getParameter("confirmRefundMonTimeStartStr"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("confirmRefundMonTimeEndStr"))){
			paramMap.put("confirmRefundMonTimeEndStr", request.getParameter("confirmRefundMonTimeEndStr"));
		}
		SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    if(StringUtils.isNotEmpty(request.getParameter("allRefTimeStart"))){
	    	Date date = sdf.parse(request.getParameter("allRefTimeStart"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, 0);
	    	Date date2 = calendar.getTime();
	    	String startDate = sdf.format(date2);
	    	paramMap.put("allRefTimeStartStr", startDate);
	    }
	    if(StringUtils.isNotEmpty(request.getParameter("allRefTimeEnd"))){
	    	Date date = sdf.parse(request.getParameter("allRefTimeEnd"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, 0);
	    	Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
	    	paramMap.put("allRefTimeEndStr", endDate);
	    }
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("currentPage", String.valueOf(currPage));
		paramMap.put("pageSize", String.valueOf(size));
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundMon_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/refundMon/selectRefundAndMon.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
			logger.info("json2:" + json2);
			JSONArray json2Object = JSONArray.fromObject(json2);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
//			for (int i = 0; i < json2Object.size(); i++) {
////				JSONObject jsonObject3 = JSONObject.fromObject(object2);
//				JSONObject jsonObject3 = (JSONObject) json2Object.get(i);
//				String code = jsonObject3.getString("code");
//				String name = jsonObject3.getString("name");
//				for (Object object : list) {
//					JSONObject jsonObject4 = JSONObject.fromObject(object);
//					String paymentType = jsonObject4.getString("paymentType");
//					if(paymentType.equals(code)){
//						paymentType = name;
//						jsonObject4.put("paymentType",paymentType);
////						object = JSONObject.toBean(jsonObject4, Object.class);
//						list3.add(jsonObject4);
//					}
//				}
//			}
			for(int i=0; i<list.size(); i++){
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String paymentType=null;
				try {
					paymentType = jsonObject4.getString("paymentType");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String codeValue = jsonObject3.getString("code");
							String codeName = jsonObject3.getString("name");
							if(paymentType.equals(codeValue)){
								paymentType = codeName;
								jsonObject4.put("paymentType",paymentType);
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
					channelName = jsonObject41.getString("orderSource");
					if(null!=json2Object2){
						for(int j=0; j < json2Object2.size(); j++){
							JSONObject jsonObject31 = (JSONObject) json2Object2.get(j);
							String codeValue = jsonObject31.getString("channelCode");
							String codeName = jsonObject31.getString("channelName");
							if(channelName.equals(codeValue)){
								channelName = codeName;
								jsonObject41.put("orderSource",codeName);
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
	 * 退款单导出Excel
	 * @Methods Name getRefundMonToExcel
	 * @Create In 2016-1-13 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getRefundMonToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getRefundMonToExcel(HttpServletRequest request, HttpServletResponse response){
		String jsons = "";	
		String title = "refundMon";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		List<ExcelRefundMonVo> epv = new ArrayList<ExcelRefundMonVo>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(StringUtils.isNotEmpty(request.getParameter("refundMonNo"))){
			map.put("refundMonNo", request.getParameter("refundMonNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("accountNo"))){
			map.put("accountNo", request.getParameter("accountNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundNo"))){
			map.put("refundNo", request.getParameter("refundNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("saleNo"))){
			map.put("saleNo", request.getParameter("saleNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			map.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("outOrderNo"))){
			map.put("outOrderNo", request.getParameter("outOrderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundClass"))){
			map.put("refundClass", request.getParameter("refundClass"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderSource"))){
			map.put("orderSource", request.getParameter("orderSource"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("reMonStatus"))){
			map.put("reMonStatus", request.getParameter("reMonStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("allRefTimeEnd"))){
			map.put("allRefTimeEndStr", request.getParameter("allRefTimeEnd"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("allRefTimeStart"))){
			map.put("allRefTimeStartStr", request.getParameter("allRefTimeStart"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("confirmRefundMonTimeEndStr"))){
			map.put("confirmRefundMonTimeEndStr", request.getParameter("confirmRefundMonTimeEndStr"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("confirmRefundMonTimeStartStr"))){
			map.put("confirmRefundMonTimeStartStr", request.getParameter("confirmRefundMonTimeStartStr"));
		}
		
		map.put("start", String.valueOf(currPage));
		map.put("limit", String.valueOf(size));
//		map.put("fromSystem", "OMSADMIN");
		String jsonStr = JSON.toJSONString(map);
		try {
//			String json = HttpUtilPcm.doPost(CommonProperties.get("excel_refundMon_list"), jsonStr);
			String json = HttpUtilPcm.doPost(CommonProperties.get("select_refundMon_list"), jsonStr);
//			String json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/refundMon/selectRefundAndMon.htm", jsonStr);
			
			JSONObject js = JSONObject.fromObject(json);
//			Object objs = js.get("data");
//			List<Object> list = (List<Object>) js.get("data");
			String data = js.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
			logger.info("json2:" + json2);
			JSONArray json2Object = JSONArray.fromObject(json2);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String paymentType=null;
				try{
					paymentType = jsonObject4.getString("paymentType");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String code = jsonObject3.getString("code");
							String name = jsonObject3.getString("name");
							if(paymentType.equals(code)){
								paymentType = name;
								jsonObject4.put("paymentType",paymentType);
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
				}catch (Exception e){
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
					channelName = jsonObject41.getString("orderSource");
					if(null!=json2Object2){
						for(int j=0; j < json2Object2.size(); j++){
							JSONObject jsonObject31 = (JSONObject) json2Object2.get(j);
							String codeValue = jsonObject31.getString("channelCode");
							String codeName = jsonObject31.getString("channelName");
							if(channelName.equals(codeValue)){
								channelName = codeName;
								jsonObject41.put("orderSource",codeName);
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
			
			// 得到JSONArray
//			JSONArray arr = JSONArray.fromObject(objs);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
//					JSONObject jOpt = list.getJSONObject(i);
					JSONObject jOpt = (JSONObject) list.get(i);
					ExcelRefundMonVo vo = (ExcelRefundMonVo) JSONObject.toBean(jOpt,ExcelRefundMonVo.class);
					epv.add(vo);
				}
			}
			
			Object result = allProSkusToExcel(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}
		
		return jsons;
	}
	public String allProSkusToExcel(HttpServletResponse response,List<ExcelRefundMonVo> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("退款单号");
		header.add("原订单号");
		header.add("销售单号");
		header.add("退货单号");
		header.add("销售渠道");
		header.add("渠道订单号");
		header.add("客户订单帐号");
		header.add("客户编号");
		header.add("退款状态");
		header.add("创建类型");
		header.add("退款金额");
		header.add("退款介质");
		header.add("开户行");
		header.add("开户人");
		header.add("卡号");
		header.add("审核人");
		header.add("财务备注");
		header.add("创建时间");
		header.add("退款成功时间");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelRefundMonVo vo:list){
			List<String> inlist = new ArrayList<String>();
				
			inlist.add(vo.getRefundMonNo()==null?"":vo.getRefundMonNo());			
			inlist.add(vo.getOrderNo()==null?"":vo.getOrderNo());
			inlist.add(vo.getSaleNo()==null?"":vo.getSaleNo());
			inlist.add(vo.getRefundNo()==null?"":vo.getRefundNo());
			inlist.add(vo.getOrderSource()==null?"":vo.getOrderSource());
			inlist.add(vo.getOutOrderNo()==null?"":vo.getOutOrderNo());
			inlist.add(vo.getAccountNo()==null?"":vo.getAccountNo());			
			inlist.add(vo.getMemberNo()==null?"":vo.getMemberNo());
			String refundMonStatusDesc = null;
			if(vo.getReMonStatus()==0){
				refundMonStatusDesc = "未退款";
			}else if(vo.getReMonStatus()==1){
				refundMonStatusDesc = "退款成功";
			}
			inlist.add(vo.getReMonStatus()==null?"":refundMonStatusDesc);
			String refundClass = null;
			if("RequestReturn".equals(vo.getRefundClass())){
				refundClass = "正常退";
			}else if("RejectReturn".equals(vo.getRefundClass())){
				refundClass = "拒收退货";
			}else if("RequestCancelReturn".equals(vo.getRefundClass())){
				refundClass = "发货前退货";
			}else if("OOSReturn".equals(vo.getRefundClass())){
				refundClass = "缺货退货";
			}else{
				refundClass = vo.getRefundClass();
			}
			inlist.add(vo.getRefundClass()==null?"":refundClass);
			
	//		inlist.add(vo.getRefundClass()==null?"":vo.getRefundClass());
			BigDecimal a = new BigDecimal("0");
			if(vo.getNeedRefundMon().compareTo(a)==1){
				inlist.add(vo.getNeedRefundMon()==null?"":"-"+vo.getNeedRefundMon().toString());
			}else{
				inlist.add(vo.getNeedRefundMon()==null?"":vo.getNeedRefundMon().toString());
			}
			inlist.add(vo.getPaymentType()==null?"":vo.getPaymentType());
			inlist.add(vo.getBankName()==null?"":vo.getBankName());
			inlist.add(vo.getBankUser()==null?"":vo.getBankUser());
			inlist.add(vo.getBankType()==null?"":vo.getBankType().toString());
			inlist.add(vo.getAllRefUser()==null?"":vo.getAllRefUser());
			inlist.add(vo.getFinanceMemo()==null?"":vo.getFinanceMemo());
			inlist.add(vo.getAllRefTimeStr()==null?"":vo.getAllRefTimeStr());
			inlist.add(vo.getConfirmRefundTimeStr()==null?"":vo.getConfirmRefundTimeStr());
			
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
		
	}
	/**
	 * 修改退款单状态
	 * @Methods Name updataRefundMonStatus
	 * @Create In 2016-1-14 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updataRefundMonStatus")
	public String updataRefundMonStatus(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundMonNo", request.getParameter("refundMonNo"));
		paramMap.put("allRefUser", request.getParameter("userName"));
		paramMap.put("financeMemo", request.getParameter("financeMemo"));
		paramMap.put("reMonStatus", 1);
		paramMap.put("fromSystem", "PAD");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("update_refundMon_status"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8081/oms-core/refundMon/updateRefundMon.htm", jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 查询字典表下拉框信息
	 * @Methods Name selectParentCodeList
	 * @Create In 2016-3-10 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectParentCodeList")
	public String selectParentCodeList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_parent_codeList"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 分页查询字典表信息
	 * @Methods Name selectCodeListPage
	 * @Create In 2016-3-10 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectCodeListPage")
	public String selectCodeListPage(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("typeValue", request.getParameter("typeValue"));
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_codeList_list"), jsonStr);
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
	 * 保存字典表信息
	 * @Methods Name saveCodeList
	 * @Create In 2016-3-11 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/saveCodeList")
	public String saveCodeList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		paramMap.put("typeValue", request.getParameter("typeValue"));
		paramMap.put("typeName", request.getParameter("typeName"));
		paramMap.put("codeValue", request.getParameter("codeValue"));
		paramMap.put("codeName", request.getParameter("codeName"));
		paramMap.put("latestUpdateMan", "1");

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("save_codeList_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 修改字典表信息
	 * @Methods Name updateCodeList
	 * @Create In 2016-3-11 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updateCodeList")
	public String updateCodeList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		paramMap.put("typeValue", request.getParameter("typeValue"));
		paramMap.put("codeValue", request.getParameter("codeValue"));
		paramMap.put("codeName", request.getParameter("codeName"));
		paramMap.put("sid", request.getParameter("sid"));
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("update_codeList_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	@ResponseBody
	@RequestMapping("/deleteCodeList")
	public String deleteCodeList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		paramMap.put("sid", request.getParameter("sid"));
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("delete_codeList_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 查询Mongo订单信息
	 * @Methods Name foundMongoOrder
	 * @Create In 2016-3-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundMongoOrder")
	public String foundMongoOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNos", request.getParameter("orderNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8091/oms-admin/selectMongo/selectOrderMongo.htm", jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8091/oms-admin/selectMongo/selectOrderMongo.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_MongoOrder_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 修复Mongolia订单信息
	 * @Methods Name fixMongoOrder
	 * @Create In 2016-3-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/fixMongoOrder")
	public String fixMongoOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNos", request.getParameter("orderNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8091/oms-admin/selectMongo/udpateOrderData.htm", jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8091/oms-admin/selectMongo/udpateOrderData.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("fix_MongoOrder_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 查询Mongo销售单信息
	 * @Methods Name foundMongoSale
	 * @Create In 2016-3-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundMongoSale")
	public String foundMongoSale(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNos", request.getParameter("saleNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8091/oms-admin/selectMongo/selectSaleMongo.htm", jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8091/oms-admin/selectMongo/selectSaleMongo.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_MongoSale_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 修复Mongolia销售单信息
	 * @Methods Name fixMongoSale
	 * @Create In 2016-3-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/fixMongoSale")
	public String fixMongoSale(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNos", request.getParameter("saleNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8091/oms-admin/selectMongo/udpateSaleData.htm", jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8091/oms-admin/selectMongo/udpateSaleData.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("fix_MongoSale_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 查询Mongo退货单信息
	 * @Methods Name foundMongoRefund
	 * @Create In 2016-3-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundMongoRefund")
	public String foundMongoRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundNos", request.getParameter("refundNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8091/oms-admin/selectMongo/selectRefundMongo.htm", jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8091/oms-admin/selectMongo/selectRefundMongo.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_MongoRefund_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 修复Mongo退货单信息
	 * @Methods Name fixMongoRefund
	 * @Create In 2016-3-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/fixMongoRefund")
	public String fixMongoRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundNos", request.getParameter("refundNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8091/oms-admin/selectMongo/udpateRefundData.htm", jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8091/oms-admin/selectMongo/udpateRefundData.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("fix_MongoRefund_list"), jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 订单导出Excel
	 * @Methods Name getOrderToExcel
	 * @Create In 2016-3-15 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getOrderToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getOrderToExcel(HttpServletRequest request, HttpServletResponse response){
		String jsons = "";	
		String title = "order";
		List<ExcelOrderVo> epv = new ArrayList<ExcelOrderVo>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(StringUtils.isNotEmpty(request.getParameter("outOrderNo"))){
			map.put("outOrderNo", request.getParameter("outOrderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderStatus"))){
			map.put("orderStatus", request.getParameter("orderStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payStatus"))){
			map.put("payStatus", request.getParameter("payStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			map.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("isCod"))){
			map.put("isCod", request.getParameter("isCod"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("memberNo"))){
			map.put("memberNo", request.getParameter("memberNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("receptPhone"))){
			map.put("receptPhone", request.getParameter("receptPhone"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("startSaleTime"))){
			map.put("saleTimeStartStr", request.getParameter("startSaleTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endSaleTime"))){
			map.put("saleTimeEndStr", request.getParameter("endSaleTime"));
		}
		String jsonStr = JSON.toJSONString(map);
		try {
			String json = HttpUtilPcm.doPost(CommonProperties.get("excel_order_list"), jsonStr);
//			String json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/order/queryOrderExcel.htm", jsonStr);
			
			JSONObject js = JSONObject.fromObject(json);
//			Object objs = js.get("data");
			List<Object> list = (List<Object>) js.get("data");
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
					channelName = jsonObject41.getString("orderSource");
					if(null!=json2Object2){
						for(int j=0; j < json2Object2.size(); j++){
							JSONObject jsonObject31 = (JSONObject) json2Object2.get(j);
							String codeValue = jsonObject31.getString("channelCode");
							String codeName = jsonObject31.getString("channelName");
							if(channelName.equals(codeValue)){
								channelName = codeName;
								jsonObject41.put("orderSource",codeName);
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
			
			// 得到JSONArray
//			JSONArray arr = JSONArray.fromObject(objs);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
//					JSONObject jOpt = arr.getJSONObject(i);
					JSONObject jOpt = (JSONObject) list.get(i);
					ExcelOrderVo vo = (ExcelOrderVo) JSONObject.toBean(jOpt,ExcelOrderVo.class);
					epv.add(vo);
				}
			}
			
			Object result = allOrderToExcel(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}
		
		return jsons;
	}
	public String allOrderToExcel(HttpServletResponse response,List<ExcelOrderVo> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("订单号");
		header.add("外部订单号");
		header.add("订单状态");
		header.add("CID");
		header.add("会员卡号");
		header.add("订单来源");
		header.add("订单类型");
		header.add("商品销售总额");
		header.add("销售时间");
		header.add("延迟时间");
		header.add("支付类型");
		header.add("支付状态");
		header.add("支付时间");
		header.add("是否需要开发票");
		header.add("应收运费");
		header.add("订单应付金额(含运费)");
		header.add("现金类支付金额(含运费不含积分)");
		header.add("使用余额总额");
		header.add("订单优惠金额");
		header.add("取消原因");
		header.add("客户备注");
		header.add("客服备注");
		header.add("收件人电话");
		header.add("收件人姓名");
		header.add("收件人城市");
		header.add("收件城市邮编");
		header.add("收件地区省份");
		header.add("收货地址");
		header.add("是否货到付款");
		header.add("最后修改人");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelOrderVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getOrderNo()==null?"":vo.getOrderNo());	
			inlist.add(vo.getOutOrderNo()==null?"":vo.getOutOrderNo());	
			inlist.add(vo.getOrderStatusDesc()==null?"":vo.getOrderStatusDesc());	
			inlist.add(vo.getAccountNo()==null?"":vo.getAccountNo());	
			inlist.add(vo.getMemberNo()==null?"":vo.getMemberNo());	
			inlist.add(vo.getOrderSource()==null?"":vo.getOrderSource());
//			String orderSource = null;
//			if(vo.getOrderSource().equals("C1")){
//				orderSource = "线上 C1";
//			}else if(vo.getOrderSource().equals("X1")){
//				orderSource = "线下 X1";
//			}else if(vo.getOrderSource().equals("C7")){
//				orderSource = "天猫";
//			}else if(vo.getOrderSource().equals("CB")){
//				orderSource = "全球购";
//			}
//			inlist.add(vo.getOrderSource()==null?"":orderSource);
//			inlist.add(vo.getOrderType()==null?"":vo.getOrderType());
			String orderType = null;
			if(vo.getOrderType().equals("PT")){
				orderType = "普通订单";
			}else if(vo.getOrderType().equals("TG")){
				orderType = "团购订单";
			}else if(vo.getOrderType().equals("DK")){
				orderType = "代客下单";
			}else if(vo.getOrderType().equals("KT")){
				orderType = "快腿订单";
			}else if(vo.getOrderType().equals("YG")){
				orderType = "员工订单";
			}
			inlist.add(vo.getOrderType()==null?"":orderType);
			inlist.add(vo.getSalesAmount()==null?"":vo.getSalesAmount().toString());
			inlist.add(vo.getSaleTimeStr()==null?"":vo.getSaleTimeStr());
			inlist.add(vo.getDelayTimeStr()==null?"":vo.getDelayTimeStr());
//			inlist.add(vo.getPaymentClass()==null?"":vo.getPaymentClass());
			String paymentClass = null;
			if("ONLINE".equals(vo.getPaymentClass())){
				paymentClass = "在线支付";
			}else {
				paymentClass = "货到付款";
			}
			inlist.add(vo.getPaymentClass()==null?"":paymentClass);
//			inlist.add(vo.getPayStatus()==null?"":vo.getPayStatus());
			String payStatus = null;
			if(vo.getPayStatus().equals("5001")){
				payStatus = "未支付";
			}else if(vo.getPayStatus().equals("5002")){
				payStatus = "部分支付";
			}else if(vo.getPayStatus().equals("5003")){
				payStatus = "超时未支付";
			}else if(vo.getPayStatus().equals("5004")){
				payStatus = "已支付";
			}
			inlist.add(vo.getPayStatus()==null?"":payStatus);
			inlist.add(vo.getPayTimeStr()==null?"":vo.getPayTimeStr());
//			inlist.add(vo.getNeedInvoice()==null?"":vo.getNeedInvoice());
			String needInvoice = null;
			if(vo.getNeedInvoice().equals("0")){
				needInvoice = "否";
			}else if(vo.getNeedInvoice().equals("1")){
				needInvoice = "是";
			}
			inlist.add(vo.getNeedInvoice()==null?"":needInvoice);
			inlist.add(vo.getNeedSendCost()==null?"":vo.getNeedSendCost().toString());
			inlist.add(vo.getPaymentAmount()==null?"":vo.getPaymentAmount().toString());
			inlist.add(vo.getCashIncome()==null?"":vo.getCashIncome().toString());
			inlist.add(vo.getAccountBalanceAmount()==null?"":vo.getAccountBalanceAmount().toString());
			inlist.add(vo.getPromotionAmount()==null?"":vo.getPromotionAmount().toString());
			inlist.add(vo.getCancelReason()==null?"":vo.getCancelReason());
			inlist.add(vo.getCustomerComments()==null?"":vo.getCustomerComments());
			inlist.add(vo.getCallCenterComments()==null?"":vo.getCallCenterComments());
			inlist.add(vo.getReceptPhone()==null?"":vo.getReceptPhone());
			inlist.add(vo.getReceptName()==null?"":vo.getReceptName());
			inlist.add(vo.getReceptCityName()==null?"":vo.getReceptCityName());
			inlist.add(vo.getReceptCityCode()==null?"":vo.getReceptCityCode());
			inlist.add(vo.getReceptProvName()==null?"":vo.getReceptProvName());
			inlist.add(vo.getReceptAddress()==null?"":vo.getReceptAddress());
//			inlist.add(vo.getIsCod()==null?"":vo.getIsCod().toString());
			String isCod = null;
			if(vo.getIsCod()==0){
				isCod = "否";
			}else if(vo.getIsCod()==1){
				isCod = "是";
			}
			inlist.add(vo.getIsCod()==null?"":isCod);
			inlist.add(vo.getLatestUpdateMan()==null?"":vo.getLatestUpdateMan());
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	/**
	 * 订单导出Excel（手机号查询）
	 * @Methods Name getOrderToExcelByPhone
	 * @Create In 2016-7-15 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getOrderToExcelByPhone",method={RequestMethod.GET,RequestMethod.POST})
	public String getOrderToExcelByPhone(HttpServletRequest request, HttpServletResponse response){
		String jsons = "";	
		String title = "order";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		List<ExcelOrderVo> epv = new ArrayList<ExcelOrderVo>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(StringUtils.isNotEmpty(request.getParameter("outOrderNo"))){
			map.put("outOrderNo", request.getParameter("outOrderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("supplyProductNo"))){
			map.put("supplyProductNo", request.getParameter("supplyProductNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderStatus"))){
			map.put("orderStatus", request.getParameter("orderStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payStatus"))){
			map.put("payStatus", request.getParameter("payStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			map.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("isCod"))){
			map.put("isCod", request.getParameter("isCod"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("memberNo"))){
			map.put("memberNo", request.getParameter("memberNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("receptPhone"))){
			map.put("receptPhone", request.getParameter("receptPhone"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("startSaleTime"))){
			map.put("saleTimeStartStr", request.getParameter("startSaleTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endSaleTime"))){
			map.put("saleTimeEndStr", request.getParameter("endSaleTime"));
		}
		map.put("start", String.valueOf(currPage));
		map.put("limit", String.valueOf(size));
		String jsonStr = JSON.toJSONString(map);
		try {
			logger.info("导出Excel表格调oms接口入参:{}",jsonStr);
			String json = HttpUtilPcm.doPost(CommonProperties.get("select_order_list_phone2"), jsonStr);
			logger.info("导出Excel表格调oms接口出参:{}",json);
			JSONObject js = JSONObject.fromObject(json);
			String data = js.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
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
					channelName = jsonObject41.getString("orderSource");
					if(null!=json2Object2){
						for(int j=0; j < json2Object2.size(); j++){
							JSONObject jsonObject31 = (JSONObject) json2Object2.get(j);
							String codeValue = jsonObject31.getString("channelCode");
							String codeName = jsonObject31.getString("channelName");
							if(channelName.equals(codeValue)){
								channelName = codeName;
								jsonObject41.put("orderSource",codeName);
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
			
			// 得到JSONArray
//			JSONArray arr = JSONArray.fromObject(objs);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
//					JSONObject jOpt = arr.getJSONObject(i);
					JSONObject jOpt = (JSONObject) list.get(i);
					ExcelOrderVo vo = (ExcelOrderVo) JSONObject.toBean(jOpt,ExcelOrderVo.class);
					epv.add(vo);
				}
			}
			
			Object result = allOrderToExcelByPhone(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}
		
		return jsons;
	}
	public String allOrderToExcelByPhone(HttpServletResponse response,List<ExcelOrderVo> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("订单号");
		header.add("外部订单号");
		header.add("订单状态");
		header.add("CID");
		header.add("会员卡号");
		header.add("订单来源");
		header.add("订单类型");
		header.add("商品名称");
		header.add("商品销售总额");
		header.add("销售时间");
		header.add("延迟时间");
		header.add("支付类型");
		header.add("支付状态");
		header.add("支付时间");
		header.add("是否需要开发票");
		header.add("应收运费");
		header.add("订单应付金额(含运费)");
		header.add("现金类支付金额(含运费不含积分)");
		header.add("积分");
		header.add("使用余额总额");
		header.add("订单优惠金额");
		header.add("取消原因");
		header.add("客户备注");
		header.add("客服备注");
		header.add("收件人电话");
		header.add("收件人姓名");
		header.add("收件人城市");
		header.add("收件城市邮编");
		header.add("收件地区省份");
		header.add("收货地址");
		header.add("是否货到付款");
		header.add("最后修改人");
		
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelOrderVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getOrderNo()==null?"":vo.getOrderNo());	
			inlist.add(vo.getOutOrderNo()==null?"":vo.getOutOrderNo());	
			inlist.add(vo.getOrderStatusDesc()==null?"":vo.getOrderStatusDesc());	
			inlist.add(vo.getAccountNo()==null?"":vo.getAccountNo());	
			inlist.add(vo.getMemberNo()==null?"":vo.getMemberNo());	
			inlist.add(vo.getOrderSource()==null?"":vo.getOrderSource());
//			String orderSource = null;
//			if(vo.getOrderSource().equals("C1")){
//				orderSource = "线上 C1";
//			}else if(vo.getOrderSource().equals("X1")){
//				orderSource = "线下 X1";
//			}else if(vo.getOrderSource().equals("C7")){
//				orderSource = "天猫";
//			}else if(vo.getOrderSource().equals("CB")){
//				orderSource = "全球购";
//			}
//			inlist.add(vo.getOrderSource()==null?"":orderSource);
//			inlist.add(vo.getOrderType()==null?"":vo.getOrderType());
			String orderType = null;
			if(vo.getOrderType().equals("PT")){
				orderType = "普通订单";
			}else if(vo.getOrderType().equals("TG")){
				orderType = "团购订单";
			}else if(vo.getOrderType().equals("DK")){
				orderType = "代客下单";
			}else if(vo.getOrderType().equals("KT")){
				orderType = "快腿订单";
			}else if(vo.getOrderType().equals("YG")){
				orderType = "员工订单";
			}
			inlist.add(vo.getOrderType()==null?"":orderType);
			inlist.add(vo.getShoppeProName()==null ? "" : vo.getShoppeProName());
			inlist.add(vo.getSalesAmount()==null?"":vo.getSalesAmount().toString());
			inlist.add(vo.getSaleTimeStr()==null?"":vo.getSaleTimeStr());
			inlist.add(vo.getDelayTimeStr()==null?"":vo.getDelayTimeStr());
//			inlist.add(vo.getPaymentClass()==null?"":vo.getPaymentClass());
			String paymentClass = null;
			if("ONLINE".equals(vo.getPaymentClass())){
				paymentClass = "在线支付";
			}else {
				paymentClass = "货到付款";
			}
			inlist.add(vo.getPaymentClass()==null?"":paymentClass);
//			inlist.add(vo.getPayStatus()==null?"":vo.getPayStatus());
			String payStatus = null;
			if(vo.getPayStatus().equals("5001")){
				payStatus = "未支付";
			}else if(vo.getPayStatus().equals("5002")){
				payStatus = "部分支付";
			}else if(vo.getPayStatus().equals("5003")){
				payStatus = "超时未支付";
			}else if(vo.getPayStatus().equals("5004")){
				payStatus = "已支付";
			}
			inlist.add(vo.getPayStatus()==null?"":payStatus);
			inlist.add(vo.getPayTimeStr()==null?"":vo.getPayTimeStr());
//			inlist.add(vo.getNeedInvoice()==null?"":vo.getNeedInvoice());
			String needInvoice = null;
			if(vo.getNeedInvoice().equals("0")){
				needInvoice = "否";
			}else if(vo.getNeedInvoice().equals("1")){
				needInvoice = "是";
			}
			inlist.add(vo.getNeedInvoice()==null?"":needInvoice);
			inlist.add(vo.getNeedSendCost()==null?"":vo.getNeedSendCost().toString());
			inlist.add(vo.getPaymentAmount()==null?"":vo.getPaymentAmount().toString());
			inlist.add(vo.getCashAmount()==null?"":vo.getCashAmount().toString());
			inlist.add(vo.getIntegral()==null?"":vo.getIntegral().toString());
			inlist.add(vo.getAccountBalanceAmount()==null?"":vo.getAccountBalanceAmount().toString());
			inlist.add(vo.getPromotionAmount()==null?"":vo.getPromotionAmount().toString());
			inlist.add(vo.getCancelReason()==null?"":vo.getCancelReason());
			inlist.add(vo.getCustomerComments()==null?"":vo.getCustomerComments());
			inlist.add(vo.getCallCenterComments()==null?"":vo.getCallCenterComments());
			inlist.add(vo.getReceptPhone()==null?"":vo.getReceptPhone());
			inlist.add(vo.getReceptName()==null?"":vo.getReceptName());
			inlist.add(vo.getReceptCityName()==null?"":vo.getReceptCityName());
			inlist.add(vo.getReceptCityCode()==null?"":vo.getReceptCityCode());
			inlist.add(vo.getReceptProvName()==null?"":vo.getReceptProvName());
			inlist.add(vo.getReceptAddress()==null?"":vo.getReceptAddress());
//			inlist.add(vo.getIsCod()==null?"":vo.getIsCod().toString());
			String isCod = null;
			if(vo.getIsCod()==0){
				isCod = "否";
			}else if(vo.getIsCod()==1){
				isCod = "是";
			}
			inlist.add(vo.getIsCod()==null?"":isCod);
			inlist.add(vo.getLatestUpdateMan()==null?"":vo.getLatestUpdateMan());
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	/**
	 * 查询线上支付分页
	 * @Methods Name selectPaymentPage
	 * @Create In 2016-3-16 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectPaymentPage")
	public String selectPaymentPage(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<String,Object> paramMap = new HashMap<String,Object>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("salesPaymentNo"))){
			paramMap.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
//		if(StringUtils.isNotEmpty(request.getParameter("startPayTime"))){
//			paramMap.put("startPayTime", request.getParameter("startPayTime"));
//		}
//		if(StringUtils.isNotEmpty(request.getParameter("endPayTime"))){
//			paramMap.put("endPayTime", request.getParameter("endPayTime"));
//		}
		
		SimpleDateFormat formatter; 
	    formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	    if(StringUtils.isNotEmpty(request.getParameter("startPayTime"))){
	    	Date date = sdf.parse(request.getParameter("startPayTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
	    	String startDate = sdf.format(date2);
	    	paramMap.put("startPayTime", startDate);
	    }
	    if(StringUtils.isNotEmpty(request.getParameter("endPayTime"))){
	    	Date date = sdf.parse(request.getParameter("endPayTime"));
	    	Calendar calendar = Calendar.getInstance();
	    	calendar.setTime(date);
	    	calendar.add(Calendar.HOUR_OF_DAY, -8);
	    	Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
	    	paramMap.put("endPayTime", endDate);
	    }
		
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_payment_Page"), jsonStr);
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
	 * 退货单导出Excel
	 * @Methods Name getRefundToExcel
	 * @Create In 2016-3-17 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getRefundToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getRefundToExcel(HttpServletRequest request, HttpServletResponse response){
		String jsons = "";	
		String title = "refund";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		List<ExcelRefundVo> epv = new ArrayList<ExcelRefundVo>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(StringUtils.isNotEmpty(request.getParameter("outOrderNo"))){
			map.put("outOrderNo", request.getParameter("outOrderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("receptPhone"))){
			map.put("receptPhone", request.getParameter("receptPhone"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundApplyNo"))){
			map.put("refundApplyNo", request.getParameter("refundApplyNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundNo"))){
			map.put("refundNo", request.getParameter("refundNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			map.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("originalSalesNo"))){
			map.put("originalSalesNo", request.getParameter("originalSalesNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("salesPaymentNo"))){
			map.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundStatus"))){
			map.put("refundStatus", request.getParameter("refundStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("memberNo"))){
			map.put("memberNo", request.getParameter("memberNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("shopNo"))){
			map.put("shopNo", request.getParameter("shopNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("rebateStatus"))){
			map.put("rebateStatus", request.getParameter("rebateStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundType"))){
			map.put("refundType", request.getParameter("refundType"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundClass"))){
			map.put("refundClass", request.getParameter("refundClass"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endRefundTime"))){
			map.put("endRefundTime", request.getParameter("endRefundTime").trim());
		}
		if(StringUtils.isNotEmpty(request.getParameter("startRefundTime"))){
			map.put("startRefundTime", request.getParameter("startRefundTime").trim());
		}
		map.put("start", String.valueOf(currPage));
		map.put("limit", String.valueOf(size));
		map.put("fromSystem", "OMSADMIN");
		String jsonStr = JSON.toJSONString(map);
		try {
//			String json = HttpUtilPcm.doPost(CommonProperties.get("excel_refund_list"), jsonStr);
			String json = HttpUtilPcm.doPost(CommonProperties.get("select_refund_list_excel"), jsonStr);
//			String json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/refund/queryRefundExcel.htm", jsonStr);
			
			JSONObject js = JSONObject.fromObject(json);
//			Object objs = js.get("data");
//			List<Object> list = (List<Object>) js.get("data");
			String data = js.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			paramMap2.put("typeValue", "refund_status");
			String jsonStr2 = JSON.toJSONString(paramMap2);
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_codelist_selectBox"), jsonStr2);
			logger.info("json2:" + json2);
			JSONObject jsonObjectJ2 = JSONObject.fromObject(json2);
			String codeData = jsonObjectJ2.getString("data");
			JSONArray json2Object = JSONArray.fromObject(codeData);
			
			List<Object> list3 = new ArrayList<Object>();
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String codeValue=null;
				try{
					codeValue = jsonObject4.getString("refundStatus");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String code = jsonObject3.getString("codeValue");
							String name = jsonObject3.getString("codeName");
							if(codeValue.equals(code)){
								codeValue = name;
								jsonObject4.put("refundStatus",codeValue);
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
				}catch (Exception e){
					list3.add(jsonObject4);
				}
			}
			list=list3;
			
			// 得到JSONArray
//			JSONArray arr = JSONArray.fromObject(objs);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
//					JSONObject jOpt = arr.getJSONObject(i);
					JSONObject jOpt = (JSONObject) list.get(i);
					ExcelRefundVo vo = (ExcelRefundVo) JSONObject.toBean(jOpt,ExcelRefundVo.class);
					epv.add(vo);
				}
			}
			
			Object result = allRefundToExcel(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}
		
		return jsons;
	}
	public String allRefundToExcel(HttpServletResponse response,List<ExcelRefundVo> list, String title) {
		List<String> header = new ArrayList<String>();
        header.add("退货单号");
		header.add("订单号");
		header.add("退货申请单号");
		header.add("原销售单号");
		header.add("外部订单号");
		header.add("手机号");
		header.add("退货单状态");
		header.add("退款状态");
		header.add("会员卡号");
		header.add("CID");
		header.add("退货类型");
		header.add("退货类别");
		header.add("退款路径");
		/*上线前添加7-30*/
		header.add("退货原因");
		header.add("商品名称");
		
		header.add("第三方退货单号");
		header.add("应退金额");
		header.add("实退金额");
		header.add("退货总数");
		header.add("门店名称");
		header.add("供应商名称");
		header.add("专柜名称");
		header.add("收银流水号");
		header.add("机器号");
		header.add("受理人");
		header.add("受理门店");
//		header.add("退货时间");
		header.add("最后修改人");
//		header.add("最后修改时间");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelRefundVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getRefundNo()==null?"":vo.getRefundNo());	
			inlist.add(vo.getOrderNo()==null?"":vo.getOrderNo());
			inlist.add(vo.getRefundApplyNo()==null?"":vo.getRefundApplyNo());
			inlist.add(vo.getOriginalSalesNo()==null?"":vo.getOriginalSalesNo());	
			inlist.add(vo.getOutOrderNo()==null?"":vo.getOutOrderNo());	
			inlist.add(vo.getReceptPhone()==null?"":vo.getReceptPhone());	
			inlist.add(vo.getRefundStatus()==null?"":vo.getRefundStatus());
//			inlist.add(vo.getRebateStatus()==null?"":vo.getRebateStatus());	
			String rebateStatus = null;
			if(vo.getRebateStatus()==null){
				rebateStatus=null;
			}else if(vo.getRebateStatus().equals("1")){
				rebateStatus = "已退款";
			}else if(vo.getRebateStatus().equals("0")){
				rebateStatus = "未退款";
			}
			inlist.add(vo.getRebateStatus()==null?"":rebateStatus);
			inlist.add(vo.getMemberNo()==null?"":vo.getMemberNo());	
			inlist.add(vo.getAccountNo()==null?"":vo.getAccountNo());	
//			inlist.add(vo.getRefundType()==null?"":vo.getRefundType().toString());	
			String refundType = null;
			if(vo.getRefundType()==null){
				refundType = null;
			}else if(vo.getRefundType()==1){
				refundType = "线上";
			}else if(vo.getRefundType()==2){
				refundType = "线下";
			}
			inlist.add(vo.getRefundType()==null?"":refundType);
//			inlist.add(vo.getRefundClass()==null?"":vo.getRefundClass());
			String refundClass = null;
			if(vo.getRefundClass()==null){
				refundClass=null;
			}else if(vo.getRefundClass().equals("THD")){
				refundClass = "退货单";
			}else if(vo.getRefundClass().equals("RequestReturn")){
				refundClass = "正常退";
			}else if(vo.getRefundClass().equals("RejectReturn")){
				refundClass = "拒收退";
			}else if(vo.getRefundClass().equals("03")){
				refundClass = "换货退";
			}else if(vo.getRefundClass().equals("RequestCancelReturn")){
				refundClass = "发货前退货";
			}else if(vo.getRefundClass().equals("OOSReturn")){
				refundClass = "缺货退货";
			}
			inlist.add(vo.getRefundClass()==null?"":refundClass);
			inlist.add(vo.getRefundTarget()==null?"":vo.getRefundTarget());	
			//退货原因
			inlist.add(vo.getRefundReasionNo()==null?"":vo.getRefundReasionNo());	
			inlist.add(vo.getShoppeProName()==null?"":vo.getShoppeProName());	
			
			inlist.add(vo.getExternalRefundNo()==null?"":vo.getExternalRefundNo());	
			inlist.add(vo.getRefundAmount()==null?"":vo.getRefundAmount().toString());	
			inlist.add(vo.getNeedRefundAmount()==null?"":vo.getNeedRefundAmount().toString());
			inlist.add(vo.getRefundNum()==null?"":vo.getRefundNum().toString());
			inlist.add(vo.getShopName()==null?"":vo.getShopName());
			inlist.add(vo.getSupplyName()==null?"":vo.getSupplyName());
			inlist.add(vo.getShoppeName()==null?"":vo.getShoppeName());
			inlist.add(vo.getSalesPaymentNo()==null?"":vo.getSalesPaymentNo());
			inlist.add(vo.getCasherNo()==null?"":vo.getCasherNo());
			inlist.add(vo.getOperator()==null?"":vo.getOperator());
			inlist.add(vo.getOperatorStore()==null?"":vo.getOperatorStore());
//			inlist.add(vo.getRefundTimeStr()==null?"":vo.getRefundTimeStr());
			inlist.add(vo.getLatestUpdateMan()==null?"":vo.getLatestUpdateMan());
//			inlist.add(vo.getLatestUpdateTimeStr()==null?"":vo.getLatestUpdateTimeStr());
			
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	/**
	 * 退货申请单取消
	 * @Methods Name refundApplyCancel
	 * @Create In 2016-3-18 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/refundApplyCancel")
	public String refundApplyCancel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		paramMap.put("latestUpdateMan", request.getParameter("lastUpdateMan"));
		paramMap.put("problemDesc", request.getParameter("cancelReason")); 
		
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("cancel_refundApply_status"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/refundApply/deleteRefundApplyStatus.htm", jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 退货单取消
	 * @Methods Name refundCancel
	 * @Create In 2016-3-18 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/refundCancel")
	public String refundCancel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundNo", request.getParameter("refundNo"));
		paramMap.put("operator", request.getParameter("latestUpdateMan"));
//		paramMap.put("problemDesc", request.getParameter("cancelReason"));没地方接收
		
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("cancel_refund_status"), jsonStr);
//			json = HttpUtilPcm.doPost("http://192.168.7.34:8081/oms-core/refundApply/deleteRefundStatus.htm", jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	@ResponseBody
	@RequestMapping("/selectOrderGetSplit")
	public String selectOrderGetSplit(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderItemNo", request.getParameter("orderItemNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_order_getSplit"), jsonStr);
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
	 * 支付平台报表明細
	 * 
	 * @Methods Name posPlatFormList
	 * @Create In 2016-3-30 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/posPlatFormList")
	public String posPlatFormList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("paymentType", request.getParameter("payType"));
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
			paramMap.put("startFlowTime", request.getParameter("startTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
			paramMap.put("endFlowTime", request.getParameter("endTime"));
		}
		paramMap.put("fromSystem", "OMSADMIN");
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_pos_platform"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSelect/checkPaymentItem.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
			logger.info("json2:" + json2);
			JSONArray json2Object = JSONArray.fromObject(json2);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String paymentType=null;
				try{
					paymentType = jsonObject4.getString("paymentType");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String code = jsonObject3.getString("code");
							String name = jsonObject3.getString("name");
							if(paymentType.equals(code)){
								paymentType = name;
								jsonObject4.put("paymentType",paymentType);
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
				}catch (Exception e){
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
	 * 支付介质
	 * 
	 * @Methods Name selectCodelist
	 * @Create In 2016-3-30 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPaymentType")
	public String selectPaymentType(HttpServletRequest request, HttpServletResponse response) {
		String json = "";

		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("remark"))){
			paramMap.put("remark", request.getParameter("remark"));
		}
		paramMap.put("fromSystem", "OMSADMIN");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			 json =HttpUtilPcm.doPost(CommonProperties.get("select_paymentType2_list"),jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8093/oms-syn/paymentType/selectPaymentType2.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
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
	 * 支付平台报表明細导出excel
	 * 
	 * @Methods Name getPosPlatformToExcel
	 * @Create In 2016-3-31 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getPosPlatformToExcel", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getPosPlatformToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		String title = "posPlatform";
		List<ExcelPosPlatformVo> epv = new ArrayList<ExcelPosPlatformVo>();
		Map<String, Object> map = new HashMap<String, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			map.put("orderNo", request.getParameter("orderNo"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("paymentType"))) {
			map.put("paymentType", request.getParameter("paymentType"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("endTime"))) {
			map.put("endFlowTime", request.getParameter("endTime").trim());
		}
		if (StringUtils.isNotEmpty(request.getParameter("startTime"))) {
			map.put("startFlowTime", request.getParameter("startTime").trim());
		}
		map.put("fromSystem", "OMSADMIN");
		String jsonStr = JSON.toJSONString(map);
		try {
			String json = HttpUtilPcm.doPost(CommonProperties.get("excel_PosPlatformNoPage_list"),jsonStr);
//			 String json =HttpUtilPcm.doPost("http://127.0.0.1:8087/oms-core-sdc/ofSelect/checkPaymentItemNoPage.htm",jsonStr);

			JSONObject js = JSONObject.fromObject(json);
			Object objs = js.get("data");
			// 得到JSONArray
			JSONArray arr = JSONArray.fromObject(objs);
			if (arr.size() > 0) {
				for (int i = 0; i < arr.size(); i++) {
					JSONObject jOpt = arr.getJSONObject(i);
					ExcelPosPlatformVo vo = (ExcelPosPlatformVo) JSONObject.toBean(jOpt,ExcelPosPlatformVo.class);
					
					String jsonStr2 = "";
					Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
					paramMap2.put("fromSystem", "OMSADMIN");
					String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
					logger.info("json2:" + json2);
					JSONArray json2Object = JSONArray.fromObject(json2);
					String paymentType = vo.getPaymentType();
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String code = jsonObject3.getString("code");
							String name = jsonObject3.getString("name");
							if(code.equals(paymentType)){
								paymentType = name;
								vo.setPaymentType(paymentType);
								break;
							}else if(j==json2Object.size()-1){
								vo.setPaymentType(paymentType);
							}
						}
					}else{
						vo.setPaymentType(paymentType);
					}
					epv.add(vo);
				}
			}

			Object result = allPosPlatformToExcel(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);

		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}

		return jsons;
	}

	public String allPosPlatformToExcel(HttpServletResponse response,
			List<ExcelPosPlatformVo> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("订单号");
		header.add("外部订单号");
		header.add("支付金额");
		header.add("支付时间");
		header.add("支付对账日期");
		header.add("付款方式");

		List<List<String>> data = new ArrayList<List<String>>();
		for (ExcelPosPlatformVo vo : list) {
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getOrderNo() == null ? "" : vo.getOrderNo());
			inlist.add(vo.getOutOrderNo() == null ? "" : vo.getOutOrderNo());
			inlist.add(vo.getAmount() == null ? "" : vo.getAmount().toString());
			inlist.add(vo.getPayTimeStr() == null ? "" : vo.getPayTimeStr());
			inlist.add(vo.getReconciliationTime() == null ? "" : vo.getReconciliationTime()
					.toString());
			inlist.add(vo.getPaymentType() == null ? "" : vo.getPaymentType());

			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-disposition", "attachment; filename=/" + title + ".xls");

			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	/**
	 * 查询COD订单审核阀值
	 * @Methods Name selectCodThreshold
	 * @Create In 2016-4-5 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectCodThreshold")
	public String selectCodThreshold(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "OMSADMIN");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_codThreshold_list"), jsonStr);
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
	 * 修改COD订单自动审核阀值
	 * @Methods Name updateCodThreshold
	 * @Create In 2016-4-5 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updateCodThreshold")
	public String updateCodThreshold(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "OMSADMIN");
		paramMap.put("latestUpdateMan", request.getParameter("userName"));
		paramMap.put("thresholdAmount", request.getParameter("thresholdAmount"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("update_codThreshold_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String success= (String) jsonObject.get("success");
			if (success.equals("true")) {
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
	 * 支付平台报表汇总
	 * @Methods Name posPlatFormAllList
	 * @Create In 2016-4-6 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/posPlatFormAllList")
	public String posPlatFormAllList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("paymentType", request.getParameter("payType"));
		if(StringUtils.isNotEmpty(request.getParameter("refundClass"))){
			paramMap.put("refundClass", request.getParameter("refundClass"));
		}else{
			paramMap.put("refundClass", "saleOrder");
		}
		if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
			paramMap.put("startFlowTime", request.getParameter("startTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
			paramMap.put("endFlowTime", request.getParameter("endTime"));
		}
		paramMap.put("fromSystem", "OMSADMIN");
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_pos_Allplatform"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSelect/checkReconciliation.htm", jsonStr);
			logger.info("json:" + json);
//			JSONObject jsonObject = JSONObject.fromObject(json);
			com.alibaba.fastjson.JSONObject jsonObject = (com.alibaba.fastjson.JSONObject) JSON.parseObject(json);
			String data = jsonObject.getString("data");
//			JSONObject jsonObject2 = JSONObject.fromObject(data);
			com.alibaba.fastjson.JSONObject jsonObject2 = (com.alibaba.fastjson.JSONObject) JSON.parseObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
			logger.info("json2:" + json2);
			JSONArray json2Object = JSONArray.fromObject(json2);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String paymentType=null;
				try{
					paymentType = jsonObject4.getString("paymentType");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String code = jsonObject3.getString("code");
							String name = jsonObject3.getString("name");
							if(paymentType.equals(code)){
								paymentType = name;
								jsonObject4.put("paymentType",paymentType);
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
				}catch (Exception e){
					list3.add(jsonObject4);
				}
			}
			list=list3;
					
					
			Integer count = jsonObject2.getInteger("count");
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
	 * 支付平台报表汇总导出Excel
	 * @Methods Name getPosPlatformAllToExcel
	 * @Create In 2016-4-7 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getPosPlatformAllToExcel", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getPosPlatformAllToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		String title = "posPlatformAl";
		List<ExcelAllPosPlatformVo> epv = new ArrayList<ExcelAllPosPlatformVo>();
		Map<String, Object> map = new HashMap<String, Object>();

		if (StringUtils.isNotEmpty(request.getParameter("refundClass"))) {
			map.put("refundClass", request.getParameter("refundClass"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("paymentType"))) {
			map.put("paymentType", request.getParameter("paymentType"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("endTime"))) {
			map.put("endFlowTime", request.getParameter("endTime").trim());
		}
		if (StringUtils.isNotEmpty(request.getParameter("startTime"))) {
			map.put("startFlowTime", request.getParameter("startTime").trim());
		}
		map.put("fromSystem", "OMSADMIN");
		String jsonStr = JSON.toJSONString(map);
		try {
			String json = HttpUtilPcm.doPost(CommonProperties.get("excel_PosPlatformAllNoPage_list"),jsonStr);
//			 String json =HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSelect/checkReconciliationNoPage.htm",jsonStr);

//			JSONObject js = JSONObject.fromObject(json);
			com.alibaba.fastjson.JSONObject js = (com.alibaba.fastjson.JSONObject) JSON.parseObject(json);
			Object objs = js.get("data");
			// 得到JSONArray
			JSONArray arr = JSONArray.fromObject(objs);
			if (arr.size() > 0) {
				for (int i = 0; i < arr.size(); i++) {
					JSONObject jOpt = arr.getJSONObject(i);
					ExcelAllPosPlatformVo vo = (ExcelAllPosPlatformVo) JSONObject.toBean(jOpt,ExcelAllPosPlatformVo.class);
					
					String jsonStr2 = "";
					Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
					paramMap2.put("fromSystem", "OMSADMIN");
					String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
					logger.info("json2:" + json2);
					JSONArray json2Object = JSONArray.fromObject(json2);
					String paymentType = vo.getPaymentType();
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String code = jsonObject3.getString("code");
							String name = jsonObject3.getString("name");
							if(code.equals(paymentType)){
								paymentType = name;
								vo.setPaymentType(paymentType);
								break;
							}else if(j==json2Object.size()-1){
								vo.setPaymentType(paymentType);
							}
						}
					}else{
						vo.setPaymentType(paymentType);
					}
					epv.add(vo);
				}
			}

			Object result = allPosPlatformAllToExcel(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);

		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}

		return jsons;
	}

	public String allPosPlatformAllToExcel(HttpServletResponse response,
			List<ExcelAllPosPlatformVo> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("业务类型");
		header.add("支付方式");
		header.add("应收金额");

		List<List<String>> data = new ArrayList<List<String>>();
		for (ExcelAllPosPlatformVo vo : list) {
			List<String> inlist = new ArrayList<String>();
			
			String refundClass = null;
			if(vo.getRefundClass()==null){
				refundClass=null;
			}else if(vo.getRefundClass().equals("saleOrder")){
				refundClass = "销售订单";
			}else if(vo.getRefundClass().equals("RequestReturn")){
				refundClass = "正常退";
			}else if(vo.getRefundClass().equals("RejectReturn")){
				refundClass = "拒收退";
			}else if(vo.getRefundClass().equals("03")){
				refundClass = "换货退";
			}else if(vo.getRefundClass().equals("RequestCancelReturn")){
				refundClass = "发货前退货";
			}else if(vo.getRefundClass().equals("OOSReturn")){
				refundClass = "缺货退货";
			}
			inlist.add(vo.getRefundClass() == null ? "" : refundClass);
			
			inlist.add(vo.getPaymentType() == null ? "" : vo.getPaymentType());
			inlist.add(vo.getAmount() == null ? "" : vo.getAmount().toString());

			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-disposition", "attachment; filename=/" + title + ".xls");

			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	/**
	 * 订单取消扣款报表
	 * @Methods Name orderCancelRefundMoney
	 * @Create In 2016-4-8 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderCancelRefundMoney")
	public String orderCancelRefundMoney(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("saleNo"))){
			paramMap.put("saleNo", request.getParameter("saleNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payType"))){
			paramMap.put("payType", request.getParameter("payType"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
			paramMap.put("saleStartFlowTime", request.getParameter("startTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
			paramMap.put("saleEndFlowTime", request.getParameter("endTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundStartFlowTime"))){
			paramMap.put("refundStartFlowTime", request.getParameter("refundStartFlowTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundEndFlowTime"))){
			paramMap.put("refundEndFlowTime", request.getParameter("refundEndFlowTime"));
		}
		paramMap.put("fromSystem", "OMSADMIN");
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_orderCancel_refundMoney"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSelect/checkChargeReport.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			String jsonStr2 = "";
			Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
			paramMap2.put("fromSystem", "OMSADMIN");
			String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
			logger.info("json2:" + json2);
			JSONArray json2Object = JSONArray.fromObject(json2);
//			List<Object> list2 = JSONArray.toList(json2Object, Object.class);
			
			List<Object> list3 = new ArrayList<Object>();
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				JSONObject jsonObject4 = JSONObject.fromObject(object);
				String paymentType=null;
				try{
					paymentType = jsonObject4.getString("paymentType");
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String code = jsonObject3.getString("code");
							String name = jsonObject3.getString("name");
							if(paymentType.equals(code)){
								paymentType = name;
								jsonObject4.put("paymentType",paymentType);
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
				}catch (Exception e){
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
	 * 订单取消扣款报表导出Excel
	 * @Methods Name getPosOrderPlatformToExcel
	 * @Create In 2016-4-8 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getPosOrderPlatformToExcel", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getPosOrderPlatformToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		String title = "posOrderPlatform";
		List<ExcelOrderPosPlatformVo> epv = new ArrayList<ExcelOrderPosPlatformVo>();
		Map<String, Object> map = new HashMap<String, Object>();

		if (StringUtils.isNotEmpty(request.getParameter("saleNo"))) {
			map.put("saleNo", request.getParameter("saleNo"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("orderNo"))) {
			map.put("orderNo", request.getParameter("orderNo"));
		}
		if (StringUtils.isNotEmpty(request.getParameter("payType"))) {
			map.put("payType", request.getParameter("payType"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
			map.put("saleStartFlowTime", request.getParameter("startTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
			map.put("saleEndFlowTime", request.getParameter("endTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundStartFlowTime"))){
			map.put("refundStartFlowTime", request.getParameter("refundStartFlowTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("refundEndFlowTime"))){
			map.put("refundEndFlowTime", request.getParameter("refundEndFlowTime"));
		}
		map.put("fromSystem", "OMSADMIN");
		String jsonStr = JSON.toJSONString(map);
		try {
			String json = HttpUtilPcm.doPost(CommonProperties.get("excel_PosOrderPlatformNoPage_list"),jsonStr);
//			 String json =HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSelect/checkChargeReportNoPage.htm",jsonStr);

			JSONObject js = JSONObject.fromObject(json);
			Object objs = js.get("data");
			// 得到JSONArray
			JSONArray arr = JSONArray.fromObject(objs);
			if (arr.size() > 0) {
				for (int i = 0; i < arr.size(); i++) {
					JSONObject jOpt = arr.getJSONObject(i);
					ExcelOrderPosPlatformVo vo = (ExcelOrderPosPlatformVo) JSONObject.toBean(jOpt,ExcelOrderPosPlatformVo.class);
					BigDecimal b = new BigDecimal("0");
					if(vo.getNeedRefundAmount().compareTo(b)==1){
						vo.setNeedRefundAmount(new BigDecimal("-"+vo.getNeedRefundAmount().toString()));
					}else{
						vo.setNeedRefundAmount(vo.getNeedRefundAmount());
					}
					if(vo.getRefundAmount().compareTo(b)==1){
						vo.setRefundAmount(new BigDecimal("-"+vo.getRefundAmount().toString()));
					}else{
						vo.setRefundAmount(vo.getRefundAmount());
					}
					String jsonStr2 = "";
					Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
					paramMap2.put("fromSystem", "OMSADMIN");
					String json2 = HttpUtilPcm.doPost(CommonProperties.get("select_paymentType_list"), jsonStr2);
					logger.info("json2:" + json2);
					JSONArray json2Object = JSONArray.fromObject(json2);
					String paymentType = vo.getPaymentType();
					if(null!=json2Object){
						for(int j=0; j < json2Object.size(); j++){
							JSONObject jsonObject3 = (JSONObject) json2Object.get(j);
							String code = jsonObject3.getString("code");
							String name = jsonObject3.getString("name");
							if(code.equals(paymentType)){
								paymentType = name;
								vo.setPaymentType(paymentType);
								break;
							}else if(j==json2Object.size()-1){
								vo.setPaymentType(paymentType);
							}
						}
					}else{
						vo.setPaymentType(paymentType);
					}
					epv.add(vo);
				}
			}

			Object result = allOrderPosPlatformToExcel(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);

		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}

		return jsons;
	}

	public String allOrderPosPlatformToExcel(HttpServletResponse response,
			List<ExcelOrderPosPlatformVo> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("订单取消日期");
		header.add("下单日期");
		header.add("订单号");
		header.add("销售单号");
		header.add("应退款方式");
		header.add("应退款金额");
		header.add("实际退款金额");
		header.add("退货扣款金额");
		header.add("扣款原因");
		header.add("扣款类型");
		List<List<String>> data = new ArrayList<List<String>>();
		for (ExcelOrderPosPlatformVo vo : list) {
			List<String> inlist = new ArrayList<String>();
			
			inlist.add(vo.getSaleTimeStr() == null ? "" : vo.getSaleTimeStr());
			inlist.add(vo.getRefundTimeStr() == null ? "" : vo.getRefundTimeStr());
			inlist.add(vo.getOrderNo() == null ? "" : vo.getOrderNo());
			inlist.add(vo.getSaleNo() == null ? "" : vo.getSaleNo());
			inlist.add(vo.getPaymentType() == null ? "" : vo.getPaymentType());
			inlist.add(vo.getRefundAmount() == null ? "" : vo.getRefundAmount().toString());
			inlist.add(vo.getNeedRefundAmount() == null ? "" : vo.getNeedRefundAmount().toString());
			inlist.add(vo.getMoney() == null ? "" : vo.getMoney().toString());
			inlist.add(vo.getPayname() == null ? "" : vo.getPayname());
			
  			String payType = null;
			if(vo.getPayType()==null){
				payType=null;
			}else if(vo.getPayType().equals("ZKKH")){
				payType = "折扣扣回";
			}else if(vo.getPayType().equals("YFKU")){
				payType = "运费扣回";
			}else if(vo.getPayType().equals("DKKH")){
				payType = "抵扣扣回";
			}else if(vo.getPayType().equals("FQKH")){
				payType = "返券扣回";
			}else if(vo.getPayType().equals("JFKH")){
				payType = "积分扣回";
			}else if(vo.getPayType().equals("YQKH")){
				payType = "用券扣回";
			}else if(vo.getPayType().equals("YJKF")){
				payType = "积分消费扣回";
			}
			inlist.add(vo.getPayType() == null ? "" : payType);

			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-disposition", "attachment; filename=/" + title + ".xls");

			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	/**
	 * 修改退货申请单（物流信息更改）
	 * @Methods Name updateRefundApply
	 * @Create In 2016-4-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updateRefundApply")
	public String updateRefundApply(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("refundApplyNo"))){
			paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("isFlag"))){
			paramMap.put("isFlag", request.getParameter("isFlag"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("expressCompanyName"))){
			paramMap.put("expressCompanyName", request.getParameter("expressCompanyName"));//快递公司
		}
		if(StringUtils.isNotEmpty(request.getParameter("courierNumber"))){
			paramMap.put("courierNumber", request.getParameter("courierNumber"));//快递单号
		}
		if(StringUtils.isNotEmpty(request.getParameter("warehouseAddress"))){
			paramMap.put("warehouseAddress", request.getParameter("warehouseAddress"));//退货地址
		}else{
			paramMap.put("warehouseAddress", "");//退货地址(没传值给空串)
		}
		paramMap.put("fromSystem", "OMSADMIN");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("update_refundApply_chain"),jsonStr);
//			json = HttpUtilPcm.doPost("http://192.168.7.52:8081/oms-core/refundApply/updateRefundApply.htm", jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 导出销售单Excel
	 * @Methods Name getSaleToExcel
	 * @Create In 2016-4-21 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getSaleToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getSaleToExcel(HttpServletRequest request, HttpServletResponse response){
		String jsons = "";	
		String title = "sale";
		List<ExcelSaleVo> epv = new ArrayList<ExcelSaleVo>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(StringUtils.isNotEmpty(request.getParameter("saleSource"))){
			map.put("saleSource", request.getParameter("saleSource"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("saleNo"))){
			map.put("saleNo", request.getParameter("saleNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("saleStatus"))){
			map.put("saleStatus", request.getParameter("saleStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payStatus"))){
			map.put("payStatus", request.getParameter("payStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			map.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("shopNo"))){
			map.put("shopNo", request.getParameter("shopNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("memberNo"))){
			map.put("memberNo", request.getParameter("memberNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("salesPaymentNo"))){
			map.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("casherNo"))){
			map.put("casherNo", request.getParameter("casherNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("startSaleTime"))){
			map.put("saleTimeStart", request.getParameter("startSaleTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endSaleTime"))){
			map.put("saleTimeEnd", request.getParameter("endSaleTime"));
		}
//		map.put("fromSystem", "OMSADMIN");
		String jsonStr = JSON.toJSONString(map);
		try {
			String json = HttpUtilPcm.doPost(CommonProperties.get("excel_sale_list"), jsonStr);
//			String json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSale/querySaleExcel.htm", jsonStr);
			
			JSONObject js = JSONObject.fromObject(json);
//			Object objs = js.get("data");
			
			List<Object> list = (List<Object>) js.get("data");
			
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
			
			// 得到JSONArray
//			JSONArray arr = JSONArray.fromObject(objs);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
					JSONObject jOpt = (JSONObject) list.get(i);
					ExcelSaleVo vo = (ExcelSaleVo) JSONObject.toBean(jOpt,ExcelSaleVo.class);
					epv.add(vo);
				}
			}
			
			Object result = allSaleToExcel(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}
		
		return jsons;
	}
	public String allSaleToExcel(HttpServletResponse response,List<ExcelSaleVo> list, String title) {
		List<String> header = new ArrayList<String>();
        header.add("销售单号");
		header.add("订单号");
		header.add("销售单状态");
		header.add("支付状态");
		header.add("CID");
		header.add("会员卡号");
		header.add("销售类别");
		header.add("销售单来源");
		header.add("门店名称");
		header.add("供应商编码");
		header.add("供应商名称");
		header.add("专柜名称");
		header.add("销售类型");
		header.add("总金额");
		header.add("应付金额");
		header.add("优惠金额");
		header.add("授权卡号");
		header.add("二维码");
		header.add("收银流水号");
		header.add("导购号");
		header.add("机器号");
		header.add("销售时间");
		header.add("最后修改人");
		header.add("最后修改时间");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelSaleVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getSaleNo()==null?"":vo.getSaleNo());	
			inlist.add(vo.getOrderNo()==null?"":vo.getOrderNo());	
			inlist.add(vo.getSaleStatusDesc()==null?"":vo.getSaleStatusDesc());	
//			inlist.add(vo.getPayStatus()==null?"":vo.getPayStatus());
			String payStatus = null;
			if("5001".equals(vo.getPayStatus())){
				payStatus = "未支付";
			}else if("5002".equals(vo.getPayStatus())){
				payStatus = "部分支付";
			}else if("5003".equals(vo.getPayStatus())){
				payStatus = "超时未支付";
			}else if("5004".equals(vo.getPayStatus())){
				payStatus = "已支付";
			}
			inlist.add(vo.getPayStatus()==null?"":payStatus);
			inlist.add(vo.getAccountNo()==null?"":vo.getAccountNo());	
			inlist.add(vo.getMemberNo()==null?"":vo.getMemberNo());	
//			inlist.add(vo.getSaleType()==null?"":vo.getSaleType().toString());	
			String saleType = null;
			if(vo.getSaleType()==1){
				saleType = "正常销售单";
			}else if(vo.getSaleType()==2){
				saleType = "大码销售单";
			}
			inlist.add(vo.getSaleType()==null?"":saleType);
			inlist.add(vo.getSaleSource()==null?"":vo.getSaleSource());	
			inlist.add(vo.getStoreName()==null?"":vo.getStoreName());	
			inlist.add(vo.getSupplyNo()==null?"":vo.getSupplyNo());	
			inlist.add(vo.getSuppllyName()==null?"":vo.getSuppllyName());	
			inlist.add(vo.getShoppeName()==null?"":vo.getShoppeName());	
//			inlist.add(vo.getSaleClass()==null?"":vo.getSaleClass().toString());
			String saleClass = null;
			if(vo.getSaleClass()==1){
				saleClass = "销售单";
			}else if(vo.getSaleClass()==2){
				saleClass = "换货换出单";
			}
			inlist.add(vo.getSaleClass()==null?"":saleClass);
			inlist.add(vo.getSaleAmount()==null?"":vo.getSaleAmount().toString());
			inlist.add(vo.getPaymentAmount()==null?"":vo.getPaymentAmount().toString());
			inlist.add(vo.getDiscountAmount()==null?"":vo.getDiscountAmount().toString());
			inlist.add(vo.getAuthorityCard()==null?"":vo.getAuthorityCard());
			inlist.add(vo.getQrcode()==null?"":vo.getQrcode());
			inlist.add(vo.getSalesPaymentNo()==null?"":vo.getSalesPaymentNo());
			inlist.add(vo.getEmployeeNo()==null?"":vo.getEmployeeNo());
			inlist.add(vo.getCasherNo()==null?"":vo.getCasherNo());
			inlist.add(vo.getSaleTimeStr()==null?"":vo.getSaleTimeStr());
			inlist.add(vo.getLatestUpdateMan()==null?"":vo.getLatestUpdateMan());
			inlist.add(vo.getLatestUpdateTimeStr()==null?"":vo.getLatestUpdateTimeStr());
			
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	/**
	 * 导出销售单Excel加手机号查询
	 * @Methods Name getSaleToExcelByPhone
	 * @Create In 2016-7-17 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getSaleToExcelByPhone",method={RequestMethod.GET,RequestMethod.POST})
	public String getSaleToExcelByPhone(HttpServletRequest request, HttpServletResponse response){
		String jsons = "";	
		String title = "sale";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		List<ExcelSaleVo> epv = new ArrayList<ExcelSaleVo>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(StringUtils.isNotEmpty(request.getParameter("receptPhone"))){
			map.put("receptPhone", request.getParameter("receptPhone"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("saleSource"))){
			map.put("saleSource", request.getParameter("saleSource"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("saleNo"))){
			map.put("saleNo", request.getParameter("saleNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("saleStatus"))){
			map.put("saleStatus", request.getParameter("saleStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payStatus"))){
			map.put("payStatus", request.getParameter("payStatus"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			map.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("outOrderNo"))){
			map.put("outOrderNo", request.getParameter("outOrderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("shopNo"))){
			map.put("shopNo", request.getParameter("shopNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("memberNo"))){
			map.put("memberNo", request.getParameter("memberNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("salesPaymentNo"))){
			map.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("casherNo"))){
			map.put("casherNo", request.getParameter("casherNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("startSaleTime"))){
			map.put("startSaleTime", request.getParameter("startSaleTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endSaleTime"))){
			map.put("endSaleTime", request.getParameter("endSaleTime"));
		}
		
		map.put("start", String.valueOf(currPage));
		map.put("limit", String.valueOf(size));
		map.put("fromSystem", "OMSADMIN");
		String jsonStr = JSON.toJSONString(map);
		try {
			String json = HttpUtilPcm.doPost(CommonProperties.get("select_sale_list_phone2"), jsonStr);
//			String json = HttpUtilPcm.doPost(CommonProperties.get("excel_sale_list_phone"), jsonStr);
//			String json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSale/querySaleExcelByPhone.htm", jsonStr);
			
			JSONObject js = JSONObject.fromObject(json);
//			Object objs = js.get("data");
			/*List<Object> list = (List<Object>) js.get("data");*/
			
			String data = js.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
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
			
			// 得到JSONArray
//			JSONArray arr = JSONArray.fromObject(objs);
			if(list.size()>0){
				for(int i=0;i<list.size();i++){
					JSONObject jOpt = (JSONObject) list.get(i);
					ExcelSaleVo vo = (ExcelSaleVo) JSONObject.toBean(jOpt,ExcelSaleVo.class);
					epv.add(vo);
				}
			}
			
			Object result = allSaleToExcelByPhone(response, epv, title);
			jsons = ResultUtil.createSuccessResult(result);
			
		} catch (Exception e) {
			e.printStackTrace();
			jsons = "";
		}
		
		return jsons;
	}
	public String allSaleToExcelByPhone(HttpServletResponse response,List<ExcelSaleVo> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("销售单号");
		header.add("订单号");
		header.add("外部订单号");
		header.add("销售单状态");
		header.add("支付状态");
		header.add("手机号");
		header.add("CID");
		header.add("会员卡号");
		header.add("销售类别");
		header.add("销售单来源");
		
		header.add("收件人姓名");
		header.add("收件人城市");
		header.add("收件城市邮编");
		header.add("收件地区省份");
		header.add("收货地址");
		
		header.add("门店名称");
		header.add("供应商编码");
		header.add("供应商名称");
		header.add("专柜名称");
		header.add("商品名称");
		header.add("销售类型");
		header.add("总金额");
		header.add("应付金额（含运费）");
		header.add("现金类支付金额（含运费不含积分）");
		header.add("积分");
		header.add("运费");
		header.add("促销优惠金额");
		header.add("使用优惠券金额");
		header.add("使用余额金额");
		header.add("授权卡号");
		header.add("二维码");
		header.add("收银流水号");
		header.add("导购号");
		header.add("机器号");
		header.add("销售时间");
		header.add("最后修改人");
		header.add("最后修改时间");
		
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelSaleVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getSaleNo()==null?"":vo.getSaleNo());	
			inlist.add(vo.getOrderNo()==null?"":vo.getOrderNo());
			inlist.add(vo.getOutOrderNo() == null ? "" : vo.getOutOrderNo());
			inlist.add(vo.getSaleStatusDesc()==null?"":vo.getSaleStatusDesc());	
//			inlist.add(vo.getPayStatus()==null?"":vo.getPayStatus());
			String payStatus = null;
			if("5001".equals(vo.getPayStatus())){
				payStatus = "未支付";
			}else if("5002".equals(vo.getPayStatus())){
				payStatus = "部分支付";
			}else if("5003".equals(vo.getPayStatus())){
				payStatus = "超时未支付";
			}else if("5004".equals(vo.getPayStatus())){
				payStatus = "已支付";
			}
			inlist.add(vo.getPayStatus()==null?"":payStatus);
			inlist.add(vo.getReceptPhone()==null?"":vo.getReceptPhone());	
			inlist.add(vo.getAccountNo()==null?"":vo.getAccountNo());	
			inlist.add(vo.getMemberNo()==null?"":vo.getMemberNo());	
//			inlist.add(vo.getSaleType()==null?"":vo.getSaleType().toString());	
			String saleType = null;
			if(vo.getSaleType()==1){
				saleType = "正常销售单";
			}else if(vo.getSaleType()==2){
				saleType = "大码销售单";
			}
			inlist.add(vo.getSaleType()==null?"":saleType);
			inlist.add(vo.getSaleSource()==null?"":vo.getSaleSource());	
			
			inlist.add(vo.getReceptName()==null?"":vo.getReceptName());	
			inlist.add(vo.getReceptCityName()==null?"":vo.getReceptCityName());	
			inlist.add(vo.getReceptCityCode()==null?"":vo.getReceptCityCode());	
			inlist.add(vo.getReceptProvName()==null?"":vo.getReceptProvName());	
			inlist.add(vo.getReceptAddress()==null?"":vo.getReceptAddress());	
			
			inlist.add(vo.getStoreName()==null?"":vo.getStoreName());	
			inlist.add(vo.getSupplyNo()==null?"":vo.getSupplyNo());	
			inlist.add(vo.getSuppllyName()==null?"":vo.getSuppllyName());	
			inlist.add(vo.getShoppeName()==null?"":vo.getShoppeName());	
			inlist.add(vo.getShoppeProName() == null ? "" : vo.getShoppeProName());
//			inlist.add(vo.getSaleClass()==null?"":vo.getSaleClass().toString());
			String saleClass = null;
			if(vo.getSaleClass()==1){
				saleClass = "销售单";
			}else if(vo.getSaleClass()==2){
				saleClass = "换货换出单";
			}
			inlist.add(vo.getSaleClass()==null?"":saleClass);
			inlist.add(vo.getSaleAmount()==null?"":vo.getSaleAmount().toString());
			BigDecimal big = new BigDecimal("0");
			inlist.add(vo.getPaymentAmount()==null?"":(vo.getPaymentAmount().add(vo.getShippingFee() == null ? big : vo.getShippingFee())).toString());
			inlist.add(vo.getCashAmount()==null?"":(vo.getCashAmount().add(vo.getShippingFee())).toString());
			inlist.add(vo.getIntegral()==null?"":vo.getIntegral().toString());
			inlist.add(vo.getShippingFee()==null?"":vo.getShippingFee().toString());
			
			inlist.add(vo.getDiscountAmount()==null?"":vo.getDiscountAmount().toString());
			inlist.add(vo.getCouponAmount()==null?"":vo.getCouponAmount().toString());
			inlist.add(vo.getAccountBalanceAmount()==null?"":vo.getAccountBalanceAmount().toString());
			inlist.add(vo.getAuthorityCard()==null?"":vo.getAuthorityCard());
			inlist.add(vo.getQrcode()==null?"":vo.getQrcode());
			inlist.add(vo.getSalesPaymentNo()==null?"":vo.getSalesPaymentNo());
			inlist.add(vo.getEmployeeNo()==null?"":vo.getEmployeeNo());
			inlist.add(vo.getCasherNo()==null?"":vo.getCasherNo());
			inlist.add(vo.getSaleTimeStr()==null?"":vo.getSaleTimeStr());
			inlist.add(vo.getLatestUpdateMan()==null?"":vo.getLatestUpdateMan());
			inlist.add(vo.getLatestUpdateTimeStr()==null?"":vo.getLatestUpdateTimeStr());
			
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}
	/**
	 * 查询订单备注
	 * @Methods Name selectRemarkLog
	 * @Create In 2016-4-23 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRemarkLog")
	public String selectRemarkLog(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
//		if(StringUtils.isNotBlank(request.getParameter("orderType"))){
//			if("普通订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "PT");
//			}
//			if("团购订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "TG");
//			}
//			if("代客订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "DK");
//			}
//			if("快腿订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "KT");
//			}
//			if("员工订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "YG");
//			}
//		}
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_remarkLog_orderNo"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/remarkLog/selectRemarkLog.htm", jsonStr);
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
	 * 添加订单备注
	 * @Methods Name saveRemarkLog
	 * @Create In 2016-4-23 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/saveRemarkLog")
	public String saveRemarkLog(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("remark"))){
			paramMap.put("remark", request.getParameter("remark"));
		}
		if(StringUtils.isNotBlank(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotBlank(request.getParameter("userName"))){
			paramMap.put("createMan", request.getParameter("userName"));
		}
//		if(StringUtils.isNotBlank(request.getParameter("orderType"))){
//			if("普通订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "PT");
//			}
//			if("团购订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "TG");
//			}
//			if("代客订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "DK");
//			}
//			if("快腿订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "KT");
//			}
//			if("员工订单".equals(request.getParameter("orderType"))){
//				paramMap.put("orderType", "YG");
//			}
//		}
		paramMap.put("remarkType", "Customer");
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("create_remarkLog_orderNo"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8081/oms-core/remarkLog/createRemarkLog.htm", jsonStr);
			logger.info("json:" + json);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * @desc 退货申请单查看  查询退回地址
	 * @create In 2016-07-18 By zhangxuzhou
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/selectRefundAddress")
	public String selectRefundAddress(HttpServletRequest request,HttpServletResponse response){
		String result = "";
		Map<Object,Object> map = new HashMap<Object,Object>();
		map.put("shopSid", request.getParameter("shopSid"));
		map.put("supplyCode", request.getParameter("supplyCode"));
		try {
			String jsonObj = JSON.toJSONString(map);
			long tiem = System.currentTimeMillis();
			logger.info("请求退回地址接口入参:{}",jsonObj);
			logger.info("请求退回地址接口开始时间：{}",tiem);
			result = HttpUtilPcm.doPost(CommonProperties.get("selectRefundAddress"), jsonObj);
			logger.info("请求退回地址接口结束时间：{},共耗时:{}",System.currentTimeMillis(),(System.currentTimeMillis()-tiem));
			logger.info("请求退回地址接口出参:{}",result);
		} catch (Exception e) {
			e.printStackTrace();
			logger.info("请求退回地址接口异常：{}",e);
		}
		return result;
	}
	
	/**
	 * 查询销售单支付介质信息（线上）
	 * @Methods Name selectSalePayments
	 * @Create In 2015-12-8 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectSalePayments")
	public String selectSalePayments(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("saleNo"))){
			paramMap.put("saleNo", request.getParameter("saleNo"));
		}
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_salepayments_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSelect/selectSalePayments.htm", jsonStr);
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
	/**
	 * 图片展示url
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/ftpUrlController")
	public String ftpUrlController(HttpServletRequest request, HttpServletResponse response) {
		Map<Object, Object> m = new HashMap<Object, Object>();
		String json = "";
		try{
			if(StringUtils.isNotBlank(request.getParameter("pro"))){
				json = CommonProperties.get("ftpUrl");
			}else{
				json = CommonProperties.get("proFtpUrl");
			}
				logger.info("json:" + json);
				if(StringUtils.isEmpty(json)){
					m.put("success", "false");
				}else{
					m.put("data", json);
					m.put("success", "true");
				}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 查询快递历史信息
	 * @Methods Name selectPackageHistoryByOrderNo
	 * @Create In 2016-4-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPackageHistoryByOrderNo")
	public String selectPackageHistoryByOrderNo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("deliveryNo"))){
			paramMap.put("deliveryNo", request.getParameter("deliveryNo"));
		}
		paramMap.put("fromSystem", "OMSADMIN");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_PackageHistory_deliver"),jsonStr);
//			json = HttpUtilPcm.doPost("http://172.16.255.169:8087/oms-core-sdc/omsPackageInfo/selectPackageHistoryByOrderNo.htm", jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 会员权限
	 * @Methods Name sysConfig
	 * @Create In 2016-4-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/sysConfig")
	public String sysConfig(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("keys", "memberInfo");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("paramMap:" + paramMap);
			json = "{'data':[{'sid':1,'sysKey':'memberInfo','sysValue':'0'}],'success':true}";//暂时写死0是权限未开启
//			json = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
//			json = HttpUtilPcm.HttpGet("http://10.6.2.49:8080/ops/sysConfig", "findSysConfigByKeys", paramMap);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询包裹单信息（要求有距离发货时间）
	 * @Methods Name selectPackageInfoPage
	 * @Create In 2016-4-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectPackageInfoPage")
	public String selectPackageInfoPage(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("deliveryNo"))){
			paramMap.put("deliveryNo", request.getParameter("deliveryNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("saleNo"))){
			paramMap.put("saleNo", request.getParameter("saleNo"));
		}
//		paramMap.put("fromSystem", "OMSADMIN");
		SimpleDateFormat formatter; 
		formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		if(StringUtils.isNotEmpty(request.getParameter("startSaleTime"))){
			Date date = sdf.parse(request.getParameter("startSaleTime"));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.HOUR_OF_DAY, 0);
			Date date2 = calendar.getTime();
			String startDate = sdf.format(date2);
			paramMap.put("startTimeStr", startDate);
		}
		if(StringUtils.isNotEmpty(request.getParameter("endSaleTime"))){
			Date date = sdf.parse(request.getParameter("endSaleTime"));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.HOUR_OF_DAY, 0);
			Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
			paramMap.put("endTimeStr", endDate);
		}
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("currentPage", String.valueOf(currPage));
		paramMap.put("pageSize", String.valueOf(size));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_Package_info"),jsonStr);
//			json = HttpUtilPcm.doPost("http://127.0.0.1:8087/oms-core-sdc/omsPackageInfo/selectNotPackagePage.htm", jsonStr);
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
	 * ops操作日志记录查询
	 * @Methods Name selectOpsOperateLogs
	 * @Create In 2016-4-14 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 * @throws ParseException 
	 */
	@ResponseBody
	@RequestMapping("/selectOpsOperateLogs")
	public String selectOpsOperateLogs(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
//		paramMap.put("fromSystem", "OMSADMIN");
		SimpleDateFormat formatter; 
		formatter = new SimpleDateFormat ("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		if(StringUtils.isNotEmpty(request.getParameter("startSaleTime"))){
			Date date = sdf.parse(request.getParameter("startSaleTime"));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.HOUR_OF_DAY, 0);
			Date date2 = calendar.getTime();
			String startDate = sdf.format(date2);
			paramMap.put("startTimeStr", startDate);
		}
		if(StringUtils.isNotEmpty(request.getParameter("endSaleTime"))){
			Date date = sdf.parse(request.getParameter("endSaleTime"));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(date);
			calendar.add(Calendar.HOUR_OF_DAY, 0);
			Date date2 = calendar.getTime();
			String endDate = sdf.format(date2);
			paramMap.put("endTimeStr", endDate);
		}
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("currentPage", String.valueOf(currPage));
		paramMap.put("pageSize", String.valueOf(size));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_opsOperate_logs"),jsonStr);
//			json = HttpUtilPcm.doPost("http://127.0.0.1:8087/oms-core-sdc/opsOperateLogs/selectListOpsOperateLogsPage.htm", jsonStr);
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
	 * 保存操作日志
	 * @Methods Name saveOpsOperateLogs
	 * @Create In 2016-3-11 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/saveOpsOperateLogs")
	public String saveOpsOperateLogs(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		if(StringUtils.isNotEmpty(request.getParameter("orderNo"))){
			paramMap.put("orderNo", request.getParameter("orderNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("pageName"))){
			paramMap.put("pageName", request.getParameter("pageName"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("buttonType"))){
			paramMap.put("buttonType", request.getParameter("buttonType"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("remark"))){
			paramMap.put("remark", request.getParameter("remark"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("operateMan"))){
			paramMap.put("operateMan", request.getParameter("operateMan"));
		}

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("save_opsOperate_logs"), jsonStr);
//			json = HttpUtilPcm.doPost("http://127.0.0.1:8087/oms-core-sdc/opsOperateLogs/saveOpsOperateLogs.htm", jsonStr);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
}
