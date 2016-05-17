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

/**
 * 
 * @Class Name 支付介质
 * @Author yangyinbo
 * @Create In 2016年1月12日
 */
@Controller
public class PayMediumController {
	private static final Logger logger = LoggerFactory.getLogger(PayMediumController.class);
	/**
	 * 查询支付介质
	 * @Methods Name business
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/payMedium/findAllList")
	@ResponseBody
	public String findAllList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("name", request.getParameter("name"));
		paramMap.put("code", request.getParameter("code"));
		paramMap.put("parentCode", request.getParameter("parentCode"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.FIND_ALL_PAY_MEDIUM_LIST);
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
	 * 根据名称检查支介质是否存在
	 * @Methods Name check
	 * @Create In 2015-1-6 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/payMedium/check")
	@ResponseBody
	public String check(String name,String code,String id) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("name", name);
		paramMap.put("code", code);
		paramMap.put("id", id);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			System.out.println("jsonStr:"+jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_PAY_MEDIUM);
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
			return "检查异常！";
		}
	}
	
	/**
	 * 新增支付介质
	 * @Methods Name addPayMedium
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/payMedium/addPayMedium")
	@ResponseBody
	public String addPaySystem(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("code", request.getParameter("code"));
		paramMap.put("name", request.getParameter("name"));
		paramMap.put("typeCode", request.getParameter("typeCode"));
		paramMap.put("remark", request.getParameter("remark"));
		paramMap.put("parentCode", request.getParameter("parentCode"));
		paramMap.put("invoiceFlag", request.getParameter("invoiceFlag"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		String checkMsg=check(paramMap.get("name"),paramMap.get("code"),null);
		if(checkMsg.equals("true")){
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.ADD_PAY_MEDIUM);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				if(jsonObject.getString("result").equals("success")){
					m.put("success", true);
					m.put("msg", "添加支付介质成功");
				}else{
					m.put("success",false);
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
	 * 修改支付介质
	 * @Methods Name updatePayMedium
	 * @Create In 2015-12-30 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping("/wfjpay/payMedium/updatePayMedium")
	@ResponseBody
	public String updatePaySystem(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", request.getParameter("id"));
		paramMap.put("code", request.getParameter("code"));
		paramMap.put("name", request.getParameter("name"));
		paramMap.put("typeCode", request.getParameter("typeCode"));
		paramMap.put("remark", request.getParameter("remark"));
		paramMap.put("parentCode", request.getParameter("parentCode"));
		paramMap.put("invoiceFlag", request.getParameter("invoiceFlag"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		String checkMsg=check(paramMap.get("name"),paramMap.get("code"),paramMap.get("id"));
		if(checkMsg.equals("true")){
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_PAY_MEDIUM);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				if(jsonObject.getString("result").equals("success")){
					m.put("success", true);
					m.put("msg","修改支付介质成功！");
				}else{
					m.put("success",false);
					m.put("msg","修改支付介质失败！");
				}
			} catch (Exception e) {
				m.put("success", false);
				m.put("msg","修改支付介质异常！");
			}
		}else{
			m.put("success",false);
			m.put("msg", checkMsg);
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 查询支付方式类型下拉列表
	 * @Methods Name businessStation
	 * @Create In 2015-12-16 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/wfjpay/payMedium/selectPayTypeList")
	public String selectPayTypeList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_TYPE_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>)jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", true);
			} else {
				m.put("success", false);
			}
		} catch (Exception e) {
			m.put("success", false);
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	@ResponseBody
	@RequestMapping("/wfjpay/payMedium/deleteMedium")
	public String deleteMedium(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("code", request.getParameter("code"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.DELETE_MEDIUM_BY_CODE);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if(jsonObject.getString("result").equals("success")){
				m.put("success", true);
				m.put("msg","删除支付介质成功！");
			}else{
				m.put("success",false);
				m.put("msg","删除支付介质失败！");
			}
		} catch (Exception e) {
			m.put("success", false);
			m.put("msg","删除支付介质异常！");
			logger.equals(e.getMessage());
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
}
//package com.wangfj.pay.web.controller;
//
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import net.sf.json.JSONObject;
//
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import com.alibaba.fastjson.JSON;
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
//import com.wangfj.order.utils.CommonProperties;
//import com.wangfj.pay.web.constant.Constants;
//import com.wangfj.pay.web.util.HttpClientUtil;
//
///**
// * 
// * @Class Name 支付介质
// * @Author yangyinbo
// * @Create In 2016年1月12日
// */
//@Controller
//public class PayMediumController {
//	private static final Logger logger = LoggerFactory.getLogger(PayMediumController.class);
//	/**
//	 * 查询支付介质
//	 * @Methods Name business
//	 * @Create In 2015-12-30 By yangyinbo
//	 * @param request
//	 * @param response
//	 * @return String
//	 */
//	@RequestMapping("/wfjpay/payMedium/findAllList")
//	@ResponseBody
//	public String findAllList(HttpServletRequest request, HttpServletResponse response) {
//		String json = "";
//		Map<String,String> paramMap = new HashMap<String,String>();
//		paramMap.put("pageSize", request.getParameter("pageSize"));
//		paramMap.put("pageNo", request.getParameter("page"));
//		paramMap.put("name", request.getParameter("name"));
//		paramMap.put("code", request.getParameter("code"));
//		paramMap.put("parentCode", request.getParameter("parentCode"));
//		Map<Object, Object> m = new HashMap<Object, Object>();
//		try {
//			String jsonStr = JSON.toJSONString(paramMap);
//			logger.info("jsonStr:" + jsonStr);
//			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.FIND_ALL_PAY_MEDIUM_LIST);
//			json=HttpClientUtil.post(url, paramMap);
//			logger.info("json:" + json);
//			JSONObject jsonObject = JSONObject.fromObject(json);
//			JSONObject object=jsonObject.getJSONObject("data");
//			List<Object> list = (List<Object>)object.get("listData");
//			if (list != null && list.size() != 0) {
//				m.put("list", list);
//				m.put("success", "true");
//				m.put("pageCount",object.getString("totalPages"));
//				m.put("pageNo",object.getString("pageNo"));
//			} else {
//				m.put("success", "false");
//				m.put("pageCount",0);
//				if(list.size()==0){
//					m.put("msg","emptyData");
//				}
//			}
//		} catch (Exception e) {
//			m.put("success", "false");
//			m.put("pageCount",0);
//			e.printStackTrace();
//		}
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
//		return gson.toJson(m);
//	}
//	
//	/**
//	 * 根据名称检查支介质是否存在
//	 * @Methods Name check
//	 * @Create In 2015-1-6 By yangyinbo
//	 * @param request
//	 * @param response
//	 * @return String
//	 */
//	@RequestMapping("/wfjpay/payMedium/check")
//	@ResponseBody
//	public boolean check(String name,String code,String parentCode,String id) {
//		String json = "";
//		Map<String,String> paramMap = new HashMap<String,String>();
//		paramMap.put("name", name);
//		paramMap.put("code", code);
//		paramMap.put("parentCode", parentCode);
//		paramMap.put("id", id);
//		try {
//			String jsonStr = JSON.toJSONString(paramMap);
//			logger.info("jsonStr:" + jsonStr);
//			System.out.println("jsonStr:"+jsonStr);
//			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_PAY_MEDIUM);
//			json=HttpClientUtil.post(url, paramMap);
//			System.out.println("json:"+json);
//			logger.info("json:" + json);
//			JSONObject jsonObject = JSONObject.fromObject(json);
//			if(jsonObject.getString("result").equals("success")){
//				return true;
//			}else{
//				return false;
//			}
//		} catch (Exception e) {
//			logger.error(e.getMessage());
//			return false;
//		}
//	}
//	
//	/**
//	 * 新增支付介质
//	 * @Methods Name addPayMedium
//	 * @Create In 2015-12-30 By yangyinbo
//	 * @param request
//	 * @param response
//	 * @return String
//	 */
//	@RequestMapping("/wfjpay/payMedium/addPayMedium")
//	@ResponseBody
//	public String addPaySystem(HttpServletRequest request, HttpServletResponse response) {
//		String json = "";
//		Map<String,String> paramMap = new HashMap<String,String>();
//		paramMap.put("code", request.getParameter("code"));
//		paramMap.put("name", request.getParameter("name"));
//		paramMap.put("typeCode", request.getParameter("typeCode"));
//		paramMap.put("remark", request.getParameter("remark"));
//		paramMap.put("parentCode", request.getParameter("parentCode"));
//		paramMap.put("invoiceFlag", request.getParameter("invoiceFlag"));
//		Map<Object, Object> m = new HashMap<Object, Object>();
//		if(check(paramMap.get("name"),paramMap.get("code"),null,null)){
//			try {
//				String jsonStr = JSON.toJSONString(paramMap);
//				logger.info("jsonStr:" + jsonStr);
//				String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.ADD_PAY_MEDIUM);
//				json=HttpClientUtil.post(url, paramMap);
//				logger.info("json:" + json);
//				JSONObject jsonObject = JSONObject.fromObject(json);
//				if(jsonObject.getString("result").equals("success")){
//					m.put("success", true);
//					m.put("msg", "添加支付介质成功");
//				}else{
//					m.put("success",false);
//				}
//			} catch (Exception e) {
//				m.put("success", false);
//				m.put("msg", "添加异常！");
//				e.printStackTrace();
//			}
//		}else{
//			m.put("success",false);
//			m.put("msg", "支付介质名称已存在！");
//		}
//		
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
//		return gson.toJson(m);
//	}
//
//	/**
//	 * 修改支付介质
//	 * @Methods Name updatePayMedium
//	 * @Create In 2015-12-30 By yangyinbo
//	 * @param request
//	 * @param response
//	 * @return String
//	 */
//	@RequestMapping("/wfjpay/payMedium/updatePayMedium")
//	@ResponseBody
//	public String updatePaySystem(HttpServletRequest request, HttpServletResponse response) {
//		String json = "";
//		Map<String,String> paramMap = new HashMap<String,String>();
//		paramMap.put("id", request.getParameter("id"));
//		paramMap.put("code", request.getParameter("code"));
//		paramMap.put("name", request.getParameter("name"));
//		paramMap.put("typeCode", request.getParameter("typeCode"));
//		paramMap.put("remark", request.getParameter("remark"));
//		paramMap.put("parentCode", request.getParameter("parentCode"));
//		paramMap.put("invoiceFlag", request.getParameter("invoiceFlag"));
//		Map<Object, Object> m = new HashMap<Object, Object>();
//		if(check(paramMap.get("name"),paramMap.get("code"),paramMap.get("parentCode"),paramMap.get("id"))){
//			try {
//				String jsonStr = JSON.toJSONString(paramMap);
//				logger.info("jsonStr:" + jsonStr);
//				String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_PAY_MEDIUM);
//				json=HttpClientUtil.post(url, paramMap);
//				logger.info("json:" + json);
//				JSONObject jsonObject = JSONObject.fromObject(json);
//				if(jsonObject.getString("result").equals("success")){
//					m.put("success", true);
//					m.put("msg","修改支付介质成功！");
//				}else{
//					m.put("success",false);
//					m.put("msg","修改支付介质失败！");
//				}
//			} catch (Exception e) {
//				m.put("success", false);
//				m.put("msg","修改支付介质异常！");
//			}
//		}else{
//			m.put("success",false);
//			m.put("msg", "支付介质名称已存在！");
//		}
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
//		return gson.toJson(m);
//	}
//	
//	/**
//	 * 查询支付方式类型下拉列表
//	 * @Methods Name businessStation
//	 * @Create In 2015-12-16 By yangyinbo
//	 * @param request
//	 * @param response
//	 * @return String
//	 */
//	@ResponseBody
//	@RequestMapping("/wfjpay/payMedium/selectPayTypeList")
//	public String selectPayTypeList(HttpServletRequest request, HttpServletResponse response) {
//		String json = "";
//		Map<String,String> paramMap = new HashMap<String,String>();
//		Map<Object, Object> m = new HashMap<Object, Object>();
//		try {
//			String jsonStr = JSON.toJSONString(paramMap);
//			logger.info("jsonStr:" + jsonStr);
//			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_TYPE_LIST);
//			json=HttpClientUtil.post(url, paramMap);
//			logger.info("json:" + json);
//			JSONObject jsonObject = JSONObject.fromObject(json);
//			List<Object> list = (List<Object>)jsonObject.get("data");
//			if (list != null && list.size() != 0) {
//				m.put("list", list);
//				m.put("success", true);
//			} else {
//				m.put("success", false);
//			}
//		} catch (Exception e) {
//			m.put("success", false);
//			e.printStackTrace();
//		}
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
//		return gson.toJson(m);
//	}
//	@ResponseBody
//	@RequestMapping("/wfjpay/payMedium/deleteMedium")
//	public String deleteMedium(HttpServletRequest request, HttpServletResponse response) {
//		String json = "";
//		Map<String,String> paramMap = new HashMap<String,String>();
//		paramMap.put("code", request.getParameter("code"));
//		Map<Object, Object> m = new HashMap<Object, Object>();
//		try {
//			String jsonStr = JSON.toJSONString(paramMap);
//			logger.info("jsonStr:" + jsonStr);
//			String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.DELETE_MEDIUM_BY_CODE);
//			json=HttpClientUtil.post(url, paramMap);
//			logger.info("json:" + json);
//			JSONObject jsonObject = JSONObject.fromObject(json);
//			if(jsonObject.getString("result").equals("success")){
//				m.put("success", true);
//				m.put("msg","删除支付介质成功！");
//			}else{
//				m.put("success",false);
//				m.put("msg","删除支付介质失败！");
//			}
//		} catch (Exception e) {
//			m.put("success", false);
//			m.put("msg","删除支付介质异常！");
//			logger.equals(e.getMessage());
//		}
//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
//		return gson.toJson(m);
//	}
//	
//}
