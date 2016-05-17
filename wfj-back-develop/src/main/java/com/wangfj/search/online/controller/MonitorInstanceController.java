package com.wangfj.search.online.controller;

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
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.search.utils.HttpRequestException;
import com.wangfj.search.utils.HttpRequester;
import com.wangfj.search.utils.MonitorConfig;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;

/**
 * 
 * @Class Name MonitorInstanceController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/back")
public class MonitorInstanceController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private MonitorConfig monitorConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;

	@ResponseBody
	@RequestMapping(value = "/monitorInstanceList", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String getAllMonitorInstance(HttpServletRequest request,
			String appSid) {
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 5;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		//String username = (String) request.getSession()
				//.getAttribute("username");
		// PrivateSignatureHandler handler = new PrivateSignatureHandler();
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
			resultJson = HttpRequester.httpPostString(
					monitorConfig.getMonitor_path()
							+ monitorConfig.getMonitor_appInstanceRead()
							+ appSid + ".json", signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}

		JSONObject json = JSONObject.parseObject(resultJson);
		if (json.containsKey("total")) {
			Integer total = json.getInteger("total");
			int pageCount = total % size == 0 ? total / size
					: (total / size + 1);
			json.put("pageCount", pageCount);
		} else {
			json.put("pageCount", 0);
		}
		return json.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/monitorInstanceUpdate", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateMonitorInstance(HttpServletRequest request,
			String appSid, String appName, String sid, String instanceName) {
		//String username = (String) request.getSession()
				//.getAttribute("username");
		// PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		try {
			appName = URLEncoder.encode(appName, "UTF-8");
			instanceName = URLEncoder.encode(instanceName, "UTF-8");
		} catch (Exception ignore) {
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("appSid", appSid);
		messageBody.put("sid", sid);
		messageBody.put("appName", appName);
		messageBody.put("instanceName", instanceName);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(
					monitorConfig.getMonitor_path()
							+ monitorConfig.getMonitor_appInstanceUpdate(),
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
	@RequestMapping(value = "/monitorInstanceSave", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveMonitorInstance(HttpServletRequest request,
			String appSid, String appName, String instanceName) {
		//String username = (String) request.getSession()
				//.getAttribute("username");
		// PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		try {
			appName = URLEncoder.encode(appName, "UTF-8");
			instanceName = URLEncoder.encode(instanceName, "UTF-8");
		} catch (Exception ignore) {
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("appSid", appSid);
		messageBody.put("appName", appName);
		messageBody.put("instanceName", instanceName);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(
					monitorConfig.getMonitor_path()
							+ monitorConfig.getMonitor_appInstanceCreate(),
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
	@RequestMapping(value = "/monitorInstanceDelete", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deleteMonitorInstance(HttpServletRequest request,
			HttpServletResponse response, String appSid, String appName,
			String sid, String instanceName) {
		//String username = (String) request.getSession()
				//.getAttribute("username");
		// PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		try {
			appName = URLEncoder.encode(appName, "UTF-8");
			instanceName = URLEncoder.encode(instanceName, "UTF-8");
		} catch (Exception ignore) {
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("appSid", appSid);
		messageBody.put("appName", appName);
		messageBody.put("sid", sid);
		messageBody.put("instanceName", instanceName);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(
					monitorConfig.getMonitor_path()
							+ monitorConfig.getMonitor_appInstanceDestory(),
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
	@RequestMapping(value = "/monitorInstanceEnabledUpdate", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String enabledMonitorInstance(HttpServletRequest request,
			String appSid, String appName, String sid, String instanceName,
			Boolean enabled) {
		//String username = (String) request.getSession()
				//.getAttribute("username");
		// PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		try {
			appName = URLEncoder.encode(appName, "UTF-8");
		} catch (Exception ignore) {
		}
		try {
			appName = URLEncoder.encode(appName, "UTF-8");
			instanceName = URLEncoder.encode(instanceName, "UTF-8");
		} catch (Exception ignore) {
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("appSid", appSid);
		messageBody.put("sid", sid);
		messageBody.put("appName", appName);
		messageBody.put("instanceName", instanceName);
		messageBody.put("enabled", enabled);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			if (enabled == true) {
				resultJson = HttpRequester.httpPostString(
						monitorConfig.getMonitor_path()
								+ monitorConfig
										.getMonitor_appInstanceDisabled(),
						signatureJson);
			} else {
				resultJson = HttpRequester
						.httpPostString(
								monitorConfig.getMonitor_path()
										+ monitorConfig
												.getMonitor_appInstanceEnabled(),
								signatureJson);
			}
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		System.out.println(resultJson);
		return resultJson;
	}

}
