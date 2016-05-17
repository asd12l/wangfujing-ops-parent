package com.wangfj.search.online.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.search.utils.HttpRequestException;
import com.wangfj.search.utils.HttpRequester;
import com.wangfj.search.utils.RsaResource;
import com.wangfj.search.utils.WeightBoostConfig;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
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
	private WeightBoostConfig weightBoostConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
	@ResponseBody
	@RequestMapping(value="/getList", method={RequestMethod.GET,
			RequestMethod.POST})
	public String getWeightList(HttpServletRequest request,String skuId){
		//String username = (String)request.getSession().getAttribute("username");
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 5;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		if(skuId==""||skuId==null){
			skuId = null;
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		messageBody.put("skuId", skuId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(weightBoostConfig.getWeight_path() + weightBoostConfig.getWeight_read(),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		Integer total = Json.getInteger("total");
		int pageCount = total % size == 0 ? total / size : (total / size + 1);
		Json.put("pageCount", pageCount);
		return Json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/save", method={RequestMethod.GET,
			RequestMethod.POST})
	public String saveBoost(HttpServletRequest request, String skuId, String boost){
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("skuId", skuId);
		messageBody.put("boost", boost);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(weightBoostConfig.getWeight_path() + weightBoostConfig.getWeight_save(),
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
	
	
	@ResponseBody
	@RequestMapping(value="/update", method={RequestMethod.GET,
			RequestMethod.POST})
	public String updateBoost(HttpServletRequest request, String skuId, String boost){
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("skuId", skuId);
		messageBody.put("boost", boost);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(weightBoostConfig.getWeight_path() + weightBoostConfig.getWeight_save(),
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
	
	@ResponseBody
	@RequestMapping(value="/delete", method={RequestMethod.GET,
			RequestMethod.POST})
	public String deleteBoost(HttpServletRequest request, String skuId){
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("skuId", skuId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(weightBoostConfig.getWeight_path() + weightBoostConfig.getWeight_delete(),
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
