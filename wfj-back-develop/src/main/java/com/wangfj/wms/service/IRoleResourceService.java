/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.IRoleResource.java
 * @Create By chengsj
 * @Create In 2013-7-8 下午2:17:24
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.RoleResource;


/**
 * @Class Name IRoleResource
 * @Author chengsj
 * @Create In 2013-7-8
 */
public interface IRoleResourceService{

	int insert(RoleResource record);

    int insertSelective(RoleResource record);
    
    List selectByRoleSid(Long sid);
    
    void deleteByRoleSid(Long sid);
}
