package com.wfj.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;


/**
 * Created by MaYong on 2015/11/24.
 */
@Controller
@RequestMapping("/memLogin")
public class MemberLoginController {
	
	private static final Logger logger = LoggerFactory
			.getLogger(MemberLoginController.class);

	/**
	 * 登录日志分页查询
	 * 
	 * @param m
	 * @param pageNo
	 * @param request
	 */
	@ResponseBody
	@RequestMapping(value="/getLoginLogList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getLoginLogList(HttpServletRequest request,
			HttpServletResponse response) {
		String method = "/mem_login/MemberloginLog.do";
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
		
		paraMap.put("mobile_input", request.getParameter("mobile_input"));
		paraMap.put("email_input", request.getParameter("email_input"));
		paraMap.put("loginchannel_input", request.getParameter("loginchannel_input"));
		
		paraMap.put("username", request.getParameter("username"));
		paraMap.put("loginTimeStartDate", request.getParameter("loginTimeStartDate"));
		paraMap.put("loginTimeEndDate", request.getParameter("loginTimeEndDate"));
		try {
			String url = CommonProperties.get("member_ops_url");
			System.err.println("============== member_ops_url:" + url);
			System.out.println("=============method:"+method);
			jsonString = HttpUtil.HttpPost(url,method, paraMap);
			logger.info("jsonString:"+jsonString);

		} catch (Exception e) {
			jsonString = "{success :false}";
		}
		return jsonString;
	}
	
	/**
	 * 第三方渠道下拉选字段查询
	 * 
	 * @param m
	 * @param pageNo
	 * @param request
	 */
	@ResponseBody
	@RequestMapping(value="/getLoginLogList1", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getLoginLogList1(HttpServletRequest request,
			HttpServletResponse response) {
		String method = "/mem_login/MemberloginLog1.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		
		Map<Object, Object> paraMap = new HashMap<Object, Object>();
		
		paraMap.put("loginchannel_input", request.getParameter("loginchannel_input"));

		try {
			String url = CommonProperties.get("member_ops_url");
			System.err.println("============== member_ops_url:" + url);
			System.out.println("=============method:"+method);
			jsonString = HttpUtil.HttpPost(url,method, paraMap);
			logger.info("jsonString:"+jsonString);
		} catch (Exception e) {
			jsonString = "{success :false}";
		}
		return jsonString;
	}
	
	
	/**
	 * 用户活跃度
	 * 
	 * @param m
	 * @param pageNo
	 * @param request
	 */
	@ResponseBody
	@RequestMapping(value="/getMemberActive", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getMemberActive(HttpServletRequest request,
			HttpServletResponse response) {
		String method = "/mem_login/getMemberActive.do";
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
		paraMap.put("loginTimeStartDate", request.getParameter("loginTimeStartDate"));
		paraMap.put("loginTimeEndDate", request.getParameter("loginTimeEndDate"));
		try {
			String url = CommonProperties.get("member_core_url");
			System.err.println("============== member_core_url:" + url);
			System.out.println("=============method:"+method);
			jsonString = HttpUtil.HttpPost(url,method, paraMap);
			logger.info("jsonString:"+jsonString);

		} catch (Exception e) {
			jsonString = "{success :false}";
		}
		return jsonString;
	}
}
