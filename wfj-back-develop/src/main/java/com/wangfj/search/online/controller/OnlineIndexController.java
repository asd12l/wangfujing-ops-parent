package com.wangfj.search.online.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
 * 线上索引管理
 * @Class Name OnlineIndexController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value="/onlineIndex")
public class OnlineIndexController {
	
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private PrivateRsaKeyProvider privateRsaKeyProvider;
	@Autowired
	private SpringWebMvcServiceProvider serviceProvider;
	@Autowired
	private OkHttpOperator okHttpOperator;
	@Value("${search.caller}")
	private String caller;
	@Value("${search.service.onlineIndex.brand}")
	private String serviceNameFreshByBrand;
	@Value("${search.service.onlineIndex.removeByBrand}")
	private String serviceNameRemoveByBrand;
	@Value("${search.service.onlineIndex.category}")
	private String serviceNameFreshByCategory;
	@Value("${search.service.onlineIndex.freshAll}")
	private String serviceNameFreshAll;
	@Value("${search.service.onlineIndex.freshBySpu}")
	private String serviceNameFreshBySpu;
	@Value("${search.service.onlineIndex.removeBySpu}")
	private String serviceNameRemoveBySpu;
	@Value("${search.service.onlineIndex.freshBySku}")
	private String serviceNameFreshBySku;
	@Value("${search.service.onlineIndex.removeBySku}")
	private String serviceNameRemoveBySku;
	@Value("${search.service.onlineIndex.freshItem}")
	private String serviceNameFreshItem;
	@Value("${search.service.onlineIndex.removeItem}")
	private String serviceNameRemoveItem;
	/**
	 * 全量刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/allFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String allIndex(HttpServletRequest request,
			HttpServletResponse response) {
		JSONObject messageBody = new JSONObject();
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameFreshAll);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameFreshAll, e);
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
	
	/**
	 * 刷新分类索引
	 */
	@ResponseBody
	@RequestMapping(value = "/categoryFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String categoryIndex(HttpServletRequest request,
			HttpServletResponse response, String categoryId, String channel) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("categoryId", categoryId);
		messageBody.put("channel", channel);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameFreshByCategory);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameFreshByCategory, e);
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
	
	/**
	 * 根据品牌编码刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/brandFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String brandIndex(HttpServletRequest request,
			HttpServletResponse response, String brandId) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("brandId", brandId);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameFreshByBrand);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameFreshByBrand, e);
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
	
	/**
	 * 根据品牌编码移除其下的专柜商品索引
	 */
	@ResponseBody
	@RequestMapping(value = "/removeBrand", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String removeBrandIndex(HttpServletRequest request,
			HttpServletResponse response, String brandId) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("brandId", brandId);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameRemoveByBrand);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameRemoveByBrand, e);
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
	/**
	 * 根据SPU编码刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/spuFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String spuIndex(HttpServletRequest request,
			HttpServletResponse response, String spuId) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("spuId", spuId);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameFreshBySpu);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameFreshBySpu, e);
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
	
	/**
	 * 根据SPU编码移除其下专柜商品索引
	 */
	@ResponseBody
	@RequestMapping(value = "/removeSpu", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String removeSpuIndex(HttpServletRequest request,
			HttpServletResponse response, String spuId) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("spuId", spuId);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameRemoveBySpu);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameRemoveBySpu, e);
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
	
	/**
	 * 根据SKU编码刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/skuFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String skuIndex(HttpServletRequest request,
			HttpServletResponse response, String skuId) {
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameFreshBySku);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameFreshBySku, e);
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
	
	/**
	 * 根据SKU编码移除其下专柜商品索引
	 */
	@ResponseBody
	@RequestMapping(value = "/removeSku", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String removeSkuIndex(HttpServletRequest request,
			HttpServletResponse response, String skuId) {
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameRemoveBySku);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameRemoveBySku, e);
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
	
	/**
	 * 根据item编码刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/itemFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String itemIndex(HttpServletRequest request,
			HttpServletResponse response, String itemId) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("itemId", itemId);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameFreshItem);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameFreshItem, e);
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
	
	/**
	 * 根据item编码移除专柜商品索引
	 */
	@ResponseBody
	@RequestMapping(value = "/removeItem", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String removeItemIndex(HttpServletRequest request,
			HttpServletResponse response, String itemId) {
		JSONObject messageBody = new JSONObject();
		messageBody.put("itemId", itemId);
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
			serviceAddress = serviceProvider.provideServiceAddress(serviceNameRemoveItem);
		} catch (Exception e) {
			logger.error("获取服务{}地址失败", serviceNameRemoveItem, e);
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
}
