/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implPageLayoutContentServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:57:45
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.PageLayoutContent;
import com.wangfj.wms.persistence.PageLayoutContentMapper;
import com.wangfj.wms.service.IPageLayoutContentService;

/**
 * @Class Name PageLayoutContentServiceImpl
 * @Author chengsj
 * @Create In 2013-8-29
 */
@Component("pageLayoutContentService")
@Scope("prototype")
@Transactional
public class PageLayoutContentServiceImpl implements IPageLayoutContentService {

	@Autowired
	PageLayoutContentMapper pageLayoutContentMapper;
	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutContentService#deleteByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageLayoutContentMapper.deleteByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutContentService#insert(com.wangfj.wms.domain.entity.PageLayoutContent)
	 */
	@Override
	public int insert(PageLayoutContent record) {
		// TODO Auto-generated method stub
		return this.pageLayoutContentMapper.insert(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutContentService#insertSelective(com.wangfj.wms.domain.entity.PageLayoutContent)
	 */
	@Override
	public int insertSelective(PageLayoutContent record) {
		// TODO Auto-generated method stub
		return this.pageLayoutContentMapper.insertSelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutContentService#selectByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public PageLayoutContent selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageLayoutContentMapper.selectByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutContentService#updateByPrimaryKeySelective(com.wangfj.wms.domain.entity.PageLayoutContent)
	 */
	@Override
	public int updateByPrimaryKeySelective(PageLayoutContent record) {
		// TODO Auto-generated method stub
		return this.pageLayoutContentMapper.updateByPrimaryKeySelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutContentService#updateByPrimaryKey(com.wangfj.wms.domain.entity.PageLayoutContent)
	 */
	@Override
	public int updateByPrimaryKey(PageLayoutContent record) {
		// TODO Auto-generated method stub
		return this.pageLayoutContentMapper.updateByPrimaryKey(record);
	}

	@Override
	public List queryByPageLayoutSid(Integer pageLayoutSid) {
		// TODO Auto-generated method stub
		return this.pageLayoutContentMapper.queryByPageLayoutSid(pageLayoutSid);
	}

}
