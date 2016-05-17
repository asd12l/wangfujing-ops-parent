package com.wangfj.wms.persistence;

import java.util.List;
import java.util.Map;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.LimitResource;


/**
 * 资源信息dao
 * @Class Name LimitResourceMapper
 * @Author chenqb
 * @Create In 2013-8-7
 */
@WangfjMysqlMapper
public interface LimitResourceMapper {
	
	/**
	 * 得到所有资源
	 * @Methods Name getAllLimitResource
	 * @Create In 2013-8-8 By chenqb
	 * @return List<LimitResource>
	 */
	public List<LimitResource> getAllLimitResource();
	
	/**
	 * 根据条件查询左侧导航菜单
	 * @Methods Name getSlideResourcesByparam
	 * @Create In 2014-12-20 By KUNPENG
	 * @param param
	 * @return List<LimitResource>
	 */
	public List<LimitResource> getSlideResourcesByparam(Map param);
	/**
	 * 根据条件进行查询资源
	 * @Methods Name getLimitResourceByparam
	 * @Create In 2013-8-8 By chenqb
	 * @return List<LimitResource>
	 */
	public List<LimitResource> getLimitResourceByparam(LimitResource resource);
	/**
	 * 保存资源
	 * @Methods Name insert
	 * @Create In 2013-8-8 By chenqb
	 * @param resource
	 * @return Integer
	 */
	public Integer insert(LimitResource resource);
	/**
	 * 修改资源
	 * @Methods Name update
	 * @Create In 2013-8-8 By chenqb
	 * @param resource
	 * @return Integer
	 */
	public Integer update(LimitResource resource);
	/**
	 * 删除资源
	 * @Methods Name delete
	 * @Create In 2013-8-8 By Administrator
	 * @param resource
	 * @return Integer
	 */
	public Integer delete(LimitResource resource);
	/**
	 * 根据用户下所有角色code查询
	 * @Methods Name getAllResourcesByUserRolesCode
	 * @Create In 2016年3月24日 By zdl
	 * @param paramList
	 * @return List<LimitResource>
	 */
	public List<LimitResource> getAllResourcesByUserRolesCode(List<String> paramList);
	/**
	 * 
	 * @Methods Name getResourcesByParentSid
	 * @Create In 2016年3月24日 By zdl
	 * @param paramMap
	 * @return List<LimitResource>
	 */
	public List<LimitResource> getResourcesByParentSid(Map<String, Object> paramMap);
	
}
