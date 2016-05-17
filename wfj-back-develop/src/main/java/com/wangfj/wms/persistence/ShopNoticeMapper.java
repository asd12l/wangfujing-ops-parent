package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.ShopNotice;

@WangfjMysqlMapper
public interface ShopNoticeMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(ShopNotice record);

    int insertSelective(ShopNotice record);

    ShopNotice selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ShopNotice record);

    int updateByPrimaryKey(ShopNotice record);
    
    List<ShopNotice> selectByNoticeType(Integer typeSid);
}