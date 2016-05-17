/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.impl.RoleResourceServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-7-8 下午2:27:40
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.RoleResource;
import com.wangfj.wms.domain.view.RoleResourceVO;
import com.wangfj.wms.persistence.RoleResourceMapper;
import com.wangfj.wms.service.IRoleResourceService;

/**
 * @Class Name RoleResourceServiceImpl
 * @Author chengsj
 * @Create In 2013-7-8
 */
@Component("roleResourceService")
@Scope("prototype")
@Transactional
public class RoleResourceServiceImpl implements IRoleResourceService {

	@Autowired
	RoleResourceMapper roleResourceMapper;
	
	
	@Override
	public int insert(RoleResource record) {
		return this.roleResourceMapper.insert(record);
	}

	@Override
	public int insertSelective(RoleResource record) {
		return this.roleResourceMapper.insertSelective(record);
	}

	@Override
	public List<RoleResourceVO> selectByRoleSid(Long sid) {
		return this.roleResourceMapper.selectByRoleSid(sid);
	}

	@Override
	public void deleteByRoleSid(Long sid) {
		this.roleResourceMapper.deleteByRoleSid(sid);
	}

}
