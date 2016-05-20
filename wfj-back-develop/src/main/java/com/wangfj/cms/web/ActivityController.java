package com.wangfj.cms.web;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.cms.utils.CdnHelper;
import com.wangfj.wms.util.ResultUtil;
import common.Logger;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "promotion")
public class ActivityController {
	private Logger logger = Logger.getLogger(ActivityController.class);

	private String className = ActivityController.class.getName();

	/**
	 * 活动列表
	 * 
	 * @Methods Name getList
	 * @Create In 2016年3月31日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "promotionList")
	public String getList(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "getList";
		String sid = request.getParameter("sid");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nav_sid", sid);
		String json = "";
		JSONObject jsonobj = new JSONObject();
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/active/a_list.do", map);
			jsonobj.put("list", json);
			jsonobj.put("resource_root_path",SystemConfig.CMS_IMAGE_SERVER);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return jsonobj.toString();
	}

	/**
	 * 删除活动
	 * 
	 * @Methods Name delPro
	 * @Create In 2016年3月31日 By wangsy
	 * @param request
	 * @param response
	 * @param sid
	 * @param nodeId
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "delPro")
	public String delPro(HttpServletRequest request, HttpServletResponse response, String sid,
			String nodeId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sid", sid);
		map.put("nodeId", nodeId);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/active/a_delete.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":delPro_ " + e.getMessage());
		}
		return json;
	}

	/**
	 * 添加促销活动
	 * 
	 * @Methods Name savePro
	 * @Create In 2016年3月31日 By wangsy
	 * @param request
	 * @param response
	 * @param navSid
	 * @param name
	 * @param link
	 * @param seq
	 * @param isShow
	 * @param pict
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "savePro")
	public String savePro(HttpServletRequest request, HttpServletResponse response, String navSid,
			String name, String link, String seq, String isShow, String pict) {
		String methodName = "savePro";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("navSid", navSid);
		map.put("name", name);
		map.put("link", link);
		map.put("seq", seq);
		map.put("isShow", isShow);
		map.put("pict", pict);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/active/a_save.do", map);
			if (StringUtils.isNotBlank(json)) {
				JSONObject jsono = new JSONObject();
				jsono = JSONObject.fromObject(json);
				if (jsono.get("success").toString().equals("true")) {
					String imgPath = pict.substring(0, pict.lastIndexOf("/") + 1);
					CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { imgPath });
				}
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 修改促销活动
	 * 
	 * @Methods Name updatePro
	 * @Create In 2016年3月31日 By wangsy
	 * @param request
	 * @param response
	 * @param sid
	 * @param name
	 * @param link
	 * @param seq
	 * @param isShow
	 * @param pict
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "edit")
	public String updatePro(HttpServletRequest request, HttpServletResponse response, String sid,
			String name, String link, String seq, String isShow, String pict, String nodeId) {
		String methodName = "updatePro";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sid", sid);
		map.put("name", name);
		map.put("link", link);
		map.put("seq", seq);
		map.put("isShow", isShow);
		map.put("pict", pict);
		map.put("nodeId", nodeId);
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/active/a_update.do", map);
			JSONObject js = JSONObject.fromObject(json);
			if (js.get("success").equals("true")) {
				String imgPath = pict.substring(0, pict.lastIndexOf("/") + 1);
				CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { imgPath });
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}
}
