package com.wangfj.pay.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.pay.web.constant.Constants;
import com.wangfj.pay.web.util.CookiesUtil;
import com.wangfj.pay.web.util.HttpClientUtil;

@Controller
@RequestMapping(value="/wfjpay")
public class MerchantController {
	private static final Logger logger = LoggerFactory.getLogger(MerchantController.class);
	
	
	
	/**
	 * 查询签约商户
	 * @Methods Name order
	 * @Create In 2015-12-16 By xionghang
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/selectMerchant")
	public String selectMerchant(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("name",request.getParameter("name"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_MERCHANT_LIST);
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
	 * 添加签约商户
	 * @Methods Name order
	 * @Create In 2015-12-16 By xionghang
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/addMerchant")
	public String addMerchant(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("feeCostRate", request.getParameter("feeCostRate"));
	
		paramMap.put("merCode",request.getParameter("merCode"));
		paramMap.put("name",request.getParameter("name"));
		paramMap.put("merchantType",request.getParameter("merchantType"));
		paramMap.put("isOpenYZShop", request.getParameter("isOpenYZShop"));
		paramMap.put("memberUrl", request.getParameter("memberUrl"));
		paramMap.put("yzShopUrl", request.getParameter("yzShopUrl"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.ADD_MERCHANT_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			//List<Object> list = (List<Object>)object.get("listData");
			if (jsonObject.getString("result").equals("success")){
				//m.put("list", list);
				m.put("success", "true");
				//m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("errors",object.getJSONObject("errors"));
			}
		} catch (Exception e) {
			m.put("success", "false");
			//m.put("pageCount",0);
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
	 * 修改签约商户
	 * @Methods Name order
	 * @Create In 2015-12-16 By xionghang
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/updateMerchant")
	public String updateMerchant(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("feeCostRate", request.getParameter("feeCostRate"));
		paramMap.put("id", request.getParameter("id"));
		if("1".equals(request.getParameter("merchantType"))){
			paramMap.put("merCode",request.getParameter("inMerCode"));
		}else{
			paramMap.put("merCode",request.getParameter("outMerCode"));
		}
		paramMap.put("name",request.getParameter("name"));
		paramMap.put("merchantType",request.getParameter("merchantType"));
		paramMap.put("isOpenYZShop", request.getParameter("isOpenYZShop"));
		paramMap.put("memberUrl", request.getParameter("memberUrl"));
		paramMap.put("yzShopUrl", request.getParameter("yzShopUrl"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_MERCHANT_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			//List<Object> list = (List<Object>)object.get("listData");
			if (jsonObject.getString("result").equals("success")){
				//m.put("list", list);
				m.put("success", "true");
				//m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("errors",object.getJSONObject("errors"));
			}
		} catch (Exception e) {
			m.put("success", "false");
			//m.put("pageCount",0);
			m.put("messages", "请选择商户编码修改方式");
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 门店信息
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/selectMerCode")
	public String selectMerCode(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_MERCHANT_CODELIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
		//	JSONObject object=jsonObject.getJSONObject("data");
			List<Object> list = (List<Object>)jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			//	m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("pageCount",0);
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
}
