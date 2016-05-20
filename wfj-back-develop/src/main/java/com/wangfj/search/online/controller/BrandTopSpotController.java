package com.wangfj.search.online.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.spec.InvalidKeySpecException;

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
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
/**
 * 坑位
 * @Class Name BrandStick
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/back")
public class BrandTopSpotController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private PrivateRsaKeyProvider privateRsaKeyProvider;
	@Autowired
	private SpringWebMvcServiceProvider serviceProvider;
	@Autowired
	private OkHttpOperator okHttpOperator;
	@Value("${search.caller}")
	private String caller;
	@Value("${search.service.brandPopularize.read}")
	private String serviceNameRead;
	@Value("${search.service.brandPopularize.create}")
	private String serviceNameCreate;
	@Value("${search.service.brandPopularize.destory}")
	private String serviceNameDestory;
	@Value("${search.service.brand.list}")
	private String serviceNameBrandList;

	@ResponseBody
	@RequestMapping(value = "/brandStickList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllBrandStick(HttpServletRequest request, String brandId, String spuId) {
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 5;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		logger.info(brandId);
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		JSONObject position = new JSONObject();
		position.put("brandId", brandId);
		position.put("spuId", spuId);
		messageBody.put("position", position);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BTSC0079");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameRead);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameRead, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BTSC0089");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (com.utils.StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BTSC0096");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (Exception e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BTSC0106");
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
	@RequestMapping(value = "/brandStickSelect", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String brandList(HttpServletRequest request) {
		JSONObject messageBody = new JSONObject();
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BTSC0134");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameBrandList);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameBrandList, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BTSC0144");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (com.utils.StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BTSC0151");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (Exception e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BTSC0161");
			return json.toJSONString();
		}
		return resultJson;
	}

	@ResponseBody
	@RequestMapping(value = "/brandStickSave", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveBrandStick(HttpServletRequest request, String brandId, String spuId,String orders) {
		System.out.println(brandId);
		if(StringUtils.isNotBlank(brandId)){
			brandId = null;
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("brandId", brandId);
		messageBody.put("spuId", spuId);
		messageBody.put("orders", orders);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BTSC0187");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameCreate);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameCreate, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BTSC0197");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (com.utils.StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BTSC0204");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (IOException e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BTSC0214");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/brandStickDelete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteBrandStick(HttpServletRequest request,String brandId, String spuId) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("brandId", brandId);
		messageBody.put("spuId", spuId);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BTSC0236");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameDestory);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameDestory, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BTSC246");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (com.utils.StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BTSC0253");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (Exception e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BTSC0263");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}
}
