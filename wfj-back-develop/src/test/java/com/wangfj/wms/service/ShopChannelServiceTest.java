package com.wangfj.wms.service;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.Channel;
import com.wangfj.wms.domain.entity.Promotions;
import com.wangfj.wms.domain.view.ChannelPromotionVO;

/**
 * @Class Name ShopChannelServiceTest
 * @Author chengsj
 * @Create In 2013-7-5
 */
public class ShopChannelServiceTest extends BaseTestContext {
	
	@Autowired
	private IChannelService channelService;
	
	@Autowired
	private IPromotionService promotionService;
	
	@Test
	public void testSelect() {
		Assert.notNull(this.channelService);
		Channel channel = this.channelService.selectByPrimaryKey(1);
		System.out.println(channel);
	}
	
//	@Test
	public void testInset() {
		Channel channel = new Channel();
		channel.setPageLayoutSid(1);
		channel.setPageTemplateSid(1);
		channel.setChannelDesc("这是测试");
		channel.setChannelUrl("www.hao123.com");
		channel.setDisplayName("测试频道");
		channel.setFlag(1);
		channel.setIsShow(1);
		channel.setName("测试名字");
		channel.setSeq("1");
		this.channelService.insert(channel);
	}
	
//	@Test
	public void testInsetSelective() {
		Channel channel = new Channel();
		channel.setPageLayoutSid(1);
		channel.setPageTemplateSid(1);
		channel.setChannelDesc("这是测试2");
		channel.setChannelUrl("www.hao123.com2");
		channel.setDisplayName("测试频道2");
		channel.setFlag(2);
		channel.setIsShow(2);
		channel.setName("测试名字2");
		channel.setSeq("2");
		
		this.channelService.insertSelective(channel);
	}
	
//	@Test
	public void testSelectByPrimaryKey() {
		
		System.out.println(this.channelService.selectByPrimaryKey(1));
	}
//	
//	@Test
	public void testUpdateByPrimaryKey() {
		Channel channel = new Channel();
		channel.setSid(136);
		channel.setName("更改测试");

		this.channelService.updateByPrimaryKey(channel);
		System.out.println(channel.getChannelUrl());
	}
//	
//	@Test
	public void testUpdateByPrimaryKeySelective() {
		Channel channel = new Channel();
		channel.setSid(137);
		channel.setName("更改测试2");
		int a = this.channelService.updateByPrimaryKeySelective(channel);
		System.out.println(a);
	}
	
//	@Test
	public void testDeleteByPrimaryKey() {
		int a = this.channelService.deleteByPrimaryKey(137);
		System.out.println(a);
	}
	
	@Test
	public void testSelectAllChannels()	{
		List list = this.channelService.selectAllChannles();
		System.out.print(list.size());
	}
	
	@Test
	public void testQueryPromotionByChannelSid()	{
		List sids = this.channelService.queryPromotionByChannelSid(201);
		List<Promotions> list = this.promotionService.queryBySids(sids);
		System.out.print(list);
	}
	
	@Test
	public void testSaveChannelPromotion()	{
		ChannelPromotionVO vo = new ChannelPromotionVO();
		vo.setPromotionSid(211);
		vo.setShopChannelSid(201);
		this.channelService.saveChannelPromotion(vo);
		List sids = this.channelService.queryPromotionByChannelSid(201);
		List<Promotions> list = this.promotionService.queryBySids(sids);
		System.out.print(list);
	}
	
	@Test
	public void testDelPromotion(){
		ChannelPromotionVO vo = new ChannelPromotionVO();
		vo.setPromotionSid(211);
		vo.setShopChannelSid(201);
		this.channelService.delPeomotion(vo);
	}
}
