/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceIRoleChannelService.java
 * @Create By chengsj
 * @Create In 2013-7-8 下午4:47:50
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.RoleChannel;


/**
 * @Class Name IRoleChannelService
 * @Author chengsj
 * @Create In 2013-7-8
 */
public interface IRoleChannelService {
	/**
	 * 删除roles和channel的对应关系
	 */
	int deleteByParamter(RoleChannel record);
	
	void deleteByRoleSid(Long sid);
	
    int insert(RoleChannel record);

    int insertSelective(RoleChannel record);
    
    List selectList(RoleChannel record);
    
    List selectAllRoleChannel();
}
