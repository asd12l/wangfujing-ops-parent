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
@RequestMapping(value="/supplyBrandShop")
public class SupplyBrandShopController {
	
	/**
	 * 校验供应商门店品牌对应关系是否存在
	 * @Methods Name querySupplyBrandShopExists
	 * @Create In 2015-3-24 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/querySupplyBrandShopExists",method={RequestMethod.GET,RequestMethod.POST})
	public String querySupplyBrandShopExists(HttpServletRequest request, HttpServletResponse response){
		
		String success ="";
		
		String shopSid = request.getParameter("shopSid");
		String supplySid = request.getParameter("supplySid");
		String brandSid = request.getParameter("brandSid");
		Map<String,Object> map = new HashMap<String,Object>();
		if(StringUtils.isNotEmpty(brandSid)){
			map.put("brandSid", brandSid);
		}
		if(StringUtils.isNotEmpty(shopSid)){
			map.put("shopSid", shopSid);
		}
		if(StringUtils.isNotEmpty(supplySid)){
			map.put("supplySid", supplySid);
		}
		
		try {
			success = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/querySupplyBrandShopExists.json", map);
		} catch (Exception e) {
			e.printStackTrace();
			success = "";
		}
		
		return success;
	}
	/**
	 * 根据供应商ID获取门店列表
	 * @Methods Name getShopInfosBySupply
	 * @Create In 2015-3-12 By chengsj
	 * @param request
	 * @param response
	 * @param supplySid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getShopInfosBySupply",method={RequestMethod.GET,RequestMethod.POST})
	public String getShopInfosBySupply(HttpServletRequest request, HttpServletResponse response,String supplySid){
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(StringUtils.isNotEmpty(supplySid)){
			map.put("supplySid", supplySid);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/getShopInfosBySupply.json", map);
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}
		return json;
	}
	
	/**
	 * 商品模块-卖场信息管理-供应商门店品牌关联管理-查询所有
	 * @Methods Name queryAllSupplyBrandShop
	 * @Create In 2015-4-17 By wangsy
	 * @param supplyName
	 * @param page
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/selectAllSupplyBrandShop",method={RequestMethod.GET,RequestMethod.POST})
	public String queryAllSupplyBrandShop(HttpServletRequest request, HttpServletResponse response,String supplyName){
		String json="";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		try {
			Map<String,Object> map=new HashMap<String, Object>();
			if( null !=supplyName || "".equals(supplyName)){
				map.put("supplyName", supplyName);
			}
			map.put("start",start);
			map.put("limit",size);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllSupplyBrandShop.html", map);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectSupplyBrandShopBySid",method={RequestMethod.GET,RequestMethod.POST})
	public String getBySid(String sid){
		String json = "";
		try{
			Map map = new HashMap();
			if( null !=sid || "".equals(sid)){
				map.put("sid", sid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/querySupplyBrandShopBySid.json", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteSupplyBrandShop",method={RequestMethod.GET,RequestMethod.POST})
	public String deleteSupplyBrandShop(String sid){
		String result = "";
		try {
			Map map = new HashMap();
			if(null!=sid || !"".equals(sid)){
				map.put("sid", sid);
			}
			result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,"/bw/deleteSupplyBrandShop.html", map);
		} catch (Exception e) {
			result = "{success :false}";
		}
		if(null == result || "".equals(result)){
    		result = "{success: false}";
    	}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectAllShop",method={RequestMethod.GET,RequestMethod.POST})
	public String queryAllShop(){
		String json = "";
		try{
			Map map = new HashMap();
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllShops.json", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectAllBrands",method={RequestMethod.GET,RequestMethod.POST})
	public String queryAllBrands(){
		String json = "";
		try{
			Map map = new HashMap();
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllBrands.json", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value="/updataSupplyBrandShop",method={RequestMethod.GET,RequestMethod.POST})
	public String updateStockSearch(String sid,String supplySid,String brandSid,String shopSid,String netBit){
		String result="";
    	try{
	    	Map map = new HashMap();
	    	if(null!= sid || !"".equals(sid)){
				map.put("sid", sid);
			}
	    	if(null!= supplySid || !"".equals(supplySid)){
				map.put("supplySid", supplySid);
			}
	    	if(null!= brandSid || !"".equals(brandSid)){
				map.put("brandSid", brandSid);
			}
	    	if(null!= shopSid || !"".equals(shopSid)){
				map.put("shopSid", shopSid);
			}
	    	if(null!= netBit || !"".equals(netBit)){
				map.put("netBit", netBit);
			}
	    	result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/updataSupplyBrandShop.html", map);
    	}catch(Exception e){
    		result = "{success :false}";
    	}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping(value="/insertSupplyBrandShop",method={RequestMethod.GET,RequestMethod.POST})
	public String insertSupplyBrandShop(String supplySid,String brandSid,String shopSid,String netBit){
		String result="";
    	try{
	    	Map map = new HashMap();
	    	if(null!= supplySid || !"".equals(supplySid)){
				map.put("supplySid", supplySid);
			}
	    	if(null!= brandSid || !"".equals(brandSid)){
				map.put("brandSid", brandSid);
			}
	    	if(null!= shopSid || !"".equals(shopSid)){
				map.put("shopSid", shopSid);
			}
	    	if(null!= netBit || !"".equals(netBit)){
				map.put("netBit", netBit);
			}
	    	result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/insertSupplyBrandShop.html", map);
    	}catch(Exception e){
    		result = "{success :false}";
    	}
		return result;	
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectAllSupply3",method={RequestMethod.GET,RequestMethod.POST})
	public String getAllSupply3(){
		String json = "";
		try{
			Map map = new HashMap();
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllSupply3.json", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
}
