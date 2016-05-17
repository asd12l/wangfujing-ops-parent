package com.wangfj.wms.service;

import java.util.List;
import java.util.Map;

import com.wangfj.wms.domain.entity.RolePermission;

public interface IRoleLimitService {

	void saveRolePermission(List<RolePermission> roleLimits);

	List<RolePermission> selectRolePermissionByParam(RolePermission param);

	List<RolePermission> selectByRoleCodesOrTypes(Map<String, Object> paramMap);

	List<String> selectManageCateByShopSidAndLevel(String shopSid,
			List<String> levels);

}
