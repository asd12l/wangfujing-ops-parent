/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceRoleChannelServiceTest.java
 * @Create By chengsj
 * @Create In 2013-7-8 下午4:47:20
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.RoleChannel;

/**
 * @Class Name RoleChannelServiceTest
 * @Author chengsj
 * @Create In 2013-7-8
 */
public class RoleChannelServiceTest extends BaseTestContext{
	
	@Autowired
	private IRoleChannelService roleChannelService;
	@Autowired
	private ITRuleNewMqlService tRuleNewMqlService;
	
	//@Test
	public void testInsert() {
		Assert.notNull(roleChannelService);
		RoleChannel roleChannel = new RoleChannel();
		roleChannel.setChannelSid(3);
		roleChannel.setRolesSid(1041l);
		
		this.roleChannelService.insert(roleChannel);
	}

//	@Test
	public void testInsertSelective() {
		RoleChannel roleChannel = new RoleChannel();
		roleChannel.setChannelSid(4);
		roleChannel.setRolesSid(2l);
		
		this.roleChannelService.insert(roleChannel);
	}
	
	//@Test
	public void testSelectList() {
		RoleChannel record = new RoleChannel();
		record.setRolesSid(2l);
		record.setChannelSid(3);
		List list = this.roleChannelService.selectList(record);
		RoleChannel roleChannel = (RoleChannel)list.get(0);
		System.out.println(roleChannel.getChannelSid() + ":" + roleChannel.getRolesSid());
		System.out.println(list.size());
	}
	
//	@Test
	public void testSelectAllRoleChannel() {
		List list = this.roleChannelService.selectAllRoleChannel();
		System.out.println(list.size());
	}
	
//	@Test
	public void testDeleteByParamter() {
		RoleChannel record = new RoleChannel();
		record.setChannelSid(1);
		record.setRolesSid(2l);
		int a = this.roleChannelService.deleteByParamter(record);
		System.out.println(a);
	}
	@Test
	public void testQueryAllRules() {
	List list = this.tRuleNewMqlService.findAllRules();
		System.out.println(list);
	}
}
