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

import com.wangfj.wms.domain.entity.PageTemplate;
import com.wangfj.wms.domain.entity.ShopChannelsMql;
import com.wangfj.wms.service.IPageTemplateService;

/**
 * @Class Name ShopChannelsMqlController
 * @Author Administrator
 * @Create In 2013-9-27
 */
@Controller
@RequestMapping(value = "/pageTem")
public class PageTemplateController {

	
	@Autowired
	@Qualifier("pageTemplateService")
	private IPageTemplateService pageTemplateService;
	
	
	@ResponseBody
	@RequestMapping(value = {"/queryPageTem"},method = {RequestMethod.GET,RequestMethod.POST})
	public String queryPageTem(String sid, Model m,HttpServletRequest request,HttpServletResponse response){
		//JSONArray resultJson = new JSONArray();
		String result="";
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		try {
			List<PageTemplate> list = this.pageTemplateService.findAllTem();
			
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
	@RequestMapping(value = {"/queryPageTemByType"},method = {RequestMethod.GET,RequestMethod.POST})
	public String queryPageTemByType(String sid, Model m,HttpServletRequest request,HttpServletResponse response,String type){
		//JSONArray resultJson = new JSONArray();
		String result="";
		Map<String, Object> jsonMap = new HashMap<String, Object>();
		try {
			if(type==null){
				result="";
			}else{
				
				List<PageTemplate> list = this.pageTemplateService.findByType(Integer.valueOf(type));
				
				jsonMap.put("success", "true");
				jsonMap.put("list", list);
				result = JSONObject.fromObject(jsonMap).toString();
			}


			
		
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
	@RequestMapping(value = "/saveTemplates", method = {RequestMethod.GET, RequestMethod.POST})
	public String saveTemplates(HttpServletRequest request, HttpServletResponse response,String name,String page,String type){
		String json = "";
		System.out.println(name+"---"+page);
		PageTemplate tem=new PageTemplate();
		tem.setName(name);
		tem.setPage(page);
		tem.setType(Integer.valueOf(type));
		
		try {
			this.pageTemplateService.insertSelective(tem);
			json = "{\"success\":\"true\"}";
		} catch (Exception e) {
			json = "{\"success\":\"false\"}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateTemplates", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateTemplates(HttpServletRequest request, HttpServletResponse response,String name,String page,String sid,String type){
		String json = "";
		PageTemplate tem=new PageTemplate();
		tem.setName(name);
		tem.setPage(page);
		tem.setSid(Integer.valueOf(sid));
		tem.setType(Integer.valueOf(type));
		
		try {
			this.pageTemplateService.updateByPrimaryKeySelective(tem);
			json = "{\"success\":\"true\"}";
		} catch (Exception e) {
			json = "{\"success\":\"false\"}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delTemplates", method = {RequestMethod.GET, RequestMethod.POST})
	public String delTemplates(HttpServletRequest request, HttpServletResponse response,String sid){
		String json = "";
		try {
			this.pageTemplateService.deleteByPrimaryKey(Integer.valueOf(sid));
			json = "{\"success\":\"true\"}";
		} catch (Exception e) {
			json = "{\"success\":\"false\"}";
		}
		return json;
	}

}
