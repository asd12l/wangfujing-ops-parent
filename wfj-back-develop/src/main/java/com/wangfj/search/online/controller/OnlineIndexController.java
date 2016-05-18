package com.wangfj.search.online.controller;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
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
import com.wangfj.search.utils.OnlineIndexConfig;
import com.wangfj.search.utils.RsaResource;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
/**
 * 线上索引管理
 * @Class Name OnlineIndexController
 * @Author litao
 * @Create In 2015年11月24日
 */
@Controller
@RequestMapping(value="/onlineIndex")
public class OnlineIndexController {
	
	private final Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private OnlineIndexConfig onlineIndexConfig;
	@Autowired
	private PrivateSignatureHandler signatureHandler;
	@Autowired
	private RsaResource rsaResource;
	/**
	 * 全量刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/allFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String allIndex(HttpServletRequest request,
			HttpServletResponse response) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		
		JSONObject messageBody = new JSONObject();
		
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getFullyIndex(),
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
	
	/**
	 * 刷新分类索引
	 */
	@ResponseBody
	@RequestMapping(value = "/categoryFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String categoryIndex(HttpServletRequest request,
			HttpServletResponse response, String categoryId, String channel) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("categoryId", categoryId);
		messageBody.put("channel", channel);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRefreshByCategory(),
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
	
	/**
	 * 根据品牌编码刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/brandFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String brandIndex(HttpServletRequest request,
			HttpServletResponse response, String brandId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("brandId", brandId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRefreshByBrand(),
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
	
	/**
	 * 根据品牌编码移除其下的专柜商品索引
	 */
	@ResponseBody
	@RequestMapping(value = "/removeBrand", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String removeBrandIndex(HttpServletRequest request,
			HttpServletResponse response, String brandId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		
		JSONObject messageBody = new JSONObject();
		messageBody.put("brandId", brandId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRemoveByBrand(),
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
	/**
	 * 根据SPU编码刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/spuFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String spuIndex(HttpServletRequest request,
			HttpServletResponse response, String spuId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		
		JSONObject messageBody = new JSONObject();
		messageBody.put("spuId", spuId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRefreshBySPU(),
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
	
	/**
	 * 根据SPU编码移除其下专柜商品索引
	 */
	@ResponseBody
	@RequestMapping(value = "/removeSpu", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String removeSpuIndex(HttpServletRequest request,
			HttpServletResponse response, String spuId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("spuId", spuId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRemoveBySPU(),
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
	
	/**
	 * 根据SKU编码刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/skuFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String skuIndex(HttpServletRequest request,
			HttpServletResponse response, String skuId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("skuId", skuId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRefreshBySKU(),
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
	
	/**
	 * 根据SKU编码移除其下专柜商品索引
	 */
	@ResponseBody
	@RequestMapping(value = "/removeSku", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String removeSkuIndex(HttpServletRequest request,
			HttpServletResponse response, String skuId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("skuId", skuId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRemoveBySKU(),
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
	
	/**
	 * 根据item编码刷新索引
	 */
	@ResponseBody
	@RequestMapping(value = "/itemFresh", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String itemIndex(HttpServletRequest request,
			HttpServletResponse response, String itemId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("itemId", itemId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRefreshItem(),
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
	
	/**
	 * 根据item编码移除专柜商品索引
	 */
	@ResponseBody
	@RequestMapping(value = "/removeItem", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String removeItemIndex(HttpServletRequest request,
			HttpServletResponse response, String itemId) {
		//String username = (String)request.getSession().getAttribute("username");
		//PrivateSignatureHandler handler = new PrivateSignatureHandler();
		signatureHandler.setPrivateKeyString(rsaResource.get());
		JSONObject messageBody = new JSONObject();
		messageBody.put("itemId", itemId);
		String signatureJson = null;
		try {
			signatureJson = signatureHandler.sign(messageBody, CookieUtil.getUserName(request));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String resultJson = null;
		try {
			resultJson = HttpRequester.httpPostString(onlineIndexConfig.getOnlinePath() + onlineIndexConfig.getRemoveItem(),
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
}
