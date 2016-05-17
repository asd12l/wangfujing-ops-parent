package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.PriceProduct;


public interface IPriceProductService {

	int deleteByPrimaryKey(Integer sid);

	int insert(PriceProduct record);

	int insertSelective(PriceProduct record);

	PriceProduct selectByPrimaryKey(Integer sid);

	int updateByPrimaryKeySelective(PriceProduct record);

	int updateByPrimaryKey(PriceProduct record);

	List queryByPageLayoutSid(Integer pageLayoutSid);
	
	List queryByPageLayoutSidFlg(Integer pageLayoutSid);

	int deleteBySelect(PriceProduct record);
}
