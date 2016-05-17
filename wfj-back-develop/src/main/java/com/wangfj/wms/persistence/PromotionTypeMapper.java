package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.PromotionType;


public interface PromotionTypeMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(PromotionType record);

    int insertSelective(PromotionType record);

    PromotionType selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PromotionType record);

    int updateByPrimaryKey(PromotionType record);
    
    List queryBySelective(PromotionType record);
}