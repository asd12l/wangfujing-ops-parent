package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.ShopChannelsMql;


public interface ShopChannelsMqlMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(ShopChannelsMql record);

    int insertSelective(ShopChannelsMql record);

    ShopChannelsMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ShopChannelsMql record);

    int updateByPrimaryKey(ShopChannelsMql record);
    
    List<ShopChannelsMql> findAllChannels();

    Integer getMaxSid();
}