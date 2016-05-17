/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.mapper.RoleResourcesTest.java
 * @Create By chengsj
 * @Create In 2013-7-10 下午1:58:54
 * TODO
 */
package com.wangfj.wms.mapper;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.RoleResource;
import com.wangfj.wms.persistence.RoleResourceMapper;

/**
 * @Class Name RoleResourcesTest
 * @Author chengsj
 * @Create In 2013-7-10
 */
public class RoleResourcesTest extends BaseTestContext {

	
	@Autowired
	RoleResourceMapper roleResourceMapper;
	
	@Test
	@Transactional
	@Rollback(false)
	public void testInsert() {
		RoleResource roleResource = new RoleResource();
		roleResource.setRolesSid(11111L);
		roleResource.setResourcesSid(3L);
		
		this.roleResourceMapper.insert(roleResource);
	}
	
	
}
