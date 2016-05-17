package com.wangfj.order.controller;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.order.utils.HttpUtilForCore;
import com.wangfj.order.utils.ResultUtil;

/**
 * 说明:
 * @author chengsj
 * @date 2013-6-13 下午05:16:33
 * @modify 
 */
@Controller
@RequestMapping("/order")
public class DispatcherController {
	
	public static final String FROM_SYSTEM = "ORDERBACK";
	
	/**
	 * 针对网站后台-销售-OMS订单管理-订单列表
	 * @Methods Name selectOrderListByParamBack
	 * @Create In 2015-5-7 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderListByParamBack")
	public String selectOrderListByParamBack(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 15;
		}
		int start = (currPage-1)*size;
		String doMethod = CommonProperties.get("query_select_order_list_back");
		Map<String, String> paramMap = this.createParam(request);
		paramMap.put("start", String.valueOf(start));
		paramMap.put("limit", String.valueOf(size));
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	
	/**
	 * 针对网站后台-销售-OMS订单管理-销售单列表
	 * @Methods Name selectSellBack
	 * @Create In 2015-5-8 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPageSaleListByParamBack")
	public String selectSellBack(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 15;
		}
		int start = (currPage-1)*size;
		String doMethod = CommonProperties.get("query_select_sale_order_list_back");
		Map<String, String> paramMap = this.createParam(request);
		paramMap.put("start", String.valueOf(start));
		paramMap.put("limit", String.valueOf(size));
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	
	/**
	 * 针对网站后台-销售-OMS订单管理-退货单列表
	 * @Methods Name selectRefundOrderBack
	 * @Create In 2015-5-11 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectOrderRefundListByParamBack")
	public String selectRefundOrderBack(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 15;
		}
		int start = (currPage-1)*size;
		String doMethod = CommonProperties.get("query_select_refund_order_list_back");
		Map<String, String> paramMap = this.createParam(request);
		paramMap.put("start", String.valueOf(start));
		paramMap.put("limit", String.valueOf(size));
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	
	/**
	 * 针对网站后台-销售-OMS订单管理-退货申请单列表
	 * @Methods Name selectRefundApplyBack
	 * @Create In 2015-5-12 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectRefundApplyByParamBack")
	public String selectRefundApplyBack(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 15;
		}
		int start = (currPage-1)*size;
		String doMethod = CommonProperties.get("query_select_refund_apply_order_list_back");
		Map<String, String> paramMap = this.createParam(request);
		paramMap.put("start", String.valueOf(start));
		paramMap.put("limit", String.valueOf(size));
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	
	
	@ResponseBody
	@RequestMapping("/selectOrderListByParam")
	public String selectOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_order_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/selectOrderDetailListByOrderSid")
	public String selectOrderDetail(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_orderDetail_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/selectRefundApplyByParam")
	public String selectRefundApply(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_refund_apply_order_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("/selectRefundApplyForFin")
	public String selectRefundApplyForFin(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_refund_apply_for_fin_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	//财务退货申请单表详细
	@ResponseBody
	@RequestMapping("/selectRefundApplyDetailByParam")
	public String selectRefundApplyDetail(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_refund_apply_orderDetail_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/selectPageSaleListByParam")
	public String selectSell(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_sale_order_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("/selectOrderPaymentRecordPageByParam")
	public String selectOrderPaymentRecordPageByParam(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_order_payment_record_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/selectSaleListByParam")
	public String selectSaleList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_sale_order_list_new");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/selectSaleDetailListByOrderSid")
	public String selectSellDetail(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_sale_orderDetail_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/selectOrderRefundListByParam")
	public String selectRefundOrder(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_refund_order_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/selectOrderDetailRefundListByOrderSid")
	public String selectRefundOrderDetail(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("query_select_refund_orderDetail_list");
		Map<String, String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/orderAndRefundToWeb")
	public String orderAndRefundToWeb(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String doMethod = CommonProperties.get("query_select_order_refund_state_list");
		Map<String,String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/selectSapSaleRecordPageByParam")
	public String selectSapSaleRecordPageByParam(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String doMethod = CommonProperties.get("query_select_sap_sale_record_list");
		Map<String,String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	/**
	 * 更改退货申请单状态
	 * @Methods Name reviewRefundApply
	 * @Create In 2013-9-25 By Administrator
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/reviewRefundApply")
	public String reviewRefundApply(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String refundRealName = request.getParameter("reviewRefundApply");
		String doMethod = CommonProperties.get("order_refund_review");
		String param = "{'fromSystem':'"+ FROM_SYSTEM +"','refundStatus':'"+request.getParameter("refundStatus") +"','refundRealName':'"+refundRealName+"','refundUserSid':'"+192+"','refundApplyNo':'"+ request.getParameter("refundApplyNo")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
				json = "操作成功 ";			
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	
	/**
	 * 确认退款
	 * @Methods Name createRefundNetRefund
	 * @Create In 2013-9-27 By Administrator
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/refundCreateNetRefund")
	public String createRefundNetRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String refundRealName = request.getParameter("reviewRefundApply");
		String doMethod = CommonProperties.get("order_refund_review");
		String param = "{'fromSystem':'"+ FROM_SYSTEM +"','refundStatus':'"+request.getParameter("refundStatus") +"','refundApplyNo':'"+ request.getParameter("refundApplyNo")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
				json = "操作成功 ";			
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	@ResponseBody
	@RequestMapping("/getShop")
	public String getShop(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("GET_SHOP_LIST");
		json = HttpUtil.GetUrlContent(url, null);
		JSONObject result = JSONObject.fromObject(json);
		return json;
	}
	@ResponseBody
	@RequestMapping("/pickUpGoods")
	public String pickUpGoods(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("sale_order_pick_up");
		String param = "{'fromSystem':'"+ FROM_SYSTEM +"','proDetailSid':'"+request.getParameter("proDetailSid") 
				+"','pickupSum':'"+ request.getParameter("pickupSum")+"','orderSid':'"+ request.getParameter("orderSid")
				+"','saleSid':'"+ request.getParameter("saleSid")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 调出门店
	 * @Methods Name saleUpdateLogisticsStatus
	 * @Create In 2013-9-25 By Administrator
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/saleUpdateLogisticsStatus")
	public String saleUpdateLogisticsStatus(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("sale_update_logistics_status");
		String param = "{'fromSystem':'"+ FROM_SYSTEM +"','saleSid':'"+request.getParameter("saleSid")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	@ResponseBody
	@RequestMapping("/saleUpdateAllotStatus")
	public String saleUpdateAllotStatus(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("sale_update_allot_status");
		String param = "{'fromSystem':'"+ FROM_SYSTEM +"','saleList':[{'saleSid':'"+request.getParameter("saleSid") +"','allotStatus':'"+
				request.getParameter("allotStatus")+"'}]}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	//顾客拒签 ，拒签后生成退货申请单
	@ResponseBody
	@RequestMapping("/saveRefundApply")
	public String saveRefundApply(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		String orderNo = request.getParameter("orderNo");
		//修改订单状态
		String doMethod = CommonProperties.get("sele_modify_order_status");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','orderStatus':'5'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			String refundNum = request.getParameter("refundNum");
			doMethod = CommonProperties.get("order_refusal");
			param = "{'fromSystem':'"+FROM_SYSTEM+"','refundGoodType':'6','refundmentType':'1','orderNo':'"+orderNo+"'," +
					"'customerMemo':'拒签','customerServiceMemo':'拒签','customerPostage':'0'," +
					"'companyPostage':'0','refundNum':'"+refundNum+"','refundApplyDetails':[{}]}";

			json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
			result = JSONObject.fromObject(json);
			if((result.getString("success")).equals("true")){
				json = "操作成功";
			}else{
				json = result.getString("memo");
			}
		}else{
			json = result.getString("memo");
		}
		//----------------
		
		return json;
	}
	/**
	 * 打印销售单次数
	 * @Methods Name modifySalePrintTimes
	 * @Create In 2013-9-17 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/modifySalePrintTimes")
	public String modifySalePrintTimes(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("sale_modify_print_times");
		String param = "{'fromSystem':'"+ FROM_SYSTEM +"','saleNo':'"+request.getParameter("saleNo")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 打印快递单
	 * @Methods Name modifyOrderLogisticsStatusForExpress
	 * @Create In 2013-9-17 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/modifyOrderLogisticsStatusForExpress")
	public String modifyOrderLogisticsStatusForExpress(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("sele_modify_order_logistics_status");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','optRealName':'"+request.getParameter("optRealName")+"','logisticsStatus':'5','logisticsStatusDesc':'打印快递单'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 调入物流中心
	 * @Methods Name modifyOrderLogisticsStatusForCentre
	 * @Create In 2014-3-10 By Administrator
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/modifyOrderLogisticsStatusForCentre")
	public String modifyOrderLogisticsStatusForCentre(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("sele_modify_order_logistics_status");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','optRealName':'"+request.getParameter("optRealName")+"','logisticsStatus':'4','logisticsStatusDesc':'调入物流中心'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 发货复检
	 * @Methods Name modifyOrderLogisticsStatusForRecheck
	 * @Create In 2013-9-17 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/modifyOrderLogisticsStatusForRecheck")
	public String modifyOrderLogisticsStatusForRecheck(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("sele_modify_order_logistics_status");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','optRealName':'"+request.getParameter("optRealName")+"','logisticsStatus':'6','logisticsStatusDesc':'发货复检'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 发货
	 * @Methods Name modifyOrderStatusForDespatch
	 * @Create In 2013-9-17 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/modifyOrderStatusForDespatch")
	public String modifyOrderStatusForDespatch(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		//修改订单状态
		String doMethod = CommonProperties.get("sele_modify_order_status");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','orderStatus':'3'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		
		if((result.getString("success")).equals("true")){
			//修改物流状态
			doMethod = CommonProperties.get("sele_modify_order_logistics_status");
			param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','logisticsStatus':'7','logisticsStatusDesc':'已发货'}";
			json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
			result = JSONObject.fromObject(json);
			if((result.getString("success")).equals("true")){
				json = "操作成功";
			}else{
				json = result.getString("memo");
			}
			
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 确认收货
	 * @Methods Name modifyOrderStatusForReceiver
	 * @Create In 2013-9-17 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/modifyOrderStatusForReceiver")
	public String modifyOrderStatusForReceiver(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		//修改订单状态
		String doMethod = CommonProperties.get("sele_modify_order_status");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','orderStatus':'4'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 订单支付
	 * @Methods Name modifyOrderStatusForPay
	 * @Create In 2013-9-17 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/modifyOrderStatusForPay")
	public String modifyOrderStatusForPay(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("sele_pay_order");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','tradeNo':'2323','totalFee':'50','discount':'0'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 填写快递单
	 * @Methods Name fillInExpressNo
	 * @Create In 2013-9-18 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/fillInExpressNo")
	public String fillInExpressNo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("return_apply_fill_in_express_no");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','refundApplyNo':'"+request.getParameter("refundApplyNo")+"','deliveryNo':'kd12332112345'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	@ResponseBody
	@RequestMapping("/getCashierNumberForSale")
	public String getCashierNumberForSale(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("get_cashier_number_for_sale");
		String param = "{'saleNo':'"+request.getParameter("saleNo")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("cashier_number_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	@ResponseBody
	@RequestMapping("/getCashierNumberForRefundDetail")
	public String getCashierNumberForRefundDetail(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("get_cashier_number_for_refund_detail");
		String param = "{'refundApplyDetailSid':'"+request.getParameter("sid")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("cashier_number_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	@ResponseBody
	@RequestMapping("/synOrderOrSale")
	public String synOrderOrSale(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = "";
		try{
			if(request.getParameter("type").equals("order")){
				doMethod = CommonProperties.get("syn_dp_order");
			}else if(request.getParameter("type").equals("sale")){
				doMethod = CommonProperties.get("syn_dp_sale");
			}
			Map<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("saleTimeFrom", request.getParameter("saleTimeFrom"));
			paramMap.put("saleTimeTo", request.getParameter("saleTimeTo"));
			String url = CommonProperties.get("syn_dp_data_url");
			json = HttpUtil.HttpPost(url, doMethod, paramMap);
		}catch(Exception e){
			e.printStackTrace();
		}
		return json;
	}
	/**
	 * 调出物流中心
	 * @Methods Name reviewRefundApplyOut
	 * @Create In 2013-9-18 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/reviewRefundApplyDiaoChu")
	public String reviewRefundApplyOut(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("return_apply_diao_chu");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','refundApplyNo':'"+request.getParameter("refundApplyNo")+"','allotStatus':'4'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 调入物流室
	 * @Methods Name reviewRefundApplyIn
	 * @Create In 2013-9-18 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/reviewRefundApplyDiaoru")
	public String reviewRefundApplyIn(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("return_apply_diao_chu");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','refundApplyNo':'"+request.getParameter("refundApplyNo")+"','allotStatus':'5'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 *导购确认收货
	 * @Methods Name reviewConfirmNetRefund
	 * @Create In 2013-9-18 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/reviewConfirmNetRefund")
	public String reviewConfirmNetRefund(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("return_apply_confirm_net_refund");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','refundApplyDetailSid':'"+request.getParameter("refundApplyDetailSid")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 顾客退货
	 * @Methods Name orderDetailReturnApply
	 * @Create In 2013-9-26 By Administrator
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderDetailReturnApply")
	public String orderDetailReturnApply(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("refund_apply_save_refund_apply");	
		String param="{'fromSystem':'"+FROM_SYSTEM+"','refundGoodType':'1','refundmentType':'1','orderNo':'"+request.getParameter("orderNo")+"'," +
		"'customerMemo':'正常退货','customerServiceMemo':'正常退货','customerPostage':'0','companyPostage':'0'," +
		"refundApplyDetails:[{'proDetailSid':'"+request.getParameter("proDetailSid")+"','refundNum':'"+request.getParameter("refundNum")+"','refundReasonSid':'1','refundReasonDesc':'不喜欢'}]}";
		
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			JSONObject obj = JSONObject.fromObject(result.getString("obj"));
			json = "操作成功！您的订单号："+obj.getString("orderNo")+"退货申请单号是："+obj.getString("refundApplyNo");
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 修改退货申请单明细状态
	 * @Methods Name modifyRefundApplyDetailStatus
	 * @Create In 2013-9-26 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/modifyRefundApplyDetailStatus")
	public String modifyRefundApplyDetailStatus(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String refundApplyNo = request.getParameter("refundApplyNo");
		String allotStatus = request.getParameter("allotStatus");
		String doMethod = CommonProperties.get("refund_apply_modify_detail_status");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','refundApplyDetailSid':'"+request.getParameter("refundApplyDetailSid")+"','refundApplyNo':'"+request.getParameter("refundApplyNo")+"','allotStatus':'"+request.getParameter("allotStatus")+"','allotStatusDesc':'"+request.getParameter("allotStatusDesc")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			doMethod = CommonProperties.get("return_apply_diao_chu");
			param = "{'fromSystem':'"+FROM_SYSTEM+"','refundApplyNo':'"+refundApplyNo+"','allotStatus':'"+allotStatus+"'}";
			json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
			result = JSONObject.fromObject(json);
			if((result.getString("success")).equals("true")){
				json = "操作成功";
			}else{
				json = result.getString("memo");
			}
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * 作废
	 * @Methods Name orderReviewCancel
	 * @Create In 2013-9-18 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderReviewCancel")
	public String orderReviewCancel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("order_cancel_order");
		String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+request.getParameter("orderNo")+"','orderStatus':'-1'}";
		json = HttpUtilForCore.HttpPostForLogistics(CommonProperties.get("oms_core_oms_url"), doMethod, param);
		JSONObject result = JSONObject.fromObject(json);
		if((result.getString("success")).equals("true")){
			json = "操作成功";
		}else{
			json = result.getString("memo");
		}
		return json;
	}
	/**
	 * pos销售记录查询
	 * @Methods Name selectPosRecordPageByParam
	 * @Create In 2013-9-22 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectPosRecordPageByParam")
	public String selectPosRecordPageByParam(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String doMethod = CommonProperties.get("query_select_pos_record_list");
		Map<String,String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	/**
	 * 
	 * @Methods Name 查找退货单
	 * @Create In 2013-10-25 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectReturnForFinListByParam")
	public String selectReturnForFinListByParam(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String doMethod = CommonProperties.get("query_return_fin_list_byparam");
		Map<String,String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	/**
	 * 查看退货申请单备注信息
	 * @Methods Name getRefundMemo
	 * @Create In 2013-9-24 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/getRefundMemo")
	public String getRefundMemo(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String doMethod = CommonProperties.get("query_select_refund_memo_list");
		Map<String,String> paramMap = this.createParam(request);
		json = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping(value = { "/getType" },method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String, Object> getType(Model model,	HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String dictTypeCode = request.getParameter("dictTypeCode");
		try {
			String url = CommonProperties.get("oms_core_oms_url");
			String param = "{'fromSystem':'third','dictTypeCode':'"+dictTypeCode+"'}";
			String types = HttpUtilForCore.HttpPostForLogistics(url, "dictItem/selectListByType", param);
			JSONObject typesJson = JSONObject.fromObject(types);
			JSONArray list = typesJson.getJSONArray("list");
			resultMap.put("list",list);
			resultMap.put("success", true);	
		} catch (Exception e) {
			resultMap.put("success", false);
		}
		return resultMap;
	}
	@ResponseBody
	@RequestMapping(value = { "/getTradeNo" },method = {RequestMethod.GET,RequestMethod.POST})
	public String getTradeNo(Model model,	HttpServletRequest request, HttpServletResponse response) {
		Map<String, String> paramMap = this.createParam(request);
		String json = "";
		try {
			String doMethod = CommonProperties.get("pos_handle_postage_pos");
			json = HttpUtil.HttpPost(CommonProperties.get("oms_sap_url"), doMethod, paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = { "/handlePostagePos" },method = {RequestMethod.GET,RequestMethod.POST})
	public String handlePostagePos(Model model,	HttpServletRequest request, HttpServletResponse response) {
		String json="";
		try {
			String url = CommonProperties.get("cashier_number_url");
			String orderNo =request.getParameter("orderNo");
			String param = "{'orderNo':'"+orderNo+"'}";
			String types = HttpUtilForCore.HttpPostForLogistics(url, "/pos/handlePostagePos.rest", param);
			JSONObject typesJson = JSONObject.fromObject(types);		
			if(typesJson.getString("success").equals("true")){
				json="操作成功";
			}
			
		} catch (Exception e) {
			json=e.toString();
		}
		return json;
	}
/**
 * 开具发票
 * @Methods Name updateOrderInvoice
 * @Create In 2014-4-23 By Administrator
 * @param model
 * @param request
 * @param response
 * @return String
 */
	@ResponseBody
	@RequestMapping(value = { "/updateOrderInvoice" },method = {RequestMethod.GET,RequestMethod.POST})
	public String updateOrderInvoice(Model model,	HttpServletRequest request, HttpServletResponse response) {
		String json="";
		try {
			String url = CommonProperties.get("oms_core_oms_url");
			String orderNo =request.getParameter("orderNo");
			String invoiceName = request.getParameter("invoiceName");
			String invoiceDesc = request.getParameter("invoiceDesc");
			String invoiceBit = "1";
			String optRealName = request.getParameter("optRealName");
			String param = "{'fromSystem':'"+FROM_SYSTEM+"','orderNo':'"+orderNo+"','invoiceName':'"+invoiceName+"','invoiceDesc':'"+invoiceDesc+"','invoiceBit':'"+invoiceBit+"','optRealName':'"+optRealName+"'}";
			String types = HttpUtilForCore.HttpPostForLogistics(url, "order/modifyInvoice", param);
			JSONObject typesJson = JSONObject.fromObject(types);		
			if(typesJson.getString("success").equals("true")){
				json=ResultUtil.createSuccessResult("操作成功");
			}		
		} catch (Exception e) {
			json=e.toString();
		}
		return json;
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
}
