package com.wangfj.wms.persistence;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.ChannelAds;

import java.util.List;


@WangfjMysqlMapper
public interface ChannelAdsMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(ChannelAds record);

    int insertSelective(ChannelAds record);

    ChannelAds selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ChannelAds record);

    int updateByPrimaryKey(ChannelAds record);
    
    List selectByChannelSid(Integer channelSid);
}