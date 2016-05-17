package com.wangfj.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	private static Logger log =  LoggerFactory.getLogger(MemberController.class);
	public static final String FROM_SYSTEM = "ORDERBACK";
	/**
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/selectPageMember")
	public String selectPageMember(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = "manage/member/list";
		Map  paramMap = new HashMap();
		if(request.getParameter("username")!=null&&!"".equalsIgnoreCase(request.getParameter("username"))){
			paramMap.put("username", request.getParameter("username"));
		}
		paramMap.put("start", request.getParameter("start"));
		paramMap.put("limit", request.getParameter("limit"));
		json = HttpUtil.HttpPost(CommonProperties.get("member_path"), doMethod, paramMap);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("/modifyMember")
	public String modifyMember(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = "manage/member/save";
		Map  paramMap = new HashMap();
		if(request.getParameter("sid")!=null&&!"".equalsIgnoreCase(request.getParameter("sid"))){
			paramMap.put("sid", request.getParameter("sid"));
		}
		if(request.getParameter("mobile")!=null&&!"".equalsIgnoreCase(request.getParameter("mobile"))){
			paramMap.put("mobile", request.getParameter("mobile"));
		}
		if(request.getParameter("delFlag")!=null&&!"".equalsIgnoreCase(request.getParameter("delFlag"))){
			paramMap.put("delFlag", request.getParameter("delFlag"));
		}

		json = HttpUtil.HttpPost(CommonProperties.get("member_path"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/getMemberInfo")
	public String getMemberInfo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = "manage/memberInfo/"+request.getParameter("memberSid");
		Map  paramMap = new HashMap();
		json = HttpUtil.HttpPost(CommonProperties.get("member_path"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/saveMemberInfo")
	public String saveMemberInfo(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = "manage/memberInfo/save";
		Map  paramMap = new HashMap();
		
		if(request.getParameter("sid")!=null&&!"".equalsIgnoreCase(request.getParameter("sid"))){
			paramMap.put("sid", request.getParameter("sid"));
		}
		if(request.getParameter("memberSid")!=null&&!"".equalsIgnoreCase(request.getParameter("memberSid"))){
			paramMap.put("memberSid", request.getParameter("memberSid"));
		}
		if(request.getParameter("question")!=null&&!"".equalsIgnoreCase(request.getParameter("question"))){
			paramMap.put("question", request.getParameter("question"));
		}
		if(request.getParameter("answer")!=null&&!"".equalsIgnoreCase(request.getParameter("answer"))){
			paramMap.put("answer", request.getParameter("answer"));
		}
		if(request.getParameter("nickName")!=null&&!"".equalsIgnoreCase(request.getParameter("nickName"))){
			paramMap.put("nickName", request.getParameter("nickName"));
		}
		if(request.getParameter("realName")!=null&&!"".equalsIgnoreCase(request.getParameter("realName"))){
			paramMap.put("realName", request.getParameter("realName"));
		}
		if(request.getParameter("birthdate")!=null&&!"".equalsIgnoreCase(request.getParameter("birthdate"))){
			paramMap.put("birthdate", request.getParameter("birthdate"));
		}
		if(request.getParameter("gender")!=null&&!"".equalsIgnoreCase(request.getParameter("gender"))){
			if("女".equalsIgnoreCase(request.getParameter("gender"))){
				paramMap.put("gender",1);
			}else{
				paramMap.put("gender",0);
			}
			
		}
		if(request.getParameter("profession")!=null&&!"".equalsIgnoreCase(request.getParameter("profession"))){
			paramMap.put("profession", request.getParameter("profession"));
		}
		if(request.getParameter("income")!=null&&!"".equalsIgnoreCase(request.getParameter("income"))){
			paramMap.put("income", request.getParameter("income"));
		}
		
		json = HttpUtil.HttpPost(CommonProperties.get("member_path"), doMethod, paramMap);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("/selectAddress")
	public String selectAddress(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = "manage/address/list";
		Map  paramMap = new HashMap();
		if(request.getParameter("memberSid")!=null&&!"".equalsIgnoreCase(request.getParameter("memberSid"))){
			paramMap.put("memberSid", request.getParameter("memberSid"));
		}

		json = HttpUtil.HttpPost(CommonProperties.get("member_path"), doMethod, paramMap);
		return json;
	}
	
	@ResponseBody
	@RequestMapping("/getAddress")
	public String getAddress(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = "manage/address/"+request.getParameter("sid");
		Map  paramMap = new HashMap();
		json = HttpUtil.HttpPost(CommonProperties.get("member_path"), doMethod, paramMap);
		return json;
	}
	@ResponseBody
	@RequestMapping("/saveAddress")
	public String saveAddress(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String doMethod = "manage/address/save";
		Map  paramMap = new HashMap();
		
		if(request.getParameter("sid")!=null&&!"".equalsIgnoreCase(request.getParameter("sid"))){
			paramMap.put("sid", request.getParameter("sid"));
		}
		if(request.getParameter("memberSid")!=null&&!"".equalsIgnoreCase(request.getParameter("memberSid"))){
			paramMap.put("memberSid", request.getParameter("memberSid"));
		}
		if(request.getParameter("province")!=null&&!"".equalsIgnoreCase(request.getParameter("province"))){
			paramMap.put("province", request.getParameter("province"));
		}
		if(request.getParameter("city")!=null&&!"".equalsIgnoreCase(request.getParameter("city"))){
			paramMap.put("city", request.getParameter("city"));
		}
		if(request.getParameter("area")!=null&&!"".equalsIgnoreCase(request.getParameter("area"))){
			paramMap.put("area", request.getParameter("area"));
		}
		if(request.getParameter("address")!=null&&!"".equalsIgnoreCase(request.getParameter("address"))){
			paramMap.put("address", request.getParameter("address"));
		}
		if(request.getParameter("mailCode")!=null&&!"".equalsIgnoreCase(request.getParameter("mailCode"))){
			paramMap.put("mailCode", request.getParameter("mailCode"));
		}
		if(request.getParameter("recipientName")!=null&&!"".equalsIgnoreCase(request.getParameter("recipientName"))){
			paramMap.put("recipientName", request.getParameter("recipientName"));
		}
		if(request.getParameter("telephone")!=null&&!"".equalsIgnoreCase(request.getParameter("telephone"))){
			paramMap.put("telephone", request.getParameter("telephone"));
		}
		if(request.getParameter("mobile")!=null&&!"".equalsIgnoreCase(request.getParameter("mobile"))){
			paramMap.put("mobile", request.getParameter("mobile"));
		}
		
		
		
		json = HttpUtil.HttpPost(CommonProperties.get("member_path"), doMethod, paramMap);
		return json;
	}
}
