package com.wfj.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.thoughtworks.xstream.alias.ClassMapper.Null;
import com.wangfj.cms.assist.AdvertisingController;
import com.wangfj.cms.utils.RequestUtils;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * Created by MaYong on 2015/11/24.
 * 会员信息相关controller
 */
@Controller
@RequestMapping("/mem")
public class MembersController {
	
	private static Logger log =  LoggerFactory.getLogger(MembersController.class);
	/**
	 * 用户信息查询
	 * 
	 * @param m
	 * @param pageNo
	 * @param request
	 * @Create In 2015-12-28 By WangWJ
	 * 
	 */
	@ResponseBody
	@RequestMapping(value ="/getByUsername", method = { RequestMethod.POST, RequestMethod.GET })
	public String getByUsername(HttpServletRequest request,
			HttpServletResponse response) {
		log.info("======== getByUsername in  =========");
		String method = "/member/getByUsername.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		//获取每页显示多少条数据
		Integer pageSize = 0;
		//获取当前页
		Integer currPage =Integer.parseInt(request.getParameter("page"));;
		pageSize = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (pageSize == null || pageSize == 0) {
			pageSize = 10;
		}
		int start = (currPage - 1) * pageSize;
		Map<Object, Object> paraMap = new HashMap<Object, Object>();
		paraMap.put("start", String.valueOf(start));
		paraMap.put("limit", String.valueOf(pageSize));
		paraMap.put("username", request.getParameter("username"));
		paraMap.put("mobile", request.getParameter("mobile"));
		paraMap.put("email", request.getParameter("email"));
		try {
			String url = CommonProperties.get("member_core_url");
			log.info("======== getByUsername url "+url+"  =========");
			System.err.println("============== member_core_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== getByUsername url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, paraMap);
		} catch (Exception e) {
			jsonString = "{success :false}";
		}
		return jsonString;
	}
	
	/**
	 * 根据邮箱重置密码
	 * 
	 * @param pageNo
	 * @param request
	 * @Create In 2016-1-7By WangWJ
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/editEmailPassword", method = { RequestMethod.POST, RequestMethod.GET })
	public String editEmailPassword(HttpServletRequest request, HttpServletResponse response){
		String json="";
		String method="/member/updateEmailPassword.do";
		long sid = Long.parseLong(request.getParameter("sid"));
		String email = request.getParameter("email");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sid", sid);
		map.put("email", email);
		try{
			String url = CommonProperties.get("member_core_url");
			json=HttpUtil.HttpPost(url,method, map);
		}catch(Exception e){
			json = "{success :false}";
			
		}
		return json;
	}
	
	/**
	 * 根据邮箱重置密码
	 * 
	 * @param pageNo
	 * @param request
	 * @Create In 2016-1-7 By WangWJ
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/editMobilePassword", method = { RequestMethod.POST, RequestMethod.GET })
	public String editMobilePassword(HttpServletRequest request, HttpServletResponse response){
		String json="";
		String method="/member/updateMobilePassword.do";
		long sid = Long.parseLong(request.getParameter("sid"));
		String mobile = request.getParameter("mobile");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("sid", sid);
		map.put("mobile",mobile );
		try{
			String url = CommonProperties.get("member_core_url");
			json=HttpUtil.HttpPost(url,method, map);
		}catch(Exception e){
			json = "{success :false}";
			
		}
		return json;
	}
	/**
	 * 用户注册周统计
	 * 
	 * @param pageNo
	 * @param request
	 * @Create In 2016-1-11 By WangWJ
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/getMemberRegister", method = { RequestMethod.POST, RequestMethod.GET })
	public String getMemberRegister(HttpServletRequest request, HttpServletResponse response){
		String json="";
		String method="/member/getMemberByWeek.do";
		String m_timeStartDate = request.getParameter("m_timeStartDate");
		String m_timeEndDate = request.getParameter("m_timeEndDate");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("m_timeStartDate", m_timeStartDate);
		map.put("m_timeEndDate", m_timeEndDate);
		JSONArray jsonArray = new JSONArray();
		JSONObject resultObject = new JSONObject();
		try{
			String url = CommonProperties.get("member_core_url");
			System.err.println("============== member_core_url:" + url);
			System.out.println("=============method:"+method);
			json=HttpUtil.HttpPost(url,method, map);
			JSONObject object = JSONObject.fromObject(json);
			jsonArray = object.getJSONArray("list");
		}catch(Exception e){
			json = "{success :false}";	
		}
		resultObject.put("list", jsonArray);
		return resultObject.toString();
	}
	
	/**
	 * 用户注册月统计
	 * 
	 * @param pageNo
	 * @param request
	 * @Create In 2016-1-11 By WangJW
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/getMemberByMonthMTime", method = { RequestMethod.POST, RequestMethod.GET })
	public String getMemberByMonthMTime(HttpServletRequest request, HttpServletResponse response){
		String json="";
		String method="/member/getMemberByMonthMTime.do";
		String m_timeStartDate = request.getParameter("m_timeStartDate");
		String m_timeEndDate = request.getParameter("m_timeEndDate");
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("m_timeStartDate", m_timeStartDate);
		map.put("m_timeEndDate", m_timeEndDate);
		JSONArray jsonArray = new JSONArray();
		JSONObject resultObject = new JSONObject();
		try{
			String url = CommonProperties.get("member_core_url");
			System.err.println("============== member_core_url:" + url);
			System.out.println("=============method:"+method);
			json=HttpUtil.HttpPost(url,method, map);
			JSONObject object = JSONObject.fromObject(json);
			jsonArray = object.getJSONArray("list");
		} catch(Exception e){
			json = "{success :false}";
			
		}
		resultObject.put("list", jsonArray);
		return resultObject.toString();
	}
	/**
	 * 查询有手机用户统计
	 * 
	 * @param m
	 * @param pageNo
	 * @param request
	 * @Create In 2016-1-15 By WangWJ
	 * 
	 */
	@ResponseBody
	@RequestMapping(value ="/getMemberByMobileAndQQ", method = { RequestMethod.POST, RequestMethod.GET })
	public String getMemberByMobileAndQQ(HttpServletRequest request,
			HttpServletResponse response) {
		String method = "/member/getMemberByMobileAndQQ.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		//获取每页显示多少条数据
		Integer pageSize = 0;
		//获取当前页
		Integer currPage =Integer.parseInt(request.getParameter("page"));;
		pageSize = request.getParameter("pageSize") == null ? null
				: Integer.parseInt(request.getParameter("pageSize"));
		if (pageSize == null || pageSize == 0) {
			pageSize = 10;
		}
		int start = (currPage - 1) * pageSize;
		Map<Object, Object> paraMap = new HashMap<Object, Object>();
		paraMap.put("start", String.valueOf(start));
		paraMap.put("limit", String.valueOf(pageSize));
		paraMap.put("username", request.getParameter("username"));
		paraMap.put("mobile", request.getParameter("mobile"));
		paraMap.put("email", request.getParameter("email"));
		try {
			String url = CommonProperties.get("member_core_url");
			log.info("======== getByUsername url "+url+"  =========");
			System.err.println("============== member_core_url:" + url);
			System.err.println("=============method:"+method);
			jsonString = HttpUtil.HttpPost(url,method, paraMap);
		} catch (Exception e) {
			jsonString = "{success :false}";
		}
		return jsonString;
	}
}

