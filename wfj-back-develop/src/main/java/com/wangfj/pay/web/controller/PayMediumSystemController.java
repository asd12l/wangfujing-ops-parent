package com.wangfj.pay.web.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.pay.web.constant.Constants;
import com.wangfj.pay.web.util.HttpClientUtil;

/**
 * 
 * @Class Name 支付介质下发系统
 * @Author yangyinbo
 * @Create In 2016年1月12日
 */
@Controller
public class PayMediumSystemController {
	private static final Logger logger = LoggerFactory.getLogger(PayMediumSystemController.class);
	/**
	 * 查询支付系统
	 * @Methods Name business
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/paySystem/findAllList")
	@ResponseBody
	public String findAllList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("name", request.getParameter("name"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.FIND_ALL_PAY_SYSTEM_LIST);
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
	 * 查询支付系统
	 * @Methods Name business
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/paySystem/findAllListNoParam")
	@ResponseBody
	public String findAllListNoParam(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_ALLSYSTEM_NOPARAM);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONArray object=jsonObject.getJSONArray("data");
			List<Object> list = (List<Object>)object.fromObject(object);
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
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 查询支付介质zTree
	 * @Methods Name findAllMediumList
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/paySystem/findAllMediumList")
	@ResponseBody
	public String findAllMediumList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", request.getParameter("id"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.FIND_ALL_PAY_MEDIUM_ZTREE);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if (jsonObject.getString("result").equals("success")) {
				List<Object> list = (List<Object>)jsonObject.get("data");
				m.put("list", list);
				m.put("success", true);
			} else {
				m.put("success", false);
				m.put("msg", "查询支付介质失败！");
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("msg","error！");
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 根据名称检查支系统是否存在
	 * @Methods Name check
	 * @Create In 2015-1-6 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/paySystem/check")
	@ResponseBody
	public String check(String name,String id,String code) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("name", name);
		paramMap.put("id", id);
		paramMap.put("code", code);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			System.out.println("jsonStr:"+jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_PAY_SYSTEM);
			json=HttpClientUtil.post(url, paramMap);
			System.out.println("json:"+json);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if(jsonObject.getString("result").equals("success")){
				return "true";
			}else{
				return jsonObject.getJSONArray("messages").get(0).toString();
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			return "false";
		}
	}
	
	/**
	 * 新增支付系统
	 * @Methods Name addPaySystem
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/paySystem/addPaySystem")
	@ResponseBody
	public String addPaySystem(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("name", request.getParameter("name"));
//		paramMap.put("callUrl", request.getParameter("callUrl"));
		paramMap.put("isEnable", request.getParameter("isEnable"));
		paramMap.put("id", request.getParameter("code"));
		String checkMsg=check(paramMap.get("name"),null,paramMap.get("id"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(checkMsg.equals("true")){
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.ADD_PAY_SYSTEM);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				if(jsonObject.getString("result").equals("success")){
					m.put("success", true);
					m.put("msg", "添加支付系统成功");
				}else{
					m.put("success",false);
					m.put("msg", jsonObject.getJSONArray("messages").get(0));
				}
			} catch (Exception e) {
				m.put("success", false);
				m.put("msg", "添加异常！");
				e.printStackTrace();
			}
		}else{
			m.put("success",false);
			m.put("msg", checkMsg);
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

	/**
	 * 修改支付系统
	 * @Methods Name updatePaySystem
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/payMedium/updatePaySystem")
	@ResponseBody
	public String updatePaySystem(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("oldCode", request.getParameter("oldCode"));
		paramMap.put("name", request.getParameter("name"));
		paramMap.put("callUrl", request.getParameter("callUrl"));
		paramMap.put("isEnable", request.getParameter("isEnable"));
		paramMap.put("id", request.getParameter("code"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		String checkMsg=check(paramMap.get("name"),paramMap.get("oldCode"),paramMap.get("id"));
		if(checkMsg.equals("true")){
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_PAY_SYSTEM);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				if(jsonObject.getString("result").equals("success")){
					m.put("success", true);
					m.put("msg","修改支付系统成功！");
				}else{
					m.put("success",false);
					m.put("msg","修改支付系统失败！");
				}
			} catch (Exception e) {
				m.put("success", false);
				m.put("msg","修改支付系统异常！");
			}
		}else{
			m.put("success",false);
			m.put("msg", checkMsg);
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 保存设置支付介质
	 * @Methods Name setPayMedium
	 * @Create In 2015-1-12 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/paySystem/saveSetPayMedium")
	@ResponseBody
	public String saveSetPayMedium(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id",request.getParameter("id"));
		paramMap.put("addZtree", request.getParameter("addZtree"));
		paramMap.put("delZtree", request.getParameter("delZtree"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.SET_PAY_MEDIUM);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if(jsonObject.getString("result").equals("success")){
				m.put("success", true);
				m.put("msg", "设置支付介质成功！");
			}else{
				m.put("success",false);
				m.put("msg", "设置支付介质失败！");
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			m.put("success", false);
			m.put("msg", "设置支付介质异常！");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
}
