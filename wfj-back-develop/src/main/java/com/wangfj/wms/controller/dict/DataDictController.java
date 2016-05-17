package com.wangfj.wms.controller.dict;

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
 * 数据字典管理
 * 
 * @Class Name DataDictController
 * @Author wangxuan
 * @Create In 2015-9-16
 */
@Controller
@RequestMapping(value = "/dataDict")
public class DataDictController {

	/**
	 * 分页查询数据字典
	 * 
	 * @Methods Name queryPageDataDict
	 * @Create In 2015-9-16 By wangxuan
	 * @param request
	 * @param response
	 * @param sid
	 * @param pid
	 * @param name
	 * @param code
	 * @param status
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/queryPageDataDict" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPageDataDict(HttpServletRequest request, HttpServletResponse response,
			String sid, String pid, String name, String code, String status) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.valueOf(Integer
				.parseInt(request.getParameter("pageSize")));
		Integer currPage = request.getParameter("page") == null ? null : Integer.valueOf(Integer
				.parseInt(request.getParameter("page")));

		Map<String, Object> para = new HashMap<String, Object>();

		if ((size == null) || (size.intValue() == 0)) {
			size = Integer.valueOf(10);
		}
		if ((currPage == null) || (currPage.intValue() == 0)) {
			currPage = Integer.valueOf(1);
		}

		para.put("currentPage", currPage);
		para.put("pageSize", size);

		if (StringUtils.isNotEmpty(sid)) {
			para.put("sid", Long.parseLong(sid));
		}

		if (StringUtils.isNotEmpty(pid)) {
			para.put("pid", Long.parseLong(pid));
		}

		if (StringUtils.isNotEmpty(name)) {
			para.put("name", name);
		}

		if (StringUtils.isNotEmpty(code)) {
			para.put("code", code);
		}

		if (StringUtils.isNotEmpty(status)) {
			para.put("status", status);
		}

		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/dict/findPageDictInfo.htm",
					JsonUtil.getJSONString(para));
			para.clear();
			if (StringUtils.isNotEmpty(json)) {
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

	/**
	 * 添加数据字典
	 * 
	 * @Methods Name addDataDict
	 * @Create In 2015-9-16 By wangxuan
	 * @param request
	 * @param response
	 * @param pid
	 * @param name
	 * @param code
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/addDataDict" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String addDataDict(HttpServletRequest request, HttpServletResponse response, String pid,
			String name, String code, String status) {
		String json = "";
		try {
			Map<String, Object> para = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(pid)) {
				para.put("pid", Long.parseLong(pid));
			}

			if (StringUtils.isNotEmpty(name)) {
				para.put("name", name);
			}

			if (StringUtils.isNotEmpty(code)) {
				para.put("code", code);
			}

			if (StringUtils.isNotEmpty(status)) {
				para.put("status", status);
			}

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/dict/saveDictInfo.htm",
					JsonUtil.getJSONString(para));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 修改数据字典
	 * 
	 * @Methods Name modifyDataDict
	 * @Create In 2015-9-16 By wangxuan
	 * @param request
	 * @param response
	 * @param sid
	 * @param pid
	 * @param name
	 * @param code
	 * @param status
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/modifyDataDict" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyDataDict(HttpServletRequest request, HttpServletResponse response,
			String sid, String pid, String name, String code, String status) {
		String json = "";
		try {
			Map<String, Object> para = new HashMap<String, Object>();

			if (StringUtils.isNotEmpty(sid)) {
				para.put("sid", Long.parseLong(sid));
			}

			if (StringUtils.isNotEmpty(pid)) {
				para.put("pid", Long.parseLong(pid));
			}

			if (StringUtils.isNotEmpty(name)) {
				para.put("name", name);
			}

			if (StringUtils.isNotEmpty(code)) {
				para.put("code", code);
			}

			if (StringUtils.isNotEmpty(status)) {
				para.put("status", status);
			}

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/dict/updateDictInfo.htm",
					JsonUtil.getJSONString(para));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 删除数据字典
	 * 
	 * @Methods Name deleteDataDict
	 * @Create In 2015-9-16 By wangxuan
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/deleteDataDict" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteDataDict(HttpServletRequest request, HttpServletResponse response,
			String sid) {
		String json = "";
		try {
			Map<String, Object> para = new HashMap<String, Object>();

			if (StringUtils.isNotEmpty(sid)) {
				para.put("sid", Long.parseLong(sid));
			}

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/dict/deleteDictInfo.htm",
					JsonUtil.getJSONString(para));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 查询数据字典
	 * 
	 * @Methods Name queryDataDictList
	 * @Create In 2015-9-16 By wangxuan
	 * @param request
	 * @param response
	 * @param sid
	 * @param pid
	 * @param name
	 * @param code
	 * @param status
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/queryDataDictList" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryDataDictList(HttpServletRequest request, HttpServletResponse response,
			String sid, String pid, String name, String code, String status) {
		String json = "";
		Map<String, Object> para = new HashMap<String, Object>();

		if (StringUtils.isNotEmpty(sid)) {
			para.put("sid", Long.parseLong(sid));
		}

		if (StringUtils.isNotEmpty(pid)) {
			para.put("pid", Long.parseLong(pid));
		}

		if (StringUtils.isNotEmpty(name)) {
			para.put("name", name);
		}

		if (StringUtils.isNotEmpty(code)) {
			para.put("code", code);
		}

		if (StringUtils.isNotEmpty(status)) {
			para.put("status", status);
		}

		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/dict/getDictInfo.htm",
					JsonUtil.getJSONString(para));

			para.clear();
			JSONObject jsonObject = JSONObject.fromObject(json);

			List<?> list = (List<?>) jsonObject.get("data");
			if ((list != null) && (list.size() != 0)) {
				para.put("list", list);
				para.put("success", "true");
			} else {
				para.put("success", "false");
			}
		} catch (Exception e) {
			para.put("success", "false");
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(para);
	}

	/**
	 * 批量查询字典信息
	 * 
	 * @Methods Name findDictByPidInfo
	 * @Create In 2015年9月24日 By wangsy
	 * @param codes
	 *            code1，code2
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/findDictByPidInfo" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findDictByPidInfo(String codes) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (StringUtils.isNotEmpty(codes)) {
				map.put("parentCode", codes);
				json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
						+ "/dict/findDictByPidInfo.htm", JsonUtil.getJSONString(map));
			}
		} catch (Exception e) {
			json = "";
		}
		return json;
	}
}
