package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.SalesMsg;
import com.wangfj.wms.domain.view.saleMsgVO;



public interface ISaleMsgService {

	 Integer selectCountByParms(saleMsgVO record);
	 
	 List<SalesMsg> selectByPrams(saleMsgVO record);
	 
	public int insertSaleMsg(SalesMsg slm);
	
	int deleteByPrimaryKey(Integer sid);
	
	SalesMsg selectByPrimaryKey(Integer sid);
	
	int updateSaleMsg(SalesMsg sm);
	
	 
	
}
