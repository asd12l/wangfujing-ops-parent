/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.LeaveMessageServiceTest.java
 * @Create By chengsj
 * @Create In 2013-8-14 下午6:17:51
 * TODO
 */
package com.wangfj.wms.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.LeaveMessageType;

/**
 * @Class Name LeaveMessageServiceTest
 * @Author chengsj
 * @Create In 2013-8-14
 */
public class LeaveMessageServiceTest extends BaseTestContext{

	@Autowired
	ILeaveMessageTypeService leaveMessageTypeService;
	
	@Test
	public void testSelectByPid(){
		System.out.println(this.leaveMessageTypeService.selectByPid(0));
	}
	
	@Test
	public void testSelectList(){
		LeaveMessageType leaveMessageType = new LeaveMessageType();
		//leaveMessageType.setPid(0);
		//leaveMessageType.setCatename("咨询问题");
		//leaveMessageType.setTotal(1);
		System.out.println(this.leaveMessageTypeService.selectList(leaveMessageType));
	}
}
