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
 *
 * @Class Name SortListboxController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/sortList")
public class CategoryTopSpotController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private PrivateRsaKeyProvider privateRsaKeyProvider;
	@Autowired
	private SpringWebMvcServiceProvider serviceProvider;
	@Autowired
	private OkHttpOperator okHttpOperator;
	@Value("${search.caller}")
	private String caller;
	@Value("${search.service.categoryPopularize.read}")
	private String serviceNameRead;
	@Value("${search.service.categoryPopularize.create}")
	private String serviceNameCreate;
	@Value("${search.service.categoryPopularize.destroy}")
	private String serviceNameDestory;
	@Value("${search.service.category}")
	private String serviceNameCategory;
	
	@ResponseBody
	@RequestMapping(value = "/allSortList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllSortList(HttpServletRequest request) {
		JSONObject messageBody = new JSONObject();
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BLC0072");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameCategory);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameCategory, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0082");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BLC0089");
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
		String resultJson1 = resultJson.replaceAll("categoryName", "text");
		String resultJson2 = resultJson1.replaceAll("children", "nodes");
		return resultJson2;
	}
	
	@ResponseBody
	@RequestMapping(value = "/sortListSelect", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String List(HttpServletRequest request, String sid,String spuId ) {
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 20;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		JSONObject position = new JSONObject();
		position.put("categoryId", sid);
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
			json.put("message", "签名处理失败, BLC0072");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameRead);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameRead, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0082");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BLC0089");
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
	@RequestMapping(value = "/sortListSave", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveCategoryTopSpot(HttpServletRequest request,String spuId,String orders) {
		String categoryId=request.getParameter("sid");
		JSONObject messageBody = new JSONObject();
		try{
			categoryId = URLEncoder.encode(categoryId, "UTF-8");
		} catch (Exception ignore) {
		}
		try{
			spuId = URLEncoder.encode(spuId, "UTF-8");
		} catch (Exception ignore) {
		}
		messageBody.put("categoryId", categoryId);
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
			json.put("message", "签名处理失败, BLC0132");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameCreate);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameCreate, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0142");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (StringUtils.isBlank(address)) {
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
	@RequestMapping(value = "/sortListDelete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteCategoryTopSpot(HttpServletRequest request,String categoryId, String spuId) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("categoryId", categoryId);
		messageBody.put("spuId", spuId);
		String signatureJson;
		try {
			signatureJson = SignatureHandler
					.sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
		} catch (Exception e) {
			logger.error("签名处理失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "签名处理失败, BLC0186");
			return json.toJSONString();
		}
		Optional<String> serviceAddress;
		try {
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameDestory);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameDestory, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0196");
			return json.toJSONString();
		}
		String address = serviceAddress.orNull();
		if (StringUtils.isBlank(address)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BLC0203");
			return json.toJSONString();
		}
		String resultJson;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
		} catch (Exception e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BLC0214");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}
}
