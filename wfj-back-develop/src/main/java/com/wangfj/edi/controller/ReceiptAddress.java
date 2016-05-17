package com.wangfj.edi.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.wangfj.edi.bean.AddressVO;
import com.wangfj.edi.bean.Page;
import com.wangfj.edi.util.HttpClients;
import com.wangfj.edi.util.PropertiesUtil;
import com.wangfj.edi.util.RequestUtils;

import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "/receiptAddress")
public class ReceiptAddress {

	@ResponseBody
	@RequestMapping(value = "/queryAddress", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryAddress(String parentId,String channel) {
		String json = "";
		String url = "";
		if("M4".equals(channel)){
			url = (String) PropertiesUtil.getContextProperty("edi_yz_address_Tree")+parentId;
		}else if("C8".equals(channel)){
			//聚美
			url = (String) PropertiesUtil.getContextProperty("edi_jm_address_Tree")+parentId;
		}else{
			url = (String) PropertiesUtil.getContextProperty("edi_address_Tree")+parentId;
		}
		try {
			json = HttpClients.httpdoGet(url);
			System.out.println("-------------------" + json);
			
		} catch (Exception e) {
			return "{success:false}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				json = "{success:false}";
			}
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/queryAddressInfo", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryAddressInfo(String id,String channel) {
		String json = "";
		String url = "";
		if("M4".equals(channel)){
			url = (String) PropertiesUtil.getContextProperty("edi_yz_address_Info")+id;
		}else if("C8".equals(channel)){
			//聚美
			url = (String) PropertiesUtil.getContextProperty("edi_jm_address_Info")+id;
		}else{
			url = (String) PropertiesUtil.getContextProperty("edi_address_Info")+id;
		}
		try {
			json = HttpClients.httpdoGet(url);
			System.out.println("-------------------json" + json);
			
		} catch (Exception e) {
			return "{success:false}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				json = "{success:false}";
			}
		}
		return json;
	}
	
	@SuppressWarnings("rawtypes") 
	@ResponseBody
	@RequestMapping(value = "/queryWFJProperties", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryWFJProperties(String type,String channel ,Page page,HttpServletRequest request,HttpServletResponse response) throws Exception {
		String statName = RequestUtils.decode(request.getParameter("statName") == null ? "" : request.getParameter("statName"));
		String cityName = RequestUtils.decode(request.getParameter("cityName") == null ? "" : request.getParameter("cityName"));
		String areaName = RequestUtils.decode(request.getParameter("areaName") == null ? "" : request.getParameter("areaName"));
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("statName",statName);
		map.put("type", type);
		map.put("cityName", cityName);
		map.put("areaName", areaName);
		map.put("page", page);
		JSONObject jsonData = JSONObject.fromObject(map);
		String url = "";
		if("M4".equals(channel)){
			url = (String) PropertiesUtil.getContextProperty("edi_yz_address_Wfj");
		}else if("C8".equals(channel)){
			//聚美
			url = (String) PropertiesUtil.getContextProperty("edi_jm_address_Wfj");
		}else{
			url = (String) PropertiesUtil.getContextProperty("edi_address_Wfj");
		}
		try {
			json = HttpClients.httpPost(url, jsonData);
			System.out.println("-------------------json地址匹配" + json);
			
		} catch (Exception e) {
			return "{success:false}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				json = "{success:false}";
			}
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateAddress", method = { RequestMethod.GET, RequestMethod.POST })
	public String updateExpress(String channel,AddressVO addressVO,HttpServletRequest request,HttpServletResponse response) {
		
		Map<String,Object> map =new HashMap<String,Object>();
		String username = request.getParameter("username");
		addressVO.setOperaterLoginid(username);
		String json = "";
		JSONObject jsonData = JSONObject.fromObject(addressVO);
		String url = "";
		if("M4".equals(channel)){
			url = (String) PropertiesUtil.getContextProperty("edi_yz_address_Update");
		}else if("C8".equals(channel)){
			//聚美
			url = (String) PropertiesUtil.getContextProperty("edi_jm_address_Update");
		}else{
			url = (String) PropertiesUtil.getContextProperty("edi_address_Update");
		}
		try {
			json = HttpClients.httpPost(url, jsonData);
			System.out.println("-------------------json++++" + json);
			if("1".equals(json)){
				json = "修改成功";
			} else{
				json = "修改失败";
			}
			map.put("success",true);
			map.put("msg",json);
//			HttpClients.sendResult(response,JSON.toJSONString(map));
			
			
		} catch (Exception e) {
			return "{success:false}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				json = "{success:false}";
			}
		}
		return JSON.toJSONString(map);
	}
}
