package com.wangfj.order.utils;

import java.lang.reflect.Array;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.wms.util.HttpUtilPcm;

public class sysValues {
	
	
	public static String desensitization(){
		Map<Object,Object> paramMap = new HashMap<Object, Object>();
		JSONObject jsonObject = new JSONObject();
		String json="";
		paramMap.put("keys", "memberInfo");
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
//			json = "{'data':[{'sid':1,'sysKey':'memberInfo','sysValue':'0'}],'success':true}";//暂时写死0是权限未开启
			json = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
//			json = HttpUtilPcm.HttpGet("http://10.6.2.49:8080/ops/sysConfig", "findSysConfigByKeys", paramMap);
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
