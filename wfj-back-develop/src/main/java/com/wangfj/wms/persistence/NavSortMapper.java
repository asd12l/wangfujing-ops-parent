package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.NavSort;

@WangfjMysqlMapper
public interface NavSortMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(NavSort record);

    int insertSelective(NavSort record);

    NavSort selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(NavSort record);

    int updateByPrimaryKey(NavSort record);
    
    List<NavSort> queryList(Integer shopChannelsSid); 
    
    int enableSort(NavSort record);
    
    int unableSort(NavSort record);
}