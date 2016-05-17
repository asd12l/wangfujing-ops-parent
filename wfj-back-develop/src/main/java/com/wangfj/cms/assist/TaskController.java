package com.wangfj.cms.assist;

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
import com.wangfj.back.util.HttpUtil;

@Controller
@RequestMapping(value="task")
public class TaskController {
	
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST, RequestMethod.GET })
	public String list(Model model, HttpServletRequest request, HttpServletResponse response,
			Integer pageNo) {
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null != pageNo && !"".equals(pageNo)){
			map.put("pageNo", pageNo);
		}
		try {
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/task/v_list.do", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return json.toString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.POST, RequestMethod.GET })
	public String save(HttpServletRequest request,HttpServletResponse response,
			String type,String name,String execycle,String intervalUnit,
			String dayOfMonth,String dayOfWeek,String hour,String minute,
			String intervalHour,String intervalMinute,String cronExpression,
			String enable,String remark,String jobClass){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("type", type);
		map.put("name", name);
		map.put("execycle", execycle);
		map.put("intervalUnit", intervalUnit);
		map.put("dayOfMonth", dayOfMonth);
		map.put("dayOfWeek", dayOfWeek);
		map.put("hour", hour);
		map.put("minute", minute);
		map.put("intervalHour", intervalHour);
		map.put("intervalMinute", intervalMinute);
		map.put("cronExpression", cronExpression);
		map.put("remark", remark);
		map.put("jobClass", jobClass);
		map.put("enabled", enable);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/task/o_save.do", map);
		}catch(Exception e){
			e.printStackTrace();
			json="{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/edit", method = { RequestMethod.POST, RequestMethod.GET })
	public String edit(HttpServletRequest request, HttpServletResponse response,
			String id,String type,String name,String execycle,String intervalUnit,
			String dayOfMonth,String dayOfWeek,String hour,String minute,
			String intervalHour,String intervalMinute,String cronExpression,
			String enable,String remark,String jobClass){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("id", id);
		map.put("type", type);
		map.put("name", name);
		map.put("execycle", execycle);
		map.put("intervalUnit", intervalUnit);
		map.put("dayOfMonth", dayOfMonth);
		map.put("dayOfWeek", dayOfWeek);
		map.put("hour", hour);
		map.put("minute", minute);
		map.put("intervalHour", intervalHour);
		map.put("intervalMinute", intervalMinute);
		map.put("cronExpression", cronExpression);
		map.put("remark", remark);
		map.put("jobClass", jobClass);
		map.put("enabled", enable);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/task/o_update.do", map);
		}catch(Exception e){
			e.printStackTrace();
			json="{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/del", method = { RequestMethod.POST, RequestMethod.GET })
	public String del(HttpServletRequest request, HttpServletResponse response,String id){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("id", id);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/task/o_delete.do", map);
		}catch(Exception e){
			e.printStackTrace();
			json="{'success':false}";
		}
		return json;
	}

}
