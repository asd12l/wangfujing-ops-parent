package com.wangfj.wms.controller.wms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

/**
 * 物流运费管理
 * 
 * @Class Name OnlinPlanController
 * @Author Henry
 * @Create In 2015年11月26日
 */
@Controller
@RequestMapping(value = "/wms")
public class LogisticsFreightController {
	
	/**
	 * 查询省
	 * 
	 * @Methods Name queryOnlinPlanList
	 * @param request
	 * @param response
	 * @param organizationName
	 * @param organizationCode
	 * @param groupSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryProvince", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryProvince(HttpServletRequest request,
			HttpServletResponse response) {
		// 操作人用户名
//		String username = (String) request.getSession().getAttribute("username");
		String username = CookiesUtil.getCookies(request, "username");

		Map<String, Object> map = new HashMap<String, Object>();
		
		String json="";
		try {
			json = HttpUtilPcm
					.doPost(SystemConfig.WMS_SYSTEM_URL
							+ "/wms/tegion/getProvince.htm",
							JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					map.put("list", jsonObject.get("data"));
				} else {
					map.put("list", null);
					map.put("pageCount", 0);
				}
			} else {
				map.put("list", null);
				map.put("pageCount", 0);
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		return gson.toJson(map);
	}
	
	/**
	 * 查询市
	 * 
	 * @Methods Name queryOnlinPlanList
	 * @param request
	 * @param response
	 * @param organizationName
	 * @param organizationCode
	 * @param groupSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryCity", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryCity(HttpServletRequest request,
			HttpServletResponse response, String organizationName,
			String sid ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parent_id", sid);
		String json="";
		try {
			json = HttpUtilPcm
					.doPost(SystemConfig.WMS_SYSTEM_URL
							+ "/wms/tegion/getCity.htm",
							JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					map.put("list", jsonObject.get("data"));
				} else {
					map.put("list", null);
					map.put("pageCount", 0);
				}
			} else {
				map.put("list", null);
				map.put("pageCount", 0);
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		return gson.toJson(map);
	}
	
	
	/**
	 * 查询区
	 * 
	 * @Methods Name queryOnlinPlanList
	 * @param request
	 * @param response
	 * @param organizationName
	 * @param organizationCode
	 * @param groupSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryArea", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryArea(HttpServletRequest request,
			HttpServletResponse response, String organizationName,
			String sid ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("parent_id", sid);
		String json="";
		try {
			json = HttpUtilPcm
					.doPost(SystemConfig.WMS_SYSTEM_URL
							+ "/wms/tegion/getArea.htm",
							JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					map.put("list", jsonObject.get("data"));
				} else {
					map.put("list", null);
					map.put("pageCount", 0);
				}
			} else {
				map.put("list", null);
				map.put("pageCount", 0);
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		return gson.toJson(map);
	}
	
	
	
	/**
	 * 查询区
	 * 
	 * @Methods Name queryOnlinPlanList
	 * @param request
	 * @param response
	 * @param organizationName
	 * @param organizationCode
	 * @param groupSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/configAreaFreight", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String AreaFreight(HttpServletRequest request,
			HttpServletResponse response, 
			String paramsPostcode,String paramsFreghtName,String paramstypePost ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("postCode", paramsPostcode);
		map.put("moneyArea", paramsFreghtName);
		map.put("type", paramstypePost);
		String json="";
		try {

			json = HttpUtilPcm
					.doPost(SystemConfig.WMS_SYSTEM_URL
							+ "/wms/tegion/configFreight.htm",
							JsonUtil.getJSONString(map));

			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					if (jsonObject.get("success").equals(true)) {
						map.put("success", true);
						map.put("mess", "设置成功!");
					}else {
						map.put("success", false);
						map.put("mess", jsonObject.get("errorMsg"));
					}
					
					
				} else {

					map.put("success", false);
				}
			} else {
				map.put("success", false);
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		return gson.toJson(map);
	}
	
	/**
	 * 查询区
	 * 
	 * @Methods Name queryOnlinPlanList
	 * @param request
	 * @param response
	 * @param organizationName
	 * @param organizationCode
	 * @param groupSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryFreight", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryFreight(HttpServletRequest request,
			HttpServletResponse response, 
			String paramsPostcode,String paramsFreghtName,String paramstypePost ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("postCode", paramsPostcode);
		String json="";
		try {

			json = HttpUtilPcm
					.doPost(SystemConfig.WMS_SYSTEM_URL
							+ "/wms/tegion/queryFreight.htm",
							JsonUtil.getJSONString(map));

			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					if (jsonObject.get("success").equals(true)) {
						map.put("success", true);
						map.put("mess", jsonObject.get("data"));
					}else {
						map.put("success", false);
						map.put("mess", jsonObject.get("errorMsg"));
					}
					
					
				} else {

					map.put("success", false);
				}
			} else {
				map.put("success", false);
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		return gson.toJson(map);
	}

}
