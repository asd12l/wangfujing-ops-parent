/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implPageLayoutBrandServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:57:00
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.PageLayoutBrand;
import com.wangfj.wms.persistence.PageLayoutBrandMapper;
import com.wangfj.wms.service.IPageLayoutBrandService;

/**
 * @Class Name PageLayoutBrandServiceImpl
 * @Author chengsj
 * @Create In 2013-8-29
 */
@Component("pageLayoutBrandService")
@Scope("prototype")
@Transactional
public class PageLayoutBrandServiceImpl implements IPageLayoutBrandService {

	@Autowired
	PageLayoutBrandMapper pageLayoutBrandMapper;
	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutBrandService#deleteByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageLayoutBrandMapper.deleteByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutBrandService#insert(com.wangfj.wms.domain.entity.PageLayoutBrand)
	 */
	@Override
	public int insert(PageLayoutBrand record) {
		// TODO Auto-generated method stub
		return this.pageLayoutBrandMapper.insert(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutBrandService#insertSelective(com.wangfj.wms.domain.entity.PageLayoutBrand)
	 */
	@Override
	public int insertSelective(PageLayoutBrand record) {
		// TODO Auto-generated method stub
		return this.pageLayoutBrandMapper.insertSelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutBrandService#selectByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public PageLayoutBrand selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageLayoutBrandMapper.selectByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutBrandService#updateByPrimaryKeySelective(com.wangfj.wms.domain.entity.PageLayoutBrand)
	 */
	@Override
	public int updateByPrimaryKeySelective(PageLayoutBrand record) {
		// TODO Auto-generated method stub
		return this.pageLayoutBrandMapper.updateByPrimaryKeySelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPageLayoutBrandService#updateByPrimaryKey(com.wangfj.wms.domain.entity.PageLayoutBrand)
	 */
	@Override
	public int updateByPrimaryKey(PageLayoutBrand record) {
		// TODO Auto-generated method stub
		return this.pageLayoutBrandMapper.updateByPrimaryKey(record);
	}

	@Override
	public List selectByPageLayoutSid(Integer pageLayoutSid) {
		// TODO Auto-generated method stub
		return this.pageLayoutBrandMapper.selectByPageLayoutSid(pageLayoutSid);
	}

	@Override
	public int deleteBySelect(PageLayoutBrand record) {
		// TODO Auto-generated method stub
		return this.pageLayoutBrandMapper.deleteBySelect(record);
	}

}
