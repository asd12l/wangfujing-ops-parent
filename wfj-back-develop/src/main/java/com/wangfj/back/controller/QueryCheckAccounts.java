package com.wangfj.back.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.back.entity.vo.CheckAccounts;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.order.service.IExcelService;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.util.ResultUtil;

@Controller
@RequestMapping("/query")
public class QueryCheckAccounts {
	private String url = CommonProperties.get("oms_core_url");
	@Autowired
	@Qualifier(value = "excelService")
	private IExcelService escelService;
	// String url = "http://localhost:8080/oms_admin/check";
	
	
	/**
	 * 针对网站后台-销售-对账管理-对账管理
	 * @Methods Name queryCheckAccountsBack
	 * @Create In 2015-5-12 By tangysh
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/queryCheckAccountsBack" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryCheckAccountsBack(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 15;
		}
		int start = (currPage-1)*size;
		
		
		Map paramMap = new HashMap();
		String startDate = request.getParameter("startTime");
		String endDate = request.getParameter("endTime");
		String saleNo = request.getParameter("saleNo");
		String cashierNumber = request.getParameter("cashierNumber");
		String checkStatus = request.getParameter("checkStatus");
		String shopSid = request.getParameter("shopSid");
		String orderType = request.getParameter("orderType");
		// //分页
		String pageNumber = request.getParameter("page");
		String pageSize = request.getParameter("pageSize");
		if (startDate!=null && startDate.length() > 0) {
			paramMap.put("cash_time1", startDate);
		}
		if (startDate!=null && startDate.length() > 0) {
			paramMap.put("cash_time2", endDate);
		}
		if (saleNo != null && !"".equals(saleNo)) {
			paramMap.put("sale_no", saleNo);
		}
		if (cashierNumber != null && !"".equals(cashierNumber)) {
			paramMap.put("cashier_number", cashierNumber);
		}
		if (checkStatus != null && !"".equals(checkStatus)) {
			paramMap.put("checkStatus", checkStatus);
		}
		if (shopSid != null && !"".equals(shopSid)) {
			paramMap.put("shopSid", shopSid);
		}
		if (orderType != null && !"".equals(orderType)) {
			paramMap.put("orderType", orderType);
		}
		paramMap.put("start", String.valueOf(start));
		paramMap.put("limit", String.valueOf(size));
		paramMap.put("pageNumber", 0);
		paramMap.put("pageSize", String.valueOf(size));
		try {
			json = HttpUtil.HttpPostForJson(url, "check/selectListByParamBack",
					paramMap);
		} catch (Exception e) {
			json = "{'success':false}";
		} finally {
			return json;
		}
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = { "/queryCheckAccounts" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryCheckAccounts(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Map paramMap = new HashMap();
		String startDate = request.getParameter("startTime");
		String endDate = request.getParameter("endTime");
		String saleNo = request.getParameter("saleNo");
		String cashierNumber = request.getParameter("cashierNumber");
		String checkStatus = request.getParameter("checkStatus");
		String shopSid = request.getParameter("shopSid");
		String orderType = request.getParameter("orderType");
		// //分页
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		String pageNumber = request.getParameter("page");
		String pageSize = request.getParameter("pageSize");
		if (startDate!=null && startDate.length() > 0) {
			paramMap.put("cash_time1", startDate);
		}
		if (startDate!=null && startDate.length() > 0) {
			paramMap.put("cash_time2", endDate);
		}
		if (saleNo != null && !"".equals(saleNo)) {
			paramMap.put("sale_no", saleNo);
		}
		if (cashierNumber != null && !"".equals(cashierNumber)) {
			paramMap.put("cashier_number", cashierNumber);
		}
		if (checkStatus != null && !"".equals(checkStatus)) {
			paramMap.put("checkStatus", checkStatus);
		}
		if (shopSid != null && !"".equals(shopSid)) {
			paramMap.put("shopSid", shopSid);
		}
		if (orderType != null && !"".equals(orderType)) {
			paramMap.put("orderType", orderType);
		}
		paramMap.put("start", start);
		paramMap.put("limit", limit);
		paramMap.put("pageNumber", pageNumber);
		paramMap.put("pageSize", pageSize);
		try {
			json = HttpUtil.HttpPostForJson(url, "check/selectListByParam",
					paramMap);
		} catch (Exception e) {
			json = "{'success':false}";
		} finally {
			return json;
		}
	}

	/**
	 * 导出Excel
	 * 
	 * @Methods Name queryCheckAccountsForExcel
	 * @Create In 2014-3-18 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/queryCheckAccountsForExcel" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryCheckAccountsForExcel(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		String title = request.getParameter("title");
		List<CheckAccounts> listCheckAccounts = new ArrayList<CheckAccounts>();
		// 得到返回的String字符串
		String l = this.selectCheckAccountsForExcel(request, response);
		// 对得到的Sting字符窜进行处理
		JSONObject js = JSONObject.fromObject(l);
		Object objs = js.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			if (arr.size() > 0) {
				for (int i = 0; i < arr.size(); i++) {
					String jsonarr = arr.getString(i);
					JSONObject jsonobj = JSONObject.fromObject(jsonarr);
					CheckAccounts ca = (CheckAccounts) JSONObject.toBean(
							jsonobj, CheckAccounts.class);
					if (jsonobj.containsKey("cashTime")) {
						ca.setCashTime(s.parse(jsonobj.getString("cashTime")));
					}
					if (jsonobj.containsKey("updateTime")) {
						ca.setUpdateTime(s.parse(jsonobj
								.getString("updateTime")));
					}
					if (jsonobj.containsKey("createTime")) {
						ca.setCreateTime(s.parse(jsonobj
								.getString("createTime")));
					}
					listCheckAccounts.add(ca);
				}

			}
			String result = escelService.exprtExcelForCheckAccounts( response,
					listCheckAccounts, title);
	
			json = ResultUtil.createSuccessResult(result);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return json;
	}

	public String selectCheckAccountsForExcel(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Map paramMap = new HashMap();
		String startDate = request.getParameter("startTime");
		String endDate = request.getParameter("endTime");
		String saleNo = request.getParameter("saleNo");
		String cashierNumber = request.getParameter("cashierNumber");
		String checkStatus = request.getParameter("checkStatus");
		String shopSid = request.getParameter("shopSid");
		String orderType = request.getParameter("orderType");
		if (!startDate.isEmpty() && startDate.length() > 0) {
			paramMap.put("cash_time1", startDate);
		}
		if (!startDate.isEmpty() && startDate.length() > 0) {
			paramMap.put("cash_time2", endDate);
		}
		if (saleNo != null && !"".equals(saleNo)) {
			paramMap.put("sale_no", saleNo);
		}
		if (cashierNumber != null && !"".equals(cashierNumber)) {
			paramMap.put("cashier_number", cashierNumber);
		}
		if (checkStatus != null && !"".equals(checkStatus)) {
			paramMap.put("checkStatus", checkStatus);
		}
		if (shopSid != null && !"".equals(shopSid)) {
			paramMap.put("shopSid", shopSid);
		}
		if (orderType != null && !"".equals(orderType)) {
			paramMap.put("orderType", orderType);
		}
		try {
			json = HttpUtil.HttpPostForJson(url, "check/selectListByParamForExcel",
					paramMap);
		} catch (Exception e) {
			json = "{'success':false}";
		} finally {
			return json;
		}
	}

	/**
	 * 查询sap销售记录表
	 * 
	 * @Methods Name querySAPSaleRecordForCheck
	 * @Create In 2014-2-10 By Zhangqingbin
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/selectSAPSaleByParam" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectSAPSaleByParam(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Map paramMap = new HashMap();
		String startDate = request.getParameter("startTime");
		String endDate = request.getParameter("endTime");
		String saleNo = request.getParameter("saleNo");
		String cashierNumber = request.getParameter("cashierNumber");
		String status = request.getParameter("status");
		// 分页
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		String pageNumber = request.getParameter("page");
		String pageSize = request.getParameter("pageSize");
		if (!startDate.isEmpty() && startDate.length() > 0) {
			paramMap.put("cash_time1", startDate);
		}
		if (!startDate.isEmpty() && startDate.length() > 0) {
			paramMap.put("cash_time2", endDate);
		}
		if (saleNo != null && !"".equals(saleNo)) {
			paramMap.put("sale_no", saleNo);
		}
		if (cashierNumber != null && !"".equals(cashierNumber)) {
			paramMap.put("cashier_number", cashierNumber);
		}
		if (status != null && !"".equals(status)) {
			paramMap.put("status", status);
		}
		paramMap.put("start", start);
		paramMap.put("limit", limit);
		paramMap.put("pageNumber", pageNumber);
		paramMap.put("pageSize", pageSize);
		try {
			json = HttpUtil.HttpPostForJson(url, "check/selectSAPSaleByParam",
					paramMap);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 查询富基销售记录表
	 * 
	 * @Methods Name querySAPSaleRecordForCheck
	 * @Create In 2014-2-10 By Zhangqingbin
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/selectFutureSaleByParam" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectFutureSaleByParam(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Map paramMap = new HashMap();
		String startDate = request.getParameter("startTime");
		String endDate = request.getParameter("endTime");
		String saleNo = request.getParameter("saleNo");
		String cashierNumber = request.getParameter("cashierNumber");
		String status = request.getParameter("status");
		// 分页
		String start = request.getParameter("start");
		String limit = request.getParameter("limit");
		String pageNumber = request.getParameter("page");
		String pageSize = request.getParameter("pageSize");
		if (!startDate.isEmpty() && startDate.length() > 0) {
			paramMap.put("cash_time1", startDate);
		}
		if (!startDate.isEmpty() && startDate.length() > 0) {
			paramMap.put("cash_time2", endDate);
		}
		if (saleNo != null && !"".equals(saleNo)) {
			paramMap.put("sale_no", saleNo);
		}
		if (cashierNumber != null && !"".equals(cashierNumber)) {
			paramMap.put("cashier_number", cashierNumber);
		}
		if (status != null && !"".equals(status)) {
			paramMap.put("status", status);
		}
		paramMap.put("start", start);
		paramMap.put("limit", limit);
		paramMap.put("pageNumber", pageNumber);
		paramMap.put("pageSize", pageSize);
		try {
			json = HttpUtil.HttpPostForJson(url,
					"check/selectFutureSaleByParam", paramMap);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 手动修改对账表中补单的状态 1：先根据流水号去对账表中删除该数据 2：sap拉取销售信息 3：进行一次对账比较
	 * 
	 * @Methods Name selectFutureSaleByParam
	 * @Create In 2014-2-28 By Zhangqingbin
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/handModify" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String handModify(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Map paramMap = new HashMap();
		String cashierNumber = request.getParameter("cashierNumber");
		String status = request.getParameter("checkStatus");
		String orderType = request.getParameter("orderType");
		if (cashierNumber != null && !"".equals(cashierNumber)) {
			paramMap.put("cashierNumber", cashierNumber);
		}
		if (status != null && !"".equals(status)) {
			paramMap.put("status", status);
		}
		if (StringUtils.isNotBlank(orderType)) {
			paramMap.put("orderType", orderType);
		}
		try {
			json = HttpUtil.HttpPostForJson(url,
					"check/handModifyStatusForCheck", paramMap);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = { "/updateCheckStatus" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateCheckStatus(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Map paramMap = new HashMap();
		String cashierNumber = request.getParameter("cashierNumber");
		String status = request.getParameter("checkStatus");
		String orderType = request.getParameter("orderType");
		if (cashierNumber != null && !"".equals(cashierNumber)) {
			paramMap.put("cashierNumber", cashierNumber);
		}
		if (status != null && !"".equals(status)) {
			paramMap.put("status", status);
		}
		if (StringUtils.isNotBlank(orderType)) {
			paramMap.put("orderType", orderType);
		}
		try {
			json = HttpUtil.HttpPostForJson(url, "check/updateCheckAccounts",
					paramMap);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}
}
