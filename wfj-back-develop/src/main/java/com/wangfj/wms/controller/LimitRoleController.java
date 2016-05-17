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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.back.view.UacRoleVO;
import com.wangfj.wms.domain.entity.LimitRole;
import com.wangfj.wms.service.ILimitRoleService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * 角色控制管理
 * @Class Name LimitRoleController
 * @Author chenqb
 * @Create In 2013-8-9
 */
@Controller
@RequestMapping("/LimitRole")
public class LimitRoleController {
	
	@Autowired
	@Qualifier(value = "limitRoleService")
	private ILimitRoleService limitRoleService;
	@Autowired
	@Qualifier(value = "limitRoleService")
	private ILimitRoleService roleService;
	
	/**
	 * 得到所有的有效角色，不分页
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllUserfullRole", method = {RequestMethod.GET, RequestMethod.POST})
	public String getAllUserfullRole(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		List result;
		result = limitRoleService.getAllUsefullRole();
		json=ResultUtil.createSuccessResult(result);
		return json;
	}
	/**
	 * 得到所有角色  分页
	 * @Methods Name getAllRole
	 * @Create In 2013-8-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllLimitRole", method = {RequestMethod.GET, RequestMethod.POST})
	public String getAllRole(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String name = request.getParameter("name");
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		//Integer size = 10;
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		try {
			List result;
			if(name !=null && name.length()>0){
				LimitRole role = new LimitRole();
				role.setRoleName(name);
				role.setStart(start);
				role.setPageSize(size);
				int total=limitRoleService.getTotalByParam(role);
				int pageCount=total%size==0?total/size:(total/size+1);
				result = limitRoleService.getByParam(role);
				json = ResultUtil.createSuccessResult(result);
				JSONObject jsonObj=new JSONObject();
				jsonObj=JSONObject.fromObject(json);
				jsonObj.put("pageCount", pageCount);
				json=jsonObj.toString();
			}else{
				LimitRole role = new LimitRole();
				role.setStart(start);
				role.setPageSize(size);
				result = limitRoleService.getAll(role);
				int total=limitRoleService.getTotalByParam(role);
				int pageCount=total%size==0?total/size:(total/size+1);
				json = ResultUtil.createSuccessResult(result);
				JSONObject jsonObj=new JSONObject();
				jsonObj=JSONObject.fromObject(json);
				jsonObj.put("pageCount", pageCount);
				json=jsonObj.toString();
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	
	/**
	 * 根据用户获取角色
	 * @Methods Name getRolesByUser
	 * @Create In 2016年3月23日 By zdl
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getRolesByUser", method = {RequestMethod.GET, RequestMethod.POST})
	public String getRolesByUser(HttpServletRequest request, HttpServletResponse response){
		String json = "";
//		String name = request.getParameter("name");
//		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer size = 10;
//		Integer currPage = Integer.parseInt(request.getParameter("page"));
//		if(size==null || size==0){
//			size = 10;
//		}
//		int start = (currPage-1)*size;
//		String username = (String) request.getSession().getAttribute("username");
//		String username = CookiesUtil.getCookies(request, "username");
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("systemCN", "SYSTEM_OPS");
			String RolesJson = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/api/findRoleListBySystemCN.do", paramMap);
			JSONObject json2 = JSONObject.fromObject(RolesJson);
			JSONArray Roles = JSONArray.fromObject(json2.get("result"));
			List<UacRoleVO> uacRolesList = JsonUtil.getListDTO(Roles.toString(), UacRoleVO.class);
			List<LimitRole> rolesList = new ArrayList<LimitRole>();
			for(UacRoleVO jo : uacRolesList){
				LimitRole role = new LimitRole();
				role.setRoleCode(jo.getCn());
				List<LimitRole> list = roleService.getByParam(role);
				if(list != null && list.size() != 0){
					role = list.get(0);
					rolesList.add(role);
				} else {
					role.setRoleName(jo.getDisplayName());
					role.setCreatedTime(new Date());
					role.setDelFlag(0);
					roleService.saveLimitRole(role);
					rolesList.add(role);
				}
			}
			int total=rolesList.size();
			int pageCount=total%size==0?total/size:(total/size+1);
			json = ResultUtil.createSuccessResult(rolesList);
			JSONObject jsonObj=new JSONObject();
			jsonObj=JSONObject.fromObject(json);
			jsonObj.put("pageCount", pageCount);
			json=jsonObj.toString();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getLimitRoleByParam", method = {RequestMethod.GET, RequestMethod.POST})
	public String getRoleByParam(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitRole limitRole = toRole(request);
		
		try {
			List result = limitRoleService.getByParam(limitRole);
			json = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	/**
	 * 保存角色
	 * @Methods Name saveRole
	 * @Create In 2013-8-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveLimitRole", method = {RequestMethod.GET, RequestMethod.POST})
	public String saveRole(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitRole limitRole = toRole(request);
		limitRole.setDelFlag(0);
		limitRole.setCreatedTime(new Date());
		try {
			String result = limitRoleService.saveLimitRole(limitRole).toString();
			json = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	/**
	 * 修改角色
	 * @Methods Name updateRole
	 * @Create In 2013-8-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/updateLimitRole", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateRole(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitRole limitRole = toRole(request);
		limitRole.setUpdateTime(new Date());
		try {
			String result = limitRoleService.updateLimitRole(limitRole).toString();
			json = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteRole", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteRole(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitRole limitRole = toRole(request);
		limitRole.setUpdateTime(new Date());
		limitRole.setDelFlag(1);
		try {
			String result = limitRoleService.updateLimitRole(limitRole).toString();
			json = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	
	public LimitRole toRole(HttpServletRequest request){
		
		String sid = request.getParameter("sid");
		String roleName = request.getParameter("roleName");
		String roleCode = request.getParameter("roleCode");
		String delFlag = request.getParameter("delFlag");
		
		LimitRole limitRole = new LimitRole();
		
		if(sid != null && sid.length()>0){
			limitRole.setSid(Long.valueOf(sid));
		}
		if(roleName != null && roleName.length()>0){
			limitRole.setRoleName(roleName);
		}
		if(roleCode != null && roleCode.length() >0){
			limitRole.setRoleCode(roleCode);
		}
		if(delFlag != null && delFlag.length()>0){
			limitRole.setDelFlag(Integer.valueOf(delFlag));
		}
		
		return limitRole;
	}
	
}
