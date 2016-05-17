/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.RoleResourceTest.java
 * @Create By chengsj
 * @Create In 2013-7-8 下午2:30:35
 * TODO
 */
package com.wangfj.wms.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.wangfj.wms.base.BaseTestContext;

/**
 * @Class Name RoleResourceTest
 * @Author chengsj
 * @Create In 2013-7-8
 */
public class RoleResourceTest extends BaseTestContext {

	@Autowired
	IRoleResourceService roleResourceService;
	
	@Test
	public void TestSelectByRoleSid(){
		System.out.println(this.roleResourceService.selectByRoleSid(1041L));;
	}
	
}
