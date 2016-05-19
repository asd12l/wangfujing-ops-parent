package com.wangfj.search.online.controller;


import java.io.IOException;

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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
/**
 * 价格区间
 * @Class Name IntervalContentController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/back")
public class IntervalContentController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private PrivateRsaKeyProvider privateRsaKeyProvider;
	@Autowired
	private SpringWebMvcServiceProvider serviceProvider;
	@Autowired
	private OkHttpOperator okHttpOperator;
	@Value("${search.caller}")
	private String caller;
	@Value("${search.service.intervalContent.read}")
	private String serviceNameRead;
	@Value("${search.service.intervalContent.create}")
	private String serviceNameCreate;
	@Value("${search.service.intervalContent.update}")
	private String serviceNameUpdate;
	@Value("${search.service.intervalContent.destroy}")
	private String serviceNameDestory;
	@Value("${search.service.channelList}")
	private String serviceNameChannelList;
	@Value("${search.service.intervalContent.doSelected}")
	private String serviceNameSelected;
	
	@ResponseBody
	@RequestMapping(value = "/intervalList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllIntervalContent(HttpServletRequest request) {
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

		Optional<String> serviceAddress2;
		try {
			serviceAddress2 = serviceProvider.provideServiceAddress(serviceNameChannelList);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameChannelList, e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "获取后台服务地址失败, BLC0082");
			return json.toJSONString();
		}
		String address2 = serviceAddress2.orNull();
		if (StringUtils.isBlank(address2)) {
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "后台无活动的服务节点, BLC0089");
			return json.toJSONString();
		}

		String resultJson;
		String resultJson2;
		try {
			resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
			resultJson2 = okHttpOperator.postJsonTextForTextResp(address2, signatureJson);
		} catch (Exception e) {
			logger.error("请求后台服务失败", e);
			JSONObject json = new JSONObject();
			json.put("success", false);
			json.put("message", "请求后台服务失败, BLC0101");
			return json.toJSONString();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		JSONObject Json2 = JSONObject.parseObject(resultJson2);
		JSONArray list = Json.getJSONArray("list");
		JSONArray list2 = Json2.getJSONArray("list");
		for(int i=0; i<list.size(); i++){
			for(int j=0; j<list2.size(); j++){
				if(list.getJSONObject(i).get("channel").equals(list2.getJSONObject(j).get("channelCode"))){
					list.getJSONObject(i).put("channelName", list2.getJSONObject(j).getString("channelName"));
				}
			}
		}
		Integer total = Json.getInteger("total");
		int pageCount = total % size == 0 ? total / size : (total / size + 1);
		Json.put("pageCount", pageCount);
		Json.put("list", list);
		return Json.toString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/channelsList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getChannelsList(HttpServletRequest request) {
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameChannelList);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameChannelList, e);
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
		return jsonObject.toString();

	}

	@ResponseBody
	@RequestMapping(value = "/intervalUpdate", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateIntervalContent(HttpServletRequest request, String sid, String channel) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("channel", channel);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameUpdate);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameUpdate, e);
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
	@RequestMapping(value = "/intervalSave", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveIntervalContent(HttpServletRequest request, String channel) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("channel", channel);
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
	@RequestMapping(value = "/intervalDelete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteIntervalContent(HttpServletRequest request, String sid, String field, String show_text, String channel, String selected) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("field", field);
		messageBody.put("showText", show_text);
		messageBody.put("sid", sid);
		messageBody.put("channel", channel);
		messageBody.put("selected", selected);
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
	
	@ResponseBody
	@RequestMapping(value = "/toSelected", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String toSelected(HttpServletRequest request, String sid, String field, String show_text, String channel, String selected) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("field", field);
		messageBody.put("showText", show_text);
		messageBody.put("sid", sid);
		messageBody.put("channel", channel);
		messageBody.put("selected", selected);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameSelected);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameSelected, e);
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
