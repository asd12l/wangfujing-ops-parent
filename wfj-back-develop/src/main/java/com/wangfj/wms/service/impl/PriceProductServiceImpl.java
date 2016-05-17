/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implPriceProductServiceImpl.java
 * @Create By lenovo
 * @Create In 2013-11-22 下午3:51:57
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.PriceProduct;
import com.wangfj.wms.persistence.PriceProductMapper;
import com.wangfj.wms.service.IPriceProductService;


/**
 * @Class Name PriceProductServiceImpl
 * @Author lenovo
 * @Create In 2013-11-22
 */
@Component("priceProductService")
@Scope("prototype")
@Transactional
public class PriceProductServiceImpl implements IPriceProductService {

	@Autowired
	PriceProductMapper priceProductMapper;
	
	
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(PriceProduct record) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.insert(record);
	}

	@Override
	public int insertSelective(PriceProduct record) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.insertSelective(record);
	}

	@Override
	public PriceProduct selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(PriceProduct record) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(PriceProduct record) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.updateByPrimaryKey(record);
	}

	@Override
	public List queryByPageLayoutSid(Integer pageLayoutSid) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.queryByPageLayoutSid(pageLayoutSid);
	}

	@Override
	public int deleteBySelect(PriceProduct record) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.deleteBySelect(record);
	}

	@Override
	public List queryByPageLayoutSidFlg(Integer pageLayoutSid) {
		// TODO Auto-generated method stub
		return this.priceProductMapper.queryByPageLayoutSidFlg(pageLayoutSid);
	}

}
