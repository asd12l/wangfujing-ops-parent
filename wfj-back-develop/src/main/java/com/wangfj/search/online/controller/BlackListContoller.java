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
import com.wangfj.search.utils.BlackListConfig;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.search.utils.HttpRequestException;
import com.wangfj.search.utils.HttpRequester;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;

/**
 * 黑名单
 * @Class Name BlackList
 * @Author litao
 * @Create In 2015年11月24日
 * @author liufl
 */
@Controller
@RequestMapping(value = "/blackList")
public class BlackListContoller {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private BlackListConfig blackListConfig;
	@Autowired
	private PrivateSignatureHandler privateSignatureHandler;
	@Autowired
	private RsaResource rsaResource;

	@ResponseBody
	@RequestMapping(value = "/getList", method = { RequestMethod.GET, RequestMethod.POST })
	public String getBlackList(HttpServletRequest request, String blackType, String id) {
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		/*String username = (String) request.getSession().getAttribute("username");*/
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 10;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		JSONObject messageBody = new JSONObject();
		if (blackType != null && blackType != "") {
			messageBody.put("type", blackType);
		}
		if (id != null && id != "") {
			messageBody.put("id", id);
		}
		messageBody.put("limit", size);
		messageBody.put("start", start);
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(blackListConfig.getBlack_path() + blackListConfig.getRead(),
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
	@RequestMapping(value = "/addBlackList", method = { RequestMethod.GET, RequestMethod.POST })
	public String addBlackList(HttpServletRequest request, String type, String id) {
		//String username = (String) request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		if (type != null && type != "") {
			messageBody.put("type", type);
		}
		if (id != null && id != "") {
			messageBody.put("id", id);
		}
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester
					.httpPostString(blackListConfig.getBlack_path() + blackListConfig.getCreate(), signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/deleteBlackList", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteBlackList(HttpServletRequest request, String id, String type) {
		//String username = (String) request.getSession().getAttribute("username");
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		JSONObject messageBody = new JSONObject();
		if (type != null && type != "") {
			messageBody.put("type", type);
		}
		if (id != null && id != "") {
			messageBody.put("id", id);
		}
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(blackListConfig.getBlack_path() + blackListConfig.getDelete(), signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		return Json.toString();
	}
}
