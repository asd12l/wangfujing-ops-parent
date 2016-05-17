package com.wangfj.wms.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.wangfj.back.util.HttpUtil;
import com.wangfj.back.view.UacRoleVO;
import com.wangfj.wms.domain.entity.RolePermission;
import com.wangfj.wms.service.IRoleLimitService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/rolePermission")
public class RoleLimitController {
	
	@Autowired
			@Qualifier("roleLimitService")
	IRoleLimitService roleLimitService;
	
	/**
	 * 保存角色权限授权
	 * 
	 * @Methods Name saveRolePermissions
	 * @Create In 2016年4月11日 By zdl
	 * @param request
	 * @param response
	 * @param roleSid
	 * @param shopSids
	 * @param channelSids
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveRolePermissions", method = {RequestMethod.GET, RequestMethod.POST})
	public String saveRolePermissions(HttpServletRequest request, HttpServletResponse response,
			String roleSid, String shopSids, String shopGroupSids, String channelSids,
			String manageCateSids, String manageCateShopCodes, String manageCateLevels, 
			String manageCateParentCodes){
		JSONObject json = new JSONObject();
		List<RolePermission> roleLimits = new ArrayList<RolePermission>();
		if(shopSids != null && shopSids != ""){
			String[] strGroupSids = shopGroupSids.split(",");
			int i=0;
			for(String s : shopSids.split(",")){
				if(s != ""){
					RolePermission rolPer = new RolePermission();
					rolPer.setRoleSid(Long.valueOf(roleSid));
					rolPer.setPermission(s);
					rolPer.setCol1(strGroupSids[i]);
					rolPer.setPermissionType(0);
					rolPer.setStatus(1);
					rolPer.setOpttime(new Date());
					roleLimits.add(rolPer);
				}
				i++;
			}
		}
		if(channelSids != null && channelSids != ""){
			for(String s : channelSids.split(",")){
				if(s != ""){
					RolePermission rolPer = new RolePermission();
					rolPer.setRoleSid(Long.valueOf(roleSid));
					rolPer.setPermission(s);
					rolPer.setPermissionType(1);
					rolPer.setStatus(1);
					rolPer.setOpttime(new Date());
					roleLimits.add(rolPer);
				}
			}
		}
		if(manageCateSids != null && manageCateSids != ""){
			String[] strManageCateShopCodes = manageCateShopCodes.split(",");
			String[] strManageCateLevels = manageCateLevels.split(",");
			String[] strManageCateParentCodes = manageCateParentCodes.split(",");
			int i=0;
			for(String s : manageCateSids.split(",")){
				if(s != ""){
					RolePermission rolPer = new RolePermission();
					rolPer.setRoleSid(Long.valueOf(roleSid));
					rolPer.setPermission(s);
					rolPer.setCol1(strManageCateShopCodes[i]);
					rolPer.setCol2(strManageCateLevels[i]);
					rolPer.setCol3(strManageCateParentCodes[i]);
					rolPer.setPermissionType(2);
					rolPer.setStatus(1);
					rolPer.setOpttime(new Date());
					roleLimits.add(rolPer);
				}
				i++;
			}
		}
		try {
			roleLimitService.saveRolePermission(roleLimits);
			json.put("success", true);
		} catch (Exception e) {
			json.put("success", false);
			e.printStackTrace();
		}
		return json.toString();
	}
	
	/**
	 * 根据角色sid查询权限资源
	 * 
	 * @Methods Name getRolePermissionsByRoleSid
	 * @Create In 2016年4月11日 By zdl
	 * @param request
	 * @param response
	 * @param roleSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getRolePermissionsByRoleSid", method = {RequestMethod.GET, RequestMethod.POST})
	public String getRolePermissionsByRoleSid(HttpServletRequest request, HttpServletResponse response,
			String roleSid){
		JSONObject json = new JSONObject();
		List<RolePermission> roleLimits = new ArrayList<RolePermission>();
		List<RolePermission> roleShopLimits = new ArrayList<RolePermission>();
		List<RolePermission> roleChannelLimits = new ArrayList<RolePermission>();
		List<RolePermission> roleManageCateLimits = new ArrayList<RolePermission>();
		RolePermission rolPer = new RolePermission();
		rolPer.setRoleSid(Long.valueOf(roleSid));
		rolPer.setStatus(1);
		try {
			roleLimits = roleLimitService.selectRolePermissionByParam(rolPer);
			for(RolePermission rp : roleLimits){
				if(rp.getPermissionType() == 0){
					roleShopLimits.add(rp);
				} else if(rp.getPermissionType() == 1){
					roleChannelLimits.add(rp);
				} else {
					roleManageCateLimits.add(rp);
				}
			}
			json.put("shopPermission", roleShopLimits);
			json.put("channelPermission", roleChannelLimits);
			json.put("manageCatePermission", roleManageCateLimits);
			json.put("success", true);
		} catch (Exception e) {
			json.put("success", false);
			e.printStackTrace();
		}
		return json.toString();
	}

	/**
	 * 异步加载
	 * 
	 * @Methods Name ajaxAsyncList
	 * @Create In 2015年8月28日 By zdl
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
			String roleSid) {
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
				json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/bwCategoryController/bw/ajaxAsyncListCache.htm",
					JsonUtil.getJSONString(map));
				JSONArray jsonArray = new JSONArray();
				JSONArray jsonArray1 = JSONArray.fromObject(json);
				for(Object o : jsonArray1){
					JSONObject o1 = JSONObject.fromObject(o);
					if(o1.getString("clevel").equals("3") || o1.getString("clevel").equals("4")){
						o1.put("nocheck",false);
						
						RolePermission rolPer = new RolePermission();
						rolPer.setRoleSid(Long.valueOf(roleSid));
						rolPer.setStatus(1);
						rolPer.setPermission(o1.getString("code"));
						rolPer.setCol1(o1.getString("shopSid"));
						rolPer.setPermissionType(2);
						List<RolePermission> roleLimits = roleLimitService.selectRolePermissionByParam(rolPer);
						if(roleLimits.size() > 0){
							o1.put("checked", true);
							if(o1.getString("clevel").equals("3")){
								String str = getForeCateByThreeCate(o1,roleSid);
								JSONArray str1 = JSONArray.fromObject(str);
								jsonArray.addAll(str1);
							}
						} else {
							o1.put("checked", false);
						}
					}
					jsonArray.add(o1);
				}
				json = jsonArray.toString();
			}
		} catch (Exception e) {

		} finally {

		}

		return json;
	}
	
	private String getForeCateByThreeCate(JSONObject jsonParam, String roleSid){
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != jsonParam.getString("id") && !"".equals(jsonParam.getString("id"))) {
			map.put("id", jsonParam.getString("id"));
			map.put("parentSid", jsonParam.getString("id"));
		}
		if (jsonParam.getString("categoryType") != null && !"".equals(jsonParam.getString("categoryType"))) {
			map.put("categoryType", jsonParam.getString("categoryType"));
		}
		if (jsonParam.getString("shopSid") != null && !"".equals(jsonParam.getString("shopSid"))) {
			map.put("shopSid", jsonParam.getString("shopSid"));
		}
		if (jsonParam.getString("channelSid") != null && !"".equals(jsonParam.getString("channelSid"))) {
			map.put("channelSid", jsonParam.getString("channelSid"));
		}
		try {
			if (!"{}".equals(map.toString())) {
				json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/bwCategoryController/bw/ajaxAsyncListCache.htm",
					JsonUtil.getJSONString(map));
				JSONArray jsonArray = new JSONArray();
				JSONArray jsonArray1 = JSONArray.fromObject(json);
				for(Object o : jsonArray1){
					JSONObject o1 = JSONObject.fromObject(o);
					if(o1.getString("clevel").equals("3") || o1.getString("clevel").equals("4")){
						o1.put("nocheck",false);
						
						RolePermission rolPer = new RolePermission();
						rolPer.setRoleSid(Long.valueOf(roleSid));
						rolPer.setStatus(1);
						rolPer.setPermission(o1.getString("code"));
						rolPer.setCol1(o1.getString("shopSid"));
						rolPer.setPermissionType(2);
						List<RolePermission> roleLimits = roleLimitService.selectRolePermissionByParam(rolPer);
						if(roleLimits.size() > 0){
							o1.put("checked", true);
						}
					}
					jsonArray.add(o1);
				}
				json = jsonArray.toString();
			}
		} catch (Exception e) {

		} finally {

		}
		return json;
	}
	
	/**
	 * 
	 * 
	 * @Methods Name getPermissionByTypes
	 * @Create In 2016年4月12日 By zdl
	 * @param request
	 * @param response
	 * @param types
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getPermissionByTypes", method = {RequestMethod.GET, RequestMethod.POST})
	public String getPermissionByTypes(HttpServletRequest request, HttpServletResponse response,
			String types){
		JSONObject json = new JSONObject();
		Map<String, Object> param = new HashMap<String, Object>();
		List<RolePermission> roleLimits = new ArrayList<RolePermission>();
		
		try {
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
			param.put("roleCodes", paramList);
		} catch (Exception e1) {
			json.put("success", false);
			e1.printStackTrace();
		}
		if(types != null && types != ""){
			List<String> types1 = new ArrayList<String>();
			for(String s : types.split(",")){
				types1.add(s);
			}
			param.put("permissionTypes", types1);
		}
		try {
			roleLimits = roleLimitService.selectByRoleCodesOrTypes(param);
			json.put("data", roleLimits);
			json.put("success", true);
		} catch (Exception e) {
			json.put("success", false);
			e.printStackTrace();
		}
		return json.toString();
	}
}
