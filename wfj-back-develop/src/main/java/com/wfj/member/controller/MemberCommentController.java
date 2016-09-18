package com.wfj.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.utils.StringUtils;
import com.wangfj.back.entity.po.SysConfig;
import com.wangfj.back.service.ISysConfigService;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Created by wangzi on 2016/7/26.
 * 会员评论相关controller
 */
@Controller
@RequestMapping("/membercommentrep")
public class MemberCommentController {

	private static Logger log =  LoggerFactory.getLogger(MemberAccountController.class);
	 @Autowired
	    private ISysConfigService sysConfigService;
@ResponseBody
@RequestMapping(value ="/getBycommentwirtlist", method = { RequestMethod.POST, RequestMethod.GET })
	public String getByMemberCoupon(HttpServletRequest request,
		HttpServletResponse response) {
		System.out.println("+++++++++++"+request.getParameter("customerservicenumber"));
		log.info("======== getBycommentwirtlist in  =========");
		String method = "/memberComment/getBycommentwirtefinds.do";
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
		System.out.println(request.getParameterMap());
		//屏显规则
		String json = "";
        String sysValue = "";
        String username = CookiesUtil.getCookies(request, "username");
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("keys", "memberInfo");
		paramMap.put("username", username);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			log.info("paramMap:" + paramMap);
			json = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
			if(!StringUtils.isEmpty(json)){
				JSONObject jsonObject = JSONObject.fromObject(json);
				String isTrue = jsonObject.getString("success");
				if(isTrue.equals("true")){
				JSONArray jsonArray = jsonObject.getJSONArray("data");
				sysValue = jsonArray.getJSONObject(0).getString("sysValue");
				}
			}
		} catch (Exception e) {
			log.error("查询屏显规则异常！返回结果json="+json);
		}
		paraMap.put("start", String.valueOf(start));
		paraMap.put("limit", String.valueOf(pageSize));
		paraMap.put("customeraccount", request.getParameter("customeraccount"));
		paraMap.put("ordernumber", request.getParameter("ordernumber"));
		paraMap.put("praisedegree", request.getParameter("praisedegree"));
		paraMap.put("whether_reply", request.getParameter("whether_reply"));
		paraMap.put("whether_shielding",  request.getParameter("whether_shielding"));
		paraMap.put("customerservicenumber",  request.getParameter("customerservicenumber"));
		paraMap.put("startcommenttime", request.getParameter("startcommenttime"));
		paraMap.put("endcommenttime",  request.getParameter("endcommenttime"));
		paraMap.put("whether_upgrade", request.getParameter("whether_upgrade"));
		paraMap.put("startrecoverytime", request.getParameter("startrecoverytime"));
		paraMap.put("endrecoverytime", request.getParameter("endrecoverytime"));
		paraMap.put("commentsid", request.getParameter("commentsid"));
		paraMap.put("replyinfo", request.getParameter("replyinfo"));
		paraMap.put("datetimenow", request.getParameter("datetimenow"));
		paraMap.put("deletnot", request.getParameter("deletnot"));
		paraMap.put("cache",request.getParameter("modowtype"));
		paraMap.put("start",start);
		paraMap.put("mask", sysValue);
//		paraMap.put("cache",  request.getParameter("cache").replace("#",""));	//首位为#的是要求屏蔽的commentid主键字段
		try {
			String url = CommonProperties.get("member_ops_url");
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
