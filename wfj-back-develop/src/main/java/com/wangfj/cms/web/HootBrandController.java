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

import common.Logger;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "hootBrand")
public class HootBrandController {
	private Logger logger = Logger.getLogger(HootBrandController.class);

	private String className = HootBrandController.class.getName();

	/**
	 * 查询导航下品牌列表
	 * 
	 * @Methods Name getList
	 * @Create In 2015年12月25日 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "brandList")
	public String getList(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "getList";
		String sid = request.getParameter("sid");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nav_sid", sid);
		String json = "";
		JSONObject jsonobj = new JSONObject();
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/brand/b_list.do", map);
			jsonobj.put("list", json);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return jsonobj.toString();
	}

	/**
	 * 删除热门品牌
	 * 
	 * @Methods Name delBrand
	 * @Create In 2016年3月31日 By wangsy
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "delBrand")
	public String delBrand(HttpServletRequest request, HttpServletResponse response, String sid, String nodeId) {
		String methodName = "delBrand";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sid", sid);
		map.put("nodeId", nodeId);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/brand/b_delete.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "saveBrand")
	public String saveBrand(HttpServletRequest request, HttpServletResponse response, String ids,
			Integer navSid, String names, String picts, String brandLink) {
		String methodName = "saveBrand";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ids", ids);
		map.put("id", navSid);
		map.put("brandName", names);
		map.put("picts", picts);
		map.put("brandLink", brandLink);

		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/brand/b_save.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}
}
