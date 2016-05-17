package com.wangfj.search.shoppe.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.wangfj.search.utils.CommonProperties;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.search.utils.HttpRequestException;
import com.wangfj.search.utils.HttpRequester;
import com.wangfj.search.utils.RsaResource;
import com.wangfj.search.utils.ShoppeConfig;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
/**
 * 
 * @Class Name ShoppeMessageController
 * @Author litao
 * @Create In 2015年12月15日
 */
@Controller
@RequestMapping(value = "/shoppe")
public class ShoppeMessageController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private ShoppeConfig shoppeConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
	/**
	 * 品牌信息修改
	 */
	@ResponseBody
	@RequestMapping(value = "/brand_Update", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateBrand(HttpServletRequest request, String storeCode, String storeBrandCode) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("storeCode", storeCode);
		messageBody.put("storeBrandCode", storeBrandCode);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(shoppeConfig.getShoppe_path() + shoppeConfig.getBrandUpdate(),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}

		return resultJson;
	}

	/**
	 * 根据条件刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/freshIndex", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String freshIndex(HttpServletRequest request,
			HttpServletResponse response, String storeCode, String shoppeCode, String spuCode, String skuCode, String storeBrandCode) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("storeCode", storeCode);
		messageBody.put("storeBrandCode", storeBrandCode);
		messageBody.put("shoppeCode", shoppeCode);
		messageBody.put("spuCode", spuCode);
		messageBody.put("skuCode", skuCode);
		
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(shoppeConfig.getShoppe_path() + CommonProperties.get(""),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}

		return resultJson;
	}
	
	/**
	 * 专柜商品刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/itemIndex", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String itemIndex(HttpServletRequest request,
			HttpServletResponse response, String itemCode) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("itemCode", itemCode);
		
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(shoppeConfig.getShoppe_path() + shoppeConfig.getItemIndex(),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}

		return resultJson;
	}
	
	
	/**
	 * 全量刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/allFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String allIndex(HttpServletRequest request,
			HttpServletResponse response) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(shoppeConfig.getShoppe_path() + shoppeConfig.getFreshIndex(),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}

		return resultJson;
	}
	
	/**
	 * 全量刷新大码商品
	 */
	@ResponseBody
	@RequestMapping(value = "/allFreshERP", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String allERPIndex(HttpServletRequest request,
			HttpServletResponse response) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(shoppeConfig.getShoppe_path() + shoppeConfig.getFreshERPIndex(),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}

		return resultJson;
	}

}
