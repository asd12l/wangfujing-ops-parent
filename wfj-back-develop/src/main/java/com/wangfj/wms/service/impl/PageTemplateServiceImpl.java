/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implPageTemplateServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:59:54
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.PageTemplate;
import com.wangfj.wms.persistence.PageTemplateMapper;
import com.wangfj.wms.service.IPageTemplateService;

/**
 * @Class Name PageTemplateServiceImpl
 * @Author chengsj
 * @Create In 2013-8-29
 */
@Component("pageTemplateService")
@Scope("prototype")
@Transactional
public class PageTemplateServiceImpl implements IPageTemplateService {

	@Autowired
	PageTemplateMapper pageTemplateMapper;
	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageTemplateService#deleteByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.deleteByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageTemplateService#insert(com.wangfj.wms.domain.entity.PageTemplate)
	 */
	@Override
	public int insert(PageTemplate record) {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.insert(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageTemplateService#insertSelective(com.wangfj.wms.domain.entity.PageTemplate)
	 */
	@Override
	public int insertSelective(PageTemplate record) {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.insertSelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageTemplateService#selectByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public PageTemplate selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.selectByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageTemplateService#updateByPrimaryKeySelective(com.wangfj.wms.domain.entity.PageTemplate)
	 */
	@Override
	public int updateByPrimaryKeySelective(PageTemplate record) {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.updateByPrimaryKeySelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageTemplateService#updateByPrimaryKey(com.wangfj.wms.domain.entity.PageTemplate)
	 */
	@Override
	public int updateByPrimaryKey(PageTemplate record) {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.updateByPrimaryKey(record);
	}

	@Override
	public List queryBySelective(PageTemplate record) {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.queryBySelective(record);
	}

	@Override
	public List<PageTemplate> findAllTem() {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.findAllTem();
	}

	@Override
	public List<PageTemplate> findByType(Integer type) {
		// TODO Auto-generated method stub
		return this.pageTemplateMapper.findByType(type);
	}

}
