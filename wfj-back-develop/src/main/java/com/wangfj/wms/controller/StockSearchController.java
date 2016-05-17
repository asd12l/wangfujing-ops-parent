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
import com.framework.page.Page;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;

@Controller
@RequestMapping(value = "/stockSearch")
public class StockSearchController {
	
	/**
	 * 商品模块-商品信息管理-库存管理-查询所有
	 * @Methods Name queryAllStockType
	 * @Create In 2015-4-17 By wangsy
	 * @param request
	 * @param response
	 * @param supplySid
	 * @param shopSid
	 * @param stockTypeSid
	 * @param productDetailSid
	 * @param productSku
	 * @return String
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/selectAllStockSearch",method={RequestMethod.GET,RequestMethod.POST})
	public String queryAllStockType(HttpServletRequest request, HttpServletResponse response,
			String supplySid,String shopSid,String stockTypeSid,
			String productDetailSid, String productSku){
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
			if( StringUtils.isNotEmpty(shopSid)){
				map.put("shopSid", shopSid);	
			}
			if( StringUtils.isNotEmpty(stockTypeSid)){
				map.put("stockTypeSid", stockTypeSid);
			}
			if( StringUtils.isNotEmpty(productDetailSid)){
				map.put("productDetailSid", productDetailSid);
			}
			if( StringUtils.isNotEmpty(productSku)){
				map.put("productSku", productSku);
			}
			map.put("start", start);
			map.put("limit", size);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllStockSearch.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectAllStockType",method={RequestMethod.GET,RequestMethod.POST})
	public String StockType(Page page){
		String json = "";
		try{
			Map map = new HashMap();
			map.put("Page_", page);
			map.put("start", page.getStartRecords());
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryStockType.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteStockSearch",method={RequestMethod.GET,RequestMethod.POST})
	public String deleteStockSearc(String sid){
    	String result = "";
    	String s_  = "";
    	try{
    		Map map = new HashMap();
    		if(null!= sid || !"".equals(sid)){
    			map.put("sid", sid);
    		}
    		result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,"/bw/deleteStockSearch.html", map);
    	}catch(Exception e){
    		result = "{success :false}";
    	}
    	if(null == result || "".equals(result)){
    		result = "{success: false}";
    	}
    	return result;
	}
	@ResponseBody
	@RequestMapping(value="selectStockBySid",method={RequestMethod.GET,RequestMethod.POST})
	public String selectStockBySid(String sid){
		String result="";
		try {
			Map map = new HashMap();
			if(null!=sid || !"".equals(sid)){
				map.put("sid", sid);
			}
			result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/selectStockBySid", map);
		} catch (Exception e) {
			result = "{success :false}";
		}
		return result;
	}
	@ResponseBody
	@RequestMapping(value="/updataStockSearch",method={RequestMethod.GET,RequestMethod.POST})
	public String updateStockSearch(String sid,String proSum){
    	String result="";
    	try{
    	Map map = new HashMap();
    	if(null!= sid || !"".equals(sid)){
			map.put("sid", sid);
		}
    	if(null!= proSum || !"".equals(proSum)){
			map.put("proSum", proSum);
		}
		result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/updataStockSearch.html",map);
    	}catch(Exception e){
    		result = "{success :false}";
    	}
		return result;
	}
	
}
