package com.wangfj.wms.persistence;

import java.util.List;
import java.util.Map;

import com.wangfj.wms.domain.entity.RolePermission;

public interface RolePermissionMapper {
    int deleteByPrimaryKey(Long sid);

    int insert(RolePermission record);

    int insertSelective(RolePermission record);

    RolePermission selectByPrimaryKey(Long sid);

    int updateByPrimaryKeySelective(RolePermission record);

    int updateByPrimaryKey(RolePermission record);
    
    int updateStatusByroleSid(RolePermission record);
    
    List<RolePermission> selectBySelective(RolePermission record);
    
    List<RolePermission> selectByRoleCodesOrTypes(Map<String, Object> paramMap);
    
    List<RolePermission> selectManageCateByShopSidAndLevel(Map<String, Object> paramMap);
}