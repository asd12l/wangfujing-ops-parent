package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.NavSortItem;


public interface INavSortItemService {
    int deleteByPrimaryKey(Integer sid);

    int insert(NavSortItem record);

    int insertSelective(NavSortItem record);

    NavSortItem selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(NavSortItem record);

    int updateByPrimaryKey(NavSortItem record);

    List<NavSortItem> queryList(Integer navSortSid); 

    List<NavSortItem> queryItemList(NavSortItem record); 
}
