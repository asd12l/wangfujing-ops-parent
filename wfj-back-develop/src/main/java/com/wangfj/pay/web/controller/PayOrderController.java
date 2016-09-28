package com.wangfj.pay.web.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.elong.common.StringUtil;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.pay.web.constant.Constants;
import com.wangfj.pay.web.util.HttpClientUtil;
import com.wangfj.pay.web.vo.ExcelOrderVo;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value="/wfjpay")
public class PayOrderController {
	private static final Logger logger = LoggerFactory.getLogger(PayOrderController.class);
	private static final String EXPORT_SIZE="10000";
	
	/**
	 * 查询支付日志明细
	 * @Methods Name order
	 * @Create In 2015-12-16 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/order")
	public String order(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("startTime", request.getParameter("startTime"));
		paramMap.put("endTime", request.getParameter("endTime"));
		if(!StringUtils.isBlank(request.getParameter("uid"))){
			paramMap.put("unid", request.getParameter("uid"));
		}
		paramMap.put("bpOrderId", request.getParameter("bpOrderId"));
		paramMap.put("userName",request.getParameter("userName"));
		paramMap.put("bpId",request.getParameter("bpId"));
		paramMap.put("orderTradeNo", request.getParameter("orderTradeNo"));
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("status", request.getParameter("status"));
		paramMap.put("initOrderTerminal", request.getParameter("initOrderTerminal"));
		paramMap.put("sortParam", request.getParameter("sortParam"));
		paramMap.put("createDate", request.getParameter("createDate"));
		paramMap.put("sortType", request.getParameter("sortType"));
		paramMap.put("userId", CookiesUtil.getUserName(request));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_ORDER_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			List<Object> list = (List<Object>)object.get("listData");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
				m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("pageCount",0);
				if(list.size()==0){
					m.put("msg","emptyData");
				}
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("pageCount",0);
			e.printStackTrace();
		}
		String js =CommonProperties.get(Constants.WFJ_LOG_JS);
		m.put("logJs", js);
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			m.put("userName", CookiesUtil.getUserName(request));
		}else{
			m.put("userName", "");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}


	/**
	 * 查询业务接口
	 * @Methods Name businessStation
	 * @Create In 2015-12-16 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/businessStation")
	public String businessStation(String flag,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("userId", CookiesUtil.getUserName(request));
		paramMap.put("flag", flag);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_BUSINESS_STATION_LIST);
			json=HttpClientUtil.post(url, paramMap);
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
		String js =CommonProperties.get(Constants.WFJ_LOG_JS);
		m.put("logJs", js);
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			m.put("userName", CookiesUtil.getUserName(request));
		}else{
			m.put("userName", "");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询支付内容
	 * @Methods Name orderDetail
	 * @Create In 2015-12-17 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderDetail")
	public String orderDetail(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String, String>();
		paramMap.put("orderTradeNo", request.getParameter("orderTradeNo"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_ORDER_DETAIL_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object = jsonObject.getJSONObject("data");
			if (object != null&&object.size()!=0) {
				m.put("object", object);
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
	 * excel订单导出检查
	 * @Methods Name checkOrderExport
	* @Create In 2015-12-17 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/order/checkOrderExport")
	public String checkOrderExport(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("startTime", request.getParameter("startTime"));
		paramMap.put("endTime", request.getParameter("endTime"));
		if(StringUtils.isNotEmpty(request.getParameter("uid"))){
			paramMap.put("unid", request.getParameter("uid"));
		}
		paramMap.put("bpId",request.getParameter("bpId"));
		paramMap.put("orderTradeNo", request.getParameter("orderTradeNo"));
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("status", request.getParameter("status"));
		paramMap.put("initOrderTerminal", request.getParameter("initOrderTerminal"));
		paramMap.put("sortParam", request.getParameter("sortParam"));
		paramMap.put("createDate", request.getParameter("createDate"));
		paramMap.put("sortType", request.getParameter("sortType"));
		paramMap.put("userId", CookieUtil.getUserName(request));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_ORDER_EXPORT);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if (jsonObject!=null&&jsonObject.size()!=0) {
				m.put("object", jsonObject);
				m.put("success", true);
				m.put("msg", "导出检查参数成功！");
			} else {
				m.put("success", false);
				m.put("msg", "导出检查参数失败！");
			}
		} catch (Exception e) {
			m.put("success", false);
			m.put("msg", "导出检查参数异常！");
			logger.error(e.getMessage());
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	
	
	
	/**
	 * 订单导出Excel
	 * @Methods Name getStockToExcel
	 * @Create In 2016-1-27 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/order/getOrderToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getStockToExcel(HttpServletRequest request, HttpServletResponse response){
		String title = "payRecorder_"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"_";
		String json="";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
			paramMap.put("startTime", request.getParameter("startTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
			paramMap.put("endTime", request.getParameter("endTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("bpId"))){
			paramMap.put("bpId", request.getParameter("bpId"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("orderTradeNo"))){
			paramMap.put("orderTradeNo", request.getParameter("orderTradeNo"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payType"))){
			paramMap.put("payType", request.getParameter("payType"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("status"))){
			paramMap.put("status", request.getParameter("status"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("initOrderTerminal"))){
			paramMap.put("initOrderTerminal", request.getParameter("initOrderTerminal"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("createDate"))){
			paramMap.put("createDate", request.getParameter("createDate"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("uid"))){
			paramMap.put("uid", request.getParameter("uid"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("userName"))){
			paramMap.put("userName", request.getParameter("userName"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("sortParam"))){
			paramMap.put("sortParam", request.getParameter("sortParam"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("sortType"))){
			paramMap.put("sortType", request.getParameter("sortType"));
		}
		paramMap.put("pageSize", EXPORT_SIZE);
		paramMap.put("pageNo", "1");
		paramMap.put("userId", CookieUtil.getUserName(request));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_ORDER_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			JSONArray arr = object.getJSONArray("listData");
			title+=object.get("totalHit");
			List<ExcelOrderVo> list = new ArrayList<ExcelOrderVo>();
			if (arr != null && arr.size() != 0) {
				for (int i=0;i<arr.size();i++){
					JSONObject obj = arr.getJSONObject(i);
					ExcelOrderVo vo = (ExcelOrderVo) JSONObject.toBean(obj,ExcelOrderVo.class);
					list.add(vo);
				}
				allOrderToExcel(response, list, title);
				m.put("success", "true");
				m.put("msg", "导出成功！");
			} else {
				m.put("success", "true");
				m.put("msg", "查询为空！");
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("msg", "导出异常！");
			logger.error(e.toString());
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 
	 * @Methods Name allOrderToExcel
	 * @Create In 2016-1-27 By yangyinbo
	 * @param response
	 * @param list
	 * @param title
	 * @return String
	 */
	public String allOrderToExcel(HttpServletResponse response,List<ExcelOrderVo> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("业务平台订单号");
		header.add("业务接口");
		header.add("支付平台订单号");
		header.add("订单生成时间");
		header.add("订单内容");
		header.add("支付账户");
		header.add("支付金额(元)");
		header.add("应付金额(元)");
		header.add("支付渠道");
		header.add("状态");
		header.add("支付平台流水号");
		header.add("订单终端类型");
		header.add("IP");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelOrderVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getBpOrderId()==null?"":vo.getBpOrderId());			
			inlist.add(vo.getBpName()==null?"":vo.getBpName());
			inlist.add(vo.getOrderTradeNo()==null?"":vo.getOrderTradeNo());
			if(vo.getCreateDate()!=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				inlist.add(sdf.format(new Date(vo.getCreateDate())));
			}else{
				inlist.add("");
			}
			inlist.add(vo.getContent()==null?"":vo.getContent());
			inlist.add(vo.getUserName()==null?"":vo.getUserName());
			inlist.add(vo.getTotalFee()==null?"":vo.getTotalFee()+"");
			inlist.add(vo.getNeedPayPrice()==null?"":vo.getNeedPayPrice()+"");		
			inlist.add(vo.getPayTypeName()==null?"":vo.getPayTypeName());		
			inlist.add(vo.getStatusName()==null?"":vo.getStatusName());
			inlist.add(vo.getPaySerialNumber()==null?"":vo.getPaySerialNumber());
			inlist.add(vo.getInitOrderTerminalName()==null?"":vo.getInitOrderTerminalName());
			inlist.add(vo.getPayIp()==null?"":vo.getPayIp());
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
		}finally{
			try {
				response.getOutputStream().close();
			} catch (IOException e) {
				logger.error(e.getMessage());
			}
		}
		
	}
	
	
	/**
	 * 查询支付日志明细
	 * @Methods Name order
	 * @Create In 2015-12-16 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/order/findAllOrderCompensate")
	public String findAllOrderCompensate(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("startTime", request.getParameter("startTime"));
		paramMap.put("endTime", request.getParameter("endTime"));
		paramMap.put("bpOrderId", request.getParameter("bpOrderId"));
		paramMap.put("bpId",request.getParameter("bpId"));
		paramMap.put("orderTradeNo", request.getParameter("orderTradeNo"));
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("status", request.getParameter("status"));
		paramMap.put("initOrderTerminal", request.getParameter("initOrderTerminal"));
		paramMap.put("sortParam", request.getParameter("sortParam"));
		paramMap.put("sortType", request.getParameter("sortType"));
		paramMap.put("userId", CookiesUtil.getUserName(request));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.FIND_ALL_ORDER_COMPENSATE);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			List<Object> list = (List<Object>)object.get("listData");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
				m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("pageCount",0);
				if(list.size()==0){
					m.put("msg","emptyData");
				}
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("pageCount",0);
			e.printStackTrace();
		}
		String js =CommonProperties.get(Constants.WFJ_LOG_JS);
		m.put("logJs", js);
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			m.put("userName", CookiesUtil.getUserName(request));
		}else{
			m.put("userName", "");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	
	
	/**
	 * 单笔订单查询
	 * @Methods Name order
	 * @Create In 2015-12-16 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/order/singleOrderQuery")
	public String singleOrderQuery(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		if(!StringUtils.isBlank(request.getParameter("startTime"))){
			paramMap.put("startTime", request.getParameter("startTime"));
		}
		if(!StringUtils.isBlank(request.getParameter("endTime"))){
			paramMap.put("endTime", request.getParameter("endTime"));
		}
		if(!StringUtils.isBlank(request.getParameter("bpOrderId"))){
			paramMap.put("bpOrderId", request.getParameter("bpOrderId"));
		}
		if(!StringUtils.isBlank(request.getParameter("orderTradeNo"))){
			paramMap.put("orderTradeNo", request.getParameter("orderTradeNo"));
		}
		if(!StringUtils.isBlank(request.getParameter("payType"))){
			paramMap.put("payType", request.getParameter("payType"));
		}
		if(!StringUtils.isBlank(request.getParameter("status"))){
			paramMap.put("status", request.getParameter("status"));
		}
		if(!StringUtils.isBlank(request.getParameter("initOrderTerminal"))){
			paramMap.put("initOrderTerminal", request.getParameter("initOrderTerminal"));	
		}
		paramMap.put("userId", CookieUtil.getUserName(request));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SINGLE_ORDER_QUERY);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if (jsonObject != null && jsonObject.getString("result").equals("success")) {
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
}
