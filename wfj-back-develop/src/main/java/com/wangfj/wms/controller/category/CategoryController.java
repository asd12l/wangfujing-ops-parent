package com.wangfj.wms.controller.category;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.utils.StringUtils;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.back.view.UacRoleVO;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.domain.entity.RolePermission;
import com.wangfj.wms.service.IRoleLimitService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

/**
 * 维护品类信息的控制器
 * 
 * @author xuxf
 */
@RequestMapping(value = "/category")
@Controller
public class CategoryController {
	
	@Autowired
			@Qualifier("roleLimitService")
	IRoleLimitService roleLimitService;

	/**
	 * 查询分类
	 * 
	 * @Methods Name getAllCategory
	 * @Create In 2015年8月18日 By wangsy
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllCategory", method = { RequestMethod.GET, RequestMethod.POST })
	public String getAllCategory(String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null == id || "".equals(id)) {
			map.put("id", 1);
		} else {
			map.put("id", id);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/getAllCateory.htm", map);
		} catch (Exception e) {
			return "{success:false}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				json = "{success:false}";
			}
		}
		return json;
	}

	/**
	 * 分类拖拽
	 * 
	 * @Methods Name categoryBeforeDrop
	 * @Create In 2015年8月12日 By wangsy
	 * @param sid
	 *            分类主键
	 * @param pId
	 *            分类父id
	 * @param sortOrder
	 *            分类下标
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/categoryBeforeDrop", method = { RequestMethod.GET, RequestMethod.POST })
	public String categoryBeforeDrop(String sid, String pId, String sortOrder, String targetPid,
			String categoryType, String targetSid, String isParent, String rootSid, String moveType) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != sid && !"".equals(sid)) {
			map.put("sid", sid);
		}
		if (null != pId && !"".equals(pId)) {
			map.put("parentSid", pId);
		}
		if (null != sortOrder && !"".equals(sortOrder)) {
			map.put("sortOrder", sortOrder);
		}
		if (null != categoryType && !"".equals(categoryType)) {
			map.put("categoryType", categoryType);
		}
		if (null != targetPid && !"".equals(targetPid)) {
			map.put("parentSid", targetPid);
		}
		if (null != targetSid && !"".equals(targetSid)) {
			map.put("targetSid", targetSid);
		}
		if (null != isParent && !"".equals(isParent)) {
			map.put("isParent", isParent);
		}
		if (null != rootSid && !"".equals(rootSid)) {
			map.put("rootSid", rootSid);
		}
		if (null != moveType && !"".equals(moveType)) {
			map.put("moveType", moveType);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/categoryBeforeDrop.htm", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return json;
	}

	/**
	 * 获取分类Tree
	 * 
	 * @Methods Name catList
	 * @Create In 2015年8月26日 By wangsy
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 * @param categoryType
	 * @param shopSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.GET, RequestMethod.POST })
	public String catList(Model m, HttpServletRequest request, HttpServletResponse response,
			String id, String categoryType, String shopSid, String cache) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("id", id);
		}
		if (categoryType != null && !"".equals(categoryType)) {
			map.put("categoryType", categoryType);
		}
		if (shopSid != null && !"".equals(shopSid)) {
			map.put("shopSid", shopSid);
		}

		try {
			if (cache != null && "1".equals(cache)) {
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/bwCategoryController/bw/listCache.htm", map);
			} else {
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/bwCategoryController/bw/list.htm", map);
			}
		} catch (Exception e) {

		} finally {

		}

		return json;
	}
	
	/**
	 * 获取分类Tree
	 * 
	 * @Methods Name catListAddPermission
	 * @Create In 2015年8月26日 By zdl
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 * @param categoryType
	 * @param shopSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/listAddPermission", method = { RequestMethod.GET, RequestMethod.POST })
	public String catListAddPermission(Model m, HttpServletRequest request, HttpServletResponse response,
			String id, String categoryType, String shopSid, String cache) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("id", id);
		}
		if (categoryType != null && !"".equals(categoryType)) {
			map.put("categoryType", categoryType);
		}
		if (shopSid != null && !"".equals(shopSid)) {
			map.put("shopSid", shopSid);
		}

		try {
			if (cache != null && "1".equals(cache)) {
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/bwCategoryController/bw/listCache.htm", map);
			} else {
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/bwCategoryController/bw/list.htm", map);
			}
			map.clear();
			JSONArray jsonList = JSONArray.fromObject(json);
            
            List<RolePermission> roleLimits = new ArrayList<RolePermission>();
            String username = CookiesUtil.getCookies(request, "username");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", username);
			String RolesJson = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/api/findRolesByUserId.do", paramMap);
			JSONObject json2 = JSONObject.fromObject(RolesJson);
			JSONArray Roles = JSONArray.fromObject(json2.get("result"));
			List<UacRoleVO> rolesList = JsonUtil.getListDTO(Roles.toString(), UacRoleVO.class);
			List<String> paramList = new ArrayList<String>();
			for(UacRoleVO jo : rolesList){
				paramList.add(jo.getCn());
			}
			map.put("roleCodes", paramList);
			List<String> types = new ArrayList<String>();
			types.add("0");
			map.put("permissionTypes", types);
			roleLimits = roleLimitService.selectByRoleCodesOrTypes(map);
			
			List<JSONObject> list = new ArrayList<JSONObject>();
			for(Object o : jsonList){
            	JSONObject o1 = JSONObject.fromObject(o);
            	for(RolePermission rp : roleLimits){
            		if(rp.getPermission().equals(o1.getString("shopSid"))){
            			list.add(o1);
            			break;
            		}
            	}
            }
			json = list.toString();
		} catch (Exception e) {

		} finally {

		}

		return json;
	}

	/**
	 * 异步加载
	 * 
	 * @Methods Name ajaxAsyncList
	 * @Create In 2015年8月28日 By wangsy
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 *            分类SID
	 * @param categoryType
	 *            分类类型
	 * @param shopSid
	 *            门店SID
	 * @param rootSid
	 *            根节点SID
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/ajaxAsyncList", method = { RequestMethod.GET, RequestMethod.POST })
	public String ajaxAsyncList(Model m, HttpServletRequest request, HttpServletResponse response,
			String id, String categoryType, String shopSid, String channelSid, String productSid,
			String cache) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("id", id);
			map.put("parentSid", id);
		}
		if (categoryType != null && !"".equals(categoryType)) {
			map.put("categoryType", categoryType);
		}
		if (shopSid != null && !"".equals(shopSid)) {
			map.put("shopSid", shopSid);
		}
		if (channelSid != null && !"".equals(channelSid)) {
			map.put("channelSid", channelSid);
		}
		if (productSid != null && !"".equals(productSid)) {
			map.put("productSid", productSid);
		}
		try {
			if (!"{}".equals(map.toString())) {
				if (cache != null && "1".equals(cache)) {
					json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
							+ "/bwCategoryController/bw/ajaxAsyncListCache.htm",
							JsonUtil.getJSONString(map));
				} else {
					json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
							+ "/bwCategoryController/bw/ajaxAsyncList.htm",
							JsonUtil.getJSONString(map));
				}
			}
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
			String sid, String id, String name, String status, String isParent, String channelSid,
			String categoryType, String level, String rootSid, String shopSid, String actionCode,
			String entryCode) {
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
		// if (null != isDisplay && !"".equals(isDisplay)) {
		// map.put("isDisplay", isDisplay);
		// }
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
		if (null != entryCode && !"".equals(entryCode)) {
			map.put("categoryCode", entryCode);
		}
		if (null != sid && !"".equals(sid)) {
			map.put("sid", sid);
			map.put("actionCode", "U");
			try {
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/categoryinfocontroller/addCategoryByParam.htm", map);
			} catch (Exception e) {

			} finally {

			}

		} else {
			map.put("actionCode", "A");
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
	 * 控制品类的删除,当品类下有子品类时,该品类不能删除
	 * 
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 * @return
	 */

	@ResponseBody
	@RequestMapping(value = "/del", method = { RequestMethod.GET, RequestMethod.POST })
	public String del(Model m, HttpServletRequest request, HttpServletResponse response, String id,
			String categoryType) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (null != id && !"".equals(id)) {
				map.put("id", id);
			}
			if (null != categoryType && !"".equals(categoryType)) {
				map.put("categoryType", categoryType);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/del.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 停用分类
	 * 
	 * @Methods Name updateStatus
	 * @Create In 2015年8月14日 By chengsj
	 * @param m
	 * @param request
	 * @param response
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/updateStatus", method = { RequestMethod.GET, RequestMethod.POST })
	public String updateStatus(Model m, HttpServletRequest request, HttpServletResponse response,
			String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (null != id && !"".equals(id)) {
				map.put("id", id);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/updatestatus.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/getCountByIsLeaf", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCountByIsLeaf(Model m, HttpServletRequest request,
			HttpServletResponse response, String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("sid", id);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/getCountByIsLeaf.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/bw/getCountByCategoryType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getCountByCategoryType(Model m, HttpServletRequest request,
			HttpServletResponse response, String id) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != id && !"".equals(id)) {
			map.put("sid", id);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/getCountByCategoryType.htm", map);
		} catch (Exception e) {

		} finally {

		}
		return json;
	}

	/**
	 * 查询工业分类拖拽开关
	 * 
	 * @Methods Name getCategoryButton
	 * @Create In 2015年8月18日 By wangsy
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getCategoryButton", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCategoryButton() {
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bwCategoryController/bw/getCategoryButton.htm", null);
		} catch (Exception e) {
			return "{'success':'false'}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				return "{'success':'false'}";
			}
		}
		return json;
	}

	/**
	 * 
	 * @Methods Name selectCategoryList
	 * @Create In 2016年1月5日 By zdl
	 * @param parentSid
	 * @param isDisplay
	 * @param categoryType
	 * @param pageSize
	 * @param currenPage
	 * @param status
	 * @param channelSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectCategoryList", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectCategoryList(String parentSid, String isDisplay, String categoryType,
			String pageSize, String currenPage, String channelSid) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != parentSid && !"".equals(parentSid)) {
			map.put("parentSid", parentSid);
		}
		if (null != isDisplay && !"".equals(isDisplay)) {
			map.put("isDisplay", isDisplay);
		}
		if (null != categoryType && !"".equals(categoryType)) {
			map.put("categoryType", categoryType);
		}
		if (null != channelSid && !"".equals(channelSid)) {
			map.put("channelSid", channelSid);
		}
		if (null != pageSize && !"".equals(pageSize)) {
			map.put("pageSize", pageSize);
		}
		if (null != currenPage && !"".equals(currenPage)) {
			map.put("currenPage", currenPage);
		}
		try {
			json = HttpUtilPcm
					.doPost(SystemConfig.SSD_SYSTEM_URL
							+ "/categoryinfocontroller/selectCategoryList.htm",
							JsonUtil.getJSONString(map));
		} catch (Exception e) {
			return "{'success':'false'}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				return "{'success':'false'}";
			}
		}
		return json;
	}

	/**
	 * 
	 * @Methods Name findChannelBySPUPara
	 * @Create In 2016年3月1日 By zdl
	 * @param spuCode
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/findChannelBySPUPara", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findChannelBySPUPara(String spuCode) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != spuCode && !"".equals(spuCode)) {
			map.put("spuCode", spuCode);
		}
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmAdminChannel/findChannelBySPUPara.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			return "{'success':'false'}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				return "{'success':'false'}";
			}
		}
		return json;
	}

	/**
	 * 根据当前分类参数查询分类的所有上级
	 * 
	 * @Methods Name findAllParentCategoryByParam
	 * @Create In 2016年3月1日 By wangxuan
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/findAllParentCategoryByParam", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findAllParentCategoryByParam(String sid, String categorySid, String parentSid,
			String categoryType, String isDisplay, String shopCode, String categoryCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(sid)) {
			map.put("sid", sid.trim());
		}
		if (StringUtils.isNotEmpty(categorySid)) {
			map.put("categorySid", categorySid.trim());
		}
		if (StringUtils.isNotEmpty(parentSid)) {
			map.put("parentSid", parentSid.trim());
		}
		if (StringUtils.isNotEmpty(categoryType)) {
			map.put("categoryType", categoryType.trim());
		}
		if (StringUtils.isNotEmpty(isDisplay)) {
			map.put("isDisplay", isDisplay.trim());
		}
		if (StringUtils.isNotEmpty(shopCode)) {
			map.put("shopCode", shopCode.trim());
		}
		if (StringUtils.isNotEmpty(categoryCode)) {
			map.put("categoryCode", categoryCode.trim());
		}
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/bwCategoryController/bw/findAllParentCategoryByParam.htm",
					JsonUtil.getJSONString(map));
			if (StringUtils.isNotEmpty(json)) {
				JSONObject categoryJson = JSONObject.fromObject(json);
				JSONArray categoryList = categoryJson.getJSONArray("data");
				StringBuffer sb = new StringBuffer();
				for (int i = categoryList.size() - 1; i >= 0; i--) {
					if (i == 0) {
						sb.append(categoryList.getJSONObject(i).getString("name"));
					} else {
						sb.append(categoryList.getJSONObject(i).getString("name") + ">");
					}
					json = "{\"success\":\"true\",\"data\":{\"categoryNames\":\"" + sb.toString()
							+ "\"}}";
				}
			}
		} catch (Exception e) {
			return "{'success':'false'}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				return "{'success':'false'}";
			}
		}
		return json;
	}

	/**
	 * 根据当前分类参数查询分类的所有上级
	 * 
	 * @Methods Name findAllParentCategoryByParam1
	 * @Create In 2016年3月1日 By wangxuan
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/findAllParentCategoryByParam1", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findAllParentCategoryByParam1(String sid, String categorySid, String parentSid,
			String categoryType, String isDisplay, String shopCode, String categoryCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(sid)) {
			map.put("sid", sid.trim());
		}
		if (StringUtils.isNotEmpty(categorySid)) {
			map.put("categorySid", categorySid.trim());
		}
		if (StringUtils.isNotEmpty(parentSid)) {
			map.put("parentSid", parentSid.trim());
		}
		if (StringUtils.isNotEmpty(categoryType)) {
			map.put("categoryType", categoryType.trim());
		}
		if (StringUtils.isNotEmpty(isDisplay)) {
			map.put("isDisplay", isDisplay.trim());
		}
		if (StringUtils.isNotEmpty(shopCode)) {
			map.put("shopCode", shopCode.trim());
		}
		if (StringUtils.isNotEmpty(categoryCode)) {
			map.put("categoryCode", categoryCode.trim());
		}
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/bwCategoryController/bw/findAllParentCategoryByParam.htm",
					JsonUtil.getJSONString(map));
		} catch (Exception e) {
			return "{'success':'false'}";
		} finally {
			if (null == json || "".equals(json) || "false".equals(json)) {
				return "{'success':'false'}";
			}
		}
		return json;
	}
	
}
