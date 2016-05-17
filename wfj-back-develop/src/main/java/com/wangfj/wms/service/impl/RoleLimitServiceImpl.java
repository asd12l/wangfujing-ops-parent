package com.wangfj.wms.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.RolePermission;
import com.wangfj.wms.persistence.RolePermissionMapper;
import com.wangfj.wms.service.IRoleLimitService;

@Component("roleLimitService")
@Scope("prototype")
public class RoleLimitServiceImpl implements IRoleLimitService {
	
	@Autowired
	RolePermissionMapper rolePermissionMapper;
	
	@Override
	@Transactional
	public void saveRolePermission(List<RolePermission> roleLimits){
		RolePermission rolePerParam = new RolePermission();
		rolePerParam.setRoleSid(roleLimits.get(0).getRoleSid());
		List<RolePermission> lists = rolePermissionMapper.selectBySelective(rolePerParam);
		rolePerParam.setStatus(0);
		rolePerParam.setPermissionType(0);
		rolePermissionMapper.updateStatusByroleSid(rolePerParam);
		rolePerParam.setPermissionType(1);
		rolePermissionMapper.updateStatusByroleSid(rolePerParam);
		for(RolePermission roleLimit : roleLimits){
			if(roleLimit.getPermissionType() == 2 && roleLimit.getCol2().equals("3")){
				rolePerParam.setPermissionType(2);
				rolePerParam.setCol1(roleLimit.getCol1());
				rolePerParam.setCol3(roleLimit.getPermission());
				rolePermissionMapper.updateStatusByroleSid(rolePerParam);
			}
		}
		for(RolePermission roleLimit : roleLimits){
			boolean isAdd = true;
			for(RolePermission list : lists){
				if(roleLimit.getPermission().equals(list.getPermission()) 
						&& roleLimit.getPermissionType().equals(list.getPermissionType())){
					list.setStatus(1);
					rolePermissionMapper.updateByPrimaryKey(list);
					isAdd = false;
					break;
				}
			}
			if(isAdd){
				rolePermissionMapper.insertSelective(roleLimit);
			}
		}
	}
	
	@Override
	public List<RolePermission> selectRolePermissionByParam(RolePermission param){		
		return rolePermissionMapper.selectBySelective(param);
	}
	
	@Override
	public List<RolePermission> selectByRoleCodesOrTypes(Map<String, Object> paramMap){		
		return rolePermissionMapper.selectByRoleCodesOrTypes(paramMap);
	}
	
	/**
	 * 根据门店查询权限管理分类
	 */
	@Override
	public List<String> selectManageCateByShopSidAndLevel(String shopSid, List<String> levels){
		List<String> list = new ArrayList<String>();
		Map<String, Object> paramMap =new HashMap<String, Object>();
		paramMap.put("col1", shopSid);
		paramMap.put("levels", levels);
		paramMap.put("permissionType", 2);
		paramMap.put("status", 1);
		List<RolePermission> rpList = 
				rolePermissionMapper.selectManageCateByShopSidAndLevel(paramMap);
		if(rpList != null && rpList.size() != 0){
			for(RolePermission rp : rpList){
				list.add(rp.getPermission());
			}
		}
		return list;
	}
	
}
