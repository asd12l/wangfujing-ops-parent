package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.LimitRole;

/**
 * 角色信息接口
 * @Class Name ILimitRoleService
 * @Author chenqb
 * @Create In 2013-8-9
 */
public interface ILimitRoleService {
	
	public List<LimitRole> getAll(LimitRole role)throws Exception;
	
	public List<LimitRole> getByParam(LimitRole role)throws Exception;
	
	public Integer saveLimitRole(LimitRole role)throws Exception;
	
	public Integer updateLimitRole(LimitRole role)throws Exception;
	
	public Integer deleteLimitRole(LimitRole role)throws Exception;

	public int getTotalByParam(LimitRole role);

	public List<LimitRole> getAllUsefullRole();

	List<LimitRole> getUserRolesByRoleCode(List<String> paramList);
}
