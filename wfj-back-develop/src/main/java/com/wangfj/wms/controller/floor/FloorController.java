package com.wangfj.wms.controller.floor;

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
import com.wangfj.wms.controller.floor.support.PcmFloorPara;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

/**
 * 楼层管理
 * 
 * @Class Name FloorController
 * @Author wangsy
 * @Create In 2015年8月6日
 */
@Controller
@RequestMapping(value = "/floor")
public class FloorController {

	/**
	 * 商品供应商管理分页查询
	 * 
	 * @Methods Name queryFloor
	 * @Create In 2015-8-20 By huangcw
	 * @param request
	 * @param response
	 * @param floorCode
	 * @param floorName
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryFloor", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryFloor(HttpServletRequest request, HttpServletResponse response,
			String floorCode, String shopSid, String floorName) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		int start = (currPage - 1) * size;
		Map<String, Object> map = new HashMap<String, Object>();
		PcmFloorPara floorPara = new PcmFloorPara();
		floorPara.setCurrentPage(currPage);
		floorPara.setPageSize(size);
		if (StringUtils.isNotEmpty(floorCode)) {
			floorPara.setFloorCode(floorCode);
		}
		if (StringUtils.isNotEmpty(shopSid)) {
			floorPara.setShopSid(Long.parseLong(shopSid));
		}
		if (StringUtils.isNotEmpty(floorName)) {
			floorPara.setFloorName(floorName);
		}
		Map<String, Object> m = new HashMap<String, Object>();
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/floor/findPageFloor.htm",
					JsonUtil.getJSONString(floorPara));
			JSONObject jsonObject = JSONObject.fromObject(json);
			String page = jsonObject.getString("data");
			JSONObject jsonObject2 = JSONObject.fromObject(page);
			@SuppressWarnings("unchecked")
			List<Object> list = (List<Object>) jsonObject2.get("list");
			Integer count = jsonObject2.getInt("count");
			int pageCount = count % size == 0 ? count / size : (count / size + 1);
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("pageCount", pageCount);
				m.put("success", "true");
			} else {
				m.put("success", "false");
				m.put("pageCount", 0);
			}

		} catch (Exception e) {
			m.put("pageCount", 0);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

	/**
	 * 修改
	 * 
	 * @Methods Name updatefloor
	 * @Create In 2015-8-25 By huangcw
	 * @param floorName
	 * @param sid
	 * @param floorCode
	 * @param floorStatus
	 * @param shopSid
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/updatefloor", method = { RequestMethod.GET, RequestMethod.POST })
	public String updatefloor(String floorName, String sid, String floorCode, String floorStatus,
			String shopSid, HttpServletRequest request) {

		PcmFloorPara pcmFloorPara = new PcmFloorPara();
		if (StringUtils.isNotEmpty(sid)) {
			pcmFloorPara.setSid(Long.parseLong(sid));
		}

		if (StringUtils.isNotEmpty(shopSid)) {
			long shopSid1 = Long.parseLong(shopSid);
			pcmFloorPara.setShopSid(shopSid1);
		}
		if (StringUtils.isNotEmpty(floorName)) {
			pcmFloorPara.setName(floorName);
		}
		if (StringUtils.isNotEmpty(floorCode)) {
			pcmFloorPara.setCode(floorCode);
		}
		if (StringUtils.isNotEmpty(floorStatus)) {
			pcmFloorPara.setFloorStatus(Integer.parseInt(floorStatus));
		}
		pcmFloorPara.setFromSystem("PCM");

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/floor/modifyFloor.htm",
					JsonUtil.getJSONString(pcmFloorPara));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	/**
	 * 添加
	 * 
	 * @Methods Name saveFloor
	 * @Create In 2015-8-20 By huangcw
	 * @param floorName
	 * @param sid
	 * @param floorCode
	 * @param floorStatus
	 * @param shopSid
	 * @param request
	 * @return String
	 */

	@ResponseBody
	@RequestMapping(value = "/saveFloor", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveFloor(String floorName, String sid, String floorCode, String floorStatus,
			String shopSid, HttpServletRequest request) {

		PcmFloorPara pcmFloorPara = new PcmFloorPara();
		if (StringUtils.isNotEmpty(shopSid)) {
			pcmFloorPara.setShopSid(Long.parseLong(shopSid));
		}
		if (StringUtils.isNotEmpty(floorName)) {
			pcmFloorPara.setName(floorName);
		}
		if (StringUtils.isNotEmpty(floorCode)) {
			pcmFloorPara.setCode(floorCode);
		}
		if (StringUtils.isNotEmpty(floorStatus)) {
			pcmFloorPara.setFloorStatus(Integer.parseInt(floorStatus));
		}
		pcmFloorPara.setFromSystem("PCM");

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/floor/addFloor.htm",
					JsonUtil.getJSONString(pcmFloorPara));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryListFloor", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryListOrganization(HttpServletRequest request, HttpServletResponse response,
			String organizationType) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(organizationType)) {
			map.put("organizationType", "3");
		}

		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/organization/findListOrganization.htm", JsonUtil.getJSONString(map));
			map.clear();
			JSONObject jsonObject = JSONObject.fromObject(json);
			List<Object> list = (List<Object>) jsonObject.get("list");
			if (list != null && list.size() != 0) {
				map.put("list", list);
				map.put("success", "true");
			} else {
				map.put("success", "false");
			}

		} catch (Exception e) {
			map.put("success", "false");
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}
}
