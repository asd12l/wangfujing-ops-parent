package com.wangfj.search.online.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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
import com.wangfj.search.utils.HotWordConfig;
import com.wangfj.search.utils.HttpRequestException;
import com.wangfj.search.utils.HttpRequester;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;

/**
 * 热词管理接口
 * @Class Name HotWordController
 * @Author litao
 * @Create In 2015年12月22日
 */
@Controller
@RequestMapping(value="/hotWord")
public class SearchHotWordController {
	
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private HotWordConfig hotWordConfig;
	@Autowired
	private PrivateSignatureHandler privateSignatureHandler;
	@Autowired
	private RsaResource rsaResource;
	
	@ResponseBody
	@RequestMapping(value = "/getList", method = { RequestMethod.GET, RequestMethod.POST })
	public String getHotWordList(HttpServletRequest request, String hotWordSite, String hotWordChannel) {
		//String username = (String) request.getSession().getAttribute("username");
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (size == null || size == 0) {
			size = 10;
		}
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		int start = (currPage - 1) * size;
		JSONObject messageBody = new JSONObject();
		JSONObject messageBody1 = new JSONObject();
		if (StringUtils.isNotBlank(hotWordSite)) {
			messageBody.put("site", hotWordSite);
		}
		if (StringUtils.isNotBlank(hotWordChannel)) {
			messageBody.put("channel", hotWordChannel);
		}
		messageBody.put("limit", size);
		messageBody.put("start", start);
		String signatureJson = null;
		String signatureJson1 = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
			signatureJson1 = privateSignatureHandler.sign(messageBody1, CookieUtil.getUserName(request));
			
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		String resultStie = null;
		String resultChannel = null;
		try {
			resultJson = HttpRequester.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_read(),
					signatureJson);
			resultStie = HttpRequester.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_site(),
					signatureJson1);
			
			logger.info("站点列表："+ resultStie);
			logger.info("频道列表："+ resultChannel);
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
		JSONObject Json1 = JSONObject.parseObject(resultStie);
		JSONArray jsonHotWord = Json.getJSONArray("list");
		for(int i=0; i<jsonHotWord.size(); i++){
			for(int j=0; j < Json1.getJSONArray("list").size(); j++){
				if(Json1.getJSONArray("list").getJSONObject(j).getString("id").equals(jsonHotWord.getJSONObject(i).getString("site"))){
					jsonHotWord.getJSONObject(i).put("siteName", Json1.getJSONArray("list").getJSONObject(j).getString("name"));
					messageBody1.put("siteId", Json1.getJSONArray("list").getJSONObject(j).getString("id"));
					try {
						signatureJson1 = privateSignatureHandler.sign(messageBody1, CookieUtil.getUserName(request));
						resultChannel = HttpRequester.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_channel(),
								signatureJson1);
					} catch (IOException e) {
						e.printStackTrace();
					} catch (HttpRequestException e) {
						e.printStackTrace();
					} catch (URISyntaxException e) {
						e.printStackTrace();
					}
					JSONObject Json2 = JSONObject.parseObject(resultChannel);
					if(Json2.getBoolean("success")){
						for(int n=0; n < Json2.getJSONArray("list").size(); n++){
							if(Json2.getJSONArray("list").getJSONObject(n).getString("id").equals(jsonHotWord.getJSONObject(i).getString("channel"))){
								jsonHotWord.getJSONObject(i).put("channelName", Json2.getJSONArray("list").getJSONObject(n).getString("name"));
							}
						}
					}
				}
			}
			
			
		}
		Integer total = (Integer)Json.get("total");
		int pageCount = total % size == 0 ? total / size : (total / size + 1);
		Json.put("pageCount", pageCount);
		Json.put("list", jsonHotWord);
		logger.info("返回的热词列表："+ Json.toString());
		return Json.toString();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/queryListSite", method = { RequestMethod.GET, RequestMethod.POST })
	public String getSiteList(HttpServletRequest request) {
		//String username = (String) request.getSession().getAttribute("username");
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_site(),
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
	@RequestMapping(value = "/queryListChannel", method = { RequestMethod.GET, RequestMethod.POST })
	public String getChannelList(HttpServletRequest request, String siteId) {
		//String username = (String) request.getSession().getAttribute("username");
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("siteId", siteId);
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
			System.out.println("消息"+signatureJson);
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_channel(),
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
	@RequestMapping(value = "/deleteHotWord", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteHotWord(HttpServletRequest request, String sid, String site, String channel, String value, String link, String orders, String enabled) {
		//String username = (String) request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("site", site);
		messageBody.put("channel", channel);
		messageBody.put("value", value);
		messageBody.put("link", link);
		messageBody.put("orders", orders);
		messageBody.put("enabled", enabled);
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_destroy(), signatureJson);
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
	@RequestMapping(value = "/addHotWord", method = { RequestMethod.GET, RequestMethod.POST })
	public String addHotWord(HttpServletRequest request, String site, String channel, String value, String link, String orders,String enabled) {
		//String username = (String) request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("site", site);
		messageBody.put("channel", channel);
		messageBody.put("value", value);
		messageBody.put("link", link);
		messageBody.put("orders", orders);
		messageBody.put("enabled", enabled);
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester
					.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_create(), signatureJson);
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
	@RequestMapping(value = "/updateHotWord", method = { RequestMethod.GET, RequestMethod.POST })
	public String updateHotWord(HttpServletRequest request, String sid, String site, String channel, String value, String link, String orders,String enabled) {
		//String username = (String) request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("site", site);
		messageBody.put("channel", channel);
		messageBody.put("value", value);
		messageBody.put("link", link);
		messageBody.put("orders", orders);
		messageBody.put("enabled", enabled);
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester
					.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_update(), signatureJson);
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
	@RequestMapping(value = "/enabledHotWord", method = { RequestMethod.GET, RequestMethod.POST })
	public String enabledHotWord(HttpServletRequest request, String sid, String site, String channel, String value, String link, String orders,String enabled) {
		//String username = (String) request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		privateSignatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("sid", sid);
		messageBody.put("site", site);
		messageBody.put("channel", channel);
		messageBody.put("value", value);
		messageBody.put("link", link);
		messageBody.put("orders", orders);
		messageBody.put("enabled", enabled);
		String signatureJson = null;
		try {
			signatureJson = privateSignatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
		}
		String resultJson = null;
		try {
			if(enabled.equals("true")){
				resultJson = HttpRequester
						.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_disabled(), signatureJson);
			}else{
				resultJson = HttpRequester
						.httpPostString(hotWordConfig.getHot_word_path() + hotWordConfig.getHot_word_enabled(), signatureJson);
			}
			
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
