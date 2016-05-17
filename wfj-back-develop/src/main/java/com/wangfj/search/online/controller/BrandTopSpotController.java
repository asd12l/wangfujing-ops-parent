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
import com.wangfj.search.utils.BrandStickConfig;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.search.utils.HttpRequestException;
import com.wangfj.search.utils.HttpRequester;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
/**
 * 坑位
 * @Class Name BrandStick
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value = "/back")
public class BrandTopSpotController {
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private BrandStickConfig brandStickConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
	@ResponseBody
	@RequestMapping(value = "/brandStickList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllIntervalContent(HttpServletRequest request, String brandId, String spuId) {
		//String username = (String)request.getSession().getAttribute("username");
		signatureHandler.setPrivateKeyString(rsaResource.get());
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 5;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		logger.info(brandId);
		/*if(brandId==""||brandId==null){
			brandId = null;
		
		}else{
			String[] bid1 = brandId.split("-");
			brandId = bid1[1];
		}*/
		JSONObject messageBody = new JSONObject();
		messageBody.put("limit", size);
		messageBody.put("start", start);
		JSONObject position = new JSONObject();
		position.put("brandId", brandId);
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
			resultJson = HttpRequester.httpPostString(brandStickConfig.getBrand_path() + brandStickConfig.getBrand_read(),
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
	@RequestMapping(value = "/brandStickSelect", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateIntervalContent(HttpServletRequest request) {
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
			resultJson = HttpRequester.httpPostString(brandStickConfig.getBrand_path() + brandStickConfig.getBrand_list(),
					signatureJson);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
		} catch (HttpRequestException e) {
			logger.error(e.getMessage(), e);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		logger.info("品牌列表："+resultJson);
		return resultJson;
	}

	@ResponseBody
	@RequestMapping(value = "/brandStickSave", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveIntervalContent(HttpServletRequest request, String brandId, String spuId,String orders) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		System.out.println(brandId);
		if(brandId==""||brandId==null){
			brandId = null;
		
		}
		JSONObject messageBody = new JSONObject();
		messageBody.put("brandId", brandId);
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
			resultJson = HttpRequester.httpPostString(brandStickConfig.getBrand_path() + brandStickConfig.getBrand_create(),
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
	@RequestMapping(value = "/brandStickDelete", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteIntervalContent(HttpServletRequest request,String brandId, String spuId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("brandId", brandId);
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
					brandStickConfig.getBrand_path() + brandStickConfig.getBrand_destroy(),signatureJson);
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
