package com.wangfj.statement.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtilForCore;

@Controller
@RequestMapping("/statement")
public class StatementController {
	
	@ResponseBody
	@RequestMapping("/OrderPayTypeController")
	public String OrderPayTypeController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = CommonProperties.get("Order_Pay_Type_Controller");
		String url = CommonProperties.get("oms_core_oms_url");
		String ojson = "{'fromSystem':'WEB','saleTimeTo':'"+request.getParameter("saleTimeTo")+"','saleTimeFrom':'"+request.getParameter("saleTimeFrom")+"'}";
		
		//json = HttpUtil.HttpPost(url, doMethod, paramMap);
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectOrderCountListByParam", ojson);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("/OrderSumController")
	public String OrderSumController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		String ojson = "{'fromSystem':'WEB','saleTimeTo':'"+request.getParameter("saleTimeTo")+"','saleTimeFrom':'"+request.getParameter("saleTimeFrom")+"','saleMoney':'"+request.getParameter("orderSum")+"','pageNumber':'"+request.getParameter("page")+"','fetchSize':'"+request.getParameter("pageSize")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectOrderAmountByParam", ojson);
		
		JSONObject jsonObj=new JSONObject();
		JSONObject result=new JSONObject();
		
		try {
			jsonObj = JSONObject.parseObject(json);
			int pageCount = 1;

			if(jsonObj.get("success").equals("true")){
				JSONObject pageJson = new JSONObject();
				pageJson = (JSONObject) jsonObj.get("page");
					int pageSize = 40;
					Integer p = (Integer) pageJson.get("pageCount");
					pageCount = (int) (p%pageSize==0?p/pageSize:(p/pageSize+1));
				result.put("pageCount", pageCount);
				result.put("list", pageJson.get("list"));
			}
			result.put("pageCount", pageCount);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return result.toString();
		
//		try {
//			jsonObj = JSONObject.parseObject(json);
//			JSONObject pageJson = new JSONObject();
//			pageJson = (JSONObject) jsonObj.get("page");
//			result.put("pageCount", pageJson.get("pageCount"));
//			result.put("list", pageJson.get("list"));
//		} catch (Exception e) {
//			// TODO: handle exception
//		}
//		return result.toString();
	}
	
	public String OrderSumForExcelController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		String ojson = "{'fromSystem':'WEB','saleTimeTo':'"+request.getParameter("saleTimeTo")+"','saleTimeFrom':'"+request.getParameter("saleTimeFrom")+"','saleMoney':'"+request.getParameter("orderSum")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectOrderAmountForExcelByParam", ojson);
		return json;
	}
	@ResponseBody
	@RequestMapping("/NetOrderController")
	public String NetOrderController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		String ojson = "{'fromSystem':'WEB','saleTimeTo':'"+request.getParameter("NetOrderEndTime")+"','saleTimeFrom':'"+request.getParameter("NetOrderStartTime")+"','inceptProvince':'"+request.getParameter("provinceName")+"','pageNumber':'"+request.getParameter("page")+"','fetchSize':'"+request.getParameter("pageSize")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectNetOrderCountByParam", ojson);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("/SaleNOController")
	public String SaleNOController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		String ojson = "{'fromSystem':'WEB','draftTime':'"+request.getParameter("SaleNoTime")+"','saleCode':'"+request.getParameter("SaleNo")+"','pageNumber':'"+request.getParameter("start")+"','fetchSize':'"+request.getParameter("limit")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectSaleCountByTimeAndSaleCode", ojson);
		return json;
	}

	/**
	 * @Methods Name 门店统计
	 * @Create In 2014-1-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/shopSaleController")
	public String shopSaleController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		//String ojson = "{'fromSystem':'WEB','saleTimeFrom':'2013-10-10 16:24:43','saleTimeTo':'2013-10-30 16:24:43'}";

		String ojson = "{'fromSystem':'WEB','saleTimeFrom':'"+request.getParameter("saleTimeFrom")+"','saleTimeTo':'"+request.getParameter("saleTimeTo")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectSaleCountByTimeAndShop", ojson);
		return json;
	}
	/**
	 * @Methods Name 门店销售退货总金额统计
	 * @Create In 2014-1-15 By Administrator
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/shopAllSaleController")
	public String shopAllSaleController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		//String ojson = "{'fromSystem':'WEB','saleTimeFrom':'2013-10-10 16:24:43','saleTimeTo':'2013-10-30 16:24:43'}";

		String ojson = "{'fromSystem':'WEB','saleTimeFrom':'"+request.getParameter("saleTimeFrom")+"','saleTimeTo':'"+request.getParameter("saleTimeTo")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectSaleAndRefundCountByParam", ojson);
		return json;
	}
	/**
	 * 
	 * @Methods Name 订单来源
	 * @Create In 2014-1-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/OrderSourceController")
	public String OrderSourceController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		String ojson = "{'fromSystem':'WEB','saleTimeTo':'"+request.getParameter("saleTimeTo")+"','saleTimeFrom':'"+request.getParameter("saleTimeFrom")+"','orderSourceSid':'"+request.getParameter("OrderSource")+"','ifPay':'"+request.getParameter("payTypes")+"','ifRefund':'"+request.getParameter("IfReturn")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectOrderSourceByParam", ojson);
		return json;
	}
	
	/**
	 * @Methods Name 网络订单为导出excel
	 * @Create In 2014-1-13 By Administrator
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/netOrderForExcelController")
	public String netOrderForExcelController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		String ojson = "{'fromSystem':'WEB','saleTimeTo':'"+request.getParameter("saleTimeTo")+"','saleTimeFrom':'"+request.getParameter("saleTimeFrom")+"','orderSourceSid':'"+request.getParameter("OrderSource")+"','ifPay':'"+request.getParameter("payTypes")+"','ifRefund':'"+request.getParameter("IfReturn")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectOrderSourceByParam", ojson);
		return json;
	}
	/**
	 * 
	 * @Methods Name 实体每日销售
	 * @Create In 2014-1-21 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/entityAllSaleController")
	public String entityAllSaleController(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String url = CommonProperties.get("oms_core_oms_url");
		//String ojson = "{'fromSystem':'WEB','saleTimeFrom':'2013-10-10 16:24:43','saleTimeTo':'2013-10-30 16:24:43'}";

		String ojson = "{'fromSystem':'WEB','saleTimeFrom':'"+request.getParameter("saleTimeFrom")+"','saleTimeTo':'"+request.getParameter("saleTimeTo")+"'}";
		json = HttpUtilForCore.HttpPostForLogistics(url, "orderCount/selectSaleAndRefundCountToShop", ojson);
		return json;
	}
}
