/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerShopChannelsMqlController.java
 * @Create By Administrator
 * @Create In 2013-9-27 上午1:43:29
 * TODO
 */
package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.wms.domain.entity.ShopChannelsMql;
import com.wangfj.wms.service.IShopChannelsMqlService;

/**
 * @Class Name ShopChannelsMqlController
 * @Author Administrator
 * @Create In 2013-9-27
 */
@Controller
@RequestMapping(value = "/mqlchannels")
public class ShopChannelsMqlController {

	
	@Autowired
	@Qualifier(value = "shopChannelsMqlService")
	private IShopChannelsMqlService shopchannelsMqlService;
	@ResponseBody
	@RequestMapping(value = {"/queryChannels"},method = {RequestMethod.GET,RequestMethod.POST})
	public String queryRules(String sid, Model m,HttpServletRequest request,HttpServletResponse response){
		//JSONArray resultJson = new JSONArray();
		String result="";
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		try {
			List<ShopChannelsMql> list = this.shopchannelsMqlService.findChannels();
			
			jsonMap.put("success", "true");
	        jsonMap.put("list", list);
	        result = JSONObject.fromObject(jsonMap).toString();


			
		
		} catch (Exception e) {
			e.printStackTrace();
			ShopChannelsMql list= new ShopChannelsMql();
				jsonMap.put("success", "false");
		        jsonMap.put("list",list);
				
		        result = JSONObject.fromObject(jsonMap).toString();
			
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveShopChannels", method = {RequestMethod.GET, RequestMethod.POST})
	public String saveShopChannels(HttpServletRequest request, HttpServletResponse response,String flag,String name,String displayName,String channelDesc,String seq,String pageTemplateSid,String isShow){
		
		String json = "";
		ShopChannelsMql channels= new ShopChannelsMql();
		if(channelDesc!=null&&!"".equals(channelDesc)){
			channels.setChannelDesc(channelDesc);
		}
		if(displayName!=null&&!"".equals(displayName)){
			
			channels.setDisplayName(displayName);
		}
		if(flag!=null&&!"".equals(flag)){
			
			channels.setFlag(Integer.valueOf(flag));
		}
		if(isShow!=null&&!"".equals(isShow)){
			
			channels.setIsShow(Integer.valueOf(isShow));
		}
		if(name!=null&&!"".equals(name)){
			
			channels.setName(name);
		}
		if(pageTemplateSid!=null&&!"".equals(pageTemplateSid)){
			
			channels.setPageTemplateSid(Integer.valueOf(pageTemplateSid));
		}
		if(seq!=null&&!"".equals(seq)){
			
			channels.setSeq(seq);
		}
		try {
			this.shopchannelsMqlService.saveShopChannels(channels);
			json = "{'success':true}";
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateShopChannels", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateShopChannels(HttpServletRequest request, HttpServletResponse response,String flag,String name,String displayName,String sid,String channelDesc,String seq,String pageTemplateSid,String isShow){
		
		String json = "";
		ShopChannelsMql channels= new ShopChannelsMql();
		if(sid!=null&&!"".equals(sid)){
			
			channels.setSid(Integer.valueOf(sid));
		}
		if(channelDesc!=null&&!"".equals(channelDesc)){
			channels.setChannelDesc(channelDesc);
		}
		if(displayName!=null&&!"".equals(displayName)){
			
			channels.setDisplayName(displayName);
		}
		if(flag!=null&&!"".equals(flag)){
			
			channels.setFlag(Integer.valueOf(flag));
		}
		if(isShow!=null&&!"".equals(isShow)){
			
			channels.setIsShow(Integer.valueOf(isShow));
		}
		if(name!=null&&!"".equals(name)){
			
			channels.setName(name);
		}
		if(pageTemplateSid!=null&&!"".equals(pageTemplateSid)){
			
			channels.setPageTemplateSid(Integer.valueOf(pageTemplateSid));
		}
		if(seq!=null&&!"".equals(seq)){
			
			channels.setSeq(seq);
		}
		try {
			this.shopchannelsMqlService.updateShopChannels(channels);
			json = "{'success':true}";
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delShopChannels", method = {RequestMethod.GET, RequestMethod.POST})
	public String delShopChannels(HttpServletRequest request, HttpServletResponse response,String flag,String name,String displayName,String sid,String channelDesc,String seq,String pageTemplateSid){
		
		String json = "";
		try {
			this.shopchannelsMqlService.deleteByPrimaryKey(Integer.valueOf(sid));
			json = "{'success':true}";
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

}
