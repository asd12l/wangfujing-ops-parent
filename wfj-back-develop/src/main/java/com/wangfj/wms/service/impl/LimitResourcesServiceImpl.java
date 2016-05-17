package com.wangfj.wms.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.LimitResource;
import com.wangfj.wms.persistence.LimitResourceMapper;
import com.wangfj.wms.service.ILimitResourcesService;

/**
 * 资源接口实现
 * @Class Name LimitResourcesServiceImpl
 * @Author chenqb
 * @Create In 2013-8-9
 */
@Component("limitResourceService")
@Scope("prototype")
@Transactional
public class LimitResourcesServiceImpl implements ILimitResourcesService {
	
	@Autowired
	private LimitResourceMapper resourceMapper;
	@Override
	public Integer deleteLimitResource(LimitResource resource) {
		// TODO Auto-generated method stub
		return resourceMapper.delete(resource);
	}

	@Override
	public List<LimitResource> getAll() {
		// TODO Auto-generated method stub
		return resourceMapper.getAllLimitResource();
	}

	@Override
	public List<LimitResource> getByParam(LimitResource resource) {
		// TODO Auto-generated method stub
		return resourceMapper.getLimitResourceByparam(resource);
	}

	@Override
	public Integer saveLimitResource(LimitResource resource) {
		// TODO Auto-generated method stub
		return resourceMapper.insert(resource);
	}

	@Override
	public Integer updateLimitResource(LimitResource resource) {
		// TODO Auto-generated method stub
		return resourceMapper.update(resource);
	}

	@Override
	public List<LimitResource> getSlideResourcesByparam(Map param) {
		// TODO Auto-generated method stub
		return resourceMapper.getSlideResourcesByparam(param);
	}
	
	@Override
	public List<LimitResource> getAllResourcesByUserRolesCode(List<String> paramList){
		// TODO Auto-generated method stub
		return resourceMapper.getAllResourcesByUserRolesCode(paramList);
	}
	
	@Override
	public List<LimitResource> getResourcesByParentSid(Map<String, Object> paramMap){
		// TODO Auto-generated method stub
		return resourceMapper.getResourcesByParentSid(paramMap);
	}

}
