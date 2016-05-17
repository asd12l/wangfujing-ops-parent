package com.wangfj.wms.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.wangfj.wms.base.BaseTestContext;

/**
 * 
 * @Class Name ChannelAdsServiceTest
 * @Author chengsj
 * @Create In 2013-11-14
 */
public class ChannelAdsServiceTest extends BaseTestContext {

	@Autowired
	IChannelAdsService channelAdsService;
	
	
	@Test
	public void testSelectByChannelSid(){
		System.out.println(this.channelAdsService.selectByChannelSid(165));
	}
}
