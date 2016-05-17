package com.wangfj.wms.controller.category;

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
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.domain.view.PropsdictAddVO;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

/**
 * 属性字典控制器
 * 
 * @Class Name CategoryPropsDictController
 * @Author wangsy
 * @Create In 2015年8月7日
 */
@Controller
public class CategoryPropsDictController {

	/**
	 * 属性字典列表
	 * 
	 * @Methods Name list
	 * @Create In 2015年8月7日 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param propsName
	 * @param propsDesc
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/propsdict/list", method = { RequestMethod.POST, RequestMethod.GET })
	public String list(Model model, HttpServletRequest request, HttpServletResponse response,
			String propsName, String propsDesc, String channelSid) {
		String json = null;
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
			if (null != propsDesc && !"".equals(propsDesc)) {
				map.put("propsDesc", propsDesc);
			}
			if (null != channelSid && !"".equals(channelSid)) {
				map.put("channelSid", channelSid);
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/propsdictcontroller/bw/propsdictList.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {

		} finally {

		}
		return json;

	}

	/**
	 * 属性和属性值添加
	 * 
	 * @Methods Name add
	 * @Create In 2015年8月28日 By wangsy
	 * @param vo
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/propsdict/add", method = { RequestMethod.POST, RequestMethod.GET })
	public String add(PropsdictAddVO vo) {
		String json = "";

		Map<String, Object> map = new HashMap<String, Object>();
		if (null != vo.getId() & !"".equals(vo.getId())) {
			map.put("id", vo.getId());
		}
		if (null != vo.getSid() & !"".equals(vo.getSid())) {
			map.put("sid", vo.getSid());
		}
		if (null != vo.getPropsName() & !"".equals(vo.getPropsName())) {
			map.put("propsName", vo.getPropsName());
		}
		if (null != vo.getIsKeyProp() & !"".equals(vo.getIsKeyProp())) {
			map.put("isKeyProp", vo.getIsKeyProp());
		}
		if (null != vo.getIsEnumProp() & !"".equals(vo.getIsEnumProp())) {
			map.put("isEnumProp", vo.getIsEnumProp());
		}
		if (null != vo.getErpType() & !"".equals(vo.getErpType())) {
			map.put("erpType", vo.getErpType());
		}
		if (null != vo.getIsErpProp() & !"".equals(vo.getIsErpProp())) {
			map.put("isErpProp", vo.getIsErpProp());
			// 如果不是ERP属性，erpType为2、、、无
			if (Integer.valueOf(vo.getIsErpProp()) == 0) {
				map.put("erpType", 2);
			}
		}
		if (null != vo.getInsert1() || !"".equals(vo.getInsert1())||!"[]".equals(vo.getInsert1())) {
			map.put("insert1", vo.getInsert1());
		}
		if (null != vo.getUpdate1() & !"".equals(vo.getUpdate1())) {
			map.put("update1", vo.getUpdate1());
		}
		if (null != vo.getPropsDesc() & !"".equals(vo.getPropsDesc())) {
			map.put("propsDesc", vo.getPropsDesc());
		}
		if (null != vo.getStatus() & !"".equals(vo.getStatus())) {
			map.put("status", vo.getStatus());
		}
		if (null != vo.getDelete1() & !"".equals(vo.getDelete1())) {
			map.put("delete1", vo.getDelete1());
		}
		if (null != vo.getChannelSid() & !"".equals(vo.getChannelSid())) {
			map.put("channelSid", vo.getChannelSid());
		} else {
			map.put("channelSid", 0);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/propsdictcontroller/bw/propsdictAdd.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 修改属性和属性值
	 * 
	 * @Methods Name edit
	 * @Create In 2015年8月7日 By wangsy
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/propsdict/edit", method = { RequestMethod.POST, RequestMethod.GET })
	public String edit(Model m, HttpServletRequest request, HttpServletResponse response, String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id & !"".equals(id)) {
			map.put("id", id);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/propsdictEdit.json", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 删除属性字典
	 * 
	 * @Methods Name del
	 * @Create In 2015年8月8日 By wangsy
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/propsdict/del", method = RequestMethod.POST)
	public String del(Model m, HttpServletRequest request, HttpServletResponse response, String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			// 属性sid
			if (null != id & !"".equals(id)) {
				map.put("sid", id);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/propsdictcontroller/bw/propsdictDel.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 类目属性管理中点击编辑的属性名称列表
	 * 
	 * @Methods Name comboxlist
	 * @Create In 2015年8月7日 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param id
	 * @param name
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/propscombox/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String comboxlist(Model model, HttpServletRequest request, HttpServletResponse response,
			String id, String propsName) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("sid", id);
		}
		if (null != propsName && !"".equals(propsName)) {
			map.put("propsName", propsName);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/propsdictcontroller/bw/propscomboxList.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/selectvalueDictByCateSid", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectvalueDictByCateSid(String categorySid) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != categorySid && !"".equals(categorySid)) {
			map.put("sid", categorySid);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/selectPropValueByCateSid.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}
}
