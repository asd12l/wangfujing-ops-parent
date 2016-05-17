package com.wangfj.wms.controller.region;

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
@RequestMapping(value = "/region")
public class RegionController {

	@RequestMapping(value = "/addRegion", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String addRegion(String regionCode, String regionInnerCode, String regionName,
			String parentId,
			String regionLevel, String regionOrder, String regionNameEn, String regionShortnameEn) {

		Map<String, Object> para = new HashMap<String, Object>();
		para.put("fromSystem", "PCM");
		if (StringUtils.isNotEmpty(regionCode)) {
			para.put("regionCode", regionCode.trim());
		}
		if (StringUtils.isNotEmpty(regionInnerCode)) {
			para.put("regionInnerCode", regionInnerCode.trim());
		}
		if (StringUtils.isNotEmpty(regionName)) {
			para.put("regionName", regionName.trim());
		}
		if (StringUtils.isNotEmpty(parentId)) {
			para.put("parentId", Long.parseLong(parentId.trim()));
		}
		if (StringUtils.isNotEmpty(regionLevel)) {
			para.put("regionLevel", Integer.parseInt(regionLevel.trim()));
		}
		if (StringUtils.isNotEmpty(regionOrder)) {
			para.put("regionOrder", Integer.parseInt(regionOrder.trim()));
		}
		if (StringUtils.isNotEmpty(regionNameEn)) {
			para.put("regionNameEn", regionNameEn.trim());
		}
		if (StringUtils.isNotEmpty(regionShortnameEn)) {
			para.put("regionShortnameEn", regionShortnameEn.trim());
		}

		String json = "";
		try {
			String url = SystemConfig.SSD_SYSTEM_URL + "/region/addRegion.htm";
			json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	@RequestMapping(value = "/modifyRegion", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String modifyRegion(String sid, String regionCode, String regionInnerCode,
			String regionName, String parentId,
			String regionLevel, String regionOrder, String regionNameEn, String regionShortnameEn) {

		Map<String, Object> para = new HashMap<String, Object>();
		para.put("fromSystem", "PCM");
		if (StringUtils.isNotEmpty(sid)) {
			para.put("sid", Long.parseLong(sid));
		}
		if (StringUtils.isNotEmpty(regionCode)) {
			para.put("regionCode", regionCode.trim());
		}
		if (StringUtils.isNotEmpty(regionInnerCode)) {
			para.put("regionInnerCode", regionInnerCode.trim());
		}
		if (StringUtils.isNotEmpty(regionName)) {
			para.put("regionName", regionName.trim());
		}
		if (StringUtils.isNotEmpty(parentId)) {
			para.put("parentId", Long.parseLong(parentId.trim()));
		}
		if (StringUtils.isNotEmpty(regionLevel)) {
			para.put("regionLevel", Integer.parseInt(regionLevel.trim()));
		}
		if (StringUtils.isNotEmpty(regionOrder)) {
			para.put("regionOrder", Integer.parseInt(regionOrder.trim()));
		}
		if (StringUtils.isNotEmpty(regionNameEn)) {
			para.put("regionNameEn", regionNameEn.trim());
		}
		if (StringUtils.isNotEmpty(regionShortnameEn)) {
			para.put("regionShortnameEn", regionShortnameEn.trim());
		}

		String json = "";
		try {
			String url = SystemConfig.SSD_SYSTEM_URL + "/region/modifyRegion.htm";
			json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryPageRegion", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryPageRegion(HttpServletRequest request, HttpServletResponse response,
			String sid, String regionName, String regionCode, String regionInnerCode,
			String parentId, String regionLevel) {

		Integer pageSize = request.getParameter("pageSize") == null ? 10 : Integer.valueOf(Integer
				.parseInt(request.getParameter("pageSize")));

		Integer currentPage = request.getParameter("page") == null ? 1 : Integer.valueOf(Integer
				.parseInt(request.getParameter("page")));

		Map<String, Object> para = new HashMap<String, Object>();
		para.put("pageSize", pageSize);
		para.put("currentPage", currentPage);

		if (StringUtils.isNotEmpty(sid)) {
			para.put("sid", Long.parseLong(sid.trim()));
		}

		if (StringUtils.isNotEmpty(parentId)) {
			para.put("parentId", Long.parseLong(parentId.trim()));
		}

		if (StringUtils.isNotEmpty(regionName)) {
			para.put("regionName", regionName.trim());
		}
		if (StringUtils.isNotEmpty(regionCode)) {
			para.put("regionCode", regionCode.trim());
		}
		if (StringUtils.isNotEmpty(regionInnerCode)) {
			para.put("regionInnerCode", regionInnerCode.trim());
		}
		if (StringUtils.isNotEmpty(regionLevel)) {
			para.put("regionLevel", Integer.parseInt(regionLevel.trim()));
		}

		para.put("fromSystem", "PCM");

		String json = "";
		try {

			System.out.println(JsonUtil.getJSONString(para));

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/region/findPageRegion.htm",
					JsonUtil.getJSONString(para));
			para.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					para.put("list", jsonPage.get("list"));
					para.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
							: jsonPage.get("pages"));
				} else {
					para.put("list", null);
					para.put("pageCount", Integer.valueOf(0));
				}
			} else {
				para.put("list", null);
				para.put("pageCount", Integer.valueOf(0));
			}
		} catch (Exception e) {
			para.put("pageCount", Integer.valueOf(0));
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(para);
	}

	@ResponseBody
	@RequestMapping(value = "/queryListRegion", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryListRegion(HttpServletRequest request, String sid, String regionName,
			String regionCode,String regionInnerCode, String parentId, String regionLevel) {

		Map<String, Object> para = new HashMap<String, Object>();

		if (StringUtils.isNotEmpty(sid)) {
			para.put("sid", Long.parseLong(sid.trim()));
		}

		if (StringUtils.isNotEmpty(parentId)) {
			para.put("parentId", Long.parseLong(parentId.trim()));
		}

		if (StringUtils.isNotEmpty(regionName)) {
			para.put("regionName", regionName.trim());
		}
		if (StringUtils.isNotEmpty(regionCode)) {
			para.put("regionCode", regionCode.trim());
		}
		if (StringUtils.isNotEmpty(regionInnerCode)) {
			para.put("regionInnerCode", regionInnerCode.trim());
		}
		if (StringUtils.isNotEmpty(regionLevel)) {
			para.put("regionLevel", Integer.parseInt(regionLevel.trim()));
		}

		para.put("fromSystem", "PCM");

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/region/findListRegion.htm",
					JsonUtil.getJSONString(para));
			para.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				List<?> dataList = (List<?>) jsonObject.get("data");
				if (dataList != null) {
					para.put("list", dataList);
				} else {
					para.put("success", "false");
				}
			} else {
				para.put("success", "false");
			}
		} catch (Exception e) {
			para.put("success", "false");
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(para);
	}

}
