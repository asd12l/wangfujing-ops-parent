/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.mapper.ShopChannelTest.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午4:01:14
 * TODO
 */
package com.wangfj.back.mapper;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import com.framework.testCase.AbstractTest;
import com.wangfj.wms.domain.entity.SysParameterType;
import com.wangfj.wms.persistence.SysParameterTypeMapper;

/**
 * @Class Name ShopChannelTest
 * @Author chengsj
 * @Create In 2013-7-5
 */
public class SysParameterTypeTest extends AbstractTest{
	
	@Autowired
	private SysParameterTypeMapper sysParameterTypeMapper;
	@Before
	public void setUp() throws Exception {
		super.setUp();
		this.sysParameterTypeMapper = context.getBean(SysParameterTypeMapper.class);
		Assert.notNull(sysParameterTypeMapper, "mapper can not be null");
	}
	@Test
	@Transactional
	@Rollback(false)
	public void testSelect(){
		Assert.notNull(this.sysParameterTypeMapper);
		String code = "T";
		List<SysParameterType> list = this.sysParameterTypeMapper.selectByCode(code);
		System.out.println();
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
	
//	@Test
//	@Transactional
//	@Rollback(false)
//	public void testChannels(){
//		Assert.notNull(this.channelMqlMapper);
//		List<ChannelsMqlVO> channel = this.channelMqlMapper.findChannels();
//		System.out.println(channel);
//	}
}
