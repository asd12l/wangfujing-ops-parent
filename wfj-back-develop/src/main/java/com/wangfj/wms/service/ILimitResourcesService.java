package com.wangfj.wms.service;

import java.util.List;
import java.util.Map;

import com.wangfj.wms.domain.entity.LimitResource;

/**
 * 资源描述接口
 * @Class Name ILimitResourcesService
 * @Author chenqb
 * @Create In 2013-8-9
 */
public interface ILimitResourcesService {
	
	public List<LimitResource> getSlideResourcesByparam(Map param);
	
	public List<LimitResource> getAll()throws Exception;
	
	public List<LimitResource> getByParam(LimitResource resource)throws Exception;
	
	public Integer saveLimitResource(LimitResource resource)throws Exception;
	
	public Integer updateLimitResource(LimitResource resource)throws Exception;
	
	public Integer deleteLimitResource(LimitResource resource)throws Exception;

	List<LimitResource> getAllResourcesByUserRolesCode(List<String> paramList);

	List<LimitResource> getResourcesByParentSid(Map<String, Object> paramMap);
}
