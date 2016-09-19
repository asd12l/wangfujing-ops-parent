package com.wangfj.order.utils;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.edi.util.HttpUtils;
import com.wangfj.edi.util.PropertiesUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;

public class sysValues {
	
	
	public static String desensitization(HttpServletRequest request){
		Map<Object,Object> paramMap = new HashMap<Object, Object>();
		String json="";
//		paramMap.put("keys", "memberInfo");
		Cookie [] cookie = request.getCookies();
		for(Cookie cok : cookie){
			if(cok.getName().equals("username")){
				paramMap.put("userName", cok.getValue());
			}
		}
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
//			json = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
			String url = (String) CommonProperties.get("select_ops_sysConfig_username")+paramMap.get("userName");
//			json = HttpUtilPcm.HttpGet(url, "", m);
			json = HttpUtils.HttpdoGet(url);
			if(StringUtils.isEmpty(json)){
				m.put("success", "false");
			}else{
				JSONObject jsonObj = JSON.parseObject(json);
				JSONArray arry = (JSONArray) jsonObj.get("data");
				for(Object obj : arry){
				  String str = obj.toString();
				  JSONObject json1 = JSON.parseObject(str);
				  if(json1.getString("sysValue").equals("1")){
					  json = "1";
				  }else{
					  json = "0";
				  }
				}
				return json;
			}
		} catch (Exception e) {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

}
