package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.Resources;


@WangfjMysqlMapper
public interface ResourcesMapper {
    int deleteByPrimaryKey(Long sid);

    int insert(Resources record);

    int insertSelective(Resources record);

    Resources selectByPrimaryKey(Long sid);

    int updateByPrimaryKeySelective(Resources record);

    int updateByPrimaryKey(Resources record);
    
    List selectAllResources();
    

    List selectResourceByName(Resources record);
    
    List selectList(Resources record);
    
    List selectOthersByPrimaryKey(List<Long> sids);
    

//  List selectPage(Roles record);
  
//  int selectPageTotal(Roles record);
    
}