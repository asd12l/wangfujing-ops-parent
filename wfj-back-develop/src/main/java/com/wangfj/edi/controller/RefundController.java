package com.wangfj.edi.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.edi.util.HttpUtils;
import com.wangfj.edi.util.PropertiesUtil;
import com.wangfj.wms.util.CookiesUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/refund")
public class RefundController {

	@ResponseBody
	@RequestMapping(value = "/obtain", method = { RequestMethod.GET, RequestMethod.POST })
	public String refundObtain(HttpServletRequest request, HttpServletResponse response,String new_refundId, String refundId, String tid,
			String oid, String status, String reason ,String type) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.valueOf(Integer.parseInt(request.getParameter("pageSize")));
		Integer currPage = request.getParameter("page") == null ? null
				: Integer.valueOf(Integer.parseInt(request.getParameter("page")));

		if (size == null || size == 0) {
			size = 15;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		StringBuffer sb = new StringBuffer();
		String url=	(String) PropertiesUtil.getContextProperty("edi_refund");
		sb.append(url);
		if((new_refundId != null) && (!"".equals(new_refundId))){
			sb.append("/new_refundId/" + new_refundId);
		} else {
			sb.append("/new_refundId/default");
		}
		if ((refundId != null) && (!"".equals(refundId))) {
			sb.append("/refundId/" + refundId);
		} else {
			sb.append("/refundId/default");
		}
		if ((tid != null) && (!"".equals(tid))) {
			sb.append("/tid/" + tid);
		} else {
			sb.append("/tid/default");
		}
		if ((oid != null) && (!"".equals(oid))) {
			sb.append("/oid/" + oid);
		} else {
			sb.append("/oid/default");
		}
		if ((status != null) && (!"".equals(status))&&(! status.equals("不限"))) {
			sb.append("/status/" + status);
		} else {
			sb.append("/status/default");
		}
		if ((reason != null) && (!"".equals(reason))&&(! reason.equals("不限"))) {
			sb.append("/reason/" + reason);
		} else {
			sb.append("/reason/default");
		}
		sb.append("/currentPage/" + currPage);
		sb.append("/pageSize/" + size);
		sb.append("/type/"+type);
		sb.append("?userName=" + CookiesUtil.getUserName(request));
		String str = sb.toString();
		try {
			json = HttpUtils.HttpdoGet(str);
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonPage = JSONObject.fromObject(json);
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0) : jsonPage.get("pages"));
				} else {
					map.put("list", null);
					map.put("pageCount", Integer.valueOf(0));
				}
			} else {
				map.put("list", null);
				map.put("pageCount", Integer.valueOf(0));
			}
		} catch (Exception e) {
			map.put("pageCount", Integer.valueOf(0));
		}
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			map.put("userName", CookiesUtil.getUserName(request));
		}else{
			map.put("userName", "");
		}
		String js = (String) PropertiesUtil.getContextProperty("log_js");
		map.put("logJs", js);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}


}
