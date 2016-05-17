package com.wangfj.wms.controller.promotionLabel;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping("/proLabel")
public class ProLabelController {

	/**
	 * 分页查数据
	 * 
	 * @Methods Name queryProLabel
	 * @Create In 2015年12月10日 By dongliang
	 * @param request
	 * @param response
	 * @param tagName
	 * @param beginDate
	 * @param endDate
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/queryProLabel" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String queryPriceLimit(HttpServletRequest request, HttpServletResponse response) {

		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currPage);
		map.put("pageSize", size);
		if (request.getParameter("tagName") != "" && request.getParameter("tagName") != null) {
			map.put("tagName", request.getParameter("tagName"));
		}
		if (request.getParameter("tagType") != "" && request.getParameter("tagType") != null) {
			map.put("tagType", request.getParameter("tagType"));
		}
		if (request.getParameter("beginDate") != "" && request.getParameter("beginDate") != null) {
			map.put("beginDate", request.getParameter("beginDate"));
		}
		if (request.getParameter("endDate") != "" && request.getParameter("endDate") != null) {
			map.put("endDate", request.getParameter("endDate"));
		}
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmTag/findPagePcmTag.htm",
					JsonUtil.getJSONString(map));
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

	/**
	 * 分页查数据
	 * @Methods Name queryProLabel
	 * @Create In 2015年12月10日 By dongliang
	 * @param request
	 * @param response
	 * @param tagName
	 * @param beginDate
	 * @param endDate
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/findProLabelByShoppeProSid" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String findProLabelByShoppeProSid(HttpServletRequest request, HttpServletResponse response) {
		
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(request.getParameter("shoppeProSid") != "" && request.getParameter("shoppeProSid") != null){
			map.put("shoppeProSid", request.getParameter("shoppeProSid"));
		}
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmTag/findPcmTagList.htm", JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				map.put("list", jsonObject.get("data"));
				
			} else {
				map.put("list", null);
			}
		} catch (Exception e) {
			map.put("pageCount", 0);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.err.println(gson.toJson(map));
		return gson.toJson(map);
	}
	
	/**
	 * 添加
	 * 
	 * @Methods Name savePcmTag
	 * @Create In 2015年12月10日 By dongliang
	 * 
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/saveProLabel" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String savePriceLimit(String tagType, String tagName, String beginDate, String endDate,
			String status, String operaterName,String tagNames) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (StringUtils.isNotEmpty(tagType)) {
				map.put("tagType", tagType);
			}
			if (StringUtils.isNotEmpty(tagName)) {
				map.put("tagName", tagName.trim());
			}
			if(StringUtils.isNotBlank(tagNames)){
				map.put("tagNames", tagNames.trim());
			}
			if (StringUtils.isNotEmpty(endDate)) {
				map.put("endDate", endDate);
			}
			if (StringUtils.isNotEmpty(beginDate)) {
				map.put("beginDate", beginDate);
			}
			if (StringUtils.isNotEmpty(status)) {
				map.put("status", status);
			}
			if (StringUtils.isNotEmpty(operaterName)) {
				map.put("operaterName", operaterName);
			}

			map.put("actionCode", "a");

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmTag/saveOrUpdatePcmTags.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	/**
	 * 修改
	 * 
	 * @Methods Name editPcmTag
	 * @Create In 2015年12月10日 By dongliang
	 * 
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/editProLabel" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String editPriceLimit(String sid, String tagType, String tagName, String beginDate,
			String endDate, String status, String operaterName) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("sid", sid);
			if (StringUtils.isNotEmpty(tagType)) {
				map.put("tagType", tagType);
			}
			if (StringUtils.isNotEmpty(tagName)) {
				map.put("tagName", tagName);
			}
			if (StringUtils.isNotEmpty(endDate)) {
				map.put("endDate", endDate);
			}
			if (StringUtils.isNotEmpty(beginDate)) {
				map.put("beginDate", beginDate);
			}
			if (StringUtils.isNotEmpty(status)) {
				map.put("status", status);
			}
			if (StringUtils.isNotEmpty(operaterName)) {
				map.put("operaterName", operaterName);
			}

			map.put("actionCode", "u");

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmTag/saveOrUpdatePcmTag.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

}
