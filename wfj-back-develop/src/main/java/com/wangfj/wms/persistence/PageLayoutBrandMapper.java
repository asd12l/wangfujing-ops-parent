package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.PageLayoutBrand;


public interface PageLayoutBrandMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(PageLayoutBrand record);

    int insertSelective(PageLayoutBrand record);

    PageLayoutBrand selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PageLayoutBrand record);

    int updateByPrimaryKey(PageLayoutBrand record);
    
    List selectByPageLayoutSid(Integer pageLayoutSid);
    
    int deleteBySelect(PageLayoutBrand record);
}