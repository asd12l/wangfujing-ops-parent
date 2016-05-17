package com.wangfj.pay.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.order.utils.CommonProperties;
import com.wangfj.pay.web.constant.Constants;
import com.wangfj.pay.web.util.HttpClientUtil;

/**
 * 支付后台用户权限controller
 * @Class Name UserRightsController
 * @Author yangyinbo
 * @Create In 2016年4月7日
 */
@Controller
@RequestMapping("/wfjpay")
public class UserRightsController {
	
	/**
	 * 查询用户列表
	 * @Methods Name getAllUsers
	 * @Create 2016-4-7 by yangyinbo 
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/userRights/getAllUsers")
	public String getAllUsers(){
		String json="";
		JSONObject resJSON=new JSONObject();
		Map<String,String> params=new HashMap<String,String>();
		String url=CommonProperties.get(Constants.UAC_CORE_URL)+"/"+CommonProperties.get(Constants.FIND_USER_LIST);
		json=HttpClientUtil.post(url,params);
		JSONObject jsonObject = JSONObject.fromObject(json);
		if(jsonObject!=null&&jsonObject.containsKey("success")&&jsonObject.getBoolean("success")){
			List list = (List) jsonObject.get("result");
			resJSON.put("success", true);
			resJSON.put("list", list);
		}else{
			resJSON.put("success", false);
		}
		return resJSON.toString();
	}
	
	/**
	 * 查询用户权限
	 * @Methods Name findRightsByUserId
	 * @Create In 2016年4月11日 By yangyinbo
	 * @param userId 用户名
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/userRights/findRightsByUserId")
	public String findRightsByUserId(String userId){
		String json="";
		JSONObject resJSON=new JSONObject();
		Map<String,String>params=new HashMap<String,String>();
		params.put("userId", userId);
		String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.FIND_RIGHTS_BY_USER_ID);
		json=HttpClientUtil.post(url,params);
		JSONObject jsonObject = JSONObject.fromObject(json);
		if(jsonObject!=null&&jsonObject.containsKey("result")&&"success".equals(jsonObject.getString("result"))){
			JSONArray bpIds=jsonObject.getJSONArray("data");
			resJSON.put("success", true);
			resJSON.put("bpIds", bpIds);
		}else{
			resJSON.put("success", false);
		}
		return resJSON.toString();
	}
	
	/**
	 * 保存用户权限
	 * @Methods Name saveUserRights
	 * @Create In 2016年4月11日 By chengsj
	 * @param userId 用户名
	 * @param delBpIds	删除的权限
	 * @param addBpIds	添加的权限
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/userRights/savaUserRights")
	public String saveUserRights(String userId,String delBpIds,String addBpIds){
		String json="";
		JSONObject resJSON=new JSONObject();
		Map<String,String>params=new HashMap<String,String>();
		params.put("userId", userId);
		params.put("delBpIds", delBpIds);
		params.put("addBpIds", addBpIds);
		String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SAVE_USER_RIGHTS);
		json=HttpClientUtil.post(url,params);
		JSONObject jsonObject = JSONObject.fromObject(json);
		if(jsonObject!=null&&jsonObject.containsKey("result")&&"success".equals(jsonObject.getString("result"))){
			resJSON.put("success", true);
		}else{
			resJSON.put("success", false);
		}
		return resJSON.toString();
	}
	
	public static void main(String[] args) {
		JSONObject a=new JSONObject();
		a.put("a", 1);
		a.put("b", 2);
		a.put("reqJSON", a);
		System.out.println(a.toString());
	}
}
