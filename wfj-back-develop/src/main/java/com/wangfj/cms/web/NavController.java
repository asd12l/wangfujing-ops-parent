package com.wangfj.cms.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.wms.util.ResultUtil;
import com.wfj.netty.servlet.util.StringUtil;

import common.Logger;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "nav")
public class NavController {
	private Logger logger = Logger.getLogger(NavController.class);

	private String className = NavController.class.getName();

	/**
	 * 加载导航树
	 * 
	 * @Methods Name getTree
	 * @Create In 2016年4月1日 By wangsy
	 * @param request
	 * @param response
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "navTree")
	public String getTree(HttpServletRequest request, HttpServletResponse response, String id) {
		String methodName = "getTree";
		String sid = request.getParameter("sid");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sid", sid);
		if(!StringUtil.isEmpty(id)){
			map.put("id", id);
		}
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/nav/getNavTreeFirst.do", map);
			JSONObject obj = JSONObject.fromObject(json);
			if (obj.get("success").equals("true")) {
				json = obj.getString("list");
			} else {
				json = "[{'id':0,'name':'根节点','pId':-1,'isShow':1}]";
			}
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 加载导航详情
	@ResponseBody
	@RequestMapping(value = "load_nav")
	public String getNav(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "getNav";
		String sid = request.getParameter("sid");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sid", sid);
		String json = "";
		JSONObject jsonobj = new JSONObject();
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/nav/n_edit.do", map);
			jsonobj.put("list", json);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return jsonobj.toString();
	}

	// 加载导航列表
	@ResponseBody
	@RequestMapping(value = "list")
	public String getNavlist(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "getNavlist";
		String sid = request.getParameter("sid");
		String channelSid = request.getParameter("channelSid");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", sid);
		map.put("channelSid", channelSid);
		String json = "";
		JSONObject jsonobj = new JSONObject();
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/nav/n_childlist.do", map);
			jsonobj.put("list", json);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return jsonobj.toString();
	}

	// 添加导航
	@ResponseBody
	@RequestMapping(value = "save")
	public String saveNav(HttpServletRequest request, HttpServletResponse response, String enName,
			String channelSid, String navSid, String name, String link, String seq, String isShow) {
		String methodName = "saveNav";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("channelSid", channelSid);
		map.put("navSid", navSid);
		map.put("name", name);
		map.put("enName", enName);
		map.put("link", link);
		map.put("seq", seq);
		map.put("isShow", isShow);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/nav/n_save.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 修改导航
	@ResponseBody
	@RequestMapping(value = "edit")
	public String updateNav(HttpServletRequest request, HttpServletResponse response,
			String enName, String sid, String name, String link, String seq, String isShow) {
		String methodName = "updateNav";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sid", sid);
		map.put("name", name);
		map.put("enName", enName);
		map.put("link", link);
		map.put("seq", seq);
		map.put("isShow", isShow);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/nav/n_update.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 删除导航
	@ResponseBody
	@RequestMapping(value = "del")
	public String delNav(HttpServletRequest request, HttpServletResponse response, String sid) {
		String methodName = "delNav";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sid", sid);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/nav/n_delete.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}
}
