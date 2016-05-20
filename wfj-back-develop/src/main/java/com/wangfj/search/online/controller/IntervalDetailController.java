package com.wangfj.search.online.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;


import com.google.common.base.Optional;
import com.utils.StringUtils;
import com.wangfj.search.utils.*;
import com.wfj.search.utils.http.OkHttpOperator;
import com.wfj.search.utils.zookeeper.discovery.SpringWebMvcServiceProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
/**
 * 区间明细
 * @Class Name IntervalDetailController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/back")
public class IntervalDetailController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private PrivateRsaKeyProvider privateRsaKeyProvider;
	@Autowired
	private SpringWebMvcServiceProvider serviceProvider;
	@Autowired
	private OkHttpOperator okHttpOperator;
	@Value("${search.caller}")
	private String caller;
	@Value("${search.service.intervalDetail.list}")
	private String serviceNameList;
	@Value("${search.service.intervalDetail.create}")
	private String serviceNameCreate;
	@Value("${search.service.intervalDetail.update}")
	private String serviceNameUpdate;
	@Value("${search.service.intervalDetail.destroy}")
	private String serviceNameDestroy;

	
	@ResponseBody
	@RequestMapping(value = "/intervalDetailList", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String getAllIntervalDetail(HttpServletRequest request, String contentSid) {
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 5;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, IDC0074");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameList);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameList, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, IDC0084");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, IDC0091");
			return json.toJSONString();
		}
		String address1 = address.replace("{contentSid}",contentSid);
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address1, signatureJson);
		} catch (Exception e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, IDC0102");
			return json.toJSONString();
		}
		JSONObject jsonObject = JSONObject.parseObject(resultJson);
		if (!jsonObject.getBoolean("success")) {
			jsonObject.put("pageCount", 0);
			return jsonObject.toString();
		} else {
			Integer total = jsonObject.getInteger("total");
			int pageCount = total % size == 0 ? total / size : (total / size + 1);
			jsonObject.put("pageCount", pageCount);
			return jsonObject.toString();
		}
	}

	@ResponseBody
	@RequestMapping(value = "/intervalDetailUpdate", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateIntercalDetail(HttpServletRequest request, String sid, String contentSid,
			String lower_limit, String upper_limit, String order_by, String show_text) {
		try{
			show_text = URLEncoder.encode(show_text, "UTF-8");
		} catch (Exception ignore) {
		}
		
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("contentSid", contentSid);
		messageBody.put("lowerLimit", lower_limit);
		messageBody.put("upperLimit", upper_limit);
		messageBody.put("orderBy", order_by);
		messageBody.put("showText", show_text);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, IDC0142");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameUpdate);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameUpdate, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, IDC0152");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, IDC0159");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (IOException e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, IDC0169");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/intervalDetailSave", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveIntercalDetail(HttpServletRequest request, String contentSid, String lower_limit,
			String upper_limit, Integer order_by, String show_text) {
		try{
			show_text = URLEncoder.encode(show_text, "UTF-8");
		} catch (Exception ignore) {
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("contentSid", contentSid);
		messageBody.put("lowerLimit", lower_limit);
		messageBody.put("upperLimit", upper_limit);
		messageBody.put("orderBy", order_by);
		messageBody.put("showText", show_text);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, IDC0199");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameCreate);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameCreate, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, IDC0209");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, IDC0216");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (IOException e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, IDC0226");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/intervalDetailDelete", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deleteIntercalDetail(HttpServletRequest request, String sid, String contentSid,
			String lower_limit, String upper_limit, String order_by, String show_text) {
		try{
			show_text = URLEncoder.encode(show_text, "UTF-8");
		} catch (Exception ignore) {
		} 
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("contentSid", contentSid);
		messageBody.put("lowerLimit", lower_limit);
		messageBody.put("upperLimit", upper_limit);
		messageBody.put("orderBy", order_by);
		messageBody.put("showText", show_text);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, IDC0257");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameDestroy);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameDestroy, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, IDC0267");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, IDC0274");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (Exception e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, IDC0284");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}

}
