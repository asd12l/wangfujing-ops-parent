package com.wangfj.cms.main;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.wms.util.ResultUtil;

@Controller
@RequestMapping(value = "pindao")
public class PindaoController {
	private static final Logger logger = LoggerFactory.getLogger(PindaoController.class);

	private String className = PindaoController.class.getName();

	// 添加频道
	@ResponseBody
	@RequestMapping(value = "add")
	public String getUpChannel(HttpServletRequest request, HttpServletResponse response,
			Integer root) {
		String methodName = "getUpChannel";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("root", root);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/channel/v_add.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 保存频道
	 * 
	 * @Methods Name save
	 * @Create In 2016年3月30日 By wangsy
	 * @param request
	 * @param response
	 * @param siteId
	 * @param root
	 * @param name
	 * @param path
	 * @param tplChannel
	 * @param priority
	 * @param indexFlag
	 * @param display
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "save")
	public String save(HttpServletRequest request, HttpServletResponse response, Integer siteId,
			Integer root, String name, String path, String tplChannel, String priority,
			String indexFlag, String display) {
		String methodName = "save";
		Map<String, Object> map = new HashMap<String, Object>();
		if (root == null) {
			root = -1;
		}
		map.put("root", root);
		map.put("name", name);
		map.put("path", path);
		map.put("indexFlag", indexFlag);
		map.put("tplChannel", tplChannel);
		map.put("priority", priority);
		map.put("display", display);
		map.put("siteId", siteId);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/channel/o_save.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 编辑频道
	@ResponseBody
	@RequestMapping(value = "edit")
	public String edit(Integer id, Integer root, HttpServletRequest request,
			HttpServletResponse response) {
		String methodName = "edit";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		if (root == null) {
			root = 0;
		}
		map.put("root", root);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/channel/v_edit.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 修改频道
	@ResponseBody
	@RequestMapping(value = "update")
	public String update(HttpServletRequest request, HttpServletResponse response, Integer id,
			String name, String path, String tplChannel, String priority, String parentId,
			String display, String indexFlag) {
		String methodName = "update";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("name", name);
		map.put("path", path);
		map.put("indexFlag", indexFlag);
		map.put("tplChannel", tplChannel);
		map.put("priority", priority);
		map.put("display", display);
		if (parentId == null) {
			parentId = "";
		}
		map.put("parentId", parentId);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/channel/o_update.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 删除频道
	@ResponseBody
	@RequestMapping(value = "del")
	public String del(HttpServletRequest request, HttpServletResponse response, Integer id) {
		String methodName = "del";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/channel/o_delete.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}
}
