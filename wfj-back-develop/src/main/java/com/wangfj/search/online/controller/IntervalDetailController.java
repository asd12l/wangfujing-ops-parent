package com.wangfj.search.online.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
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
import com.wangfj.search.utils.IntervalConfig;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
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
	private IntervalConfig intervalConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
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
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester
					.httpPostString(intervalConfig.getInterval_path() + intervalConfig.getIntervalDetail_list() + contentSid
							+ ".json", signatureJson);
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
	@RequestMapping(value = "/intervalDetailUpdate", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateIntercalDetail(HttpServletRequest request, String sid, String contentSid,
			String lower_limit, String upper_limit, String order_by, String show_text) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
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
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(intervalConfig.getInterval_path()
					+ intervalConfig.getIntervalDetail_update(), signatureJson);
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
	@RequestMapping(value = "/intervalDetailSave", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveIntercalDetail(HttpServletRequest request, String contentSid, String lower_limit,
			String upper_limit, Integer order_by, String show_text) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
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
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(intervalConfig.getInterval_path()
					+ intervalConfig.getIntervalDetail_create(), signatureJson);
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
	@RequestMapping(value = "/intervalDetailDelete", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deleteIntercalDetail(HttpServletRequest request, String sid, String contentSid,
			String lower_limit, String upper_limit, String order_by, String show_text) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
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
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(intervalConfig.getInterval_path()
					+ intervalConfig.getIntervalDetail_destroy(), signatureJson);
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
