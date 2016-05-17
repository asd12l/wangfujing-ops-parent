package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.PriceRule;
import com.wangfj.wms.util.PriceRuleKey;


public interface IPriceRuleService {

	int deleteByPrimaryKey(Integer sid);

	int insert(PriceRule record);

	int insertSelective(PriceRule record);

	PriceRule selectByPrimaryKey(Integer sid);

	int updateByPrimaryKeySelective(PriceRule record);

	int updateByPrimaryKey(PriceRule record);

	List queryPageLayoutByTime(PriceRuleKey key);

	List queryBySelect(PriceRule record);
	
	List changPriceBackByEndTime(PriceRuleKey key);
}
