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
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.pay.web.constant.Constants;
import com.wangfj.pay.web.util.HttpClientUtil;

@Controller
public class BusinessPlatformController {
	private static final Logger logger = LoggerFactory.getLogger(BusinessPlatformController.class);
	/**
	 * 查询业务平台
	 * @Methods Name business
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/business")
	@ResponseBody
	public String business(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("name", request.getParameter("platformName"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_BUSINESS_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			List<Object> list = (List<Object>)object.get("listData");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
				m.put("pageCount",object.getString("totalPages"));
				m.put("pageNo",object.getString("pageNo"));
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
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 根据名称检查业务平台是否存在
	 * @Methods Name check
	 * @Create In 2015-1-6 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/business/checkBusiness")
	@ResponseBody
	public boolean check(String name,String id) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("name", name);
		paramMap.put("id", id);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_BUSINESS);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if(jsonObject.getString("result").equals("success")){
				return true;
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 新增业务平台
	 * @Methods Name addBusinessPlatform
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/addBusinessPlatform")
	@ResponseBody
	public String addBusinessPlatform(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("bpName", request.getParameter("bpName"));
		paramMap.put("redirectUrl", request.getParameter("redirectUrl"));
		paramMap.put("notifyUrl", request.getParameter("notifyUrl"));
		paramMap.put("mobileRedirectUrl", request.getParameter("mobileRedirectUrl"));
		paramMap.put("mobileNotifyUrl", request.getParameter("mobileNotifyUrl"));
		paramMap.put("status", request.getParameter("status"));
		paramMap.put("description", request.getParameter("description"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		m.put("msg", "添加业务平台成功!");
		if(check(paramMap.get("bpName"),null)){
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.ADD_BUSINESS_PLATFORM_INTERFACE);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				if(jsonObject.getString("result").equals("success")){
					m.put("success", "true");
				}else{
					m.put("success","false");
					m.put("msg", "添加业务平台失败!");
				}
			} catch (Exception e) {
				m.put("success", "false");
				m.put("msg", "添加业务平台异常!");
				e.printStackTrace();
			}
		}else{
			m.put("success","false");
			m.put("msg", "业务平台名称已存在！");
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

	/**
	 * 修改业务平台
	 * @Methods Name updateBusinessPlatform
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/updateBusinessPlatform")
	@ResponseBody
	public String updateBusinessPlatform(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", request.getParameter("id"));
		paramMap.put("bpName", request.getParameter("bpName"));
		paramMap.put("redirectUrl", request.getParameter("redirectUrl"));
		paramMap.put("notifyUrl", request.getParameter("notifyUrl"));
		paramMap.put("mobileRedirectUrl", request.getParameter("mobileRedirectUrl"));
		paramMap.put("mobileNotifyUrl", request.getParameter("mobileNotifyUrl"));
		paramMap.put("status", request.getParameter("status"));
		paramMap.put("description", request.getParameter("description"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		m.put("msg", "修改业务平台成功!");
		if(check(paramMap.get("bpName"),paramMap.get("id"))){
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_BUSINESS_PLATFORM_INTERFACE);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				if(jsonObject.getString("result").equals("success")){
					m.put("success", "true");
				}else{
					m.put("success","false");
					m.put("msg","修改业务平台失败！");
				}
			} catch (Exception e) {
				m.put("success", "false");
				m.put("msg","修改业务平台异常！");
				e.printStackTrace();
			}
		}else{
			m.put("success","false");
			m.put("msg", "业务平台名称已存在！");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 添加支付渠道
	 * @Methods Name addPayChannel
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/business/addPayChannel")
	@ResponseBody
	public String addPayChannel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("client_type", request.getParameter("clientType"));
		paramMap.put("pay_type", request.getParameter("payType"));
		paramMap.put("dic_code", request.getParameter("dicCode"));
		paramMap.put("pay_partner",request.getParameter("payPartner"));
		paramMap.put("pay_service",request.getParameter("payService"));
		paramMap.put("bp_id", request.getParameter("bpId"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		m.put("msg", "添加支付渠道成功!");
		if(checkPayChannel(paramMap.get("bp_id"),paramMap.get("pay_service"),paramMap.get("dic_code"),paramMap.get("client_type"),null)){
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.ADD_PAY_CHANNEL);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				if(jsonObject.getString("result").equals("success")){
					m.put("success", "true");
				}else{
					m.put("success","false");
					m.put("msg", "添加支付渠道失败！");
				}
			} catch (Exception e) {
				m.put("success", "false");
				m.put("msg", "添加支付渠道异常！");
				e.printStackTrace();
			}
		}else{
			m.put("success", "false");
			m.put("msg", "终端和银行不可以同时重复，请更改终端或者银行后重试！");
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 修改支付渠道
	 * @Methods Name updatePayChannel
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/business/updatePayChannel")
	@ResponseBody
	public String updatePayChannel(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", request.getParameter("id"));
		paramMap.put("client_type", request.getParameter("clientType"));
		paramMap.put("pay_type", request.getParameter("payType"));
		paramMap.put("dic_code", request.getParameter("dicCode"));
		paramMap.put("pay_partner",request.getParameter("payPartner"));
		paramMap.put("pay_service",request.getParameter("payService"));
		paramMap.put("bp_id",request.getParameter("bpId"));
		paramMap.put("id",request.getParameter("id"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		m.put("msg", "更新支付渠道成功!");
		if(checkPayChannel(paramMap.get("bp_id"),paramMap.get("pay_service"),paramMap.get("dic_code"),paramMap.get("client_type"),paramMap.get("id"))){
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_PAY_CHANNEL);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				if(jsonObject.getString("result").equals("success")){
					m.put("success", "true");
				}else{
					m.put("success","false");
					m.put("msg", "更新支付渠道失败!");
				}
			} catch (Exception e) {
				m.put("success", "false");
				m.put("msg", "更新支付渠道异常!");
				e.printStackTrace();
			}
		}else{
			m.put("success", "false");
			m.put("msg", "终端和银行不可以同时重复，请更改终端或者银行后重试！");
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 删除支付渠道
	 * @Methods Name deleteCyberBank
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/business/deletePayChannel")
	@ResponseBody
	public String deleteCyberBank(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", request.getParameter("id"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.DELETE_PAY_CHANNEL);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			if(jsonObject.getString("result").equals("success")){
				m.put("success", "true");
			}else{
				m.put("success","false");
			}
		} catch (Exception e) {
			m.put("success", "false");
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询支付渠道
	 * @Methods Name selectPayChannelList
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/business/selectPayChannelList")
	@ResponseBody
	public String selectPayChannelList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("bpId", request.getParameter("bpId"));
		paramMap.put("payService", request.getParameter("payService"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_BUSINNESS_CHANNEL_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject object = JSONObject.fromObject(json);
			List<Object> list = (List<Object>)object.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
				if(list.size()==0){
					m.put("msg","emptyData");
				}
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("pageCount",0);
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询支付渠道签约账户
	 * @Methods Name selectChannelAccount
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/business/selectPartnerAccount")
	@ResponseBody
	public String selectChannelAccount(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("payType", request.getParameter("payType"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PARTNER_ACCOUNT);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject object = JSONObject.fromObject(json);
			List<Object> list = (List<Object>)object.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
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
			logger.error(e.getMessage());
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询下拉银行列表
	 * @Methods Name selectBankList
	 * @Create In 2015-1-4 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/wfjpay/business/selectBankList")
	public String selectBankList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		String payService=request.getParameter("payService");
		if(payService!=null&&!payService.equals("")){
			if(payService.equals("1")){
				paramMap.put("third_bank_flag","1");
			}else if(payService.equals("2")){
				paramMap.put("third_channel_flag","1");
			}else if(payService.equals("3")){
				paramMap.put("online_bank_flag","1");
			}
		}
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_BUSINESS_BANK_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>)jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
				m.put("msg", "查询下拉银行列表成功！");
			} else {
				m.put("success", "false");
				m.put("msg", "查询下拉银行列表失败！");
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("msg", "查询下拉银行列表异常！");
			logger.error(e.getMessage());
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 根据支付渠道是否存在
	 * @Methods Name checkPayChannel
	 * @Create In 2015-1-6 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/business/checkPayChannel")
	@ResponseBody
	public boolean checkPayChannel(String bpId, String payService,String dicCode,String clientType,String  id) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("bpId", bpId);
		paramMap.put("payService", payService);
		paramMap.put("dicCode", dicCode);
		paramMap.put("clientType", clientType);
		paramMap.put("id", id);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_PAY_CHANNEL);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if(jsonObject.getString("result").equals("success")){
				return true;
			}else{
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
