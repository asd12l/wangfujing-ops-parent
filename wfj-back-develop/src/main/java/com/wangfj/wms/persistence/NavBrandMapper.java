package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.NavBrand;


@WangfjMysqlMapper
public interface NavBrandMapper {
    int deleteByPrimaryKey(Long sid);
    
    int insert(NavBrand record);

    int insertSelective(NavBrand record);

    NavBrand selectByPrimaryKey(Long sid);

    int updateByPrimaryKeySelective(NavBrand record);

    int updateByPrimaryKey(NavBrand record);
    
    int updateBybrandSid(NavBrand record);

    List selectNavBrandByNavSid(NavBrand record);
    
    int countNavBrandRecord(NavBrand record);
    
    int countSeq(NavBrand record);
    
    int maxSeq(NavBrand record);
}