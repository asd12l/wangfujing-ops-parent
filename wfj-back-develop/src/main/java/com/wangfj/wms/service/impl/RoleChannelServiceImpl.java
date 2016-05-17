/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.impl.RoleChannelServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-7-8 下午8:31:32
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.RoleChannel;
import com.wangfj.wms.persistence.RoleChannelMapper;
import com.wangfj.wms.service.IRoleChannelService;


/**
 * @Class Name RoleChannelServiceImpl
 * @Author chengsj
 * @Create In 2013-7-8
 */
@Component("roleChannelService")
@Scope("prototype")
@Transactional
public class RoleChannelServiceImpl implements IRoleChannelService {

	@Autowired
	RoleChannelMapper roleChannelMapper;
	@Override
	public int deleteByParamter(RoleChannel record) {
		// TODO Auto-generated method stub
		return this.roleChannelMapper.deleteByParamter(record);
	}

	@Override
	public int insert(RoleChannel record) {
		// TODO Auto-generated method stub
		return this.roleChannelMapper.insert(record);
	}

	@Override
	public int insertSelective(RoleChannel record) {
		// TODO Auto-generated method stub
		return this.roleChannelMapper.insertSelective(record);
	}

	@Override
	public List selectList(RoleChannel record) {
		// TODO Auto-generated method stub
		return this.roleChannelMapper.selectList(record);
	}

	@Override
	public List selectAllRoleChannel() {
		// TODO Auto-generated method stub
		return this.roleChannelMapper.selectAllRoleChannel();
	}

	public void deleteByRoleSid(Long sid) {
		this.roleChannelMapper.deleteByRoleSid(sid);
	}

}
