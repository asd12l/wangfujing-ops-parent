package com.wangfj.search.online.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.google.common.base.Optional;
import com.wangfj.search.utils.*;
import com.wfj.search.utils.http.OkHttpOperator;
import com.wfj.search.utils.zookeeper.discovery.SpringWebMvcServiceProvider;
import org.apache.commons.lang.StringUtils;
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
 * 加权管理
 * @Class Name WeightBoostController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value="/weight")
public class WeightBoostController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private PrivateRsaKeyProvider privateRsaKeyProvider;
	@Autowired
	private SpringWebMvcServiceProvider serviceProvider;
	@Autowired
	private OkHttpOperator okHttpOperator;
	@Value("${search.caller}")
	private String caller;
	@Value("${search.service.weightBoost.read}")
	private String serviceNameRead;
	@Value("${search.service.weightBoost.save}")
	private String serviceNameSave;
	@Value("${search.service.weightBoost.delete}")
	private String serviceNameDelete;
	
	@ResponseBody
	@RequestMapping(value="/getList", method={RequestMethod.GET,
			RequestMethod.POST})
	public String getWeightList(HttpServletRequest request,String skuId){
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 5;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		if(StringUtils.isBlank(skuId)){
			skuId = null;
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		messageBody.put("skuId", skuId);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BLC0132");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameRead);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameRead, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0142");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (com.utils.StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BLC0149");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (Exception e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BLC0101");
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
	@RequestMapping(value="/save", method={RequestMethod.GET,
			RequestMethod.POST})
	public String saveBoost(HttpServletRequest request, String skuId, String boost){
		JSONObject messageBody = new JSONObject();
		messageBody.put("skuId", skuId);
		messageBody.put("boost", boost);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BLC0132");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameSave);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameSave, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0142");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (com.utils.StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BLC0149");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (IOException e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BLC0161");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}
	
	
	@ResponseBody
	@RequestMapping(value="/update", method={RequestMethod.GET,
			RequestMethod.POST})
	public String updateBoost(HttpServletRequest request, String skuId, String boost){
		JSONObject messageBody = new JSONObject();
		messageBody.put("skuId", skuId);
		messageBody.put("boost", boost);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BLC0132");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameSave);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameSave, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0142");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (com.utils.StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BLC0149");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (IOException e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BLC0161");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/delete", method={RequestMethod.GET,
			RequestMethod.POST})
	public String deleteBoost(HttpServletRequest request, String skuId){
		JSONObject messageBody = new JSONObject();
		messageBody.put("skuId", skuId);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BLC0132");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameDelete);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameDelete, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0142");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (com.utils.StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BLC0149");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (IOException e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BLC0161");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}
}
