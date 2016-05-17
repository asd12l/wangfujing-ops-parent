package com.wangfj.wms.controller.productlimit;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/productlimit")
public class ProductLimitController {

	@ResponseBody
	@RequestMapping(value = "/queryPageLimit", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryPageLimit(HttpServletRequest request, HttpServletResponse response,
			String brandSid, String categorySid) {

		Map<String, Object> map = new HashMap<String, Object>();

		Integer pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request
				.getParameter("pageSize"));

		Integer currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request
				.getParameter("page"));

		map.put("currentPage", currentPage);
		map.put("pageSize", pageSize);

		if (StringUtils.isNotEmpty(brandSid)) {
			map.put("brandSid", Long.parseLong(brandSid.trim()));
		}
		if (StringUtils.isNotEmpty(categorySid)) {
			map.put("categorySid", Long.parseLong(categorySid.trim()));
		}

		String json = "";
		try {
			String url = SystemConfig.SSD_SYSTEM_URL
					+ "/productOnlineLimit/findPageProductLimitInfo.htm";
			json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(map));
			map.clear();
			if (StringUtils.isNotEmpty(json)) {
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
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	@ResponseBody
	@RequestMapping(value = { "/addProductLimitList" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String addBrandGroup(HttpServletRequest request, HttpServletResponse response,
			String optName, String[] brandSids, String[] categorySids, String[] limitValues,
			String[] statuses) {

		List<Map<String, Object>> paraList = new ArrayList<Map<String, Object>>();

		if (brandSids.length != 0) {
			for (int i = 0; i < brandSids.length; i++) {
				if (StringUtils.isNotEmpty(brandSids[i])) {
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("brandSid", Long.parseLong(brandSids[i].trim()));
					if (StringUtils.isNotEmpty(categorySids[i])) {
						map.put("categorySid", Long.parseLong(categorySids[i].trim()));
					}
					if (StringUtils.isNotEmpty(limitValues[i])) {
						map.put("limitValue", Integer.parseInt(limitValues[i].trim()));
					}
					if (StringUtils.isNotEmpty(statuses[i])) {
						map.put("status", Integer.parseInt(statuses[i].trim()));
					}
					if (StringUtils.isNotEmpty(optName)) {
						map.put("optName", optName.trim());
					}
					paraList.add(map);
				}
			}
		}

		String json = "";
		try {

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productOnlineLimit/addProductLimitList.htm",
					JsonUtil.getJSONString(paraList));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = { "/modifyProductLimit" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String modifyBrandGroup(HttpServletRequest request, HttpServletResponse response,
			String sid, String brandSid, String categorySid, String limitValue, String status,
			String optName) {

		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(sid)) {
			map.put("sid", Long.parseLong(sid.trim()));
		}
		if (StringUtils.isNotEmpty(brandSid)) {
			map.put("brandSid", Long.parseLong(brandSid.trim()));
		}
		if (StringUtils.isNotEmpty(categorySid)) {
			map.put("categorySid", Long.parseLong(categorySid.trim()));
		}
		if (StringUtils.isNotEmpty(limitValue)) {
			map.put("limitValue", Integer.parseInt(limitValue.trim()));
		}
		if (StringUtils.isNotEmpty(status)) {
			map.put("status", Integer.parseInt(status.trim()));
		}
		if (StringUtils.isNotEmpty(optName)) {
			map.put("optName", optName.trim());
		}

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productOnlineLimit/modifyProductLimit.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = { "/queryCategoryPartInfoList" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryCategoryPartInfoList(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productOnlineLimit/findCategoryPartInfoByParam.htm",
					JsonUtil.getJSONString(map));
			map.clear();
			JSONObject jsonObject = JSONObject.fromObject(json);

			List<?> list = (List<?>) jsonObject.get("data");
			if ((list != null) && (list.size() != 0)) {
				map.put("list", list);
				map.put("success", "true");
			} else {
				map.put("success", "false");
			}
		} catch (Exception e) {
			map.put("success", "false");
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	@ResponseBody
	@RequestMapping(value = "/getShopBrandByShopSidAndSkuSid", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getShopBrandByShopSidAndSkuSid(String shopSid, String skuSid) {
		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";
		if (StringUtils.isNotEmpty(shopSid)) {
			map.put("shopSid", shopSid.trim());
		}
		if (StringUtils.isNotEmpty(skuSid)) {
			map.put("skuSid", skuSid.trim());
		}
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmAdminBrand/getListBrandByShopSidAndSkuSid.htm",
					JsonUtil.getJSONString(map));
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}
		return json;
	}

}
