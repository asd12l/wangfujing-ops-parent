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
import com.wangfj.wms.persistence.ChannelMapper;
import com.wangfj.wms.persistence.TRuleNewChannelMqlMapper;
import com.wangfj.wms.util.ChannelsMqlVO;

/**
 * @Class Name ShopChannelTest
 * @Author chengsj
 * @Create In 2013-7-5
 */
public class ShopChannelMapperTest extends BaseTestContext{
	
	@Autowired
	private ChannelMapper channelMapper;
	@Autowired
	private TRuleNewChannelMqlMapper channelMqlMapper;
	
//	@Test
//	@Transactional
//	@Rollback(false)
//	public void testSelect(){
//		Assert.notNull(this.channelMapper);
//		Channel channel = this.channelMapper.selectByPrimaryKey(1);
//		System.out.println(channel);
//	}
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
	
	@Test
	@Transactional
	@Rollback(false)
	public void testChannels(){
		Assert.notNull(this.channelMqlMapper);
		List<ChannelsMqlVO> channel = this.channelMqlMapper.findChannels();
		System.out.println(channel);
	}
}
