package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;

@Controller
@RequestMapping(value = "/storeDisplay")
public class ShopStoreDisplayController {
	
	/**
	 * 根据SID获取信息
	 * @Methods Name getChannelByChannelById
	 * @Create In 2015-4-20 By wangsy
	 * @param sid
	 * @return String
	 */
	@RequestMapping(value = "/getShopStoreById/{id}",method={RequestMethod.GET,RequestMethod.POST})
	public String getShopStoreById(@PathVariable("id") String id,Model m, HttpServletRequest request){
		JSONObject jsons = new JSONObject();
		String json = "";
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			if( null !=id || "".equals(id)){
				map.put("sid", id);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/getShopStoreById.html", map);
			jsons = JSONObject.fromObject(json);
			m.addAttribute("sid", id);
			m.addAttribute("json", jsons);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return "forward:/jsp/ShopStoreNode/editShopStoreNode.jsp";  
	}
	
	/**
	 * 校验门店是否存在
	 * @Methods Name queryShopExists
	 * @Create In 2015-3-24 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryShopExists",method={RequestMethod.GET,RequestMethod.POST})
	public String queryShopExists(HttpServletRequest request, HttpServletResponse response){
		
		String success ="";
		
		String shopName = request.getParameter("shopName");		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("shopName", shopName);		
		try {
			success = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryShopExists.json", map);
		} catch (Exception e) {
			e.printStackTrace();
			success = "";
		}
		
		return success;
	}
	/**
	 * 商品模块-卖场信息管理-门店管理-查询所有门店
	 * @Methods Name querySupplier
	 * @Create In 2015-4-17 By wangsy
	 * @param start
	 * @param shopName
	 * @param pageSize
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectAllStore",method={RequestMethod.GET,RequestMethod.POST})
	public String querySupplier(HttpServletRequest request, HttpServletResponse response,String shopName){
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			if(!( null ==shopName || "".equals(shopName))){
				map.put("shopName", shopName);
			}
			map.put("start",start);
			map.put("limit",size);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllStore.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
	/**
	 * 添加或修改门店
	 * @Methods Name insertOrUpdate
	 * @Create In 2015-4-21 By wangsy
	 * @param supplySid
	 * @param username
	 * @param sid
	 * @param shopName
	 * @param address
	 * @param contactPerson
	 * @param phone
	 * @param mailbox
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/insertOrUpdateStore",method={RequestMethod.GET,RequestMethod.POST})
	public String insertOrUpdate(String supplySid,String username,String sid,String shopName,String address,String contactPerson,String phone,String mailbox){
		String json = "";
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			if(StringUtils.isNotEmpty(sid)){
				map.put("sid", sid);	
			}
			map.put("phone",phone);
			map.put("mailbox",mailbox);
			map.put("shopName", shopName);
			map.put("address",address);
			map.put("contactPerson",contactPerson);
			map.put("userName",username);
			if(StringUtils.isNotEmpty(supplySid)){
				map.put("supplySid", supplySid);	
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/insertOrUpdateShopStore.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value="/deleteStore",method={RequestMethod.GET,RequestMethod.POST})
	public String insertOrUpdate(String sid){
		String json = "";
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("sid", sid);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/deleteShopStore.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
}
