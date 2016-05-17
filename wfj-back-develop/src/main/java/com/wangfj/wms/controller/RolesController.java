/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.RolesController.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午4:27:12
 * TODO
 */
package com.wangfj.wms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.wms.domain.entity.RoleChannel;
import com.wangfj.wms.domain.entity.RoleResource;
import com.wangfj.wms.domain.entity.Roles;
import com.wangfj.wms.service.IChannelService;
import com.wangfj.wms.service.IRoleChannelService;
import com.wangfj.wms.service.IRoleResourceService;
import com.wangfj.wms.service.IRolesService;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name RolesController
 * @Author chengsj
 * @Create In 2013-7-5
 */
@Controller
@RequestMapping("/roles")
public class RolesController {

	@Autowired
			@Qualifier("roleService")
	IRolesService rolesService;
	
	@Autowired
			@Qualifier("roleChannelService")
	IRoleChannelService roleChannelService;
	
	@Autowired
			@Qualifier("roleResourceService")
	IRoleResourceService roleResourceService;
	
	@Autowired
			@Qualifier("channelService")
	IChannelService channelService;
	
	@ResponseBody
	@RequestMapping(value = "/selectRoles", method = {RequestMethod.GET, RequestMethod.POST})
	public String selectByPrimaryKey(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String sid = request.getParameter("sid");
		
		try {
			Roles record = this.rolesService.selectByPrimaryKey(Long.valueOf(sid));
			json = ResultUtil.createSuccessResult(record);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectChannel", method = {RequestMethod.GET, RequestMethod.POST})
	public String selectChannelByPrimaryKey(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		List list = null;
		String sid = request.getParameter("sid");
		
		try {
			if(sid != null && !"".equals(sid)){
				RoleChannel roleChannel = new RoleChannel();
				roleChannel.setRolesSid(Long.valueOf(sid));
				List<RoleChannel> record = this.roleChannelService.selectList(roleChannel);
				List<Long> listLong = new ArrayList<Long>();
				for(int i=0; i < record.size() ; i++){
					Integer sids =record.get(i).getChannelSid();
					listLong.add(Long.valueOf(sids));
				}
				 list = this.channelService.selectChannelsBySid(listLong);
			}else{
				 list = this.channelService.selectAllChannles();
			}
			json = ResultUtil.createSuccessResult(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectOthers", method = {RequestMethod.GET, RequestMethod.POST})
	public String selectOthersByPrimaryKey(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String sid = request.getParameter("sid");
		
		try {
			
				RoleChannel roleChannel = new RoleChannel();
				roleChannel.setRolesSid(Long.valueOf(sid));
				List<RoleChannel> record = this.roleChannelService.selectList(roleChannel);
				List<Long> listLong = new ArrayList<Long>();
			if(record.size() > 0){
				for(int i=0; i < record.size() ; i++){
					Integer sids =record.get(i).getChannelSid();
					listLong.add(Long.valueOf(sids));
				}
				List list = this.channelService.selectOthers(listLong);
				json = ResultUtil.createSuccessResult(list);
			}else{
				List list = this.channelService.selectAllChannles();
				json = ResultUtil.createSuccessResult(list);
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/selectList", method = {RequestMethod.GET, RequestMethod.POST})
	public String selectlist(String name,HttpServletRequest request, HttpServletResponse response){
		System.out.println(name);
		String json = "";
		String roleName = request.getParameter("name");
		try {
			Roles roles = new Roles();
			if(roleName != null &&!"".equals(roleName)){
				roles.setRoleName(roleName);
			}
			List list = this.rolesService.selectList(roles);
			json = ResultUtil.createSuccessResult(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveRoles", method = {RequestMethod.GET, RequestMethod.POST})
	public String saveRoles(String roleName,String memo,String resourceSid,String channelSid,HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String[] reSid = null;
		String[] chSid = null;
		try {
			Roles roles = new Roles();
			if(roleName != null &&!"".equals(roleName)){
				roles.setRoleName(roleName);
			}
			if(memo != null && !"".equals(memo)){
				roles.setMemo(memo);
			}
			this.rolesService.insert(roles);
			Long roleSid = this.rolesService.queryMaxRoleSid();
			if(resourceSid != null && !"".equals(resourceSid)){
				 reSid = resourceSid.split(",");
				for(int i = 0;i < reSid.length ; i++){
					this.updateRoleResource(Long.valueOf(roleSid),Long.valueOf(reSid[i]));
				}
			}
			if(channelSid != null && !"".equals(channelSid)){
				 chSid = channelSid.split(",");
			 	for(int i = 0 ; i < chSid.length ; i++){
					this.updateRoleChannel(Long.valueOf(roleSid),Integer.valueOf(chSid[i]));
				 }
			}
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateRoles", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateRoles(String roleName,String memo,String resourceSid,String channelSid,HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String[] reSid = null;
		String[] chSid = null;
		String sid = request.getParameter("sid");
		if(resourceSid != null && !"".equals(resourceSid)){
		 reSid = resourceSid.split(",");
		}
		if(channelSid != null && !"".equals(channelSid)){
		 chSid = channelSid.split(",");
		}
		Roles roles = new Roles();
		try {
			if(sid != null && !"".equals(sid)){
				roles.setSid(Long.valueOf(sid));
			}
			if(roleName != null && !"".equals(roleName)){
				roles.setRoleName(roleName);
			}
			if(memo != null && !"".equals(memo)){
				roles.setMemo(memo);
			}
			this.rolesService.updateByPrimaryKeySelective(roles);
			if(resourceSid != null && !"".equals(resourceSid)){
				this.roleResourceService.deleteByRoleSid(Long.valueOf(sid));
				for(int i = 0;i < reSid.length ; i++){
					this.updateRoleResource(Long.valueOf(sid),Long.valueOf(reSid[i]));
				}
			}
			if(channelSid != null && !"".equals(channelSid)){
				this.roleChannelService.deleteByRoleSid(Long.valueOf(sid));
			 	for(int i = 0 ; i < chSid.length ; i++){
					 this.updateRoleChannel(Long.valueOf(sid),Integer.valueOf(chSid[i]));
				 }
			}
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/delRoles", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteByPrimaryKey(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		String sid = request.getParameter("roleSid");
		
		try{
			this.rolesService.deleteByPrimaryKey(Long.valueOf(sid));
			this.roleResourceService.deleteByRoleSid(Long.valueOf(sid));
			this.roleChannelService.deleteByRoleSid(Long.valueOf(sid));
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	
	public void updateRoleResource(Long roleSid,Long resourceSid){
		
		RoleResource roleResource = new RoleResource();
		roleResource.setRolesSid(roleSid);
		roleResource.setResourcesSid(resourceSid);
		this.roleResourceService.insert(roleResource);
	}
	
	public void updateRoleChannel(Long roleSid,Integer channelSid){
		
		RoleChannel roleChannel = new RoleChannel();
		roleChannel.setRolesSid(roleSid);
		roleChannel.setChannelSid(channelSid);
		this.roleChannelService.insert(roleChannel);
	}
}
