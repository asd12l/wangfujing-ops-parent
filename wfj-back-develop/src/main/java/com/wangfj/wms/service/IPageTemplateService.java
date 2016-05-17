package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.PageTemplate;


public interface IPageTemplateService {
	int deleteByPrimaryKey(Integer sid);

    int insert(PageTemplate record);

    int insertSelective(PageTemplate record);

    PageTemplate selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PageTemplate record);

    int updateByPrimaryKey(PageTemplate record);
    
    List queryBySelective(PageTemplate record);
    
    List<PageTemplate> findAllTem();
    
    List<PageTemplate> findByType(Integer type);
}
