/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implPageLayoutTemplateMqlServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:59:22
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.PageLayoutTemplateMql;
import com.wangfj.wms.persistence.PageLayoutTemplateMqlMapper;
import com.wangfj.wms.service.IPageLayoutTemplateMqlService;

/**
 * @Class Name PageLayoutTemplateMqlServiceImpl
 * @Author chengsj
 * @Create In 2013-8-29
 */
@Component("pageLayoutTemplateMqlService")
@Scope("prototype")
@Transactional
public class PageLayoutTemplateMqlServiceImpl implements
		IPageLayoutTemplateMqlService {

	@Autowired
	PageLayoutTemplateMqlMapper pageLayoutTemplateMqlMapper;
	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutTemplateMqlService#deleteByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.deleteByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutTemplateMqlService#insert(com.wangfj.wms.domain.entity.PageLayoutTemplateMql)
	 */
	@Override
	public int insert(PageLayoutTemplateMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.insert(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutTemplateMqlService#insertSelective(com.wangfj.wms.domain.entity.PageLayoutTemplateMql)
	 */
	@Override
	public int insertSelective(PageLayoutTemplateMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.insertSelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutTemplateMqlService#selectByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public PageLayoutTemplateMql selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.selectByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutTemplateMqlService#updateByPrimaryKeySelective(com.wangfj.wms.domain.entity.PageLayoutTemplateMql)
	 */
	@Override
	public int updateByPrimaryKeySelective(PageLayoutTemplateMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.updateByPrimaryKeySelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutTemplateMqlService#updateByPrimaryKeyWithBLOBs(com.wangfj.wms.domain.entity.PageLayoutTemplateMql)
	 */
	@Override
	public int updateByPrimaryKeyWithBLOBs(PageLayoutTemplateMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.updateByPrimaryKeyWithBLOBs(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutTemplateMqlService#updateByPrimaryKey(com.wangfj.wms.domain.entity.PageLayoutTemplateMql)
	 */
	@Override
	public int updateByPrimaryKey(PageLayoutTemplateMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<PageLayoutTemplateMql> queryAllTemplates() {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.queryAllTemplates();
	}

	@Override
	public List queryBySelect(PageLayoutTemplateMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutTemplateMqlMapper.queryBySelect(record);
	}

}
