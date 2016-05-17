/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implPriceRuleServiceImpl.java
 * @Create By lenovo
 * @Create In 2013-11-22 下午2:45:19
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.PriceRule;
import com.wangfj.wms.persistence.PriceRuleMapper;
import com.wangfj.wms.service.IPriceRuleService;
import com.wangfj.wms.util.PriceRuleKey;


/**
 * @Class Name PriceRuleServiceImpl
 * @Author wangd
 * @Create In 2013-11-22
 */
@Component("priceRuleService")
@Scope("prototype")
@Transactional
public class PriceRuleServiceImpl implements IPriceRuleService {
	
	@Autowired
	PriceRuleMapper priceRuleMapper;

	@Override
	public int deleteByPrimaryKey(Integer sid) {
		return this.priceRuleMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(PriceRule record) {
		return this.priceRuleMapper.insert(record);
	}

	@Override
	public int insertSelective(PriceRule record) {
		return this.priceRuleMapper.insertSelective(record);
	}

	@Override
	public PriceRule selectByPrimaryKey(Integer sid) {
		return this.priceRuleMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(PriceRule record) {
		return this.priceRuleMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(PriceRule record) {
		return this.priceRuleMapper.updateByPrimaryKey(record);
	}

	@Override
	public List queryPageLayoutByTime(PriceRuleKey key) {
		
		return this.priceRuleMapper.queryPageLayoutByTime(key);
	}

	@Override
	public List queryBySelect(PriceRule record) {
		// TODO Auto-generated method stub
		return this.priceRuleMapper.queryBySelect(record);
	}

	@Override
	public List changPriceBackByEndTime(PriceRuleKey key) {
		// TODO Auto-generated method stub
		return this.priceRuleMapper.changPriceBackByEndTime(key);
	}

}
