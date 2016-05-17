package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.RoleResource;

@WangfjMysqlMapper
public interface RoleResourceMapper {
    int insert(RoleResource record);

    int insertSelective(RoleResource record);
    
    List selectByRoleSid(Long sid);
    
    List selectResourceSidByRoleSid(Long sid);
    
    void deleteByRoleSid(Long sid);
    
}