package com.wangfj.wms.persistence;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.back.view.ProductKey;
import com.wangfj.wms.domain.entity.ProConSearchMql;


@WangfjMysqlMapper
public interface ProConSearchMqlMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(ProConSearchMql record);

    int insertSelective(ProConSearchMql record);

    ProConSearchMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ProConSearchMql record);

    int updateByPrimaryKey(ProConSearchMql record);
    
    void updateProConSearch(ProductKey productKey);
}