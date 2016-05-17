package com.wangfj.search.online.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
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
import com.wangfj.search.utils.MonitorConfig;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
/**
 * 集群监控
 * @Class Name MonitorController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/back")
public class MonitorController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private MonitorConfig monitorConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
	@ResponseBody
	@RequestMapping(value = "/monitorList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllMonitor(HttpServletRequest request
			) {
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
			resultJson = HttpRequester.httpPostString(monitorConfig.getMonitor_path() + monitorConfig.getMonitor_appRead(),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		if(!JSONObject.parseObject(resultJson).getBoolean("success")){
			JSONObject Json = JSONObject.parseObject(resultJson);
			Json.put("pageCount", 0);
			return Json.toString();
		}else{
		JSONObject Json = JSONObject.parseObject(resultJson);
		Integer total = Json.getInteger("total");
		int pageCount = total % size == 0 ? total / size : (total / size + 1);
		Json.put("pageCount", pageCount);
		return Json.toString();
		}

	}

	@ResponseBody
	@RequestMapping(value = "/monitorUpdate", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateMonitor(HttpServletRequest request, String sid, String appName) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		try{
			appName = URLEncoder.encode(appName, "UTF-8");
		} catch (Exception ignore) {
		}
		messageBody.put("appName", appName);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(monitorConfig.getMonitor_path() + monitorConfig.getMonitor_appUpdate(),
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
	@RequestMapping(value = "/monitorSave", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveMonitor(HttpServletRequest request, String appName) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		try{
			appName = URLEncoder.encode(appName, "UTF-8");
		} catch (Exception ignore) {
		}
		messageBody.put("appName", appName);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(monitorConfig.getMonitor_path() + monitorConfig.getMonitor_appCreate(),
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
	@RequestMapping(value = "/monitorDelete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteMonitor(HttpServletRequest request, String sid, String appName) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("appName", appName);
		messageBody.put("sid", sid);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(
					monitorConfig.getMonitor_path() + monitorConfig.getMonitor_appDestory(), signatureJson);
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
