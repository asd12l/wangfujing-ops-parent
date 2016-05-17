/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.mapper.ShopChannelTest.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午4:01:14
 * TODO
 */
package com.wangfj.wms.mapper;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.SysParameterType;
import com.wangfj.wms.persistence.SysParameterTypeMapper;

/**
 * @Class Name ShopChannelTest
 * @Author chengsj
 * @Create In 2013-7-5
 */
public class SysParameterTypeTest extends BaseTestContext{
	
	@Autowired
	private SysParameterTypeMapper sysParameterTypeMapper;
	
	@Test
	@Transactional
	@Rollback(false)
	public void testSelect(){
		Assert.notNull(this.sysParameterTypeMapper);
		String code = "t";
		List<SysParameterType> list = this.sysParameterTypeMapper.selectByCode(code);
		for(SysParameterType s : list) {
			System.out.println(s.getCode());
		}
	}
//	
//	@Test
//	@Transactional
//	@Rollback(false)
//	public void testInsert(){
//		Channel channel = new Channel();
//		channel.setPageLayoutSid(1);
//		channel.setPageTemplateSid(1);
//		channel.setChannelDesc("这是测试");
//		channel.setChannelUrl("www.hao123.com");
//		channel.setDisplayName("测试频道");
//		channel.setFlag(1);
//		channel.setIsShow(1);
//		channel.setName("测试名字");
//		channel.setSeq("1");
//		this.channelMapper.insert(channel);
//		
//	}
	
}
