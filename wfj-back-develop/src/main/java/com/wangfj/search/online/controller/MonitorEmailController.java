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
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.search.utils.HttpRequestException;
import com.wangfj.search.utils.HttpRequester;
import com.wangfj.search.utils.MonitorConfig;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;

/**
 * 
 * @Class Name MonitorEmailController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/back")
public class MonitorEmailController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private MonitorConfig monitorConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
	@ResponseBody
	@RequestMapping(value = "/monitorEmailsList",method={RequestMethod.GET,RequestMethod.POST})
	public String getAllMonitorEmails(HttpServletRequest request, String appSid){
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		if(size==null || size==0){
			size = 5;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage-1)*size;
		//String username = (String)request.getSession().getAttribute("username");
		signatureHandler.setPrivateKeyString(rsaResource.get());
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		
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
			resultJson = HttpRequester.httpPostString(monitorConfig.getMonitor_path()+monitorConfig.getMonitor_appEmailRead()+appSid+".json", signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
	    JSONObject Json = JSONObject.parseObject(resultJson);
	    Integer total = Json.getInteger("total");
	    int pageCount=total%size==0?total/size:(total/size+1);
	    Json.put("pageCount", pageCount);
	    return Json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/monitorEmailsUpdate",method={RequestMethod.GET,RequestMethod.POST})
	public String updateMonitorEmails(HttpServletRequest request, String appSid, String appName, String sid, String email){
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		try{
			appName = URLEncoder.encode(appName, "UTF-8");
		} catch (Exception ignore) {
		}
	    JSONObject messageBody = new JSONObject();
	    messageBody.put("appSid", appSid);
	    messageBody.put("sid", sid);
	    messageBody.put("appName", appName);
	    messageBody.put("email", email);
	    String signatureJson = null;
  		try {
  			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
  		} catch (Exception e1) {
  			logger.error(e1.getMessage(), e1);
  		}
	    String resultJson = null;
	    try {
			resultJson = HttpRequester.httpPostString(monitorConfig.getMonitor_path()+monitorConfig.getMonitor_appEmailUpdate(), signatureJson);
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
	@RequestMapping(value="/monitorEmailsSave",method={RequestMethod.GET,RequestMethod.POST})
	public String saveMonitorEmails(HttpServletRequest request,HttpServletResponse response, String appSid, String appName, String email){
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		try{
			appName = URLEncoder.encode(appName, "UTF-8");
		} catch (Exception ignore) {
		}
	    JSONObject messageBody = new JSONObject();
	    messageBody.put("appSid", appSid);
	    messageBody.put("appName", appName);
	    messageBody.put("email", email);
	    String signatureJson = null;
  		try {
  			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
  		} catch (Exception e1) {
  			logger.error(e1.getMessage(), e1);
  		}
	    String resultJson = null;
	    try {
			resultJson = HttpRequester.httpPostString(monitorConfig.getMonitor_path()+monitorConfig.getMonitor_appEmailCreate(), signatureJson);
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
	@RequestMapping(value="/monitorEmailsDelete",method={RequestMethod.GET,RequestMethod.POST})
	public String deleteMonitorEmails(HttpServletRequest request,HttpServletResponse response, String appSid, String appName, String sid, String email){
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		try{
			appName = URLEncoder.encode(appName, "UTF-8");
		} catch (Exception ignore) {
		}
	    JSONObject messageBody = new JSONObject();
	    messageBody.put("appSid", appSid);
	    messageBody.put("appName", appName);
	    messageBody.put("sid", sid);
	    messageBody.put("email", email);
	    String signatureJson = null;
  		try {
  			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
  		} catch (Exception e1) {
  			logger.error(e1.getMessage(), e1);
  		}
	    String resultJson = null;
	    try {
			resultJson = HttpRequester.httpPostString(monitorConfig.getMonitor_path()+monitorConfig.getMonitor_appEmailDestory(), signatureJson);
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

