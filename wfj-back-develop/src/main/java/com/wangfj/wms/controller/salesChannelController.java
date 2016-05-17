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
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.ResultUtil;
@Controller
@RequestMapping(value = "/ChannelDisplay")
public class salesChannelController {
	
	/**
	 * 根据渠道SID获取信息
	 * @Methods Name getChannelByChannelById
	 * @Create In 2015-4-20 By wangsy
	 * @param sid
	 * @return String
	 */
	@RequestMapping(value = "/getChannelByChannelById/{id}",method={RequestMethod.GET,RequestMethod.POST})
	public String getChannelByChannelById(@PathVariable("id") String id,Model m, HttpServletRequest request){
		JSONObject jsons = new JSONObject();
		String json = "";
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			if( null !=id || "".equals(id)){
				map.put("sid", id);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/Channel/getChannelByChannelById.html", map);
			jsons = JSONObject.fromObject(json);
			m.addAttribute("sid", id);
			m.addAttribute("json", jsons);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return "forward:/jsp/salesChannel/editSalesChannelNode.jsp";  
	}
	
	/**
	 * 添加销售渠道-名称验证是否重复
	 * @Methods Name getChannelByChannelName
	 * @Create In 2015-3-23 By wangsy
	 * @param channelName
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getChannelByChannelName",method={RequestMethod.GET,RequestMethod.POST})
	public String getChannelByChannelName(String channelName){
		String json = "";
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			if( null !=channelName || "".equals(channelName)){
				map.put("channelName", channelName);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/Channel/getChannelByChannelName.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
	/**
	 * 查询所有渠道
	 * @Methods Name selectAllChannel
	 * @Create In 2015-3-23 By chengsj
	 * @param channelName
	 * @param pageSize
	 * @param start
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectAllChannel",method={RequestMethod.GET,RequestMethod.POST})
	public String selectAllChannel(HttpServletRequest request, HttpServletResponse response,String channelName){
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			if( null !=channelName || "".equals(channelName)){
				map.put("channelName", channelName);
			}
			map.put("start",start);
			map.put("limit",size);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/Channel/AllChannel.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
	/**
	 * 添加渠道
	 * @Methods Name addChannel
	 * @Create In 2015-3-23 By chengsj
	 * @param channelName
	 * @param isLeaf1
	 * @param sid
	 * @param un
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addChannel",method={RequestMethod.GET,RequestMethod.POST})
	public String addChannel(String channelName, String isLeaf1,String sid,String un){
		String json = "";
		try{
			Map<String ,Object> map = new HashMap<String ,Object> ();
			map.put("channelName", channelName);
			map.put("status", isLeaf1);
			map.put("userName", un);
			if( null !=sid ||"".equals(sid)){
				map.put("sid", sid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/Channel/Save.html", map);
		}catch(Exception e){
			json =  ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 删除渠道
	 * @Methods Name delChannel
	 * @Create In 2015-3-23 By chengsj
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteChannel",method={RequestMethod.GET,RequestMethod.POST})
	public String delChannel(String sid){
		String json="";
		try{
			Map<String,Object> map = new HashMap<String,Object>();
			if( null !=sid ||"".equals(sid)){
				map.put("sid", sid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/Channel/del.html", map);
		}catch(Exception e){
			json =  ResultUtil.createFailureResult(e);
		}
		return json;
	}
}

