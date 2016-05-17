package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;


@Controller
public class SsdCategoryVluesDictController {
	
	@ResponseBody
	@RequestMapping(value = "/valuesdict/list", method = {RequestMethod.POST,RequestMethod.GET})
	public String list(Model model,HttpServletRequest request,HttpServletResponse response,
			String page,String rows,String valuesName){
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if(null !=page & !"".equals(page)){
			map.put("page", page);
		}
		if(null != rows & !"".equals(rows)){
			map.put("rows",rows);
		}
		if(null !=valuesName & !"".equals(valuesName)){
			map.put("valuesName",valuesName);
		}
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/valuesdictList.json", map);
		}catch(Exception e){
			
		}finally{
			
		}
		return json;
		
	}
		
		

	@ResponseBody
	@RequestMapping(value = "/valuesdict/add", method = RequestMethod.POST)
	public String add(Model m, HttpServletRequest request,String sid,
			HttpServletResponse response,String id,String valuesName,
			String valuesDesc, String valuesCode,String status,String channelSid) {
		String json = null;
		Map<String, Object> map = new HashMap<String, Object>();
		if(null !=sid & !"".equals(sid)){
			map.put("sid", sid);
		}
		if(null != id & !"".equals(id)){
			map.put("id", id);
		}
		if(null !=valuesName & !"".equals(valuesName)){
			map.put("valuesName",valuesName);
		}
		if(null != valuesDesc & !"".equals(valuesDesc)){
			map.put("valuesDesc",valuesDesc);
		}
		if(null !=valuesCode & !"".equals(valuesCode)){
			map.put("valuesCode", valuesCode);
		}
		if(null !=status & !"".equals(status)){
			map.put("status", status);
		}
		if(null!= channelSid & !"".equals(channelSid)){
			map.put("channelSid",channelSid);
		}
		
		try{
		json =	HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/valuesdictAdd.json", map);
		}catch(Exception e){
			
		}finally{
			
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/valuesdict/edit", method = {RequestMethod.POST,RequestMethod.GET})
	public String edit(Model m, HttpServletRequest request,
			HttpServletResponse response,String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if(null != id & !"".equals(id)){
			map.put("id", id);
		}
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,"/bw/valuesdictEdit.json", map);
		}catch(Exception e){}finally{
			
		}
		return json ;
	}
	
	@ResponseBody
	@RequestMapping(value = "/valuesdict/del", method = RequestMethod.POST)
	public String del(Model m, HttpServletRequest request,
			HttpServletResponse response,String id) {
		String json  = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if(null != id & !"".equals(id)){
			map.put("id", id);
		}
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,"/bw/valuesdictEdit.json", map);
		}catch(Exception e)
		{}
		finally{
			
		}
		return json;
	}
	
	

	@ResponseBody
	@RequestMapping(value = "/valuescombox/list", method = {RequestMethod.POST,RequestMethod.GET})
	public String comboxlist(Model model,HttpServletRequest request,HttpServletResponse response,String id){
		String json= "";
		Map<String, Object> map = new HashMap<String, Object>();
		if(null != id & !"".equals(id)){
			map.put("id", id);
		}
		try{
			json = HttpUtil.HttpPostForJson(SystemConfig.SSD_SYSTEM_URL, "/bw/valuescomboxList.json", map);
		}catch(Exception e){
			
		}finally{
			
		}
		return json;
	}
	
	/**
	 * 属性值列表
	 * 
	 * @Methods Name comboxvlist
	 * @Create In 2015年8月7日 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/valuesbox/list", method = {RequestMethod.POST,RequestMethod.GET})
	public String comboxvlist(Model model,HttpServletRequest request,HttpServletResponse response,String sid){
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if(null !=sid & !"".equals(sid)){
			map.put("sid", sid);
		}
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/valuesdictcontroller/bw/valuesboxList.htm", map);
		}catch(Exception e){
			
		}finally{
			
		}
		
        return json;
	}

}
