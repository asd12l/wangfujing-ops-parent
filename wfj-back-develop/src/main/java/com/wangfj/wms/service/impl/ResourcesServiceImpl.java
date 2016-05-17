/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implResourcesServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午3:45:09
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.Resources;
import com.wangfj.wms.persistence.ResourcesMapper;
import com.wangfj.wms.service.IResourcesService;

/**
 * @Class Name ResourcesServiceImpl
 * @Author chengsj
 * @Create In 2013-7-5
 */

@Component("resourcesService")
@Scope("prototype")
@Transactional
public class ResourcesServiceImpl implements IResourcesService{

	
	@Autowired
	private ResourcesMapper resourcesMapper;

	@Override
	public int deleteByPrimaryKey(Long sid) {
		return this.resourcesMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(Resources record) {
		
		return this.resourcesMapper.insert(record);
	}

	@Override
	public int insertSelective(Resources record) {
		return this.resourcesMapper.insertSelective(record);
	}

	@Override
	public Resources selectByPrimaryKey(Long sid) {
		return this.resourcesMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(Resources record) {
		return this.resourcesMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKey(Resources record) {
		return this.resourcesMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public List selectAllResources() {
		
		return this.resourcesMapper.selectAllResources();
	}


	@Override
	public List selectResourceByName(Resources record) {
		
		return this.resourcesMapper.selectResourceByName(record);
	}



	@Override
	public List selectList(Resources record) {
		return this.resourcesMapper.selectList(record);
	}

	@Override
	public List selectOthersByPrimaryKey(List<Long> sids) {
		return this.resourcesMapper.selectOthersByPrimaryKey(sids);
	}

	
	
}
