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
 * @Class Name SortDetailController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Deprecated
/*@Controller
@RequestMapping(value = "/sortDetail")*/
public class SortDetailController {
	@Autowired
	private RsaResource rsaResource;
	
	@ResponseBody
	@RequestMapping(value = "/DetailList", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String getAllDetail(HttpServletRequest request,
			HttpServletResponse response, String contentSid) {
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 5;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		String username = (String)request.getSession().getAttribute("username");
		PrivateSignatureHandler handler = new PrivateSignatureHandler();
		handler.setCaller(CommonProperties.get("caller"));
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
			resultJson = HttpRequester
					.httpPostString(CommonProperties.get("sortRule_path") + CommonProperties.get("sortDetail") + contentSid
							+ ".json", signatureJson);
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
	@RequestMapping(value = "/DetailUpdate", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateDetail(HttpServletRequest request,
			HttpServletResponse response, String sid, String contentSid, String ruleSid, String orderBy, String orderFiled) {
		String username = (String)request.getSession().getAttribute("username");
		PrivateSignatureHandler handler = new PrivateSignatureHandler();
			handler.setCaller(CommonProperties.get("caller"));
			handler.setPrivateKeyString(rsaResource.get());
		try{
			orderFiled = URLEncoder.encode(orderFiled, "UTF-8");
		} catch (Exception ignore) {
		}
		
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("ruleSid", contentSid);
		messageBody.put("orderBy", orderBy);
		messageBody.put("orderFiled", orderFiled);
		String signatureJson = null;
		try {
			signatureJson = handler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(CommonProperties.get("sortRule_path")
					+ CommonProperties.get("sortDetail_Update"), signatureJson);
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
	@RequestMapping(value = "/detailSave", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveDetail(HttpServletRequest request,
			HttpServletResponse response, String contentSid, String orderBy, String orderFiled) {
		String username = (String)request.getSession().getAttribute("username");
		PrivateSignatureHandler handler = new PrivateSignatureHandler();
			handler.setCaller(CommonProperties.get("caller"));
			handler.setPrivateKeyString(rsaResource.get());
		try{
			orderFiled = URLEncoder.encode(orderFiled, "UTF-8");
		} catch (Exception ignore) {
		} 
		
		JSONObject messageBody = new JSONObject();
		messageBody.put("ruleSid", contentSid);
		messageBody.put("orderBy", orderBy);
		messageBody.put("orderFiled", orderFiled);
		String signatureJson = null;
		try {
			signatureJson = handler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(CommonProperties.get("sortRule_path")
					+ CommonProperties.get("sortDetail_Create"), signatureJson);
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
	@RequestMapping(value = "/DetailDelete", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deleteDetail(HttpServletRequest request,
			HttpServletResponse response, String sid, String ruleSid, String orderBy, String orderFiled) {
		String username = (String)request.getSession().getAttribute("username");
		PrivateSignatureHandler handler = new PrivateSignatureHandler();
			handler.setCaller(CommonProperties.get("caller"));
			handler.setPrivateKeyString(rsaResource.get());
		try{
			orderFiled = URLEncoder.encode(orderFiled, "UTF-8");
		} catch (Exception ignore) {
		} 
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("ruleSid", ruleSid);
		messageBody.put("orderBy", orderBy);
		messageBody.put("orderFiled", orderFiled);
		String signatureJson = null;
		try {
			signatureJson = handler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(CommonProperties.get("sortRule_path")
					+ CommonProperties.get("sortDetail_Destory"), signatureJson);
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
