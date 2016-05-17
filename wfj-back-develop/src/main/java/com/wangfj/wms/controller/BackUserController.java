package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.utils.StringUtils;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.wms.domain.entity.BackUser;
import com.wangfj.wms.domain.entity.BackUserRole;
import com.wangfj.wms.domain.entity.LogisticsUser;
import com.wangfj.wms.service.IBackUserService;
import com.wangfj.wms.service.IRolesService;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;


/**
 * @Class Name BackUserController
 * @Author wwb
 * @Create In 2014-12-3
 */
@Controller
@RequestMapping(value = "/backUser")
public class BackUserController {
	
	@Autowired
	@Qualifier("backUserService")
	private IBackUserService backUserService;
	@Autowired
	@Qualifier("roleService")
	private IRolesService roleService;
	
	@ResponseBody
	@RequestMapping(value = "/getBackUserList",method={RequestMethod.GET,RequestMethod.POST})
	public String getAllBackUser(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String name = request.getParameter("name");
		String type = request.getParameter("type");
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		//Integer size = 10;
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		BackUser backUser=new BackUser();
		try {
			List result;
			if(StringUtils.isNotEmpty(name)){
				backUser.setUserName(name);
			}
			if(StringUtils.isNotEmpty(type)){
				backUser.setType(Integer.parseInt(type));
			}
			backUser.setStart(start);
			backUser.setPageSize(size);
			int total=backUserService.getTotalByParam(backUser);
			int pageCount=total%size==0?total/size:(total/size+1);
			result = backUserService.getByParam(backUser);
			json = ResultUtil.createSuccessResult(result);
			JSONObject jsonObj=new JSONObject();
			jsonObj=JSONObject.fromObject(json);
			jsonObj.put("pageCount", pageCount);
			json=jsonObj.toString();
//			else{
//				result = backUserService.getAll();
//				json = ResultUtil.createSuccessResult(result);
//			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateBackUserRole",method={RequestMethod.GET,RequestMethod.POST})
	public String updateBackUserRole(HttpServletRequest request, HttpServletResponse response,String userSid,String roleSid,String userName,String oldRole){
		String json = "";
		BackUserRole userRole=new BackUserRole();
		try {
			if(userSid!=null&&!"".equals(userSid)){
				userRole.setUserSid(Integer.parseInt(userSid));
			}
			if(roleSid!=null&&!"".equals(roleSid)){
				userRole.setRoleSid(Integer.parseInt(roleSid));
			}
			if(userName!=null&&!"".equals(userName)){
				userRole.setUserName(userName);
			}
			if("".equals(oldRole)){
				backUserService.insertUserRole(userRole);
			}else{
				backUserService.updateUserRole(userRole);
			}
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value="/saveBackUser",method={RequestMethod.GET,RequestMethod.POST})
	public String saveBackUser(HttpServletRequest request,HttpServletResponse response,String userName,String passWord,String realName){
		String json="";
		BackUser backUser=new BackUser();
		try{
			if(userName!=null&&!"".equals(userName)){
				backUser.setUserName(userName);
			}
			BackUser backUser2=new BackUser();
			backUser2=backUserService.queryUserByName(userName);
			if(backUser2!=null&&backUser2.getSid()!=null){
				json=ResultUtil.createFailureResult("user exsit error", "该用户已存在");
//				return json;
			}else{
				if(passWord!=null&&!"".equals(passWord)){
					backUser.setPassWord(passWord);
				}
				if(realName!=null&&!"".equals(realName)){
					backUser.setRealName(realName);
				}
				backUser.setType(0);
				backUserService.insertBackUser(backUser);
				json = ResultUtil.createSuccessResult();
			}
		}catch(Exception e){
			json=ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value="/saveLogiticsUser",method={RequestMethod.GET,RequestMethod.POST})
	public String saveLogiticsUser(HttpServletRequest request,HttpServletResponse response,String userName,String passWord,String realName,String supplyName,String supplySid,String shopName,String shopSid){
		String json="";
		BackUser backUser=new BackUser();
		LogisticsUser logisticsUser = new LogisticsUser();
		try{
			if(StringUtils.isNotEmpty(userName)){
				backUser.setUserName(userName);
			}
			if(StringUtils.isNotEmpty(passWord)){
				backUser.setPassWord(passWord);
			}
			if(StringUtils.isNotEmpty(realName)){
				backUser.setRealName(realName);
			}
			backUser.setType(1);
			
			if(StringUtils.isNotEmpty(supplySid)){
				logisticsUser.setSupplySid(Integer.parseInt(supplySid));
			}
			if(StringUtils.isNotEmpty(supplyName)){
				logisticsUser.setSupplyName(supplyName);
			}
			if(StringUtils.isNotEmpty(shopSid)){
				logisticsUser.setShopSid(Integer.parseInt(shopSid));
			}
			if(StringUtils.isNotEmpty(shopName)){
				logisticsUser.setShopName(shopName);
			}
				
			boolean flag = backUserService.saveLogiticsUser(backUser, logisticsUser);
			if(flag){
				json = ResultUtil.createSuccessResult();
			}else{
				json=ResultUtil.createFailureResult("", "保存失败");
			}
		}catch(Exception e){
			json=ResultUtil.createFailureResult(e.getMessage(), "保存失败");
		}
		return json;
	}
	
	@RequestMapping(value="/opsTest",method={RequestMethod.GET,RequestMethod.POST})
	public String test(HttpServletRequest request,HttpServletResponse response,String sid){
		return "OK";
	}
	@ResponseBody
	@RequestMapping(value="/deleteBackUser",method={RequestMethod.GET,RequestMethod.POST})
	public String deleteBackUser(HttpServletRequest request,HttpServletResponse response,String sid){
		String json="";
		try{
			if(sid!=null&&!"".equals(sid)){
				backUserService.deleteBackUser(Integer.parseInt(sid));
			}
			json=ResultUtil.createSuccessResult();
		}catch(Exception e){
			json=ResultUtil.createFailureResult("", "失败");
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value="/editUserPwd",method={RequestMethod.GET,RequestMethod.POST})
	public String editUserPwd(HttpServletRequest request,HttpServletResponse response,
			String userName, String password, String newPassword){
		String json="";
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("username", userName);
		paramMap.put("password", password);
		paramMap.put("passwordNew", newPassword);
		try{
			String ss = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/validate/UpdateUserPassword.do", paramMap);
			JSONObject jsonO = JSONObject.fromObject(ss);
			if(jsonO.getString("success").equals("true")){
				json=ResultUtil.createSuccessResult("修改成功");
			} else {
				json=ResultUtil.createFailureResult("", jsonO.getString("msg"));
			}
		}catch(Exception e){
			json=ResultUtil.createFailureResult("", "修改失败");
		}
		return json;
	}
	
}
