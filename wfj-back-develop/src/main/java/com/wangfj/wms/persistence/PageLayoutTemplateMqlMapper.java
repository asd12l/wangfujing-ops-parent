package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.PageLayoutTemplateMql;


public interface PageLayoutTemplateMqlMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(PageLayoutTemplateMql record);

    int insertSelective(PageLayoutTemplateMql record);

    PageLayoutTemplateMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PageLayoutTemplateMql record);

    int updateByPrimaryKeyWithBLOBs(PageLayoutTemplateMql record);

    int updateByPrimaryKey(PageLayoutTemplateMql record);
    
    List<PageLayoutTemplateMql> queryAllTemplates();
    
    List queryBySelect(PageLayoutTemplateMql record);
}