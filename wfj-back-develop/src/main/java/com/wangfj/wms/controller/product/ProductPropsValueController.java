package com.wangfj.wms.controller.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.constants.SystemConfig;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.domain.view.ParametersDto;
import com.wangfj.wms.domain.view.SaveProductParametersVO;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

/**
 * 产品属性维护
 * 
 * @Class Name ProductPropsValueController
 * @Author duanzhaole
 * @Create In 2015年8月20日
 */
@RequestMapping(value = "/productprops")
@Controller
public class ProductPropsValueController {

	/**
	 * 通过叶子节点查询产品信息
	 * 
	 * @Methods Name selectSpuByIsLeaf
	 * @Create In 2015年8月20日 By duanzhaole
	 * @param model
	 * @param request
	 * @param response
	 * @param propsName
	 * @param cid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectSpuByIsLeaf", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectSpuByIsLeaf(Model model, HttpServletRequest request,
			HttpServletResponse response, String propsName, String cid) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		// int start = (currPage - 1) * size;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageSize", size);// 每页显示数量
		map.put("currenPage", currPage);// 当前第几页
		try {
			if (null != cid && !"".equals(cid)) {
				map.put("sid", cid);
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/bwCategoryController/bw/selectSpuByIsLeaf.htm", map);
				if (json == null || json.equals("")) {
					map.clear();
					map.put("error", "查询为空");
					json = JsonUtil.getJSONString(map);
				}
			} else {
				map.clear();
				map.put("list", null);
				map.put("pageCount", 0);
				json = JsonUtil.getJSONString(map);
			}
		} catch (Exception e) {
			map.clear();
			map.put("list", null);
			map.put("pageCount", 0);
			json = JsonUtil.getJSONString(map);
		} finally {

		}
		return json;
	}

	/**
	 * 通过叶子节点查询属性字典信息
	 * 
	 * @Methods Name selectPropDictByIsLeaf
	 * @Create In 2015年8月20日 By duanzhaole
	 * @param model
	 * @param request
	 * @param response
	 * @param propsName
	 * @param cid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectPropValueBySid", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectPropDictByIsLeaf(String cid, String productSid, String isnotnull,
			HttpServletRequest request, HttpServletResponse response, String propsName) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (null != cid && !"".equals(cid)) {
				map.put("sid", cid);
			}
			if (null != productSid && !"".equals(productSid)) {
				map.put("productSid", productSid);
			}
			if (null != isnotnull && !"".equals(isnotnull)) {
				map.put("isnotnull", isnotnull);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/selectPropValueBySid.htm", map);
		} catch (Exception e) {

		} finally {
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/selectPropValueBySid1", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectPropDictByIsLeaf1(String spuSid,
			HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			
			if (null != spuSid && !"".equals(spuSid)) {
				map.put("spuSid", spuSid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/cateListSelect.htm", map);
		} catch (Exception e) {

		} finally {
		}
		return json;
	}

	
	/**
	 * 获取分类Tree
	 * 
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String catList(Model m, HttpServletRequest request, HttpServletResponse response,
			String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("id", id);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/list.htm", map);
		} catch (Exception e) {

		} finally {

		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/liste", method = { RequestMethod.GET, RequestMethod.POST })
	public String procatList(Model m, HttpServletRequest request, HttpServletResponse response,
			String productSid, String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (id != null && !"".equals(id)) {
				map.put("id", id);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/liste.html", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 分类添加
	 * 
	 * @Methods Name add
	 * @Create In 2015年8月7日 By wangsy
	 * @param m
	 * @param request
	 * @param response
	 * @param sid
	 *            当sid为空时 ,添加新的品类;当sid不为空时,更新品类信息
	 * @param channelSid
	 * @param id
	 * @param name
	 * @param status
	 * @param isDisplay
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/add", method = { RequestMethod.GET, RequestMethod.POST })
	public String add(Model m, HttpServletRequest request, HttpServletResponse response,
			String sid, String id, String name, String status, String isDisplay, String isParent,
			String channelSid, String categoryType, String level, String rootSid, String shopSid) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("parentSid", id);
		}
		if (null != name && !"".equals(name)) {
			map.put("name", name);
		}
		if (null != status && !"".equals(status)) {
			map.put("status", status);
		}
		if (null != rootSid && !"".equals(rootSid)) {
			map.put("rootSid", rootSid);
		}
		if (null != shopSid && !"".equals(shopSid)) {
			map.put("shopSid", shopSid);
		}
		if (null != isDisplay && !"".equals(isDisplay)) {
			map.put("isDisplay", isDisplay);
		}
		if (null != isParent && !"".equals(isParent)) {
			map.put("isParent", isParent);
		}
		if (null != channelSid && !"".equals(channelSid)) {
			map.put("channelSid", channelSid);
		}
		if (null != categoryType && !"".equals(categoryType)) {
			map.put("categoryType", categoryType);
		}
		if (null != level && !"".equals(level)) {
			map.put("level", level);
		}
		if (null != sid && !"".equals(sid)) {
			map.put("sid", sid);
			try {
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/categoryinfocontroller/updateCategoryByParam.htm", map);
			} catch (Exception e) {

			} finally {

			}
		} else {
			try {
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/categoryinfocontroller/addCategoryByParam.htm", map);
			} catch (Exception e) {

			} finally {

			}
		}
		return json;
	}

	/**
	 * 控制品类的更新时,用于品类的信息加载
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
	@RequestMapping(value = "/edit", method = { RequestMethod.GET, RequestMethod.POST })
	public String update(Model m, HttpServletRequest request, HttpServletResponse response,
			String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (null != id && !"".equals(id)) {
				map.put("id", id);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/edit.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 产品与属性管理添加使用
	 * 
	 * @Methods Name addProductParameters
	 * @Create In 2015年8月26日 By wangsy
	 * @param sppv
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addProductParameters", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String addProductParameters(String jsonPara) {
		String json = "";
		List<SaveProductParametersVO> sppvs = JsonUtil.getListDTO(jsonPara, SaveProductParametersVO.class);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		for(SaveProductParametersVO sppv : sppvs){
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(sppv.getCategorySid())) {
				map.put("categorySid", sppv.getCategorySid());
			}
			if (StringUtils.isNotEmpty(sppv.getChannelSid())) {
				map.put("channelSid", sppv.getChannelSid());
			}
			if (StringUtils.isNotEmpty(sppv.getSpuSid())) {
				map.put("spuSid", sppv.getSpuSid());
			}
			if (StringUtils.isNotEmpty(sppv.getCategoryName())) {
				map.put("categoryName", sppv.getCategoryName());
			}
			if (StringUtils.isNotEmpty(sppv.getCategoryType())) {
				map.put("categoryType", sppv.getCategoryType());
			}
			if (StringUtils.isNotEmpty(sppv.getParameters())) {
				List<ParametersDto> listInsert = JSON.parseArray(sppv.getParameters(),
						ParametersDto.class);
				map.put("parameters", listInsert);
			}
			list.add(map);
		}		
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/bwCategoryController/bw/productCatePropValue.htm",
					JsonUtil.getJSONString(list));
		} catch (Exception e) {
			// TODO: handle exception
		}

		return json;
	}

	/**
	 * 更换统计分类
	 */
	@ResponseBody
	@RequestMapping(value = "/updateStatCategory", method = { RequestMethod.GET, RequestMethod.POST })
	public String updateStatCategory(String spuSid, String cateSid, String activeTime) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categorySid", cateSid);
		map.put("productSid", spuSid);
		map.put("activeTime", activeTime);
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/propertyChange/changeGroupCategory.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			// TODO: handle exception
		}
		return json;
	}
}
