/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implChannelAdsServicwImpl.java
 * @Create By chengsj
 * @Create In 2013-11-14 下午5:47:29
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.ChannelAds;
import com.wangfj.wms.persistence.ChannelAdsMapper;
import com.wangfj.wms.service.IChannelAdsService;


/**
 * @Class Name ChannelAdsServicwImpl
 * @Author chengsj
 * @Create In 2013-11-14
 */
@Component("channelAdsService")
@Scope("prototype")
@Transactional
public class ChannelAdsServicwImpl implements IChannelAdsService {

	@Autowired
	ChannelAdsMapper channelAdsMapper;

	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.channelAdsMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(ChannelAds record) {
		// TODO Auto-generated method stub
		return this.channelAdsMapper.insert(record);
	}

	@Override
	public int insertSelective(ChannelAds record) {
		// TODO Auto-generated method stub
		return this.channelAdsMapper.insertSelective(record);
	}

	@Override
	public ChannelAds selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.channelAdsMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(ChannelAds record) {
		// TODO Auto-generated method stub
		return this.channelAdsMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ChannelAds record) {
		// TODO Auto-generated method stub
		return this.channelAdsMapper.updateByPrimaryKey(record);
	}

	@Override
	public List selectByChannelSid(Integer channelSid) {
		// TODO Auto-generated method stub
		return this.channelAdsMapper.selectByChannelSid(channelSid);
	}

}
