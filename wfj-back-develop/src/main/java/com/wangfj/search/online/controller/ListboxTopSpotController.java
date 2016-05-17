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
import com.wangfj.search.utils.RsaResource;
import com.wangfj.search.utils.SortListBoxConfig;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
/**
 *
 * @Class Name SortListboxController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/sortList")
public class ListboxTopSpotController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private SortListBoxConfig sortListBoxConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
	@ResponseBody
	@RequestMapping(value = "/allSortList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllMonitor(HttpServletRequest request) {
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
			resultJson = HttpRequester.httpPostString(sortListBoxConfig.getSortList_path() + sortListBoxConfig.getSortList_SortListRetrieve(),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		String resultJson1 = resultJson.replaceAll("categoryName", "text");
		String resultJson2 = resultJson1.replaceAll("children", "nodes");
		//System.out.println("allSortList"+resultJson2);
		logger.info(resultJson2);
		return resultJson2;
	}
	
	@ResponseBody
	@RequestMapping(value = "/sortListSelect", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateMonitor(HttpServletRequest request, String sid,String spuId ) {
		String categoryId=sid;
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		//String username = (String)request.getSession().getAttribute("username");
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 20;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		JSONObject position = new JSONObject();
		position.put("categoryId", categoryId);
		position.put("spuId", spuId);
		messageBody.put("position", position);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(sortListBoxConfig.getSortList_path() + sortListBoxConfig.getSortList_SortListSelect(),
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
		//System.out.println("selet："+Json);
		return Json.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/sortListSave", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveMonitor(HttpServletRequest request,String spuId,String orders) {
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		//String username = (String)request.getSession().getAttribute("username");
		String categoryId=request.getParameter("sid");
		JSONObject messageBody = new JSONObject();
		try{
			categoryId = URLEncoder.encode(categoryId, "UTF-8");
		} catch (Exception ignore) {
		}
		try{
			spuId = URLEncoder.encode(spuId, "UTF-8");
		} catch (Exception ignore) {
		}
		messageBody.put("categoryId", categoryId);
		messageBody.put("spuId", spuId);
		messageBody.put("orders", orders);
		
		
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(sortListBoxConfig.getSortList_path() + sortListBoxConfig.getSortList_SortListCreate(),
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
	@RequestMapping(value = "/sortListDelete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteMonitor(HttpServletRequest request,String categoryId, String spuId) {
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		//String username = (String)request.getSession().getAttribute("username");
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("categoryId", categoryId);
		messageBody.put("spuId", spuId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(
					sortListBoxConfig.getSortList_path() + sortListBoxConfig.getSortList_SortListDestory(), signatureJson);
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
