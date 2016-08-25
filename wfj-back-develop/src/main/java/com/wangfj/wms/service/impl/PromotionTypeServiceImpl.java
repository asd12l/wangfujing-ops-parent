/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implPromotionTypeServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午7:01:12
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.PromotionType;
import com.wangfj.wms.persistence.PromotionTypeMapper;
import com.wangfj.wms.service.IPromotionTypeService;

/**
 * @Class Name PromotionTypeServiceImpl
 * @Author chengsj
 * @Create In 2013-8-29
 */
@Component("promotionTypeService")
@Transactional
public class PromotionTypeServiceImpl implements IPromotionTypeService {

	@Autowired
	PromotionTypeMapper promotionTypeMapper;
	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPromotionTypeService#deleteByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.promotionTypeMapper.deleteByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPromotionTypeService#insert(com.wangfj.wms.domain.entity.PromotionType)
	 */
	@Override
	public int insert(PromotionType record) {
		// TODO Auto-generated method stub
		return this.promotionTypeMapper.insert(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPromotionTypeService#insertSelective(com.wangfj.wms.domain.entity.PromotionType)
	 */
	@Override
	public int insertSelective(PromotionType record) {
		// TODO Auto-generated method stub
		return this.promotionTypeMapper.insertSelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPromotionTypeService#selectByPrimaryKey(java.lang.Integer)
	 */
	@Override
	public PromotionType selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.promotionTypeMapper.selectByPrimaryKey(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPromotionTypeService#updateByPrimaryKeySelective(com.wangfj.wms.domain.entity.PromotionType)
	 */
	@Override
	public int updateByPrimaryKeySelective(PromotionType record) {
		// TODO Auto-generated method stub
		return this.promotionTypeMapper.updateByPrimaryKeySelective(record);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.wms.service.IPromotionTypeService#updateByPrimaryKey(com.wangfj.wms.domain.entity.PromotionType)
	 */
	@Override
	public int updateByPrimaryKey(PromotionType record) {
		// TODO Auto-generated method stub
		return this.promotionTypeMapper.updateByPrimaryKey(record);
	}

	@Override
	public List queryBySelective(PromotionType record) {
		// TODO Auto-generated method stub
		return this.promotionTypeMapper.queryBySelective(record);
	}

}
