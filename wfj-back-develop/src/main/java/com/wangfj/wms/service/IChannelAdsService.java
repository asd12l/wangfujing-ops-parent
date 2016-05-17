package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.ChannelAds;


/**
 * 
 * @Class Name IChannelAds
 * @Author chengsj
 * @Create In 2013-11-14
 */
public interface IChannelAdsService {

	int deleteByPrimaryKey(Integer sid);

    int insert(ChannelAds record);

    int insertSelective(ChannelAds record);

    ChannelAds selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ChannelAds record);

    int updateByPrimaryKey(ChannelAds record);
    
    List selectByChannelSid(Integer channelSid);
}
