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

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.search.utils.HttpRequestException;
import com.wangfj.search.utils.HttpRequester;
import com.wangfj.search.utils.IntervalConfig;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
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
	private IntervalConfig intervalConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
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
		String resultJson2 = null;
		try {
			resultJson = HttpRequester.httpPostString(intervalConfig.getInterval_path() + intervalConfig.getInterval_read(),
					signatureJson);
			resultJson2 = HttpRequester.httpPostString(intervalConfig.getInterval_path() + intervalConfig.getChannelList(),
					signatureJson);
			logger.info("区间列表："+ resultJson);
			logger.info("渠道列表："+resultJson2);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
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
	public String getchannerlsList(HttpServletRequest request) {
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
			resultJson = HttpRequester.httpPostString(intervalConfig.getInterval_path() + intervalConfig.getChannelList(),
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
	@RequestMapping(value = "/intervalUpdate", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateIntervalContent(HttpServletRequest request, String sid, String channel) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("channel", channel);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(intervalConfig.getInterval_path() + intervalConfig.getInterval_update(),
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
	@RequestMapping(value = "/intervalSave", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveIntervalContent(HttpServletRequest request, String channel) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		
		messageBody.put("channel", channel);
		
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(intervalConfig.getInterval_path() + intervalConfig.getInterval_create(),
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
	@RequestMapping(value = "/intervalDelete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteIntervalContent(HttpServletRequest request, String sid, String field, String show_text, String channel, String selected) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("field", field);
		messageBody.put("showText", show_text);
		messageBody.put("sid", sid);
		messageBody.put("channel", channel);
		messageBody.put("selected", selected);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(
					intervalConfig.getInterval_path() + intervalConfig.getInterval_destroy(), signatureJson);
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
	@RequestMapping(value = "/toSelected", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String toSelected(HttpServletRequest request, String sid, String field, String show_text, String channel, String selected) {
		//String username = (String)request.getSession().getAttribute("username");
		signatureHandler.setPrivateKeyString(rsaResource.get());
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		
		JSONObject messageBody = new JSONObject();
		messageBody.put("field", field);
		messageBody.put("showText", show_text);
		messageBody.put("sid", sid);
		messageBody.put("channel", channel);
		messageBody.put("selected", selected);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(
					intervalConfig.getInterval_path() + intervalConfig.getDoSelected(), signatureJson);
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
