package com.wangfj.wms.controller.channel;

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

/**
 * 渠道展示Controller
 * 
 * @Class Name ChannelDisplayController
 * @Author wangxuan
 * @Create In 2015-8-20
 */
@Controller
@RequestMapping(value = "/channelDisplay")
public class ChannelDisplayController {

	/**
	 * 分页查询渠道
	 * 
	 * @Methods Name queryPageChannel
	 * @Create In 2015-8-21 By wangxuan
	 * @param channelName
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/queryPageChannel", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String queryPageChannel(String channelName, String channelCode,
			HttpServletRequest request, HttpServletResponse response) {

		String currentPage = request.getParameter("page");
		String pageSize = request.getParameter("pageSize");

		Map<String, Object> para = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(currentPage)) {
			para.put("currentPage", currentPage);
		} else {
			para.put("currentPage", "1");
		}

		if (StringUtils.isNotEmpty(pageSize)) {
			para.put("pageSize", pageSize);
		} else {
			para.put("pageSize", "10");
		}

		if (StringUtils.isNotEmpty(channelName)) {
			para.put("channelName", channelName);
		}
		if (StringUtils.isNotEmpty(channelCode)) {
			para.put("channelCode", channelCode);
		}

		String json = "";
		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {
			String url = SystemConfig.SSD_SYSTEM_URL + "/pcmAdminChannel/findPageChannel.htm";
			json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));

			JSONObject jsonObject = JSONObject.fromObject(json);
			String page = (String) jsonObject.getString("data");
			JSONObject pageJson = JSONObject.fromObject(page);

			String pages = pageJson.getString("pages");
			@SuppressWarnings("unchecked")
			List<Object> list = (List<Object>) pageJson.get("list");

			if (list != null && !list.isEmpty()) {
				returnMap.put("list", list);
				returnMap.put("pageCount", pages);
				returnMap.put("success", "true");
			} else {
				returnMap.put("success", "false");
				returnMap.put("pageCount", 0);
			}

		} catch (Exception e) {
			returnMap.put("success", "false");
			returnMap.put("pageCount", 0);
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(returnMap);

	}

	/**
	 * 查询所有渠道
	 * 
	 * @Methods Name queryAllChannelDisplays
	 * @Create In 2015-8-21 By wangxuan
	 * @param channelName
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/queryAllChannelDisplays", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String queryAllChannelDisplays(String channelStatus, HttpServletRequest request) {

		Map<String, Object> para = new HashMap<String, Object>();
		para.put("status", channelStatus);
		
		String json = "";
		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {
			String url = SystemConfig.SSD_SYSTEM_URL + "/pcmAdminChannel/findListChannel.htm";
			json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));

			JSONObject jsonObject = JSONObject.fromObject(json);
			@SuppressWarnings("unchecked")
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && !list.isEmpty()) {
				returnMap.put("list", list);
				returnMap.put("success", "true");
			} else {
				returnMap.put("success", "false");
				returnMap.put("pageCount", 0);
			}

		} catch (Exception e) {
			returnMap.put("success", "false");
			returnMap.put("pageCount", 0);
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(returnMap);

	}

	/**
	 * 添加渠道
	 * 
	 * @Methods Name addChannel
	 * @Create In 2015-8-21 By wangxuan
	 * @param channelName
	 * @param status
	 * @param username
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/addChannel", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String addChannel(String channelCode, String channelName, String status,
			String username, HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> para = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(channelCode)) {
			para.put("channelCode", channelCode);
		}
		if (StringUtils.isNotEmpty(channelName)) {
			para.put("channelName", channelName);
		}
		if (StringUtils.isNotEmpty(status)) {
			para.put("status", status);
		}
		if (StringUtils.isNotEmpty(username)) {
			para.put("optUser", username);
		}

		String json = "";
		String url = SystemConfig.SSD_SYSTEM_URL + "/pcmAdminChannel/addChannel.htm";

		try {
			json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));
		} catch (Exception e) {
			json = "{'success':'false'}";
		}

		return json;

	}

	/**
	 * 修改渠道
	 * 
	 * @Methods Name modifyChannel
	 * @Create In 2015-8-21 By wangxuan
	 * @param channelName
	 * @param status
	 * @param username
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/modifyChannel", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String modifyChannel(String sid, String channelCode, String channelName, String status,
			String username, HttpServletRequest request, HttpServletResponse response) {

		Map<String, Object> para = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(sid)) {
			para.put("sid", sid);
		}
		if (StringUtils.isNotEmpty(channelCode)) {
			para.put("channelCode", channelCode);
		}
		if (StringUtils.isNotEmpty(channelName)) {
			para.put("channelName", channelName);
		}
		if (StringUtils.isNotEmpty(status)) {
			para.put("status", status);
		}
		if (StringUtils.isNotEmpty(username)) {
			para.put("optUser", username);
		}

		String json = "";
		String url = SystemConfig.SSD_SYSTEM_URL + "/pcmAdminChannel/upateChannel.htm";

		try {
			json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));
		} catch (Exception e) {
			json = "{'success':'false'}";
		}

		return json;

	}

	@RequestMapping(value = "/findChannelBySid", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public String findChannelBySid(String sid, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> para = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(sid)) {
			para.put("sid", sid);
		}

		String json = "";
		String url = SystemConfig.SSD_SYSTEM_URL + "/pcmAdminChannel/findChannelBySid.htm";

		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {
			json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));

			JSONObject obj = JSONObject.fromObject(json);

			if (obj != null) {
				returnMap.put("obj", obj);
				returnMap.put("success", "true");
			} else {
				returnMap.put("success", "false");
			}

		} catch (Exception e) {
			returnMap.put("success", "false");
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(returnMap);

	}

}
