package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.PageLayoutContent;


public interface PageLayoutContentMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(PageLayoutContent record);

    int insertSelective(PageLayoutContent record);

    PageLayoutContent selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PageLayoutContent record);

    int updateByPrimaryKey(PageLayoutContent record);
    
    List queryByPageLayoutSid(Integer pageLayoutSid);
}