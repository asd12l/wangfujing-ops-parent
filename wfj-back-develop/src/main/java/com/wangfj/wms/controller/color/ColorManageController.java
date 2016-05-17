package com.wangfj.wms.controller.color;

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
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/colorManage")
public class ColorManageController {

	/**
	 * 查询色系列表
	 * 
	 * @Methods Name fingColorDict
	 * @Create In 2015年8月20日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/fingColorDict", method = { RequestMethod.GET, RequestMethod.POST })
	public String fingColorDict(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("start", 0);
			map.put("limit", 100);
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/colorDict/selectColorDict.htm", JsonUtil.getJSONString(map));
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
			map.put("list", null);
			map.put("pageCount", 0);
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 查询包装名称与包装编码是否已存在
	 * 
	 * @Methods Name getColorNameAndColorAlias
	 * @Create In 2015-3-20 By wangsy
	 * @param colorName
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getColorNameAndColorAlias", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getColorNameAndColorAlias(String colorName, String colorAlias) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (!(null == colorName || "".equals(colorName))) {
				map.put("colorName", colorName);
			}
			if (!(null == colorAlias || "".equals(colorAlias))) {
				map.put("colorAlias", colorAlias);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bw/getColorNameAndColorAlias.html", map);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 商品模块-商品信息管理-包装单位管理-查询所有
	 * 
	 * @Methods Name queryAllColor
	 * @Create In 2015-3-20 By wangsy
	 * @param colorName
	 * @param pageSize
	 * @param start
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectAllColor", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryAllColor(HttpServletRequest request, HttpServletResponse response,
			String colorName) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		int start = (currPage - 1) * size;
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (!(null == colorName || "".equals(colorName))) {
				map.put("colorName", colorName);
			}
			map.put("start", start);
			map.put("limit", size);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllColor.html", map);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/insertOrUpdate", method = { RequestMethod.GET, RequestMethod.POST })
	public String insertColor(String colorName, String sid, String colorAlias) {

		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(sid)) {
				map.put("sid", sid);
			}
			map.put("colorAlias", colorAlias);
			map.put("colorName", colorName);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/insertOrUpdate.html", map);
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteColor", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteColor(String sid) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("sid", sid);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/deleteColor.html", map);
		} catch (Exception e) {
			// TODO: handle exception
			json = "{'success:false'}";
		}
		return json;
	}
}
