package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.ResultUtil;


/**
 * @Class Name BackUserController
 * @Author wwb
 * @Create In 2014-12-3
 */
@Controller
@RequestMapping(value = "/hotKey")
public class HotKeyController {
	/**
	 * 根据频道id获取频道下的热词
	 */
	@ResponseBody
	@RequestMapping(value = "/getChnHotKeys",method={RequestMethod.GET,RequestMethod.POST})
	public String getChnHotKeys(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		String chnId=request.getParameter("chnId");
		try {
			map.put("chnId", chnId);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/hotkey/list.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 根据频道id获取频道下热词的默认显示数量
	 */
	@ResponseBody
	@RequestMapping(value = "/getShowCount",method={RequestMethod.GET,RequestMethod.POST})
	public String getShowCount(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		String chnId=request.getParameter("chnId");
		try {
			map.put("chnId", chnId);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/hotkey/getShowCount.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 新增某个频道下的热词
	 * 	/admin/hotkey/new.json
	 */
	@ResponseBody
	@RequestMapping(value = "/addHotKey",method={RequestMethod.GET,RequestMethod.POST})
	public String addHotKey(HttpServletRequest request, HttpServletResponse response){
		String json="";
		JSONObject jo=new JSONObject();
		Map<String,Object> map = new HashMap<String,Object>();
		String chnId=request.getParameter("chnId");
		String hotWord=request.getParameter("hotWord");
		String sequence=request.getParameter("sequence");
		String valid=request.getParameter("valid");
		jo.put("sid", 0);
		jo.put("hotWord", hotWord);
		jo.put("sequence", sequence);
		jo.put("valid", valid);
		jo.put("chnId", chnId);
		String data="";
		try {
			//data="{\"sid\":0,\"hotWord\":"+hotWord+",\"sequence\":"+sequence+",\"valid\":"+valid+",\"chnId\":"+chnId+"}";
			map.put("data", jo.toString());
			//{"sid":0,"hotWord":"\u963f\u8fea\u8fbe\u65af","sequence":0,"valid":true,"chnId":165}
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/hotkey/new.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	/**
	 * 新增某个频道下的热词
	 * 	/admin/hotkey/new.json
	 */
	@ResponseBody
	@RequestMapping(value = "/updateHotKey",method={RequestMethod.GET,RequestMethod.POST})
	public String updateHotKey(HttpServletRequest request, HttpServletResponse response){
		String json="";
		JSONObject jo=new JSONObject();
		Map<String,Object> map = new HashMap<String,Object>();
		String sid=request.getParameter("sid");
		String chnId=request.getParameter("chnId");
		String hotWord=request.getParameter("hotWord");
		String sequence=request.getParameter("sequence");
		String valid=request.getParameter("valid");
		jo.put("sid", sid);
		jo.put("hotWord", hotWord);
		jo.put("sequence", sequence);
		jo.put("valid", valid);
		jo.put("chnId", chnId);
		try {
			map.put("data", jo.toString());
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/hotkey/update.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 删除热词
	 * 	/admin/hotkey/destroy.json
	 */
	@ResponseBody
	@RequestMapping(value = "/destroyHotKey",method={RequestMethod.GET,RequestMethod.POST})
	public String destroyHotKey(HttpServletRequest request, HttpServletResponse response){
		String json="";
		JSONObject jo=new JSONObject();
		Map<String,Object> map = new HashMap<String,Object>();
		String sid=request.getParameter("sid");
		jo.put("sid", sid);
		System.out.println(jo);
		try {
			map.put("data", jo.toString());
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/hotkey/destroy.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * /admin/hotkey/newShowCount.json
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/newShowCount",method={RequestMethod.GET,RequestMethod.POST})
	public String newShowCount(HttpServletRequest request, HttpServletResponse response){
		String json="";
		JSONObject jo=new JSONObject();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String chnId=request.getParameter("chnId");
			String count=request.getParameter("count");
			map.put("chnId", chnId);
			map.put("count", count);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/hotkey/newShowCount.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * /admin/hotkey/updateShowCount.json
	 */
	@ResponseBody
	@RequestMapping(value = "/updateShowCount",method={RequestMethod.GET,RequestMethod.POST})
	public String updateShowCount(HttpServletRequest request, HttpServletResponse response){
		String json="";
		JSONObject jo=new JSONObject();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String chnId=request.getParameter("chnId");
			String count=request.getParameter("count");
			map.put("chnId", chnId);
			map.put("count", count);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/hotkey/updateShowCount.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/suggestKeyList",method={RequestMethod.GET,RequestMethod.POST})
	public String suggestKeyList(HttpServletRequest request, HttpServletResponse response){
		String json="";
		JSONObject jo=new JSONObject();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String query=request.getParameter("query");
			if(query==null){
				query="";
			}
			//String count=request.getParameter("count");
			map.put("query", query);
			map.put("start", 0);
			map.put("limit", 50);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/suggestion/list.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/addSuggestKey",method={RequestMethod.GET,RequestMethod.POST})
	public String addSuggestKey(HttpServletRequest request, HttpServletResponse response){
		String json="";
		JSONObject jo=new JSONObject();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String query=request.getParameter("suggestKey");
			map.put("keyword", query);
			jo=JSONObject.fromObject(map);
			JSONObject jo2=new JSONObject();
			jo2.put("data", jo);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/suggestion/new.json", jo2);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/delSuggestKey",method={RequestMethod.GET,RequestMethod.POST})
	public String delSuggestKey(HttpServletRequest request, HttpServletResponse response){
		String json="";
		JSONObject jo=new JSONObject();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String query=request.getParameter("sid");
			map.put("sid", query);
			jo=JSONObject.fromObject(map);
			JSONObject jo2=new JSONObject();
			jo2.put("data", jo);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/suggestion/destroy.json", jo2);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
}
