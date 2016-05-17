/**
 * 
 */
package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.LimitRole;



/**
 * 角色DAO
 * @Class Name LimitRoleMapper
 * @Author chenqb
 * @Create In 2013-8-7
 */
@WangfjMysqlMapper
public interface LimitRoleMapper {
	/**
	 * 得到所有的角色
	 * @param role 
	 * @Methods Name getAllLimitRole
	 * @Create In 2013-8-8 By Administrator
	 * @return List<LimitRole>
	 */
	public List<LimitRole> getAllLimitRole(LimitRole role);
	/**
	 * 根据条件进行查询
	 * @Methods Name getLimitRoleByParam
	 * @Create In 2013-8-8 By Administrator
	 * @param role
	 * @return List<LimitRole>
	 */
	public List<LimitRole> getLimitRoleByParam(LimitRole role);
	/**
	 * 保存角色
	 * @Methods Name insert
	 * @Create In 2013-8-8 By Administrator
	 * @param role
	 * @return Integer
	 */
	public Integer insert(LimitRole role); 
	/**
	 * 修改角色
	 * @Methods Name update
	 * @Create In 2013-8-8 By Administrator
	 * @param role
	 * @return Integer
	 */
	public Integer update(LimitRole role);
	/**
	 * 删除角色
	 * @Methods Name delete
	 * @Create In 2013-8-8 By Administrator
	 * @param role
	 * @return Integer
	 */
	public Integer delete(LimitRole role);
	/**
	 * 根据条件获取总条数
	 * @Methods Name getTotalByParam
	 * @Create In 2015-4-23 By wwb
	 * @param role
	 * @return int
	 */
	public int getTotalByParam(LimitRole role);
	
	public List<LimitRole> getAllUsefullRole();
	
	/**
	 * 根据角色Code批量查询角色
	 * @Methods Name getUserRolesByRoleCode
	 * @Create In 2016年3月24日 By zdl
	 * @param paramList
	 * @return List<LimitRole>
	 */
	public List<LimitRole> getUserRolesByRoleCode(List<String> paramList);
	
}
