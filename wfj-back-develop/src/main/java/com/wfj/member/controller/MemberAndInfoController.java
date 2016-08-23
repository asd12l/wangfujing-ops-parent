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
 * Created by WangJW on 2016/2/29.
 * 会员信息相关controller
 */
@Controller
@RequestMapping("/member")
public class MemberAndInfoController {

		private static Logger log =  LoggerFactory.getLogger(MemberAndInfoController.class);
		/**
		 * 会员等级查询
		 * 
		 * @param m
		 * @param pageNo
		 * @param request
		 * @Create In 2015-12-28 By WangWJ
		 * 
		 */
		@ResponseBody
		@RequestMapping(value ="/getByMemberAndInfo", method = { RequestMethod.POST, RequestMethod.GET })
		public String getByMemberAndInfo(HttpServletRequest request,
				HttpServletResponse response) {
			log.info("======== getByMemberAndInfo in  =========");
			String method = "/memberAndInfo/getByMemberAndInfo.do";
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
				log.info("======== getByMemberAndInfo url "+url+"  =========");
				System.err.println("============== member_core_url:" + url);
				System.err.println("=============method:"+method);
				System.err.println("======== getByMemberAndInfo url "+url+ method+"  =========");
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
		 * 
		 * 会员等级查询
		 * @param m
		 * @param pageNo
		 * @param request
		 * @Create In 2016-3-1 By WangWJ
		 * 
		 */
		@ResponseBody
		@RequestMapping(value ="/getByMemberGrade", method = { RequestMethod.POST, RequestMethod.GET })
		public String getByMemberGrade(HttpServletRequest request,
				HttpServletResponse response) {
			log.info("======== getByMemberGrade in  =========");
			String method = "/memberAndInfo/getByMemberGrade.do";
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
			paraMap.put("registfrom",  request.getParameter("regist_from"));
			paraMap.put("membergrade",  request.getParameter("membergrade"));
			paraMap.put("changetime",  request.getParameter("changetime"));
			try {
				String url = CommonProperties.get("member_core_url");
				log.info("======== getByMemberGrade url "+url+"  =========");
				//System.err.println("============== member_core_url:" + url);
				//System.err.println("=============method:"+method);
				//System.err.println("======== getByMemberGrade url "+url+ method+"  =========");
				jsonString = HttpUtil.HttpPost(url,method, paraMap);
			} catch (Exception e) {
				jsonString = "{success :false}";
			}
			return jsonString;
		}
		
		/**
		 * 
		 * 会员购买查询
		 * @param m
		 * @param pageNo
		 * @param request
		 * @Create In 2016-3-1 By WangWJ
		 * 
		 */
		@ResponseBody
		@RequestMapping(value ="/getByMemberPurchase", method = { RequestMethod.POST, RequestMethod.GET })
		public String getByMemberPurchase(HttpServletRequest request,
				HttpServletResponse response) {
			log.info("======== getByMemberPurchase in  =========");
			String method = "/memberAndInfo/getByMemberPurchase.do";
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
				log.info("======== getByMemberPurchase url "+url+"  =========");
				System.err.println("============== member_core_url:" + url);
				System.err.println("=============method:"+method);
				System.err.println("======== getByMemberPurchase url "+url+ method+"  =========");
				jsonString = HttpUtil.HttpPost(url,method, paraMap);
			} catch (Exception e) {
				jsonString = "{success :false}";
			}
			return jsonString;
		}
		
		/**
		 * 
		 * 会员退货查询
		 * @param m
		 * @param pageNo
		 * @param request
		 * @Create In 2016-3-1 By WangWJ
		 * 
		 */
		@ResponseBody
		@RequestMapping(value ="/getByMemberRefund", method = { RequestMethod.POST, RequestMethod.GET })
		public String getByMemberRefund(HttpServletRequest request,
				HttpServletResponse response) {
			log.info("======== getByMemberRefund in  =========");
			String method = "/memberAndInfo/getByMemberRefund.do";
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
				log.info("======== getByMemberRefund url "+url+"  =========");
				System.err.println("============== member_core_url:" + url);
				System.err.println("=============method:"+method);
				System.err.println("======== getByMemberRefund url "+url+ method+"  =========");
				jsonString = HttpUtil.HttpPost(url,method, paraMap);
			} catch (Exception e) {
				jsonString = "{success :false}";
			}
			return jsonString;
		}
}
