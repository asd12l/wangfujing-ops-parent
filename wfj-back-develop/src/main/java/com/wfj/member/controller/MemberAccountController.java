package com.wfj.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;

/**
 * Created by WangJW on 2016/3/2.
 * 会员信息相关controller
 */
@Controller
@RequestMapping("/memberAccount")
public class MemberAccountController {

	private static Logger log =  LoggerFactory.getLogger(MemberAccountController.class);
	/**
	 * 积分记录
	 * 
	 * @param m
	 * @param pageNo
	 * @param request
	 * @Create In 2016-3-2 By WangWJ
	 * 
	 */
	@ResponseBody
	@RequestMapping(value ="/getByMemberIntegral", method = { RequestMethod.POST, RequestMethod.GET })
	public String getByMemberIntegral(HttpServletRequest request,
			HttpServletResponse response) {
		log.info("======== getByMemberIntegral in  =========");
		String method = "/memberAcc/getByMemberIntegral.do";
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
		paraMap.put("identity_card_no", request.getParameter("identity_card_no"));
		paraMap.put("m_timeStartDate",  request.getParameter("m_timeStartDate"));
		paraMap.put("m_timeEndDate",  request.getParameter("m_timeEndDate"));
		try {
			String url = CommonProperties.get("member_core_url");
			log.info("======== getByMemberIntegral url "+url+"  =========");
			System.err.println("============== member_core_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== getByMemberIntegral url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, paraMap);
		} catch (Exception e) {
			jsonString = "{success :false}";
		}
		return jsonString;
	}
	
	/**
	 * 
	 * 余额记录
	 * @param m
	 * @param pageNo
	 * @param request
	 * @Create In 2016-3-2 By WangWJ
	 * 
	 */
	@ResponseBody
	@RequestMapping(value ="/getByMemberBalance", method = { RequestMethod.POST, RequestMethod.GET })
	public String getByMemberBalance(HttpServletRequest request,
			HttpServletResponse response) {
		log.info("======== getByMemberBalance in  =========");
		String method = "/memberAcc/getByMemberBalance.do";
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
		paraMap.put("identity_card_no", request.getParameter("identity_card_no"));
		paraMap.put("m_timeStartDate",  request.getParameter("m_timeStartDate"));
		paraMap.put("m_timeEndDate",  request.getParameter("m_timeEndDate"));
		try {
			String url = CommonProperties.get("member_core_url");
			log.info("======== getByMemberBalance url "+url+"  =========");
			System.err.println("============== member_core_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== getByMemberBalance url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, paraMap);
		} catch (Exception e) {
			jsonString = "{success :false}";
		}
		return jsonString;
	}
	
	/**
	 * 
	 * 优惠券记录
	 * @param m
	 * @param pageNo
	 * @param request
	 * @Create In 2016-3-2 By WangWJ
	 * 
	 */
	@ResponseBody
	@RequestMapping(value ="/getByMemberCoupon", method = { RequestMethod.POST, RequestMethod.GET })
	public String getByMemberCoupon(HttpServletRequest request,
			HttpServletResponse response) {
		log.info("======== getByMemberCoupon in  =========");
		String method = "/memberAcc/getByMemberCoupon.do";
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
		paraMap.put("identity_card_no", request.getParameter("identity_card_no"));
		paraMap.put("m_timeStartDate",  request.getParameter("m_timeStartDate"));
		paraMap.put("m_timeEndDate",  request.getParameter("m_timeEndDate"));
		try {
			String url = CommonProperties.get("member_core_url");
			log.info("======== getByMemberCoupon url "+url+"  =========");
			System.err.println("============== member_core_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== getByMemberCoupon url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, paraMap);
		} catch (Exception e) {
			jsonString = "{success :false}";
		}
		return jsonString;
	}
}
