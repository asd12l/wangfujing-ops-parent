package com.wangfj.order.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

/**
 * 
 * @Comment	针对网站后台-销售-OMS订单管理
 * @Class Name OmsController
 * @Author tangysh
 * @Create In 2015-8-13
 */
@Controller
@RequestMapping("/testOms")
public class TestOmsController {

	private static final Logger logger = LoggerFactory.getLogger(TestOmsController.class);

	public static final String FROM_SYSTEM = "ORDERBACK";



	/**
	 * 创建销售单
	 * @Methods Name foundSale
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundSale")
	public String foundSale(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();//= this.createParam(request);
		paramMap.put("saleSource", "X1");
		paramMap.put("accountNo", request.getParameter("accountNo"));
		paramMap.put("casherNo", request.getParameter("casherNo"));
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("shoppeNo", request.getParameter("shoppeNo"));
		paramMap.put("employeeNo", request.getParameter("employeeNo"));
		paramMap.put("supplyNo", request.getParameter("supplyNo"));
		paramMap.put("suppllyName", request.getParameter("suppllyName"));
		paramMap.put("invoiceAmount", request.getParameter("invoiceAmount"));
		paramMap.put("saleType", request.getParameter("saleType"));
		paramMap.put("authorityCard", request.getParameter("authorityCard"));
		paramMap.put("authorized", request.getParameter("authorized"));
		paramMap.put("cashIncomeFlag", request.getParameter("cashIncomeFlag"));
		paramMap.put("needInvoice", request.getParameter("needInvoice"));
		paramMap.put("invoiceTitle", request.getParameter("invoiceTitle"));
		paramMap.put("storeName", request.getParameter("storeName"));
		paramMap.put("shoppeName", request.getParameter("shoppeName"));
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("saleClass", request.getParameter("saleClass"));
		paramMap.put("saleAmount", request.getParameter("saleAmount"));
		paramMap.put("paymentAmount", request.getParameter("paymentAmount1"));
		paramMap.put("qrcode", request.getParameter("qrcode"));

		String brandNames[] = request.getParameterValues("brandName");
		String shoppeProNames[] = request.getParameterValues("shoppeProName");
		String supplyProductNos[] = request.getParameterValues("supplyProductNo");
		String erpProductNos[] = request.getParameterValues("erpProductNo");
		String skuNos[] = request.getParameterValues("skuNo");
		String spuNos[] = request.getParameterValues("spuNo");
		String supplyInnerProdNos[] = request.getParameterValues("supplyInnerProdNo");
		String units[] = request.getParameterValues("unit");
		String barcodes[] = request.getParameterValues("barcode");
		String colorNos[] = request.getParameterValues("colorNo");
		String colorNames[] = request.getParameterValues("colorName");
		String sizeNos[] = request.getParameterValues("sizeNo");
		String sizeNames[] = request.getParameterValues("sizeName");
		String brandNos[] = request.getParameterValues("brandNo");
		String statisticsCateNos[] = request.getParameterValues("statisticsCateNo");
		String standPrices[] = request.getParameterValues("standPrice");
		String salePrices[] = request.getParameterValues("salePrice");
		String saleSums[] = request.getParameterValues("saleSum");
		String paymentAmounts[] = request.getParameterValues("paymentAmount");
		String isGifts[] = request.getParameterValues("isGift");
		String cashIncomeFlags[] = request.getParameterValues("cashIncomeFlag1");
		String productClasses[] = request.getParameterValues("productClass");
		String productTypes[] = request.getParameterValues("productType");
		String incomeAmounts[] = request.getParameterValues("incomeAmount");
		String taxs[] = request.getParameterValues("tax");
		JSONArray products = new JSONArray();
		JSONObject product ;
		int i = 0;
		for(String shoppeProName:shoppeProNames){
			product = new JSONObject();
			product.put("shoppeProName", shoppeProName);
			product.put("brandName", brandNames[i]);
			product.put("supplyProductNo", supplyProductNos[i]);
			product.put("erpProductNo", erpProductNos[i]);
			product.put("skuNo", skuNos[i]);
			product.put("spuNo", spuNos[i]);
			product.put("supplyInnerProdNo", supplyInnerProdNos[i]);
			product.put("unit", units[i]);
			product.put("barcode", barcodes[i]);
			product.put("colorNo", colorNos[i]);
			product.put("colorName", colorNames[i]);
			product.put("sizeNo", sizeNos[i]);
			product.put("sizeName", sizeNames[i]);
			product.put("brandNo", brandNos[i]);
			product.put("statisticsCateNo", statisticsCateNos[i]);
			product.put("standPrice", standPrices[i]);
			product.put("salePrice", salePrices[i]);
			product.put("saleSum", saleSums[i]);
			product.put("paymentAmount", paymentAmounts[i]);
			product.put("isGift", isGifts[i]);
			product.put("cashIncomeFlag", cashIncomeFlags[i]);
			product.put("productClass", productClasses[i]);
			product.put("productType", productTypes[i]);
			product.put("incomeAmount", incomeAmounts[i]);
			product.put("tax", taxs[i]);
			products.add(product);
			i++;
		}
		paramMap.put("products", products);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prSale/createPrSaleOrder.htm", jsonStr);
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
	 * 打印销售单
	 * @Methods Name printSale
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/printSale")
	public String printSale(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("saleNo"));
		paramMap.put("operator", request.getParameter("operator"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prPrint/printSale.htm", jsonStr);
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
	 * 销售单POS支付
	 * @Methods Name salePos
	 * @Create In 2015-8-31 By tangysh
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
		paramMap.put("money", request.getParameter("money"));
		paramMap.put("payFlowNo", request.getParameter("payFlowNo"));
		paramMap.put("posNo", request.getParameter("posNo"));
		paramMap.put("ooFlag", request.getParameter("ooFlag"));
		paramMap.put("payTimeStr", request.getParameter("payTimeStr"));
		paramMap.put("isRefund", request.getParameter("isRefund"));
		paramMap.put("totalDiscountAmount", request.getParameter("totalDiscountAmount"));
		paramMap.put("paymentAmount", request.getParameter("paymentAmount"));
		paramMap.put("actualPaymentAmount", request.getParameter("actualPaymentAmount"));
		paramMap.put("changeAmount", request.getParameter("changeAmount"));
		paramMap.put("tempDiscountAmount", request.getParameter("tempDiscountAmount"));
		paramMap.put("zrAmount", request.getParameter("zrAmount"));
		paramMap.put("memberDiscountAmount", request.getParameter("memberDiscountAmount"));
		paramMap.put("promDiscountAmount", request.getParameter("promDiscountAmount"));
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("shopName", request.getParameter("shopName"));
		paramMap.put("income", request.getParameter("income"));
		paramMap.put("casher", request.getParameter("casher"));
		paramMap.put("shifts", request.getParameter("shifts"));
		paramMap.put("channel", request.getParameter("channel"));
		paramMap.put("weixinCard", request.getParameter("weixinCard"));
		paramMap.put("weixinStoreNo", request.getParameter("weixinStoreNo"));               
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("rmb", request.getParameter("rmb")); 
		paramMap.put("elecGet", request.getParameter("elecGet"));               
		paramMap.put("elecDeducation", request.getParameter("elecDeducation"));
		paramMap.put("bankServiceCharge", request.getParameter("bankServiceCharge"));
		paramMap.put("sourceType", request.getParameter("sourceType")); 


		String saleNo1s[] = request.getParameterValues("saleNo1");
		JSONArray sales = new JSONArray();		
		int p = 0;
		for(String saleno:saleNo1s){			
			sales.add(saleno);
			p++;
		}
		paramMap.put("saleNos", sales);


		String paymentClasses[] = request.getParameterValues("paymentClass");
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
		JSONArray pays = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String paymentClass:paymentClasses){
			pay = new JSONObject();
			pay.put("paymentClass", paymentClass);
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

			pays.add(pay);
			i++;
		}
		paramMap.put("payments", pays);



		String codes[] = request.getParameterValues("code");
		String names[] = request.getParameterValues("name");
		String getTypes[] = request.getParameterValues("getType");
		String getChannels[] = request.getParameterValues("getChannel");
		String getTimeStrs[] = request.getParameterValues("getTimeStr");
		String amount1s[] = request.getParameterValues("amount1");		
		String couponBatch1s[] = request.getParameterValues("couponBatch1");

		JSONArray gets = new JSONArray();
		JSONObject get ;
		i = 0;
		for(String code:codes){
			get = new JSONObject();
			get.put("code", code);						
			get.put("name", names[i]);
			get.put("getType", getTypes[i]);
			get.put("getChannel", getChannels[i]);
			get.put("getTimeStr", getTimeStrs[i]);			
			get.put("amount", amount1s[i]);
			get.put("couponBatch", couponBatch1s[i]);		


			gets.add(get);
			i++;
		}
		paramMap.put("flowGets", gets);


		String rowNos[] = request.getParameterValues("rowNo");
		String saleNos[] = request.getParameterValues("saleNo");
		String paymentAmount1s[] = request.getParameterValues("paymentAmount1");
		String supplyProductNos[] = request.getParameterValues("supplyProductNo");
		String salesItemIds[] = request.getParameterValues("salesItemId");
		String saleSums[] = request.getParameterValues("saleSum");		
		String erpProductNos[] = request.getParameterValues("erpProductNo");
		String promotionSplitses[] = request.getParameterValues("promotionSplits");
		JSONArray products = new JSONArray();
		JSONObject product ;
		i = 0;
		for(String rowNo:rowNos){
			product = new JSONObject();
			product.put("rowNo",rowNo);						
			product.put("saleNo", saleNos[i]);
			product.put("paymentAmount", paymentAmount1s[i]);
			product.put("supplyProductNo", supplyProductNos[i]);
			product.put("salesItemId", salesItemIds[i]);			
			product.put("saleSum", saleSums[i]);
			product.put("erpProductNo", erpProductNos[i]);
			product.put("promotionSplits", JSON.parseArray(promotionSplitses[i]));		

			products.add(product);
			i++;
		}
		paramMap.put("products", products);

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prPosFlow/savePaymentInfo.htm", jsonStr);
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
	 * 全脱机支付
	 * @Methods Name salePay
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/salePay")
	public String salePay(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		paramMap.put("money", request.getParameter("money"));
		paramMap.put("payFlowNo", request.getParameter("payFlowNo"));
		paramMap.put("posNo", request.getParameter("posNo"));
		paramMap.put("ooFlag", request.getParameter("ooFlag"));
		paramMap.put("payTimeStr", request.getParameter("payTimeStr"));
		paramMap.put("isRefund", request.getParameter("isRefund"));
		paramMap.put("totalDiscountAmount", request.getParameter("totalDiscountAmount"));
		paramMap.put("paymentAmount", request.getParameter("paymentAmount"));
		paramMap.put("actualPaymentAmount", request.getParameter("actualPaymentAmount"));
		paramMap.put("changeAmount", request.getParameter("changeAmount"));
		paramMap.put("tempDiscountAmount", request.getParameter("tempDiscountAmount"));
		paramMap.put("zrAmount", request.getParameter("zrAmount"));
		paramMap.put("memberDiscountAmount", request.getParameter("memberDiscountAmount"));
		paramMap.put("promDiscountAmount", request.getParameter("promDiscountAmount"));
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("shopName", request.getParameter("shopName"));
		paramMap.put("income", request.getParameter("income"));
		paramMap.put("casher", request.getParameter("casher"));
		paramMap.put("shifts", request.getParameter("shifts"));
		paramMap.put("channel", request.getParameter("channel"));
		paramMap.put("weixinCard", request.getParameter("weixinCard"));
		paramMap.put("weixinStoreNo", request.getParameter("weixinStoreNo"));               
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("rmb", request.getParameter("rmb")); 
		paramMap.put("elecGet", request.getParameter("elecGet"));               
		paramMap.put("elecDeducation", request.getParameter("elecDeducation"));
		paramMap.put("bankServiceCharge", request.getParameter("bankServiceCharge"));
		paramMap.put("sourceType", request.getParameter("sourceType")); 


		String paymentClasses[] = request.getParameterValues("paymentClass");
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
		JSONArray pays = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String paymentClass:paymentClasses){
			pay = new JSONObject();
			pay.put("paymentClass", paymentClass);
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

			pays.add(pay);
			i++;
		}
		paramMap.put("payments", pays);



		String codes[] = request.getParameterValues("code");
		String names[] = request.getParameterValues("name");
		String getTypes[] = request.getParameterValues("getType");
		String getChannels[] = request.getParameterValues("getChannel");
		String getTimeStrs[] = request.getParameterValues("getTimeStr");
		String amount1s[] = request.getParameterValues("amount1");		
		String couponBatch1s[] = request.getParameterValues("couponBatch1");

		JSONArray gets = new JSONArray();
		JSONObject get ;
		i = 0;
		for(String code:codes){
			get = new JSONObject();
			get.put("code", code);						
			get.put("name", names[i]);
			get.put("getType", getTypes[i]);
			get.put("getChannel", getChannels[i]);
			get.put("getTimeStr", getTimeStrs[i]);			
			get.put("amount", amount1s[i]);
			get.put("couponBatch", couponBatch1s[i]);		


			gets.add(get);
			i++;
		}
		paramMap.put("flowGets", gets);


		String rowNos[] = request.getParameterValues("rowNo");
//		String saleNos[] = request.getParameterValues("saleNo");
		String paymentAmount1s[] = request.getParameterValues("paymentAmount1");
		String supplyProductNos[] = request.getParameterValues("supplyProductNo");
//		String salesItemIds[] = request.getParameterValues("salesItemId");
		String saleSums[] = request.getParameterValues("saleSum");		
		String erpProductNos[] = request.getParameterValues("erpProductNo");
		JSONArray products = new JSONArray();
		JSONObject product ;
		i = 0;
		for(String rowNo:rowNos){
			product = new JSONObject();
			product.put("rowNo",rowNo);						
//			product.put("saleNo", saleNos[i]);
			product.put("paymentAmount", paymentAmount1s[i]);
			product.put("supplyProductNo", supplyProductNos[i]);
//			product.put("salesItemId", salesItemIds[i]);			
			product.put("saleSum", saleSums[i]);
			product.put("erpProductNo", erpProductNos[i]);
			products.add(product);
			i++;
		}
		paramMap.put("products", products);


		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prAllOfflineFlow/savePaymentInfo.htm", jsonStr);
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
	 * PAD创建
	 * @Methods Name salePadCreat
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/salePadCreat")
	public String salePadCreat(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("posNo", request.getParameter("posNo"));
		paramMap.put("ooFlag", request.getParameter("ooFlag"));

		paramMap.put("isRefund", request.getParameter("isRefund"));

		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("shopName", request.getParameter("shopName"));
		paramMap.put("authorizationNo", request.getParameter("authorizationNo"));
		paramMap.put("casher", request.getParameter("casher"));
		paramMap.put("shifts", request.getParameter("shifts"));
		paramMap.put("channel", request.getParameter("channel"));
		paramMap.put("weixinCard", request.getParameter("weixinCard"));
		paramMap.put("weixinStoreNo", request.getParameter("weixinStoreNo"));               
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));


		String saleNo1s[] = request.getParameterValues("saleNo");
		JSONArray sales = new JSONArray();		
		int p = 0;
		for(String saleno:saleNo1s){			
			sales.add(saleno);
			p++;
		}
		paramMap.put("saleNos", sales);

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prNewPadFlow/creatPadFlowNo.htm", jsonStr);
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
	 * PAD添加销售单
	 * @Methods Name salePadAdd
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/salePadAdd")
	public String salePadAdd(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("salesPaymentNo")))
		{
			paramMap.put("salePaymentNo", request.getParameter("salesPaymentNo"));
		}		
		paramMap.put("saleNo", request.getParameter("saleNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prNewPadFlow/addSaleIntoPadFlow.htm", jsonStr);
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
	 * PAD取消
	 * @Methods Name salePadCancle
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/salePadCancle")
	public String salePadCancle(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("salesPaymentNo")))
		{
			paramMap.put("salePaymentNo", request.getParameter("salesPaymentNo"));
		}	
		paramMap.put("saleNo", request.getParameter("saleNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prNewPadFlow/cancelSaleFormPadFlow.htm", jsonStr);
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
	 * PAD支付
	 * @Methods Name salePad
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/salePad")
	public String salePad(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		paramMap.put("money", request.getParameter("money"));
		paramMap.put("payFlowNo", request.getParameter("payFlowNo"));

		paramMap.put("payTimeStr", request.getParameter("payTimeStr"));

		paramMap.put("totalDiscountAmount", request.getParameter("totalDiscountAmount"));
		paramMap.put("paymentAmount", request.getParameter("paymentAmount"));
		paramMap.put("actualPaymentAmount", request.getParameter("actualPaymentAmount"));
		paramMap.put("changeAmount", request.getParameter("changeAmount"));
		paramMap.put("tempDiscountAmount", request.getParameter("tempDiscountAmount"));
		paramMap.put("zrAmount", request.getParameter("zrAmount"));
		paramMap.put("memberDiscountAmount", request.getParameter("memberDiscountAmount"));
		paramMap.put("promDiscountAmount", request.getParameter("promDiscountAmount"));

		paramMap.put("income", request.getParameter("income"));


		paramMap.put("rmb", request.getParameter("rmb")); 
		paramMap.put("elecGet", request.getParameter("elecGet"));               
		paramMap.put("elecDeducation", request.getParameter("elecDeducation"));
		paramMap.put("bankServiceCharge", request.getParameter("bankServiceCharge"));


		String paymentClasses[] = request.getParameterValues("paymentClass");
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
		JSONArray pays = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String paymentClass:paymentClasses){
			pay = new JSONObject();
			pay.put("paymentClass", paymentClass);
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

			pays.add(pay);
			i++;
		}
		paramMap.put("payments", pays);



		String codes[] = request.getParameterValues("code");
		String names[] = request.getParameterValues("name");
		String getTypes[] = request.getParameterValues("getType");
		String getChannels[] = request.getParameterValues("getChannel");
		String getTimeStrs[] = request.getParameterValues("getTimeStr");
		String amount1s[] = request.getParameterValues("amount1");		
		String couponBatch1s[] = request.getParameterValues("couponBatch1");

		JSONArray gets = new JSONArray();
		JSONObject get ;
		i = 0;
		for(String code:codes){
			get = new JSONObject();
			get.put("code", code);						
			get.put("name", names[i]);
			get.put("getType", getTypes[i]);
			get.put("getChannel", getChannels[i]);
			get.put("getTimeStr", getTimeStrs[i]);			
			get.put("amount", amount1s[i]);
			get.put("couponBatch", couponBatch1s[i]);		


			gets.add(get);
			i++;
		}
		paramMap.put("flowGets", gets);

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prNewPadFlow/payPadFlow.htm", jsonStr);
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
	 * 打印款机
	 * @Methods Name printPay
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/printPay")
	public String printPay(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("starttime", request.getParameter("starttime"));
		paramMap.put("endtime", request.getParameter("endtime"));
		paramMap.put("posNo", request.getParameter("posNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prNewPadFlow/printPadFlow.htm", jsonStr);
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
	 * 作废销售单
	 * @Methods Name saleCancel
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/saleCancel")
	public String saleCancel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("saleNo"));
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prSale/prUpdateSaleBySaleNo.htm", jsonStr);
//			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prSale/cancelSale.htm", jsonStr);
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
	 * 作废退货单
	 * @Methods Name refundCancel
	 * @Create In 2015-8-31 By tangysh
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
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/refund/deletePrRefundStatus.htm", jsonStr);
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
	 * 顾客已提货
	 * @Methods Name takeStock
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/takeStock")
	public String takeStock(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("saleNo", request.getParameter("saleNo"));
		paramMap.put("operator", request.getParameter("operator"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prStockOperate/takeStock.htm", jsonStr);
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
	 * 创建退货单
	 * @Methods Name foundRefund
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundRefund")
	public String foundRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("originalSalesNo", request.getParameter("originalSalesNo"));
		paramMap.put("refundClass", request.getParameter("refundClass"));
		paramMap.put("payFlowNo", request.getParameter("payFlowNo"));
		paramMap.put("refundNum", request.getParameter("refundNum1"));
		paramMap.put("employeeNo", request.getParameter("employeeNo"));
		paramMap.put("operatorStore", request.getParameter("operatorStore"));
		paramMap.put("casherNo", request.getParameter("casherNo"));





		String saleItemNos[] = request.getParameterValues("saleItemNo");
		String refundNums[] = request.getParameterValues("refundNum");


		JSONArray pays = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String saleItemNo:saleItemNos){
			pay = new JSONObject();
			pay.put("refundNum", refundNums[i]);
			pay.put("saleItemNo", saleItemNo);


			pays.add(pay);
			i++;
		}
		paramMap.put("products", pays);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/refund/saveRefund.htm", jsonStr);
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
	 * 打印退货单
	 * @Methods Name printRefund
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/printRefund")
	public String printRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundNo", request.getParameter("refundNo"));
		paramMap.put("operator", request.getParameter("operator"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prPrint/printRefund.htm", jsonStr);
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
	 * 审核退货单
	 * @Methods Name examineRefund
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/examineRefund")
	public String examineRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundNo", request.getParameter("refundNo"));
		paramMap.put("operator", request.getParameter("operator"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prExamine/examineRefund.htm", jsonStr);
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
	 * 退货单退款
	 * @Methods Name refundPos
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/refundPos")
	public String refundPos(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		paramMap.put("money", request.getParameter("money"));
		paramMap.put("payFlowNo", request.getParameter("payFlowNo"));
		paramMap.put("posNo", request.getParameter("posNo"));
		paramMap.put("ooFlag", request.getParameter("ooFlag"));
		paramMap.put("payTimeStr", request.getParameter("payTimeStr"));
		paramMap.put("isRefund", request.getParameter("isRefund"));
		paramMap.put("totalDiscountAmount", request.getParameter("totalDiscountAmount"));
		paramMap.put("paymentAmount", request.getParameter("paymentAmount"));
		paramMap.put("actualPaymentAmount", request.getParameter("actualPaymentAmount"));
		paramMap.put("changeAmount", request.getParameter("changeAmount"));
		paramMap.put("tempDiscountAmount", request.getParameter("tempDiscountAmount"));
		paramMap.put("zrAmount", request.getParameter("zrAmount"));
		paramMap.put("memberDiscountAmount", request.getParameter("memberDiscountAmount"));
		paramMap.put("promDiscountAmount", request.getParameter("promDiscountAmount"));
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("shopName", request.getParameter("shopName"));
		paramMap.put("income", request.getParameter("income"));
		paramMap.put("casher", request.getParameter("casher"));
		paramMap.put("shifts", request.getParameter("shifts"));
		paramMap.put("channel", request.getParameter("channel"));
		paramMap.put("weixinCard", request.getParameter("weixinCard"));
		paramMap.put("weixinStoreNo", request.getParameter("weixinStoreNo"));               
		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("orderNo", request.getParameter("orderNo"));
		paramMap.put("rmb", request.getParameter("rmb")); 
		paramMap.put("elecGet", request.getParameter("elecGet"));               
		paramMap.put("elecDeducation", request.getParameter("elecDeducation"));
		paramMap.put("bankServiceCharge", request.getParameter("bankServiceCharge"));
		paramMap.put("sourceType", request.getParameter("sourceType")); 


		String refundNo1s[] = request.getParameterValues("refundNo1");
		JSONArray sales = new JSONArray();

		int l = 0;
		for(String refundNo1:refundNo1s){						
			sales.add(refundNo1);
			l++;
		}
		paramMap.put("saleNos", sales);

		String paymentClasses[] = request.getParameterValues("paymentClass");
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
		JSONArray pays = new JSONArray();
		JSONObject pay ;
		int i = 0;
		for(String paymentClass:paymentClasses){
			pay = new JSONObject();
			pay.put("paymentClass", paymentClass);
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

			pays.add(pay);
			i++;
		}
		paramMap.put("payments", pays);




		String paymentClass1s[] = request.getParameterValues("paymentClass1");
		String paymentType1s[] = request.getParameterValues("paymentType1");
		String deductionReasons[] = request.getParameterValues("deductionReason");
		String deductionTypes[] = request.getParameterValues("deductionType");
		String deductionAmounts[] = request.getParameterValues("deductionAmount");
		String account1s[] = request.getParameterValues("account1");

		String couponType1s[] = request.getParameterValues("couponType1");
		String couponBatch1s[] = request.getParameterValues("couponBatch1");

		JSONArray deductions = new JSONArray();
		JSONObject deduction ;
		i = 0;
		for(String paymentClass:paymentClass1s){
			deduction = new JSONObject();
			deduction.put("paymentClass", paymentClass);
			deduction.put("paymentType", paymentType1s[i]);			
			deduction.put("deductionReason", deductionReasons[i]);
			deduction.put("deductionAmount", deductionAmounts[i]);
			deduction.put("deductionType", deductionTypes[i]);
			deduction.put("account", account1s[i]);			
			deduction.put("couponType", couponType1s[i]);
			deduction.put("couponBatch", couponBatch1s[i]);		


			deductions.add(deduction);
			i++;
		}
		paramMap.put("flowDeductions", deductions);




		String codes[] = request.getParameterValues("code");
		String names[] = request.getParameterValues("name");
		String getTypes[] = request.getParameterValues("getType");
		String getChannels[] = request.getParameterValues("getChannel");
		String getTimeStrs[] = request.getParameterValues("getTimeStr");
		String amount2s[] = request.getParameterValues("amount2");		
		String couponBatch2s[] = request.getParameterValues("couponBatch2");

		JSONArray gets = new JSONArray();
		JSONObject get ;
		i = 0;
		for(String code:codes){
			get = new JSONObject();
			get.put("code", code);						
			get.put("name", names[i]);
			get.put("getType", getTypes[i]);
			get.put("getChannel", getChannels[i]);
			get.put("getTimeStr", getTimeStrs[i]);			
			get.put("amount", amount2s[i]);
			get.put("couponBatch", couponBatch2s[i]);		


			gets.add(get);
			i++;
		}
		paramMap.put("flowGets", gets);


		String rowNos[] = request.getParameterValues("rowNo");
		String saleNos[] = request.getParameterValues("saleNo");
		String paymentAmount1s[] = request.getParameterValues("paymentAmount1");
		String supplyProductNos[] = request.getParameterValues("supplyProductNo");
		String salesItemIds[] = request.getParameterValues("salesItemId");
		String saleSums[] = request.getParameterValues("saleSum");		
		String erpProductNos[] = request.getParameterValues("erpProductNo");
		String promotionSplitses[] = request.getParameterValues("promotionSplits");
		JSONArray products = new JSONArray();
		JSONObject product ;
		i = 0;
		for(String rowNo:rowNos){
			product = new JSONObject();
			product.put("rowNo",rowNo);						
			product.put("saleNo", saleNos[i]);
			product.put("paymentAmount", paymentAmount1s[i]);
			product.put("supplyProductNo", supplyProductNos[i]);
			product.put("salesItemId", salesItemIds[i]);			
			product.put("saleSum", saleSums[i]);
			product.put("erpProductNo", erpProductNos[i]);
			product.put("promotionSplits", JSON.parseArray(promotionSplitses[i]));		

			products.add(product);
			i++;
		}
		paramMap.put("products", products);

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prPosFlow/saveRefundInfo.htm", jsonStr);
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
	 * 导购还库
	 * @Methods Name returnStock
	 * @Create In 2015-8-31 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/returnStock")
	public String returnStock(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("refundNo", request.getParameter("refundNo"));
		paramMap.put("operator", request.getParameter("operator"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prStockOperate/returnStock.htm", jsonStr);
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
	 * @Methods Name saveInvoice
	 * @Create In 2015-9-14 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/saveInvoice")
	public String saveInvoice(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("saleNo")))
		{
			paramMap.put("saleNo", request.getParameter("saleNo"));
		}
		if(StringUtils.isNotBlank(request.getParameter("invoiceNo")))
		{
			paramMap.put("invoiceNo", request.getParameter("invoiceNo"));
		}
		paramMap.put("invoiceAmount", request.getParameter("invoiceAmount"));
		paramMap.put("invoiceTitle", request.getParameter("invoiceTitle"));
		paramMap.put("invoiceDetail", request.getParameter("invoiceDetail"));
		paramMap.put("createdTimeStr", request.getParameter("createdTimeStr"));
		paramMap.put("createdMan", request.getParameter("createdMan"));

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prInvoice/saveInvoiceInfo.htm", jsonStr);
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
	 * 作废流水信息
	 * @Methods Name salePadCancel
	 * @Create In 2015-9-14 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/salePadCancel")
	public String salePadCancel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("salesPaymentNo")))
		{
			paramMap.put("salesPaymentNo", request.getParameter("salesPaymentNo"));
		}
		paramMap.put("casher", request.getParameter("casher"));

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prNewPadFlow/canclePadFlow.htm", jsonStr);
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
	 * 创建换货单
	 * @Methods Name foundExchange
	 * @Create In 2015-9-14 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/foundExchange")
	public String foundExchange(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();

		paramMap.put("memberNo", request.getParameter("memberNo"));
		paramMap.put("originalSaleNo", request.getParameter("originalSaleNo"));
		paramMap.put("saleNo", request.getParameter("saleNo"));
		paramMap.put("refundNo", request.getParameter("refundNo"));
		paramMap.put("shopNo", request.getParameter("shopNo"));
		paramMap.put("imbalance", request.getParameter("imbalance"));
		paramMap.put("employeeNo", request.getParameter("employeeNo"));
		paramMap.put("casherNo", request.getParameter("casherNo"));

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prExchangeOrder/saveExchangeOrder.htm", jsonStr);
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
	 * 修改换货单
	 * @Methods Name updateExchange
	 * @Create In 2015-9-14 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updateExchange")
	public String updateExchange(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();

		paramMap.put("exchangeNo", request.getParameter("exchangeNo"));

		if(StringUtils.isNotEmpty(request.getParameter("originalSaleNo"))){
			paramMap.put("originalSaleNo", request.getParameter("originalSaleNo"));
		}

		if(StringUtils.isNotEmpty(request.getParameter("saleNo"))){
			paramMap.put("saleNo", request.getParameter("saleNo"));
		}

		if(StringUtils.isNotEmpty(request.getParameter("refundNo"))){
			paramMap.put("refundNo", request.getParameter("refundNo"));
		}

		if(StringUtils.isNotEmpty(request.getParameter("imbalance"))){
			paramMap.put("imbalance", request.getParameter("imbalance"));
		}

		paramMap.put("employeeNo", request.getParameter("employeeNo"));

		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prExchangeOrder/upateExchangeOrder.htm", jsonStr);
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
	 * 查询款机信息（带分页）
	 * @Methods Name selectSalePosFlowPage
	 * @Create In 2015-8-26 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPosFlowPage")
	public String selectPosFlowPage(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		Map<Object, Object> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("start", String.valueOf(start));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prSelect/selectPosFlowPage.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSON.parseObject(json);
			String data = jsonObject.getString("data");
			JSONObject jsonObject2 = JSON.parseObject(data);
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
	 * 查询销售单信息
	 * @Methods Name selectSaleInfoList
	 * @Create In 2015-8-25 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectSaleInfoList")
	public String selectSaleInfoList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = this.createParam(request);
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prSelect/selectSaleInfo.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSON.parseObject(json);
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
	 * 作废发票
	 * @Methods Name invoiceCancel
	 * @Create In 2015-9-15 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/invoiceCancel")
	public String invoiceCancel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotBlank(request.getParameter("invoiceNo")))
		{
			paramMap.put("invoiceNo", request.getParameter("invoiceNo"));
		}		
		paramMap.put("latestUpdateMan", request.getParameter("latestUpdateMan"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prInvoice/updateInvoiceStatus.htm", jsonStr);
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
	 * 查询商品信息
	 * @Methods Name selectProduct
	 * @Create In 2015-9-16 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectProduct")
	public String selectProduct(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String paraData = "{\"productNos\": [{\"supplyProductNo\":\"datapalce\",\"erpProductNo\":\"datapalce1\"}]}";
		paraData = paraData.replaceFirst("datapalce", request.getParameter("supplyProductNo")==null?"":request.getParameter("supplyProductNo"));
		paraData = paraData.replace("datapalce1", request.getParameter("erpProductNo")==null?"":request.getParameter("erpProductNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			logger.info("jsonStr:" + paraData);
			json = HttpUtilPcm.doPost("http://10.6.2.48:8042/pcm-inner-sdc/product/selectSupplyProductList.htm", paraData);
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
	 * 查询换货单
	 * @Methods Name getExchange
	 * @Create In 2015-9-17 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/getExchange")
	public String getExchange(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		
		paramMap.put("exchangeNo", request.getParameter("exchangeNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("fromSystem", "PCM");
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			json = HttpUtilPcm.doPost("http://10.6.2.47:8083/oms-prefix-core/prExchangeOrder/seleteExchangeOrderEntity.htm", jsonStr);
			logger.info("json:" + json);
			JSONObject jsonObject = JSON.parseObject(json);
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("data", list.get(0));
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


	private Map<Object, Object> createParam(HttpServletRequest request) {
		request.removeAttribute("_method");
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		Enumeration enumeration = request.getParameterNames();
		while(enumeration.hasMoreElements()) {
			String paramStr = (String)enumeration.nextElement();
			if("orderSid".equals(paramStr)) {
				paramMap.put("orderSid", request.getParameter(paramStr));
			}else if("orderNo".equals(paramStr)) {
				paramMap.put("orderNo", request.getParameter(paramStr));
			}else if("state".equals(paramStr)) {
				paramMap.put("orderStatus", request.getParameter(paramStr));
			}else if("endSaleTime".equals(paramStr)) {
				paramMap.put("endSaleTime", request.getParameter(paramStr));
			}else if("startSaleTime".equals(paramStr)) {
				paramMap.put("startSaleTime", request.getParameter(paramStr));
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
	 * 移库
	 * @Methods Name saveStockWei
	 * @Create In 2015-10-21 By chenhu
	 * @param request
	 * @param response
	 * @param stockName
	 * @param sid
	 * @param channelSid
	 * @param stockInfo
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/saveStockWei" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String saveStockWei(HttpServletRequest request, HttpServletResponse response, String stockTypeSid,
			String shoppeProSid, String channelSid, String newStockType, String proSum) {
		String json = "";
		JSONArray lists = new JSONArray();
		JSONObject map = new JSONObject();
		try {
			if (StringUtils.isNotEmpty(channelSid)) {
				map.put("channelSid", channelSid);
			}
			if (StringUtils.isNotEmpty(newStockType)) {
				map.put("newStockType", newStockType);
			}
			if (StringUtils.isNotEmpty(shoppeProSid)) {
				map.put("shoppeProSid", shoppeProSid);
			}
			if (StringUtils.isNotEmpty(stockTypeSid)) {
				map.put("stockTypeSid", stockTypeSid);
			}
			if (StringUtils.isNotEmpty(proSum)) {
				map.put("proSum", proSum);
			}
			map.put("fromSystem", "OMSADMIN");
			lists.add(map);
			String str = JsonUtil.getJSONString(lists);
			json = HttpUtilPcm.doPost("http://10.6.2.48:8042/pcm-inner-sdc/stockInner/findStockTypeUpdateFromPcm.htm", str);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

}
