package com.wangfj.pay.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.wangfj.pay.web.vo.ZtreeNodesVO;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/wfjpay/coupon")
public class CouponController {
	private static final Logger logger = LoggerFactory.getLogger(CouponController.class);
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
	@RequestMapping(value="/findAllYZCouponByPage")
	public String findAllYZCouponByPage(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("orderId", request.getParameter("orderId"));
		paramMap.put("outerTid", request.getParameter("outerTid"));
		paramMap.put("outerItemId", request.getParameter("outerItemId"));
		paramMap.put("verifyStoreId",request.getParameter("verifyStoreId"));
		paramMap.put("verifyStartTime",request.getParameter("verifyStartTime"));
		paramMap.put("verifyEndTime", request.getParameter("verifyEndTime"));
		paramMap.put("sortParam", request.getParameter("sortParam"));
		paramMap.put("sortType", request.getParameter("sortType"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.COUPON_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_YZ_COUPON_VERIFY_LIST);
//			url="http://localhost:80/wfjpay-verify/Coupon/findAllYZCouponByPage.do";
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
	 * 分页查询活动配置信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/findAllList")
	@ResponseBody
	public String findAllList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.COUPON_CORE_URL)+"/"+CommonProperties.get(Constants.FIND_COUPON_TYPE_INFO);
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
	 * 修改活动配置
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/updateActivity")
	@ResponseBody
	public String updateActivity(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("Id", request.getParameter("activityCode"));
		paramMap.put("itemId", request.getParameter("activityID"));
		paramMap.put("beginTime", request.getParameter("activityBeginTime"));
		paramMap.put("endTime", request.getParameter("ctivityEndTime"));
		paramMap.put("updateTime", request.getParameter("activityUpdateTime"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.COUPON_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_COUPON_INFO);
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
	 * 保存配置信息操作日志
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/saveLogInfo")
	@ResponseBody
	public String saveLogInfo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("logInfo",request.getParameter("logInfo"));
		paramMap.put("createTime", request.getParameter("createTime"));
		paramMap.put("userName", request.getParameter("userName"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.COUPON_CORE_URL)+"/"+CommonProperties.get(Constants.SAVE_COUPON_LOG_INFO);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if(jsonObject.getString("result").equals("success")){
				m.put("success", true);
				m.put("msg", "保存券核销操作日志成功！");
			}else{
				m.put("success",false);
				m.put("msg", "保存券核销操作日志失败！");
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			m.put("success", false);
			m.put("msg", "保存券核销操作日志异常！");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 查询活动对应门店信息
	 */
	@RequestMapping("/findAllCouponList")
	@ResponseBody
	public String findAllListNoParam(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String codeJson = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("itemId",request.getParameter("itemId"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.COUPON_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_COUPON_STORE_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("活动门店信息:" + jsonStr);
			//
			Map<String,String> CodeMap = new HashMap<String,String>();
			String codeUrl=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_ALLSYSTEM_NOPARAM);
			codeJson=HttpClientUtil.post(codeUrl, CodeMap);
			logger.info("门店信息:" + jsonStr);
			//
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONArray object=jsonObject.getJSONArray("data");//
			
			JSONObject jsonCode = JSONObject.fromObject(codeJson);
			JSONArray CodeObject=jsonCode.getJSONArray("data");//
			List<ZtreeNodesVO> Codelist = new ArrayList<ZtreeNodesVO>();
			List<Object> list1 = (List<Object>)CodeObject.fromObject(CodeObject);
			List<Object> list2 = (List<Object>)object.fromObject(object);
			for (int i = 0; i < list1.size(); i++) {
				ZtreeNodesVO z = new ZtreeNodesVO();
				JSONObject jo1 = JSONObject.fromObject(list1.get(i));
				z.setId(jo1.getString("id"));
				z.setName(jo1.getString("name"));
				z.setpId("0");
			for (int j = 0;j< list2.size(); j++){
				JSONObject jo2 = JSONObject.fromObject(list2.get(j));
				if(jo2.getString("storeNo").equals(jo1.getString("id"))){
					z.setChecked(true);
					list2.remove(j);
					j--;
				}
			}
			Codelist.add(z);
		}
			logger.info("json:" + json);
			List<Object> list = (List<Object>)object.fromObject(object);
			if (Codelist != null && Codelist.size() != 0) {
				m.put("list", Codelist);
				m.put("success", "true");
			} else {
				m.put("success", "false");
				m.put("pageCount",0);
				if(Codelist.size()==0){
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
	 * 保存活动配置门店信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/saveActivityInfo")
	@ResponseBody
	public String saveActivityInfo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("itemId",request.getParameter("item_id"));
		paramMap.put("addZtree", request.getParameter("addZtree"));
		paramMap.put("delZtree", request.getParameter("delZtree"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.COUPON_CORE_URL)+"/"+CommonProperties.get(Constants.SAVE_COUPON_ACTIVITY_INFO);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if(jsonObject.getString("result").equals("success")){
				m.put("success", true);
				m.put("msg", "设置活动门店配置信息成功！");
			}else{
				m.put("success",false);
				m.put("msg", "设置活动门店配置信息失败！");
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			m.put("success", false);
			m.put("msg", "设置活动门店配置信息异常！");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

}
