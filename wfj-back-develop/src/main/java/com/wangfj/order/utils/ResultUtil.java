package com.wangfj.order.utils;

import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * 说明:
 * @author chengsj
 * @date 2013-5-29 下午02:18:58
 * @modify 
 */
public class ResultUtil {
	public static String createSuccessResult() {
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		resultMap.put("success", "true");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	public static String createSuccessResult(Object obj) {
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		resultMap.put("success", "true");
		resultMap.put("obj", obj);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	public static String createSuccessResult(List list) {
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		resultMap.put("success", "true");
		resultMap.put("list", list);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	public static String createSuccessResultList(Object obj){
		String jsonStr = "";
		JSONObject jo = new JSONObject();
		if (obj != null) {
            if (isArray(obj)) {
                JSONArray jsonArray = JSONArray.fromObject(obj);
                jo.put("list", jsonArray);
                jsonStr =  jo.toString();
            } else {
                JSONObject jsonObject = JSONObject.fromObject(obj);
                jo.put("page", jsonObject);
                jo.put("success", "true");
                jsonStr = jo.toString();
            }
        }
		return jsonStr;
	}
	private  static boolean isArray(Object obj) {
        return obj instanceof Collection || obj.getClass().isArray();
    }
	
	
	public static String createFailureResult(String errorCode, String memo) {
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		resultMap.put("success", "false");
		resultMap.put("errorCode", errorCode);
		resultMap.put("memo", memo);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	/**
	 * added by kanglei 2013-08-03
	 * @param map,eg:map.put("orderNo","参数为空！")
	 */
	public static String createFailureResult(String errorCode, Map map) {
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		resultMap.put("success", "false");
		resultMap.put("errorCode", errorCode);
		resultMap.put("memo", map);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	/**
	 * added by kanglei 2013-08-03
	 * @param map,
	 */
	public static String createFailureResult(String errorCode, String param,String errorDesc) {
		Map<String, Object> resultMap = new LinkedHashMap<String, Object>();
		resultMap.put("success", "false");
		resultMap.put("errorCode", errorCode);
		resultMap.put(param, errorDesc);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
}
