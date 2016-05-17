package com.wangfj.search.online.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
/** 
 * 暂时不提供
 * @Class Name SortRuleController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Deprecated
/*@Controller
@RequestMapping(value = "/back")*/
public class SortRuleController {
	@Autowired
	private RsaResource rsaResource;
	private String path = CommonProperties.get("sortRule_path");
	private String caller_path = CommonProperties.get("caller_path");
	private String caller = CommonProperties.get("caller");
	private String sortRule_sortRuleRetrieve = CommonProperties.get("sortRule_sortRuleRetrieve");
	private String sortRule_sortRuleCreate = CommonProperties
			.get("sortRule_sortRuleCreate");
	private String sortRule_sortRuleUpdate = CommonProperties
			.get("sortRule_sortRuleUpdate");
	private String sortRule_sortRuleDestory = CommonProperties
			.get("sortRule_sortRuleDestory");

	@ResponseBody
	@RequestMapping(value = "/sortRuleList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllMonitor(HttpServletRequest request,
			HttpServletResponse response) {
		String username = (String)request.getSession().getAttribute("username");
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 20;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		PrivateSignatureHandler handler = new PrivateSignatureHandler();
			handler.setCaller(caller);
			handler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		String signatureJson = null;
		try {
			signatureJson = handler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		
		try {
			resultJson = HttpRequester.httpPostString(path + sortRule_sortRuleRetrieve,
					signatureJson);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (HttpRequestException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		JSONObject Json = JSONObject.parseObject(resultJson);
		Integer total = Json.getInteger("total");
		int pageCount = total % size == 0 ? total / size : (total / size + 1);
		Json.put("pageCount", pageCount);
		return Json.toString();

	}

	@ResponseBody
	@RequestMapping(value = "/sortRuleUpdate", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateMonitor(HttpServletRequest request,
			HttpServletResponse response, String sid, String showText,String showOrder,String defaultOrderBy) {
		PrivateSignatureHandler handler = new PrivateSignatureHandler();
		String username = (String)request.getSession().getAttribute("username");
			handler.setCaller(caller);
			handler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		try{
			showText = URLEncoder.encode(showText, "UTF-8");
		} catch (Exception ignore) {
		}
		messageBody.put("showText", showText);
		messageBody.put("showOrder", showOrder);
		messageBody.put("defaultOrderBy", defaultOrderBy);
		String signatureJson = null;
		try {
			signatureJson = handler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(path + sortRule_sortRuleUpdate,
					signatureJson);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (HttpRequestException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}
		System.out.println(resultJson);
		return resultJson;
	}

	@ResponseBody
	@RequestMapping(value = "/sortRuleSave", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveMonitor(HttpServletRequest request,
			HttpServletResponse response,  String showText,String showOrder,String defaultOrderBy) {
		PrivateSignatureHandler handler = new PrivateSignatureHandler();
		String username = (String)request.getSession().getAttribute("username");
			handler.setCaller(caller);
			handler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		try{
			showText = URLEncoder.encode(showText, "UTF-8");
		} catch (Exception ignore) {
		}
		messageBody.put("showText", showText);
		messageBody.put("showOrder", showOrder);
		messageBody.put("defaultOrderBy", defaultOrderBy);
		String signatureJson = null;
		try {
			signatureJson = handler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(path + sortRule_sortRuleCreate,
					signatureJson);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (HttpRequestException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		return resultJson;
	}

	@ResponseBody
	@RequestMapping(value = "/sortRuleDelete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteMonitor(HttpServletRequest request,
			HttpServletResponse response,  String sid, String showText,String showOrder,String defaultOrderBy) {
		PrivateSignatureHandler handler = new PrivateSignatureHandler();
		String username = (String)request.getSession().getAttribute("username");
			handler.setCaller(caller);
			handler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("showText", showText);
		messageBody.put("sid", sid);
		messageBody.put("showOrder", showOrder);
		messageBody.put("defaultOrderBy", defaultOrderBy);
		String signatureJson = null;
		try {
			signatureJson = handler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(
					path + sortRule_sortRuleDestory, signatureJson);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (HttpRequestException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}

		return resultJson;
	}
}
