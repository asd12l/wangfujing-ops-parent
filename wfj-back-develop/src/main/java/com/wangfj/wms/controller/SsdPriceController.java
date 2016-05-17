package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;

@Controller
@RequestMapping(value = "/price")
public class SsdPriceController {
	/***
	 * 商品模块-商品信息管理-价格管理-查询所有
	 * @Methods Name selectAllPrices
	 * @Create In 2015-3-22 By wangsy
	 * @param supplySid
	 * @param shopSid
	 * @param productName
	 * @param productSku
	 * @param start
	 * @param pageSize
	 * @return String
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/selectAllPrices",method={RequestMethod.GET,RequestMethod.POST})
	public String selectAllPrices(HttpServletRequest request, HttpServletResponse response,
			String supplySid,String shopSid,String productName,String productSku){
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		try{
			Map map = new HashMap();
			if( StringUtils.isNotEmpty(supplySid)){
				map.put("supplySid", supplySid);
			}
			if(StringUtils.isNotEmpty(shopSid)){
				map.put("shopSid", shopSid);	
			}
			if( StringUtils.isNotEmpty(productName)){
				map.put("productName", productName);
			}			
			if(StringUtils.isNotEmpty(productSku)){
				map.put("productSku", productSku);
			}
			map.put("start", start);
			map.put("limit",size);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/selectAllPrices.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	/**
	 * 更新价格
	 * @Methods Name updateStockSearch
	 * @Create In 2015-3-22 By chengsj
	 * @param sid
	 * @param originalPrice
	 * @param currentPrice
	 * @param promotionPrice
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/updatePrice",method={RequestMethod.GET,RequestMethod.POST})
	public String updatePrice(String sid,String originalPrice,String currentPrice,String promotionPrice){
    	String result="";
    	try{
    	Map map = new HashMap();
    	if(StringUtils.isNotEmpty(sid)){
			map.put("sid", sid);
		}
    	if(StringUtils.isNotEmpty(originalPrice)){
			map.put("originalPrice", originalPrice);
		}
    	if(StringUtils.isNotEmpty(currentPrice)){
			map.put("currentPrice", currentPrice);
		}
    	if(StringUtils.isNotEmpty(promotionPrice)){
			map.put("promotionPrice", promotionPrice);
		}
		result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/updatePrice.html",map);
    	}catch(Exception e){
    		result = "{success :false}";
    	}
		return result;
	}
}
