package com.wangfj.wms.controller.price;

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
import com.utils.StringUtils;
import com.wangfj.wms.controller.organization.support.PcmShoppePara;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping("/priceLimit")
public class PriceLimitController {
	
	@ResponseBody
	@RequestMapping(value = { "/queryPriceLimit" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String queryPriceLimit(HttpServletRequest request, HttpServletResponse response,
			String organizationName) {
		
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		if(organizationName==null||organizationName.equals("")){
			organizationName=null;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currPage);
		map.put("pageSize", size);
		map.put("shopCode", organizationName);
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/priceLimit/findPagePriceLimit.htm", JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
				} else {
					map.put("list", null);
					map.put("pageCount", 0);
				}
			} else {
				map.put("list", null);
				map.put("pageCount", 0);
			}

		} catch (Exception e) {
			map.put("pageCount", 0);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}
	

	@ResponseBody
	@RequestMapping(value = { "/savePriceLimit" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String savePriceLimit(String shopSid,String upper,String createName,
			String upperStatus,String lower,String lowerStatus) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (StringUtils.isNotEmpty(shopSid)) {
				map.put("shopSid", shopSid);
			}
			if (StringUtils.isNotEmpty(createName)) {
				map.put("createName", createName);
			}
			if (StringUtils.isNotEmpty(upper)) {
				map.put("upper", upper);
			}
			if (StringUtils.isNotEmpty(upperStatus)) {
				map.put("upperStatus", upperStatus);
			}
			if (StringUtils.isNotEmpty(lower)) {
				map.put("lower", lower);
			}
			if (StringUtils.isNotEmpty(lowerStatus)) {
				map.put("lowerStatus", lowerStatus);
			}
			map.put("actionCode", "a");

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/priceLimit/saveOrUpdatePriceLimit.htm", 
					JsonUtil.getJSONString(map));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = { "/editPriceLimit" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String editPriceLimit(String shopSid,String upper,String createName,
			String upperStatus,String lower,String lowerStatus) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (StringUtils.isNotEmpty(shopSid)) {
				map.put("shopSid", shopSid);
			}
			if (StringUtils.isNotEmpty(createName)) {
				map.put("createName", createName);
			}
			if (StringUtils.isNotEmpty(upper)) {
				map.put("upper", upper);
			}
			if (StringUtils.isNotEmpty(upperStatus)) {
				map.put("upperStatus", upperStatus);
			}
			if (StringUtils.isNotEmpty(lower)) {
				map.put("lower", lower);
			}
			if (StringUtils.isNotEmpty(lowerStatus)) {
				map.put("lowerStatus", lowerStatus);
			}
			map.put("actionCode", "u");

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/priceLimit/saveOrUpdatePriceLimit.htm", 
					JsonUtil.getJSONString(map));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}
	
	
	@ResponseBody
	@RequestMapping(value = { "/findAllShopSidFromPriceLimit" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String findAllShopSidFromPriceLimit() {
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/priceLimit/findAllShopSidFromPriceLimit.htm", 
					null);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		
		return json;
	}
}