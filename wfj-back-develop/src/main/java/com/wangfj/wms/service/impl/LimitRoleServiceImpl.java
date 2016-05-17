package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.LimitRole;
import com.wangfj.wms.persistence.LimitRoleMapper;
import com.wangfj.wms.service.ILimitRoleService;

/**
 * 角色管理接口实现
 * @Class Name LimitRoleServiceImpl
 * @Author chenqb
 * @Create In 2013-8-9
 */
@Component("limitRoleService")
@Scope("prototype")
@Transactional
public class LimitRoleServiceImpl implements ILimitRoleService {
	
	@Autowired
	private LimitRoleMapper roleMapper;
	
	@Override
	public Integer deleteLimitRole(LimitRole role) {
		// TODO Auto-generated method stub
		return roleMapper.delete(role);
	}

	@Override
	public List<LimitRole> getAll(LimitRole role) {
		// TODO Auto-generated method stub
		List<LimitRole> l = roleMapper.getAllLimitRole(role);
		return l;
		
	}

	@Override
	public List<LimitRole> getByParam(LimitRole role) {
		// TODO Auto-generated method stub
		return roleMapper.getLimitRoleByParam(role);
	}

	@Override
	public Integer saveLimitRole(LimitRole role) {
		// TODO Auto-generated method stub
		return roleMapper.insert(role);
	}

	@Override
	public Integer updateLimitRole(LimitRole role) {
		// TODO Auto-generated method stub
		return roleMapper.update(role);
	}

	@Override
	public int getTotalByParam(LimitRole role) {
		return roleMapper.getTotalByParam(role);
	}

	@Override
	public List<LimitRole> getAllUsefullRole() {
		List<LimitRole> l = roleMapper.getAllUsefullRole();
		return l;
	}
	
	@Override
	public List<LimitRole> getUserRolesByRoleCode(List<String> paramList){
		return roleMapper.getUserRolesByRoleCode(paramList);
	}
	
}
