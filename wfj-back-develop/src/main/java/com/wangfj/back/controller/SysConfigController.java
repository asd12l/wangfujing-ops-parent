package com.wangfj.back.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.constants.SystemConfig;
import com.wangfj.back.entity.po.SysConfig;
import com.wangfj.back.entity.vo.SysConfigVO;
import com.wangfj.back.service.ISysConfigService;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.back.view.UacRoleVO;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.JsonUtil;

/**
 * @Class Name SysConfigController
 * @Author zhangdl
 * @Create In 2016-8-30
 */

@Controller
@RequestMapping(value="sysConfig")
public class SysConfigController {
	
	@Autowired
	ISysConfigService sysConfigService;
	
	@ResponseBody
	@RequestMapping(value = "/findAll", method ={ RequestMethod.GET,RequestMethod.POST})
	public String findAll(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<SysConfig> list = sysConfigService.selectAll();
		if(list == null || list.size() == 0){
			resultMap.put("success", false);
		} else {
			resultMap.put("data", list);
			resultMap.put("success", true);
		}
		return JSONObject.toJSONString(resultMap);
	}
	
//	@ResponseBody
//	@RequestMapping(value = "/findSysConfigByKeys", method ={ RequestMethod.GET,RequestMethod.POST})
	public String findSysConfigByKeys(HttpServletRequest request, HttpServletResponse response,
			String keys) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(keys != null && !"".equals(keys)){
			List<String> paramKeys = new ArrayList<String>();
			
			String[] ks = keys.split(",");
			for(String s : ks){
				paramKeys.add(s);
			}
			
			List<SysConfig> list = sysConfigService.selectByKeys(paramKeys);
			if(list == null || list.size() == 0){
				resultMap.put("msg", "查询为空");
				resultMap.put("success", false);
			} else {
				List<SysConfigVO> listVO = new ArrayList<SysConfigVO>();
				for(SysConfig sc : list){
					SysConfigVO vo = new SysConfigVO();
					vo.setSysKey(sc.getSysKey());
					vo.setSysValue(sc.getSysValue());
					listVO.add(vo);
				}
				resultMap.put("data", listVO);
				resultMap.put("success", true);
			}
		} else {
			resultMap.put("msg", "查询为空");
			resultMap.put("success", false);
		}
		return JSONObject.toJSONString(resultMap);
	}
	
	@ResponseBody
	@RequestMapping(value = "/findSysConfigByKeys", method ={ RequestMethod.GET,RequestMethod.POST})
	public String findSysConfigByKeys1(HttpServletRequest request, HttpServletResponse response,
			String keys, String username) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try{
			String userName = CookiesUtil.getCookies(request, "username");
			if(userName == null || "".equals(userName)){
				if(username != null && !"".equals(username)){
					userName = username;
				}
			}
			List<SysConfigVO> listVO = new ArrayList<SysConfigVO>();
			SysConfigVO vo = new SysConfigVO();
			listVO.add(vo);
			if(userName != null && !"".equals(userName)){
				paramMap.put("userId", userName);
				paramMap.put("systemCN", "SYSTEM_OPS");
				String RolesJson = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/api/findRolesByUserAndSys.json", paramMap);
				net.sf.json.JSONObject json2 = net.sf.json.JSONObject.fromObject(RolesJson);
				if(json2.getString("success").equals("true")){
					Object o = json2.get("result");
					JSONArray Roles = JSONArray.fromObject(o);
					if(Roles != null && Roles.size() != 0){
						List<UacRoleVO> rolesList = JsonUtil.getListDTO(Roles.toString(), UacRoleVO.class);
						List<String> paramList = new ArrayList<String>();
						for(UacRoleVO jo : rolesList){
							paramList.add(jo.getCn());
						}
						paramMap.clear();
						paramMap.put("roleCodes", paramList);
						paramMap.put("sysValue", "0");
						Map<String, Object> resources = sysConfigService.selectByRoleCodes(paramMap);
						if(resources != null){
							vo.setSysKey("memberInfo");
							vo.setSysValue("0");
						} else {
							vo.setSysKey("memberInfo");
							vo.setSysValue("1");
						}
					} else {
						vo.setSysKey("memberInfo");
						vo.setSysValue("1");
						System.out.println("没权限");
					}
				} else {
					vo.setSysKey("memberInfo");
					vo.setSysValue("1");
					System.out.println("没权限");
				}
			} else {
				vo.setSysKey("memberInfo");
				vo.setSysValue("1");
				System.out.println("用户名为空");
			}
			resultMap.put("data", listVO);
			resultMap.put("success", true);
		} catch(Exception e){
			e.printStackTrace();
			resultMap.put("msg", "系统异常");
			resultMap.put("success", false);
		}
		return JSONObject.toJSONString(resultMap);
	}
	
	@ResponseBody
	@RequestMapping(value = "/findSysConfigByRole", method ={ RequestMethod.GET,RequestMethod.POST})
	public String findSysConfigByRoleCode(HttpServletRequest request, HttpServletResponse response,
			String roleSid, String roleCode) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try{
			if(roleCode != null && !"".equals(roleCode)){
				SysConfigVO vo = new SysConfigVO();
				List<String> paramList = new ArrayList<String>();
				paramList.add(roleCode);
				paramMap.put("roleCodes", paramList);
				Map<String, Object> resources = sysConfigService.selectByRoleCodes(paramMap);
				if(resources != null){
					vo.setSysKey("memberInfo");
					vo.setSysValue(resources.get("col1").toString());
					resultMap.put("data", vo);
					resultMap.put("success", true);
				} else {
					paramMap.clear();
					paramMap.put("roleSid", roleSid);
					paramMap.put("roleCode", roleCode);
					paramMap.put("sysKey", "memberInfo");
					paramMap.put("sysValue", "1");
					if(sysConfigService.saveOrEditSysConfigByRoleCode(paramMap)){
						vo.setSysKey("memberInfo");
						vo.setSysValue("1");
						resultMap.put("data", vo);
						resultMap.put("success", true);
					} else {
						resultMap.put("msg", "系统异常");
						resultMap.put("success", false);
					}
				}
			} else {
				resultMap.put("msg", "角色为空");
				resultMap.put("success", false);
			}
		} catch(Exception e){
			e.printStackTrace();
			resultMap.put("msg", "系统异常");
			resultMap.put("success", false);
		}
		return JSONObject.toJSONString(resultMap);
	}
	
	@ResponseBody
	@RequestMapping(value = "/editSysConfigByKey", method ={ RequestMethod.GET,RequestMethod.POST})
	public String editSysConfigByKey(HttpServletRequest request, HttpServletResponse response,
			String key, String value) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		SysConfig cof = new SysConfig();
		cof.setSysKey(key);
		cof.setSysValue(value);
		try {
			boolean success = sysConfigService.saveOrEditSysConfigByKey(cof);
			if(success){
				resultMap.put("msg", "修改成功");
				resultMap.put("success", true);
			} else {
				resultMap.put("msg", "修改失败");
				resultMap.put("success", true);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			resultMap.put("msg", "系统异常");
			resultMap.put("success", false);
		}
		return JSONObject.toJSONString(resultMap);
	}
	
	@ResponseBody
	@RequestMapping(value = "/editSysConfigByRole", method ={ RequestMethod.GET,RequestMethod.POST})
	public String editSysConfigByRole(HttpServletRequest request, HttpServletResponse response,
			String roleSid, String roleCode, String key, String value) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		SysConfig cof = new SysConfig();
		cof.setSysKey(key);
		cof.setSysValue(value);
		try {
			paramMap.put("roleSid", roleSid);
			paramMap.put("roleCode", roleCode);
			paramMap.put("sysKey", key);
			paramMap.put("sysValue", value);
			if(sysConfigService.saveOrEditSysConfigByRoleCode(paramMap)){
				resultMap.put("success", true);
			} else {
				resultMap.put("msg", "修改失败");
				resultMap.put("success", false);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			resultMap.put("msg", "系统异常");
			resultMap.put("success", false);
		}
		return JSONObject.toJSONString(resultMap);
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveSysConfigByKey", method ={ RequestMethod.GET,RequestMethod.POST})
	public String saveSysConfigByKey(HttpServletRequest request, HttpServletResponse response,
			String key, String value) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		SysConfig cof = new SysConfig();
		cof.setSysKey(key);
		cof.setSysValue(value);
		try {
			boolean success = sysConfigService.saveOrEditSysConfigByKey(cof);
			if(success){
				resultMap.put("msg", "添加成功");
				resultMap.put("success", true);
			} else {
				resultMap.put("msg", "添加失败");
				resultMap.put("success", true);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			resultMap.put("msg", "系统异常");
			resultMap.put("success", false);
		}
		return JSONObject.toJSONString(resultMap);
	}

}
