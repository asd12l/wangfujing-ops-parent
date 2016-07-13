package com.wangfj.order.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.util.HttpUtilPcm;
/**
 * 
 * @Class Name TestOnlineOmsOrderController
 * @Author chenhu
 * @Create In 2015-10-15
 */
@Controller
@RequestMapping("/testOnlineOmsOrder")
public class TestOnlineOmsOrderController {
	private static final Logger logger = LoggerFactory.getLogger(TestOnlineOmsOrderController.class);
	/**
	 * 查询字典
	 * @Methods Name selectCodelist
	 * @Create In 2016-1-21 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectCodelist")
	public String selectCodelist(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		Map<String, String> paramMap = this.createParam(request);
		paramMap.put("typeValue", request.getParameter("typeValue"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_codelist_selectBox"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/codelist/selectCodelist.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.parseObject(json);
//			String data = jsonObject.getString("data");
//			JSONObject jsonObject2 = JSONObject.parseObject(data);
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
	 * 创建旗舰店订单
	 * @Methods Name foundOrder
	 * @Create In 2015-10-15 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundOrder")
	public String foundOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		//订单
//		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderSource", request.getParameter("orderSource"));
		paramMap.put("orderType", request.getParameter("orderType"));
		paramMap.put("paymentClass", request.getParameter("paymentClass"));
		paramMap.put("delayTime", request.getParameter("delayTime"));
		paramMap.put("deliveryMode", request.getParameter("deliveryMode"));
		paramMap.put("deliveryModeName", request.getParameter("deliveryModeName"));
		paramMap.put("needInvoice", request.getParameter("needInvoice"));
		paramMap.put("needSendCost", request.getParameter("needSendCost"));
		paramMap.put("salesAmount", request.getParameter("salesAmount"));
		paramMap.put("saleSum", request.getParameter("saleSum1"));
		paramMap.put("refundSum", request.getParameter("refundSum"));
		paramMap.put("sendSum", request.getParameter("sendSum"));
		paramMap.put("sendAmount", request.getParameter("sendAmount"));
		paramMap.put("paymentAmount", request.getParameter("paymentAmount"));
		paramMap.put("cashAmount", request.getParameter("cashAmount"));
		paramMap.put("cashIncome", request.getParameter("cashIncome"));
		paramMap.put("accountBalanceAmount", request.getParameter("accountBalanceAmount"));
		paramMap.put("promotionAmount", request.getParameter("promotionAmount"));
		paramMap.put("customerComments", request.getParameter("customerComments"));
		paramMap.put("callCenterComments", request.getParameter("callCenterComments"));
		paramMap.put("receptPhone", request.getParameter("receptPhone"));
		paramMap.put("receptName", request.getParameter("receptName"));
		paramMap.put("receptCityNo", request.getParameter("receptCityNo"));
		paramMap.put("receptCityName", request.getParameter("receptCityName"));
		paramMap.put("receptCityCode", request.getParameter("receptCityCode"));
		paramMap.put("receptProvNo", request.getParameter("receptProvNo"));
		paramMap.put("receptProvName", request.getParameter("receptProvName"));
		paramMap.put("receptAddress", request.getParameter("receptAddress"));
		paramMap.put("extractFlag", request.getParameter("extractFlag"));
		paramMap.put("recoveryFlag", request.getParameter("recoveryFlag"));
		paramMap.put("promFlag", request.getParameter("promFlag"));
		paramMap.put("version", request.getParameter("version"));
		paramMap.put("memberType", request.getParameter("memberType"));
		paramMap.put("isCod", request.getParameter("isCod"));

		//订单明细
		JSONArray orderItemList = new JSONArray();
		JSONObject orderItemList1 ;
		String supplyProductNos[] = request.getParameterValues("supplyProductNo");
		String salesPrices[] = request.getParameterValues("salesPrice");
		String saleSums[] = request.getParameterValues("saleSum");
		
		int j = 0;
		for(String supplyProductNo:supplyProductNos){
			orderItemList1 = new JSONObject();
			orderItemList1.put("supplyProductNo", supplyProductNo);
			orderItemList1.put("salesPrice", salesPrices[j]);
			orderItemList1.put("saleSum", saleSums[j]);
			orderItemList.add(orderItemList1);
			j++;
		}
		paramMap.put("orderItemList", orderItemList);
//		//支付介质
//		JSONArray paymentItems = new JSONArray();
//		JSONObject paymentItem ;
////		String posFlowNos[] = request.getParameterValues("posFlowNo");
//		String paymentTypes[] = request.getParameterValues("paymentType");
//		String amounts[] = request.getParameterValues("amount");
//		String acturalAmounts[] = request.getParameterValues("acturalAmount");
//		String rates[] = request.getParameterValues("rate");
//		String accounts[] = request.getParameterValues("account");
//		String userIds[] = request.getParameterValues("userId");
//		String payFlowNos[] = request.getParameterValues("payFlowNo");
//		String couponTypes[] = request.getParameterValues("couponType");
//		String couponBatchs[] = request.getParameterValues("couponBatch");
//		String couponNames[] = request.getParameterValues("couponName");
//		String activityNos[] = request.getParameterValues("activityNo");
//		String couponRules[] = request.getParameterValues("couponRule");
//		String couponRuleNames[] = request.getParameterValues("couponRuleName");
//		String remarks[] = request.getParameterValues("remark");
//		String cashBalances[] = request.getParameterValues("cashBalance");
//		
//		int i = 0;
//		for(String payFlowNo:payFlowNos){
//			paymentItem = new JSONObject();
//			paymentItem.put("paymentType", paymentTypes[i]);
//			paymentItem.put("amount", amounts[i]);
//			paymentItem.put("acturalAmount", acturalAmounts[i]);
//			paymentItem.put("rate", rates[i]);
//			paymentItem.put("account", accounts[i]);
//			paymentItem.put("userId", userIds[i]);
//			paymentItem.put("payFlowNo", payFlowNos[i]);
//			paymentItem.put("couponType", couponTypes[i]);
//			paymentItem.put("couponBatch", couponBatchs[i]);
//			paymentItem.put("couponName", couponNames[i]);
//			paymentItem.put("activityNo", activityNos[i]);
//			paymentItem.put("couponRule", couponRules[i]);
//			paymentItem.put("couponRuleName", couponRuleNames[i]);
//			paymentItem.put("remark", remarks[i]);
//			paymentItem.put("cashBalance", cashBalances[i]);
//			paymentItems.add(paymentItem);
//			i++;
//		}
//		paramMap.put("paymentItems", paymentItems);
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/createOrder.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/createOrder.htm", jsonStr);
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
	 * 创建云店订单
	 * @Methods Name foundOrder
	 * @Create In 2015-10-15 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/createYunOrder")
	public String createYunOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		//订单
//		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderSource", request.getParameter("orderSource"));
		paramMap.put("orderType", request.getParameter("orderType"));
		paramMap.put("paymentClass", request.getParameter("paymentClass"));
		paramMap.put("delayTime", request.getParameter("delayTime"));
		paramMap.put("deliveryMode", request.getParameter("deliveryMode"));
		paramMap.put("deliveryModeName", request.getParameter("deliveryModeName"));
		paramMap.put("needInvoice", request.getParameter("needInvoice"));
		paramMap.put("needSendCost", request.getParameter("needSendCost"));
		paramMap.put("salesAmount", request.getParameter("salesAmount"));
		paramMap.put("saleSum", request.getParameter("saleSum1"));
		paramMap.put("refundSum", request.getParameter("refundSum"));
		paramMap.put("sendSum", request.getParameter("sendSum"));
		paramMap.put("sendAmount", request.getParameter("sendAmount"));
		paramMap.put("paymentAmount", request.getParameter("paymentAmount"));
		paramMap.put("cashAmount", request.getParameter("cashAmount"));
		paramMap.put("cashIncome", request.getParameter("cashIncome"));
		paramMap.put("accountBalanceAmount", request.getParameter("accountBalanceAmount"));
		paramMap.put("promotionAmount", request.getParameter("promotionAmount"));
		paramMap.put("customerComments", request.getParameter("customerComments"));
		paramMap.put("callCenterComments", request.getParameter("callCenterComments"));
		paramMap.put("receptPhone", request.getParameter("receptPhone"));
		paramMap.put("receptName", request.getParameter("receptName"));
		paramMap.put("receptCityNo", request.getParameter("receptCityNo"));
		paramMap.put("receptCityName", request.getParameter("receptCityName"));
		paramMap.put("receptCityCode", request.getParameter("receptCityCode"));
		paramMap.put("receptProvNo", request.getParameter("receptProvNo"));
		paramMap.put("receptProvName", request.getParameter("receptProvName"));
		paramMap.put("receptAddress", request.getParameter("receptAddress"));
		paramMap.put("extractFlag", request.getParameter("extractFlag"));
		paramMap.put("recoveryFlag", request.getParameter("recoveryFlag"));
		paramMap.put("promFlag", request.getParameter("promFlag"));
		paramMap.put("version", request.getParameter("version"));
		paramMap.put("memberType", request.getParameter("memberType"));
		paramMap.put("isCod", request.getParameter("isCod"));
		
		//订单明细
		JSONArray orderItemList = new JSONArray();
		JSONObject orderItemList1 ;
		String skuNos[] = request.getParameterValues("skuNo");
		String salesPrices[] = request.getParameterValues("salesPrice");
		String saleSums[] = request.getParameterValues("saleSum");
		String paymentAmountms[] = request.getParameterValues("paymentAmountm");
		
		int j = 0;
		for(String skuNo:skuNos){
			orderItemList1 = new JSONObject();
			orderItemList1.put("skuNo", skuNo);
			orderItemList1.put("salesPrice", salesPrices[j]);
			orderItemList1.put("saleSum", saleSums[j]);
			orderItemList1.put("paymentAmount", paymentAmountms[j]);
			orderItemList.add(orderItemList1);
			j++;
		}
		paramMap.put("orderItemList", orderItemList);
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/createOrder.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/createYunOrder.htm", jsonStr);
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
	 * 创建订单（总的）
	 * @Methods Name createSunOrder
	 * @Create In 2015-11-18 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/createSunOrder")
	public String createSunOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		//订单
//		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderSource", request.getParameter("orderSource"));
		paramMap.put("orderType", request.getParameter("orderType"));
		paramMap.put("paymentClass", request.getParameter("paymentClass"));
		paramMap.put("delayTime", request.getParameter("delayTime"));
		paramMap.put("deliveryMode", request.getParameter("deliveryMode"));
		paramMap.put("deliveryModeName", request.getParameter("deliveryModeName"));
		paramMap.put("needInvoice", request.getParameter("needInvoice"));
		paramMap.put("sendCost", request.getParameter("sendCost"));
		paramMap.put("salesAmount", request.getParameter("salesAmount"));
		paramMap.put("saleSum", request.getParameter("saleSum2"));
		paramMap.put("refundSum", request.getParameter("refundSum"));
		paramMap.put("sendSum", request.getParameter("sendSum"));
		paramMap.put("sendAmount", request.getParameter("sendAmount"));
		paramMap.put("paymentAmount", request.getParameter("paymentAmount"));
		paramMap.put("cashAmount", request.getParameter("cashAmount"));
		paramMap.put("cashIncome", request.getParameter("cashIncome"));
		paramMap.put("accountBalanceAmount", request.getParameter("accountBalanceAmount"));
		paramMap.put("promotionAmount", request.getParameter("promotionAmount"));
		paramMap.put("customerComments", request.getParameter("customerComments"));
		paramMap.put("callCenterComments", request.getParameter("callCenterComments"));
		paramMap.put("receptPhone", request.getParameter("receptPhone"));
		paramMap.put("receptName", request.getParameter("receptName"));
		paramMap.put("receptCityNo", request.getParameter("receptCityNo"));
		paramMap.put("receptCityName", request.getParameter("receptCityName"));
		paramMap.put("receptCityCode", request.getParameter("receptCityCode"));
		paramMap.put("receptProvNo", request.getParameter("receptProvNo"));
		paramMap.put("receptProvName", request.getParameter("receptProvName"));
		paramMap.put("receptAddress", request.getParameter("receptAddress"));
		paramMap.put("extractFlag", request.getParameter("extractFlag"));
		paramMap.put("recoveryFlag", request.getParameter("recoveryFlag"));
		paramMap.put("promFlag", request.getParameter("promFlag"));
		paramMap.put("version", request.getParameter("version"));
		paramMap.put("memberType", request.getParameter("memberType"));
		paramMap.put("isCod", request.getParameter("isCod"));
		paramMap.put("receptDistrictName", request.getParameter("receptDistrictName"));
		paramMap.put("receptDistrictNo", request.getParameter("receptDistrictNo"));
		
		//订单明细
		JSONArray orderItemList = new JSONArray();
		JSONObject orderItemList1 ;
		String skuNos[] = request.getParameterValues("skuNo");
		String supplyProductNos[] = request.getParameterValues("supplyProductNo");
		String salesPrices[] = request.getParameterValues("salesPrice");
		String saleSums[] = request.getParameterValues("saleSum");
		String paymentAmountms[] = request.getParameterValues("paymentAmountm");
		String isGifts[] = request.getParameterValues("isGift");
		
		int j = 0;
		for(String salesPrice:salesPrices){
			orderItemList1 = new JSONObject();
			orderItemList1.put("salesPrice", salesPrice);
			orderItemList1.put("skuNo", skuNos[j]);
			orderItemList1.put("supplyProductNo", supplyProductNos[j]);
			orderItemList1.put("saleSum", saleSums[j]);
			orderItemList1.put("paymentAmount", paymentAmountms[j]);
			orderItemList1.put("isGift", isGifts[j]);
			orderItemList.add(orderItemList1);
			j++;
		}
		paramMap.put("orderItemList", orderItemList);
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/createOrder.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/createOnlineOrder.htm", jsonStr);
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
	 * 订单支付
	 * @Methods Name salePos
	 * @Create In 2015-10-16 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/salePos")
	public String salePos(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		paramMap.put("cashAmount", request.getParameter("orderMoney"));
		paramMap.put("payFlowNo", request.getParameter("payFlowNo"));
		paramMap.put("ooFlag", request.getParameter("ooFlag"));
		paramMap.put("payTimeStr", request.getParameter("payTime"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("casher", request.getParameter("casher"));

		String posFlowNos[] = request.getParameterValues("posFlowNo");
		String paymentTypes[] = request.getParameterValues("paymentType");
		String amounts[] = request.getParameterValues("amount");
		String acturalAmounts[] = request.getParameterValues("acturalAmount");
		String rates[] = request.getParameterValues("rate");
		String accounts[] = request.getParameterValues("account");
		String userIds[] = request.getParameterValues("userId");
		String payFlowNos[] = request.getParameterValues("payFlowNo");
		String couponTypes[] = request.getParameterValues("couponType");
		String couponBatchs[] = request.getParameterValues("couponBatch");
		String couponNames[] = request.getParameterValues("couponName");
		String activityNos[] = request.getParameterValues("activityNo");
		String couponRules[] = request.getParameterValues("couponRule");
		String couponRuleNames[] = request.getParameterValues("couponRuleName");
		String remarks[] = request.getParameterValues("remark");
		String cashBalances[] = request.getParameterValues("cashBalance");		
		JSONArray paymentItems = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String posFlowNo:posFlowNos){
			pay = new JSONObject();
			pay.put("posFlowNo", posFlowNo);
			pay.put("paymentType", paymentTypes[i]);
			pay.put("amount", amounts[i]);
			pay.put("acturalAmount", acturalAmounts[i]);
			pay.put("rate", rates[i]);
			pay.put("account", accounts[i]);		
			pay.put("userId", userIds[i]);
			pay.put("payFlowNo", payFlowNos[i]);
			pay.put("couponType", couponTypes[i]);
			pay.put("couponBatch", couponBatchs[i]);		
			pay.put("couponName", couponNames[i]);
			pay.put("activityNo", activityNos[i]);
			pay.put("couponRule", couponRules[i]);
			pay.put("couponRuleName", couponRuleNames[i]);
			pay.put("remark", remarks[i]);
			pay.put("cashBalance", cashBalances[i]);

			paymentItems.add(pay);
			i++;
		}
		paramMap.put("paymentItems", paymentItems);

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/prPosFlow/savePaymentInfo.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/payment/savePaymentInfo.htm", jsonStr);
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
	 * 订单审核
	 * @Methods Name shOrder
	 * @Create In 2015-10-23 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderCheck")
	public String orderCheck(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("callCenterComments", request.getParameter("callCenterComments"));
		paramMap.put("updateMan", request.getParameter("UpdateMan"));
		paramMap.put("orderStatus", request.getParameter("orderStatus"));
		
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("save_cod_paymentInfo"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/payment/saveCodPaymentInfo.htm", jsonStr);
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
	 * 订单取消
	 * @Methods Name orderCancel
	 * @Create In 2015-10-26 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderCancel")
	public String orderCancel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("latestUpdateMan", request.getParameter("lastUpdateMan"));
		
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/prPosFlow/savePaymentInfo.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/updateOrderStatus.htm", jsonStr);
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
	 * 订单查询
	 * @Methods Name foundByOrder
	 * @Create In 2015-10-26 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundByOrder")
	public String foundByOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("start", 1);
		paramMap.put("limit", 10);
		paramMap.put("orderNo", request.getParameter("orderNo"));
		
//		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_order_no"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/selectOrderPage.htm", jsonStr);
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
	 * 订单明细查询
	 * @Methods Name getOrderDetail
	 * @Create In 2015-10-26 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/getOrderDetail")
	public String getOrderDetail(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNo", request.getParameter("orderNo"));
		
//		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_order_detail"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/order/getOrderDetail.htm", jsonStr);
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
	 * 保存包裹单
	 * @Methods Name savePackage
	 * @Create In 2015-10-20 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/savePackage")
	public String savePackage(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		JSONArray paraLists = new JSONArray();
		JSONObject param = new JSONObject();
		param.put("orderNo", request.getParameter("orderNo"));
		param.put("packageNo", request.getParameter("packageNo"));
		param.put("delComName", request.getParameter("delComName"));
		param.put("delComNo", request.getParameter("delComNo"));
		param.put("deliveryNo", request.getParameter("deliveryNo"));
		param.put("sendTimeStr", request.getParameter("sendTimeStr"));
		param.put("extPlaceNo", request.getParameter("extPlaceNo"));
		param.put("extPlaceName", request.getParameter("extPlaceName"));
		param.put("packageStatus", request.getParameter("packageStatus"));
		param.put("packageStatusDesc", request.getParameter("packageStatusDesc"));
		param.put("refundAddress", request.getParameter("refundAddress"));
		param.put("updateMan", request.getParameter("updateMan"));
		param.put("remark", request.getParameter("remark"));
		param.put("operatorSource", request.getParameter("operatorSource"));
		
		String packageNos[] = request.getParameterValues("packageNo1");
		String deliveryNos[] = request.getParameterValues("deliveryNo1");
		String saleNos[] = request.getParameterValues("saleNo");
		String saleNums[] = request.getParameterValues("saleNum");
		String saleItemNos[] = request.getParameterValues("saleItemNo");
		JSONArray packageItemParas = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String saleNo:saleNos){
			pay = new JSONObject();
			pay.put("packageNo", packageNos[i]);
			pay.put("deliveryNo", deliveryNos[i]);
			pay.put("saleNo", saleNo);
			pay.put("saleItemNo", saleItemNos[i]);
			pay.put("saleNum", saleNums[i]);
			
			packageItemParas.add(pay);
			i++;
		}
		param.put("packageItems", packageItemParas);
		
		param.put("fromSystem", "PCM");
		paraLists.add(param);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paraLists);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/omsPackageInfo/saveOmsPackageInfo.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/omsPackageInfo/saveOmsPackageInfo.htm", jsonStr);
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
	 * 修改包裹单信息
	 * @Methods Name updatePackage
	 * @Create In 2015-10-20 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updatePackage")
	public String updatePackage(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		String orderNos[] = request.getParameterValues("orderNo");
		String packageNos[] = request.getParameterValues("packageNo");
		String deliveryNos[] = request.getParameterValues("deliveryNo");
		String packageStatuss[] = request.getParameterValues("packageStatus");
		String packageStatusDescs[] = request.getParameterValues("packageStatusDesc");
		String updateMans[] = request.getParameterValues("updateMan");
		String delComNames[] = request.getParameterValues("delComName");
		String delComNos[] = request.getParameterValues("delComNo");
		String sendTimeStrs[] = request.getParameterValues("sendTimeStr");
		String extPlaceNos[] = request.getParameterValues("extPlaceNo");
		String extPlaceNames[] = request.getParameterValues("extPlaceName");
		String refundAddresss[] = request.getParameterValues("refundAddress");
		String remarks[] = request.getParameterValues("remark");
		String operatorSources[] = request.getParameterValues("operatorSource");
		String isOutbounds[] = request.getParameterValues("isOutbound");
		JSONArray paraLists = new JSONArray();
		JSONObject pay = new JSONObject();
		int i = 0;
		for(String orderNo:orderNos){
			pay.put("orderNo", orderNo);
			pay.put("packageNo", packageNos[i]);
			pay.put("deliveryNo", deliveryNos[i]);
			pay.put("packageStatus", packageStatuss[i]);
			pay.put("packageStatusDesc", packageStatusDescs[i]);
			if(null != updateMans[i] && !"".equals(updateMans[i])){
				pay.put("updateMan", updateMans[i]);
			}
			if(null != delComNames[i] && !"".equals(delComNames[i])){
				pay.put("delComName", delComNames[i]);
			}
			if(null != delComNos[i] && !"".equals(delComNos[i])){
				pay.put("delComNo", delComNos[i]);
			}
			if(null != sendTimeStrs[i] && !"".equals(sendTimeStrs[i])){
				pay.put("sendTimeStr", sendTimeStrs[i]);
			}
			if(null != extPlaceNos[i] && !"".equals(extPlaceNos[i])){
				pay.put("extPlaceNo", extPlaceNos[i]);
			}
			if(null != extPlaceNames[i] && !"".equals(extPlaceNames[i])){
				pay.put("extPlaceName", extPlaceNames[i]);
			}
			if(null != refundAddresss[i] && !"".equals(refundAddresss[i])){
				pay.put("refundAddress", refundAddresss[i]);
			}
			if(null != remarks[i] && !"".equals(remarks[i])){
				pay.put("remark", remarks[i]);
			}
			if(null != operatorSources[i] && !"".equals(operatorSources[i])){
				pay.put("operatorSource", operatorSources[i]);
			}
			if(null != isOutbounds[i] && !"".equals(isOutbounds[i])){
				pay.put("isOutbound", isOutbounds[i]);
			}
			pay.put("fromSystem", "PCM");
			paraLists.add(pay);
			i++;
		}
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paraLists);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/omsPackageInfo/saveOmsPackageInfo.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/omsPackageInfo/updateOmsPackageInfo.htm", jsonStr);
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
	 * 添加包裹单物流状态
	 * @Methods Name updatePackageHistory
	 * @Create In 2015-10-20 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updatePackageHistory")
	public String updatePackageHistory(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		String orderNos[] = request.getParameterValues("orderNo");
		String packageNos[] = request.getParameterValues("packageNo");
		String packageStatuss[] = request.getParameterValues("packageStatus");
		String packageStatusDescs[] = request.getParameterValues("packageStatusDesc");
		String deliveryNos[] = request.getParameterValues("deliveryNo");
		String deliveryDateStrs[] = request.getParameterValues("deliveryDateStr");
		String deliveryRecords[] = request.getParameterValues("deliveryRecord");
		String deliveryMans[] = request.getParameterValues("deliveryMan");
		String deliveryManNos[] = request.getParameterValues("deliveryManNo");
		String delComNames[] = request.getParameterValues("delComName");
		String delComNos[] = request.getParameterValues("delComNo");
		String updateMans[] = request.getParameterValues("updateMan");
		String remarks[] = request.getParameterValues("remark");
		String operatorSources[] = request.getParameterValues("operatorSource");
		String isSigns[] = request.getParameterValues("isSign");
		String isRefuseSigns[] = request.getParameterValues("isRefuseSign");
		String signTimeStrs[] = request.getParameterValues("signTimeStr");
		String signNames[] = request.getParameterValues("signName");
		JSONArray paraLists = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String orderNo:orderNos){
			pay = new JSONObject();
			pay.put("orderNo", orderNo);
			pay.put("packageNo", packageNos[i]);
			pay.put("deliveryNo", deliveryNos[i]);
			if(null != packageStatuss[i] && !"".equals(packageStatuss[i])){
				pay.put("packageStatus", packageStatuss[i]);
			}
			if(null != packageStatusDescs[i] && !"".equals(packageStatusDescs[i])){
				pay.put("packageStatusDesc", packageStatusDescs[i]);
			}
			if(null != deliveryDateStrs[i] && !"".equals(deliveryDateStrs[i])){
				pay.put("deliveryDateStr", deliveryDateStrs[i]);
			}
			if(null != deliveryRecords[i] && !"".equals(deliveryRecords[i])){
				pay.put("deliveryRecord", deliveryRecords[i]);
			}
			if(null != deliveryMans[i] && !"".equals(deliveryMans[i])){
				pay.put("deliveryMan", deliveryMans[i]);
			}
			if(null != deliveryManNos[i] && !"".equals(deliveryManNos[i])){
				pay.put("deliveryManNo", deliveryManNos[i]);
			}
			if(null != delComNames[i] && !"".equals(delComNames[i])){
				pay.put("delComName", delComNames[i]);
			}
			if(null != delComNos[i] && !"".equals(delComNos[i])){
				pay.put("delComNo", delComNos[i]);
			}
			if(null != updateMans[i] && !"".equals(updateMans[i])){
				pay.put("updateMan", updateMans[i]);
			}
			if(null != remarks[i] && !"".equals(remarks[i])){
				pay.put("remark", remarks[i]);
			}
			if(null != operatorSources[i] && !"".equals(operatorSources[i])){
				pay.put("operatorSource", operatorSources[i]);
			}
			if(null != isSigns[i] && !"".equals(isSigns[i])){
				pay.put("isSign", isSigns[i]);
			}
			if(null != isRefuseSigns[i] && !"".equals(isRefuseSigns[i])){
				pay.put("isRefuseSign", isRefuseSigns[i]);
			}
			if(null != signTimeStrs[i] && !"".equals(signTimeStrs[i])){
				pay.put("signTimeStr", signTimeStrs[i]);
			}
			if(null != signNames[i] && !"".equals(signNames[i])){
				pay.put("signName", signNames[i]);
			}
			pay.put("fromSystem", "PCM");
			paraLists.add(pay);
			i++;
		}
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paraLists);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/omsPackageInfo/saveOmsPackageInfo.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/omsPackageInfo/updatePackageHistory.htm", jsonStr);
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
	 * 拒收退货创建退货申请单
	 * @Methods Name updatePackageHistory2
	 * @Create In 2015-10-20 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	/*@ResponseBody
	@RequestMapping("/updatePackageHistory2")
	public String updatePackageHistory2(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		String orderNos[] = request.getParameterValues("orderNo");
		String packageNos[] = request.getParameterValues("packageNo");
		String packageStatuss[] = request.getParameterValues("packageStatus");
		String packageStatusDescs[] = request.getParameterValues("packageStatusDesc");
		String deliveryNos[] = request.getParameterValues("deliveryNo");
		String deliveryDateStrs[] = request.getParameterValues("deliveryDateStr");
		String deliveryRecords[] = request.getParameterValues("deliveryRecord");
		String deliveryMans[] = request.getParameterValues("deliveryMan");
		String deliveryManNos[] = request.getParameterValues("deliveryManNo");
		String delComNames[] = request.getParameterValues("delComName");
		String delComNos[] = request.getParameterValues("delComNo");
		String updateMans[] = request.getParameterValues("updateMan");
		String remarks[] = request.getParameterValues("remark");
		String operatorSources[] = request.getParameterValues("operatorSource");
		String isSigns[] = request.getParameterValues("isSign");
		String isRefuseSigns[] = request.getParameterValues("isRefuseSign");
		String signTimeStrs[] = request.getParameterValues("signTimeStr");
		String signNames[] = request.getParameterValues("signName");
		JSONArray paraLists = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String orderNo:orderNos){
			pay = new JSONObject();
			pay.put("orderNo", orderNo);
			pay.put("packageNo", packageNos[i]);
			pay.put("deliveryNo", deliveryNos[i]);
			if(null != packageStatuss[i] && !"".equals(packageStatuss[i])){
				pay.put("packageStatus", packageStatuss[i]);
			}
			if(null != packageStatusDescs[i] && !"".equals(packageStatusDescs[i])){
				pay.put("packageStatusDesc", packageStatusDescs[i]);
			}
			if(null != deliveryDateStrs[i] && !"".equals(deliveryDateStrs[i])){
				pay.put("deliveryDateStr", deliveryDateStrs[i]);
			}
			if(null != deliveryRecords[i] && !"".equals(deliveryRecords[i])){
				pay.put("deliveryRecord", deliveryRecords[i]);
			}
			if(null != deliveryMans[i] && !"".equals(deliveryMans[i])){
				pay.put("deliveryMan", deliveryMans[i]);
			}
			if(null != deliveryManNos[i] && !"".equals(deliveryManNos[i])){
				pay.put("deliveryManNo", deliveryManNos[i]);
			}
			if(null != delComNames[i] && !"".equals(delComNames[i])){
				pay.put("delComName", delComNames[i]);
			}
			if(null != delComNos[i] && !"".equals(delComNos[i])){
				pay.put("delComNo", delComNos[i]);
			}
			if(null != updateMans[i] && !"".equals(updateMans[i])){
				pay.put("updateMan", updateMans[i]);
			}
			if(null != remarks[i] && !"".equals(remarks[i])){
				pay.put("remark", remarks[i]);
			}
			if(null != operatorSources[i] && !"".equals(operatorSources[i])){
				pay.put("operatorSource", operatorSources[i]);
			}
			if(null != isSigns[i] && !"".equals(isSigns[i])){
				pay.put("isSign", isSigns[i]);
			}
			if(null != isRefuseSigns[i] && !"".equals(isRefuseSigns[i])){
				pay.put("isRefuseSign", isRefuseSigns[i]);
			}
			if(null != signTimeStrs[i] && !"".equals(signTimeStrs[i])){
				pay.put("signTimeStr", signTimeStrs[i]);
			}
			if(null != signNames[i] && !"".equals(signNames[i])){
				pay.put("signName", signNames[i]);
			}
			
			String saleNos[] = request.getParameterValues("saleNo");
			String packageNo1s[] = request.getParameterValues("packageNo1");
			String saleNums[] = request.getParameterValues("saleNum");
			String saleItemNos[] = request.getParameterValues("saleItemNo");
			String deliveryNo1s[] = request.getParameterValues("deliveryNo1");
			JSONArray packageItems = new JSONArray();
			JSONObject pay1 ;
			int j = 0;
			for(String saleNo:saleNos){
				pay1 = new JSONObject();
				pay1.put("saleNo", saleNo);
				pay1.put("packageNo", packageNo1s[j]);
				pay1.put("deliveryNo", deliveryNo1s[j]);
				if(null != saleNums[j] && !"".equals(saleNums[j])){
					pay1.put("saleNum", saleNums[j]);
				}
				if(null != saleItemNos[j] && !"".equals(saleItemNos[j])){
					pay1.put("saleItemNo", saleItemNos[j]);
				}
				packageItems.add(pay1);
				j++;
			}
			pay.put("packageItems", packageItems);
			pay.put("fromSystem", "PCM");
			paraLists.add(pay);
			i++;
		}
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paraLists);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/omsPackageInfo/saveOmsPackageInfo.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/omsPackageInfo/updatePackageHistory.htm", jsonStr);
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
	}*/
	
	/**
	 * 创建退货申请单
	 * @Methods Name createRefund
	 * @Create In 2015-10-22 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/createRefund")
	public String createRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		//退货申请单
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("problemDesc", request.getParameter("problemDesc"));
		paramMap.put("customerComments", request.getParameter("customerComments"));
		paramMap.put("refundNum", request.getParameter("refundNum"));
		JSONArray products = new JSONArray();
		JSONObject product ;
		String orderItemNos[] = request.getParameterValues("orderItemNo");
		String refundNum1s[] = request.getParameterValues("refundNum1");
		
		int j = 0;
		for(String orderItemNo:orderItemNos){
			product = new JSONObject();
			product.put("orderItemNo", orderItemNo);
			product.put("refundNum", refundNum1s[j]);
			
			products.add(product);
			j++;
		}
		paramMap.put("products", products);
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("create_rerundApply_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/refundApply/createRefundApply.htm", jsonStr);
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
	 * 客服创建退货申请单
	 * @Methods Name createRefund
	 * @Create In 2015-10-22 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/createKeRefund")
	public String createKeRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		//退货申请单
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		paramMap.put("refundStatus", request.getParameter("refundStatus"));
//		paramMap.put("applyTime", request.getParameter("applyTime"));
		paramMap.put("refundNum", request.getParameter("refundNum"));
		paramMap.put("refundTarget", request.getParameter("refundTarget"));
		paramMap.put("refundMoneyChannel", request.getParameter("refundMoneyChannel"));
		paramMap.put("refundType", request.getParameter("refundType"));
		paramMap.put("refundClass", request.getParameter("refundClass"));
		paramMap.put("refundAmount", request.getParameter("refundAmount"));
		paramMap.put("needRefundAmount", request.getParameter("needRefundAmount"));
		paramMap.put("returnShippingFee", request.getParameter("returnShippingFee"));
		paramMap.put("paymentClass", request.getParameter("paymentClass"));
		paramMap.put("paymentClassDesc", request.getParameter("paymentClassDesc"));
		paramMap.put("problemDesc", request.getParameter("problemDesc"));
		paramMap.put("customerComments", request.getParameter("customerComments"));
		paramMap.put("callCenterComments", request.getParameter("callCenterComments"));
		paramMap.put("packStatus", request.getParameter("packStatus"));
		paramMap.put("productsStatus", request.getParameter("productsStatus"));
		paramMap.put("createMode", request.getParameter("createMode"));
		paramMap.put("exchangeNo", request.getParameter("exchangeNo"));
		paramMap.put("originalDeliveryNo", request.getParameter("originalDeliveryNo"));
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
//		paramMap.put("latestUpdateTime", request.getParameter("latestUpdateTime"));
//		paramMap.put("createdTime", request.getParameter("createdTime"));
		paramMap.put("refundPath", request.getParameter("refundPath"));
		paramMap.put("channel", request.getParameter("channel"));
		
		//退货申请单明细明细
		JSONArray products = new JSONArray();
		JSONObject product ;
		String orderItemNoqs[] = request.getParameterValues("orderItemNo");
		String refundNum15s[] = request.getParameterValues("refundNum15");
//		String sellDetailss[] = request.getParameterValues("sellDetails");
		String refundApplyDeductionSplitDtos[] = request.getParameterValues("refundApplyDeductionSplitDto");
		String refundApplyGetSplitDtos[] = request.getParameterValues("refundApplyGetSplitDto");
		String refundApplyPromotionSplitDtos[] = request.getParameterValues("refundApplyPromotionSplitDto");
		String r1=null;
		String r2=null;
		String r3=null;
		String p=null;
		JSONArray arr1 = new JSONArray();
		JSONArray arr2 = new JSONArray();
		JSONArray arr3 = new JSONArray();
		int j = 0;
		for(String orderItemNo:orderItemNoqs){
			product = new JSONObject();
			product.put("orderItemNo", orderItemNo);
			product.put("refundNum", refundNum15s[j]);
			p = product.toJSONString();
			
			r1 = refundApplyDeductionSplitDtos[j];
			r2 = refundApplyGetSplitDtos[j];
			r3 = refundApplyPromotionSplitDtos[j];
			if(!"".equals(r1)&&null!=r1){
				arr1 = JSON.parseArray(r1);
			}
			if(!"".equals(r2)&&null!=r2){
				arr2 = JSON.parseArray(r2);
			}
			if(!"".equals(r3)&&null!=r3){
				arr3 = JSON.parseArray(r3);
			}
			product.put("refundApplyDeductionSplitDto",arr1);
			product.put("refundApplyGetSplitDto",arr2);
			product.put("refundApplyPromotionSplitDto",arr3);
////			product.put("sellDetails", sellDetailss[j]);
//			str = sellDetailss[j];
//			str=str.substring(1,str.length()-1);
//			str+=p;
			products.add(product);
//			products.add(str);
			j++;
		}
		paramMap.put("products", products);
		//扣款介质
		JSONArray deduction = new JSONArray();
//		JSONObject payMent = null ;
//		String orderNos[] = request.getParameterValues("orderNo");
//		String orderItemNos[] = request.getParameterValues("orderItemNo");
//		String sellPaymentss[] = request.getParameterValues("sellPayments");
		String sellPayments = request.getParameter("sellPayments");
		if(!"".equals(sellPayments)&&null!=sellPayments){
			deduction = JSON.parseArray(sellPayments);
		}else{
			deduction = null;
		}
//		int i = 0;
//		for(String sellPayments:sellPaymentss){
//			payMent = new JSONObject();
////			payMent.put("orderItemNo", orderItemNo);
////			payMent.put("orderNo", orderNos[i]);
//			payMent.put("sellPayment", sellPayments);
//			deduction.add(payMent);
//			i++;
//		}
		paramMap.put("deduction", deduction);
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("save_rerundApply_CS"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/refundApply/createRefundApplyCS.htm", jsonStr);
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
	 * 客服创建退货申请单2
	 * @Methods Name createRefund2
	 * @Create In 2015-10-22 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/createKeRefund2")
	public String createKeRefund2(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		//退货申请单
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		paramMap.put("refundStatus", request.getParameter("refundStatus"));
		paramMap.put("refundNum", request.getParameter("refundNum15"));
		paramMap.put("refundTarget", request.getParameter("refundTarget"));
		paramMap.put("refundMoneyChannel", request.getParameter("refundMoneyChannel"));
		paramMap.put("refundType", request.getParameter("refundType"));
		paramMap.put("refundClass", request.getParameter("refundClass"));
		paramMap.put("refundAmount", request.getParameter("refundAmount"));
		paramMap.put("needRefundAmount", request.getParameter("needRefundAmount"));
		paramMap.put("returnShippingFee", request.getParameter("returnShippingFee"));
		paramMap.put("paymentClass", request.getParameter("paymentClass"));
		paramMap.put("paymentClassDesc", request.getParameter("paymentClassDesc"));
		paramMap.put("problemDesc", request.getParameter("problemDesc"));
		paramMap.put("customerComments", request.getParameter("customerComments"));
		paramMap.put("callCenterComments", request.getParameter("callCenterComments"));//备注
		paramMap.put("packStatus", request.getParameter("packStatus"));//包装情况
		paramMap.put("productsStatus", request.getParameter("productsStatus"));//商品情况
		paramMap.put("createMode", request.getParameter("createMode"));
		paramMap.put("exchangeNo", request.getParameter("exchangeNo"));
		paramMap.put("originalDeliveryNo", request.getParameter("originalDeliveryNo"));
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
		paramMap.put("refundPath", request.getParameter("refundPath"));
		paramMap.put("channel", request.getParameter("channel"));
		
		
		JSONArray products = new JSONArray();
		JSONObject product ;
		//组装赠品数据
		String gift = request.getParameter("gift"); //赠品数据
		System.out.println(gift);
		if("".equals(gift)||null==gift){
			
		}else{
			String giftArr [] = gift.split("\\|");
			for(String giftStr : giftArr){
				product = new JSONObject();
				String giftItemArr[] = giftStr.split(",");
				product.put("refundNum", giftItemArr[0]);
				product.put("orderItemNo", giftItemArr[1]);
				products.add(product);
				
			}
		}
		//退货申请单明细明细
		String refundPcitureUrls[] = request.getParameterValues("refundPcitureUrl");
		String orderItemNoqs[] = request.getParameterValues("orderItemNo");
		String refundNum15s[] = request.getParameterValues("refundNum16");
		String problemDescs[] = request.getParameterValues("problemDesc");
		//组装非赠品数据
		for(String orderItemNo:orderItemNoqs){
			product = new JSONObject();
			product.put("orderItemNo", orderItemNo);
			product.put("refundNum", refundNum15s[0]);
			product.put("refundPcitureUrl", refundPcitureUrls[0]);
			product.put("refundReasionNo", problemDescs[0]);//退货原因
			products.add(product);
		}
		paramMap.put("products", products);
		//扣款介质
		JSONArray deduction = new JSONArray();
		String sellPayments = request.getParameter("sellPayments");
		if(!"".equals(sellPayments)&&null!=sellPayments){
			deduction = JSON.parseArray(sellPayments);
		}else{
			deduction = null;
		}
		paramMap.put("deduction", deduction);
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("save_rerundApply_CS"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/refundApply/createRefundApplyCS.htm", jsonStr);
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
	 * 缺货退货创建退货申请单
	 * @Methods Name createKeRefund3
	 * @Create In 2016-1-19 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/createKeRefund3")
	public String createKeRefund3(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		//退货申请单
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("saleNo", request.getParameter("saleNo"));
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		paramMap.put("refundStatus", request.getParameter("refundStatus"));
		paramMap.put("refundNum", request.getParameter("refundNum15"));
		paramMap.put("refundTarget", request.getParameter("refundTarget"));
		paramMap.put("refundMoneyChannel", request.getParameter("refundMoneyChannel"));
		paramMap.put("refundType", request.getParameter("refundType"));
		paramMap.put("refundClass", request.getParameter("refundClass"));
		paramMap.put("refundAmount", request.getParameter("refundAmount"));
		paramMap.put("needRefundAmount", request.getParameter("needRefundAmount"));
		paramMap.put("returnShippingFee", request.getParameter("returnShippingFee"));
		paramMap.put("paymentClass", request.getParameter("paymentClass"));
		paramMap.put("paymentClassDesc", request.getParameter("paymentClassDesc"));
		paramMap.put("problemDesc", request.getParameter("problemDesc"));
		paramMap.put("customerComments", request.getParameter("customerComments"));
		paramMap.put("callCenterComments", request.getParameter("callCenterComments"));
		paramMap.put("packStatus", request.getParameter("packStatus"));
		paramMap.put("productsStatus", request.getParameter("productsStatus"));
		paramMap.put("createMode", request.getParameter("createMode"));
		paramMap.put("exchangeNo", request.getParameter("exchangeNo"));
		paramMap.put("originalDeliveryNo", request.getParameter("originalDeliveryNo"));
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
		paramMap.put("refundPath", request.getParameter("refundPath"));
		paramMap.put("channel", request.getParameter("channel"));
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("save_rerundApply_OOS"), jsonStr);
//			json = HttpUtilPcm.doPost("http://172.16.255.226:8081/oms-core/refundApply/saveRefundApplyOOS.htm", jsonStr);
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
	 * 缺货退货创建申请单
	 * @Methods Name createInerimRefund
	 * @Create In 2015-11-24 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/createInerimRefund")
	public String createInerimRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		JSONArray paramMap = new JSONArray();
		//退货申请单
		JSONObject sale = new JSONObject();
		String saleNo = request.getParameter("saleNo");
		String latestUpdateMan = request.getParameter("latestUpdateMan");
		sale.put("saleNo", saleNo);
		sale.put("latestUpdateMan", latestUpdateMan);
		paramMap.add(sale);
		//退货申请单明细明细
		JSONArray products = new JSONArray();
		JSONObject product ;
		String salesItemNos[] = request.getParameterValues("salesItemNo");
		String refundNums[] = request.getParameterValues("refundNum");
		
		int j = 0;
		for(String salesItemNo:salesItemNos){
			product = new JSONObject();
			product.put("salesItemNo", salesItemNo);
			product.put("refundNum", refundNums[j]);
			
			products.add(product);
			j++;
		}
//		paramMap.add(products);
		sale.put("products", products);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("understock_operate_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/interim/understockOperate.htm", jsonStr);
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
	 * 退货申请单取消
	 * @Methods Name refundApplyCancel
	 * @Create In 2015-10-26 By chenhu
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
		
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/prPosFlow/savePaymentInfo.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/refundApply/deleteRefundApplyStatus.htm", jsonStr);
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
	 * 查询退货申请单
	 * @Methods Name foundByRefund
	 * @Create In 2015-10-27 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundByRefund")
	public String foundByRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("currentPage", 1);
		paramMap.put("pageSize", 10);
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		
//		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/prPosFlow/savePaymentInfo.htm", jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/refundApply/selectRefundApplyPage.htm", jsonStr);
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
	 * 退货申请单审核
	 * @Methods Name refundCheck
	 * @Create In 2015-10-27 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/refundCheck")
	public String refundCheck(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		paramMap.put("callCenterComments", request.getParameter("callCenterComments"));
		paramMap.put("refundStatus", request.getParameter("refundStatus"));
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
		paramMap.put("reimbursePath", request.getParameter("refundTarget"));
		paramMap.put("returnShippingFee", request.getParameter("refundFee"));
		
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("create_online_refund"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/refundApply/createOnlineRefund.htm", jsonStr);
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
	 * 退货申请单审核2
	 * @Methods Name refundCheck2
	 * @Create In 2015-10-27 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/refundCheck2")
	public String refundCheck2(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		String js = request.getParameter("jj");
		if(js!=null){
			JSONObject jb = JSONObject.parseObject(js);
			paramMap.put("billDetail", jb.get("billDetail"));
			paramMap.put("calcBillid", jb.get("calcBillid"));
		}
//		paramMap.put("bankName", request.getParameter("bankName"));
//		paramMap.put("bankNumber", request.getParameter("bankNumber"));
		paramMap.put("quan", request.getParameter("quan"));
		paramMap.put("returnShippingFee", request.getParameter("refundFee"));
		paramMap.put("refundPath", request.getParameter("refundType"));
//		paramMap.put("warehouseAddress", request.getParameter("address"));
		paramMap.put("fromSystem", "PCM");
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
		paramMap.put("refundStatus", request.getParameter("refundStatus"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost(CommonProperties.get("sale_return_affirmreturn"), jsonStr);
			json = HttpUtilPcm.doPost("http://192.168.6.253:8091/oms-admin/promReesult/salereturnAffirmreturn.htm", jsonStr);
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
	 * 查询退货扣款介质
	 * @Methods Name foundPromResult
	 * @Create In 2015-11-10 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundPromResult")
	public String foundPromResult(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNo", request.getParameter("orderNo"));
		if(null!=request.getParameter("refundApplyNo")){
			paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
		}
		Map<Object, Object> paramMap2 = new HashMap<Object, Object>();
		List list = new ArrayList<Object>();
		paramMap2.put("orderItemNo", request.getParameter("orderItemNo"));
		paramMap2.put("refundNum", request.getParameter("refundNum15"));
		list.add(paramMap2);
		paramMap.put("products", list);
		
//		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8083/oms-prefix-core/prPosFlow/savePaymentInfo.htm", jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/promReesult/selectPromReesult.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_prom_reesult"), jsonStr);
//			json = HttpUtilPcm.doPost("http://172.16.255.226:8091/oms-admin/promReesult/selectPromReesult.htm", jsonStr);
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
	 * 创建发票
	 * @Methods Name createInvoice
	 * @Create In 2015-11-25 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/createInvoice")
	public String createInvoice(HttpServletRequest request, HttpServletResponse response) {
		String json = "";

		String saleNos[] = request.getParameterValues("saleNo");
		String invoiceNos[] = request.getParameterValues("invoiceNo");
		String invoiceAmounts[] = request.getParameterValues("invoiceAmount");
		String invoiceTitles[] = request.getParameterValues("invoiceTitle");
		String invoiceDetails[] = request.getParameterValues("invoiceDetail");
		String invoiceStatuss[] = request.getParameterValues("invoiceStatus");
		String createdTimeStrs[] = request.getParameterValues("createdTimeStr");
		String createdMans[] = request.getParameterValues("createdMan");
		String latestUpdateMans[] = request.getParameterValues("latestUpdateMan");
		JSONArray paraLists = new JSONArray();
		int i = 0;
		for(String saleNo:saleNos){
			JSONObject pay = new JSONObject();
			pay.put("saleNo", saleNo);
			pay.put("invoiceNo", invoiceNos[i]);
			pay.put("invoiceAmount", invoiceAmounts[i]);
			pay.put("invoiceTitle", invoiceTitles[i]);
			pay.put("invoiceDetail", invoiceDetails[i]);
			pay.put("invoiceStatus", invoiceStatuss[i]);
			pay.put("createdTimeStr", createdTimeStrs[i]);
			pay.put("createdMan", createdMans[i]);
			pay.put("latestUpdateMan", latestUpdateMans[i]);

			paraLists.add(pay);
			i++;
		}

		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paraLists);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/ofInvoice/saveInvoices.htm", jsonStr);
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
	 * 修改销售单状态
	 * @Methods Name updateSaleStatus
	 * @Create In 2015-11-24 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updateSaleStatus")
	public String updateSaleStatus(HttpServletRequest request, HttpServletResponse response) {
		String json = "";

		String saleNos[] = request.getParameterValues("saleNo");
		String orderNos[] = request.getParameterValues("orderNo");
		String saleStatuss[] = request.getParameterValues("saleStatus");
		String saleStatusDescs[] = request.getParameterValues("saleStatusDesc");
		String latestUpdateMans[] = request.getParameterValues("latestUpdateMan");
		JSONArray paraLists = new JSONArray();
		int i = 0;
		for(String saleNo:saleNos){
			JSONObject pay = new JSONObject();
			pay.put("saleNo", saleNo);
			pay.put("orderNo", orderNos[i]);
			pay.put("saleStatus", saleStatuss[i]);
			pay.put("saleStatusDesc", saleStatusDescs[i]);
			pay.put("latestUpdateMan", latestUpdateMans[i]);

			paraLists.add(pay);
			i++;
		}

		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paraLists);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("update_sale_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/ofSale/updateSaleList.htm", jsonStr);
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
	 * 修改退货单状态
	 * @Methods Name updateRefundStatus
	 * @Create In 2015-11-24 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updateRefundStatus")
	public String updateRefundStatus(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		String refundNos[] = request.getParameterValues("refundNo");
		String refundStatuss[] = request.getParameterValues("refundStatus");
		String refundStatusDescs[] = request.getParameterValues("refundStatusDesc");
		String latestUpdateMans[] = request.getParameterValues("latestUpdateMan");
		JSONArray paraLists = new JSONArray();
		int i = 0;
		for(String refundNo:refundNos){
			JSONObject pay = new JSONObject();
			pay.put("refundNo", refundNo);
			pay.put("refundStatus", refundStatuss[i]);
			pay.put("refundStatusDesc", refundStatusDescs[i]);
			pay.put("latestUpdateMan", latestUpdateMans[i]);
			
			paraLists.add(pay);
			i++;
		}
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paraLists);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("update_refund_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/refund/updateRefundList.htm", jsonStr);
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
	 * 价格查询
	 * @Methods Name selectProduct
	 * @Create In 2016-1-8 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPrice")
	public String selectProduct(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String spn = request.getParameter("supplyProductNo");
		String paraData = "{\"productNos\": [{\"supplyProductNo\":\"datapalce\"}]}";
		paraData = paraData.replaceFirst("datapalce", request.getParameter("supplyProductNo")==null?"":request.getParameter("supplyProductNo"));
		
		String paraData2 = "{\"productNos\": [{\"supplyProductNo\":\"datapalce1\"}]}";
		paraData2 = paraData2.replace("datapalce1", request.getParameter("skuNo")==null?"":request.getParameter("skuNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("jsonStr:" + paraData);
			logger.info("jsonStr:" + paraData2);
			if((!"".equals(spn))&&spn!=null){
				json = HttpUtilPcm.doPost("http://10.6.2.48:8042/pcm-inner-sdc/product/selectSupplyProductList.htm", paraData);
			}else{
				json = HttpUtilPcm.doPost("http://10.6.2.48:8042/pcm-inner-sdc/product/selectSupplyProductListOrdered.htm", paraData2);
			}
			logger.info("json:" + json);
			JSONObject jsonObject = JSON.parseObject(json);
			JSONObject dataObject = jsonObject.getJSONObject("data");
			JSONArray product = dataObject.getJSONArray("products");
			if (product != null && product.size() != 0) {
				m.put("data", product.get(0));
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
	 * 查询退货单及其促销信息
	 * @Methods Name selectRefundALL
	 * @Create In 2016-1-8 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundALL")
	public String selectRefundALL(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundNo", request.getParameter("refundNo"));
		paramMap.put("fromSystem", "PCM");
		String jsonStr = JSON.toJSONString(paramMap);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refund_all"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8081/oms-core/refund/selectALL.htm", jsonStr);
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
	 * 查询销售单(发货前销售单)
	 * @Methods Name selectSaleList2
	 * @Create In 2016-1-19 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectSaleList2")
	public String selectSaleList2(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<String, String> paramMap = this.createParam(request);
		paramMap.put("createdMode", "AUTO");//线上
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8087/oms-core-sdc/ofSelect/selectSale2.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_sale2_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.parseObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.parseObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
			
			//渠道字段转换(PCM接口)
			String jsonStr22 = "";
			Map<Object, Object> paramMap22 = new HashMap<Object, Object>();
			jsonStr22 = JSON.toJSONString(paramMap22);
			String json22 = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmAdminChannel/findListChannel.htm", jsonStr22);
			logger.info("json22:" + json22);
			net.sf.json.JSONObject jsonObjectJ22 = net.sf.json.JSONObject.fromObject(json22);
			String codeData2 = jsonObjectJ22.getString("data");
			net.sf.json.JSONArray json2Object2 = net.sf.json.JSONArray.fromObject(codeData2);
			
			List<Object> list41 = new ArrayList<Object>();
			for (int i = 0; i < list.size(); i++) {
				Object object = list.get(i);
				net.sf.json.JSONObject jsonObject41 = net.sf.json.JSONObject.fromObject(object);
				String channelName =null;
				try {
					channelName = jsonObject41.getString("saleSource");
					if(null!=json2Object2){
						for(int j=0; j < json2Object2.size(); j++){
							net.sf.json.JSONObject jsonObject31 = (net.sf.json.JSONObject) json2Object2.get(j);
							String codeValue = jsonObject31.getString("channelCode");
							String codeName = jsonObject31.getString("channelName");
							if(channelName.equals(codeValue)){
								channelName = codeName;
								jsonObject41.put("saleSource",codeName);
								list41.add(jsonObject41);
								break;
							}else if(j==json2Object2.size()-1){
								net.sf.json.JSONObject jsonObject51 = net.sf.json.JSONObject.fromObject(object);
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
	 * 订单地址异常查询
	 * @Methods Name selectSaleList3
	 * @Create In 2016-3-11 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectSaleList3")
	public String selectSaleList3(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		Map<String, String> paramMap = this.createParam(request);
		paramMap.put("orderStatus", "9306");
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "OMS");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/ofSelect/selectPageByOrderStatus.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_sale3_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.parseObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.parseObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
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
	 * 查询订单（签收后）
	 * @Methods Name selectOrderList
	 * @Create In 2016-1-22 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderList")
	public String selectOrderList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("isCod", request.getParameter("isCod"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("outOrderNo", request.getParameter("outOrderNo"));
		paramMap.put("orderStatus", request.getParameter("orderStatus")); //9107  9108  已收货  已完成
		/*if("9107".equals(request.getParameter("orderStatus"))){
			paramMap.put("orderStatus", request.getParameter("orderStatus"));
		}else if(request.getParameter("orderStatus")==null || request.getParameter("orderStatus")==""){
			paramMap.put("orderStatus", "9107");
		}else{
			paramMap.put("orderStatus", "10000");
		}*/
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("payStatus", request.getParameter("payStatus"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("receptPhone", request.getParameter("receptPhone"));
		paramMap.put("memberType", request.getParameter("memberType"));
		paramMap.put("saleTimeStart", request.getParameter("startSaleTime"));
		paramMap.put("saleTimeEnd", request.getParameter("endSaleTime"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/order/selectOrderPage2.htm", jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_order2_list"), jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.parseObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.parseObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
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
	 * 查询退货单
	 * @Methods Name selectRefundList
	 * @Create In 2016-1-19 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundList2")
	public String selectRefundList2(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
//		int start = (currPage-1)*size;
		Map<String, String> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("createdMode", "1");//线上
		paramMap.put("start", String.valueOf(currPage));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refund2_list"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/ofSelect/selectRefund.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.parseObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.parseObject(data);
			List<Object> list = (List<Object>) jsonObject2.get("list");
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
	
	private Map<String, String> createParam(HttpServletRequest request) {
		request.removeAttribute("_method");
		Map<String, String> paramMap = new HashMap<String, String>();
		Enumeration enumeration = request.getParameterNames();
		while(enumeration.hasMoreElements()) {
			String paramStr = (String)enumeration.nextElement();
			if("orderSid".equals(paramStr)) {
				paramMap.put("orderSid", request.getParameter(paramStr));
			}else if("orderNo".equals(paramStr)) {
				paramMap.put("orderNo", request.getParameter(paramStr));
			}else if("saleSource".equals(paramStr)) {
				paramMap.put("saleSource", request.getParameter(paramStr));
			}else if("outOrderNo".equals(paramStr)) {
				paramMap.put("outOrderNo", request.getParameter(paramStr));
			}else if("state".equals(paramStr)) {
				paramMap.put("orderStatus", request.getParameter(paramStr));
			}else if("endSaleTime".equals(paramStr)) {
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
				}
			}else if("endRefundTime".equals(paramStr)) {
				
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
				}
					
//				paramMap.put("endSaleTime", request.getParameter(paramStr));
//			}else if("startSaleTime".equals(paramStr)) {
//				paramMap.put("startSaleTime", request.getParameter(paramStr));
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
			}else{
				paramMap.put(paramStr, request.getParameter(paramStr));
			}
		}
		return paramMap;
	}
	/**
	 * 查询销售单发票信息(根据订单号查询)
	 * @Methods Name selectInvoiceList
	 * @Create In 2016-2-1 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectInvoiceList")
	public String selectInvoiceList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_invoice_orderNo"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/ofSelect/selectInvoiceByOrderNo.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.parseObject(json);
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
	
	@ResponseBody
	@RequestMapping("/selectCustomerInfo")
	public String selectCustomerInfo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("fromSystem", "PCM");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_customer_info"), jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.46:8087/oms-core-sdc/ofSelect/selectInvoiceByOrderNo.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.parseObject(json);
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
	 * 查看退货申请营销所有信息
	 * @Methods Name selectRefundApplyAll
	 * @Create In 2016-4-25 By chenHu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundApplyAll")
	public String selectRefundApplyAll(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundApplyNo", request.getParameter("refundApplyNo"));
//		paramMap.put("fromSystem", "OMSADMIN");
		String jsonStr = JSON.toJSONString(paramMap);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost(CommonProperties.get("select_refundApply_all"), jsonStr);
//			json = HttpUtilPcm.doPost("http://localhost:8081/oms-core/refundApply/selectRefundApplyAll.htm", jsonStr);
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
}
