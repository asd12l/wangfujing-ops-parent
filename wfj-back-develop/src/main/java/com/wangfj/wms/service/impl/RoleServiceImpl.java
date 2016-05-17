/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implRoleServiceTest.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午2:23:21
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.Roles;
import com.wangfj.wms.persistence.RolesMapper;
import com.wangfj.wms.service.IRolesService;


/**
 * @Class Name RoleServiceImpl
 * @Author chengsj
 * @Create In 2013-7-5
 */
@Component("roleService")
@Scope("prototype")
@Transactional
public class RoleServiceImpl implements IRolesService {

	@Autowired
	private RolesMapper rolesMapper;
	
	
	public int deleteByPrimaryKey(Long sid) {
		return this.rolesMapper.deleteByPrimaryKey(sid);
	}

	public int insert(Roles record) {
		return this.rolesMapper.insert(record);
	}

	public int insertSelective(Roles record) {
		return this.rolesMapper.insertSelective(record);
	}

	public Roles selectByPrimaryKey(Long sid) {
		return this.rolesMapper.selectByPrimaryKey(sid);
	}

	public int updateByPrimaryKeySelective(Roles record) {
		return this.rolesMapper.updateByPrimaryKey(record);
	}

	public int updateByPrimaryKey(Roles record) {
		return this.rolesMapper.updateByPrimaryKeySelective(record);
	}

	public List selectList(Roles record) {
		return this.rolesMapper.selectList(record);
	}

	public List selectAllRoles() {
		return this.rolesMapper.selectAllRoles();
	}

	@Override
	public Long queryMaxRoleSid() {
		return this.rolesMapper.queryMaxRoleSid();
	}

}
