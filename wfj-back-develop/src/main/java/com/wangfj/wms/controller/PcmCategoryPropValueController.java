package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;

@Controller
public class PcmCategoryPropValueController {
	/**
	 * 根据三级分类查询所有的属性集合及对应的属性值集合
	 * 
	 * @Methods Name getPropsAndValuesByCategory
	 * @Create In 2015-3-6 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/props/getPropsAndValuesByCategory", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getPropsAndValuesByCategory(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		String categoryId = request.getParameter("categoryId");
		if (StringUtils.isNotEmpty(categoryId)) {
			map.put("categoryId", categoryId);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bw/getPropsAndValuesByCategory.json", map);
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}
		return json;
	}

	/**
	 * 获取分类属性列表
	 * 
	 * @Methods Name list
	 * @Create In 2015年8月7日 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param propsName
	 * @param cid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/props/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model, HttpServletRequest request, HttpServletResponse response,
			String propsName, String cid) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		int start = (currPage - 1) * size;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("limit", size);
		try {
			if (null != propsName && !"".equals(propsName)) {
				map.put("propsName", propsName);
			}
			if (null != cid && !"".equals(cid)) {
				map.put("cid", cid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/propvaluecontroller/bw/listAllValue.htm", map);
			if ("".equals(json)) {
				map.put("list", null);
				map.put("pageCount", 0);
			}
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 类目属性值列表
	 * 
	 * @Methods Name valueList
	 * @Create In 2015年8月7日 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param propsSid
	 * @param categorySid
	 * @param channelSid
	 * @param page
	 * @param rows
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/values/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String valueList(Model model, HttpServletRequest request, HttpServletResponse response,
			String propsSid, String categorySid, String channelSid, String page, String rows) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != propsSid && !"".equals(propsSid)) {
			map.put("propsSid", propsSid);
		}
		if (null != categorySid && !"".equals(categorySid)) {
			map.put("categorySid", categorySid);
		}
		if (null != channelSid && !"".equals(channelSid)) {
			map.put("channelSid", channelSid);
		}
		if (null != page && !"".equals(page)) {
			map.put("page", page);
		}
		if (null != rows && !"".equals(rows)) {
			map.put("rows", rows);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/propvaluecontroller/bw/Lists.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}
	
	/**
	 * 类目属性值列表2
	 * 
	 * @Methods Name valueList
	 * @Create In 2015年8月7日 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param propsSid
	 * @param categorySid
	 * @param channelSid
	 * @param page
	 * @param rows
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/values/list1", method = { RequestMethod.GET, RequestMethod.POST })
	public String valueList1(HttpServletRequest request,String propSid) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != propSid && !"".equals(propSid)) {
			map.put("sid", propSid);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"categoryValuesDict/bw/selectValueDictByPropSid.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 编辑保存分类和属性
	 * 
	 * @Methods Name addPropsAndValues
	 * @Create In 2015年8月8日 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param cid
	 * @param name
	 * @param propsid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/provalues/add", method = { RequestMethod.POST, RequestMethod.GET })
	public String addPropsAndValues(Model model, HttpServletRequest request,
			HttpServletResponse response, String cid, String name, String propsid,String notNull) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != cid && !"".equals(cid)) {
			map.put("cid", cid);
		}
		if (null != name && !"".equals(name)) {
			map.put("name", name);
		}
		if (null != propsid && !"".equals(propsid)) {
			map.put("propsSid", propsid);
		}
		if (null != notNull && !"".equals(notNull)) {
			map.put("notNull", notNull);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/propvaluecontroller/bw/addd.htm", map);
		} catch (Exception e) {

		}
		return json;
	}

	/**
	 * 分类编辑属性
	 * 
	 * @Methods Name update
	 * @Create In 2015年8月7日 By wangsy
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/propvals/edit", method = { RequestMethod.POST, RequestMethod.GET })
	public String update(Model m, HttpServletRequest request, HttpServletResponse response,
			String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("cid", id);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/propvaluecontroller/bw/editl.htm", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/chancombox/list", method = { RequestMethod.POST, RequestMethod.GET })
	public String comboxlist(Model model, HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/comboxlistlist.html", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return json;
	}
}
