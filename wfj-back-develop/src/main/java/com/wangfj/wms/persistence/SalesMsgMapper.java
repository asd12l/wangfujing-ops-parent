package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.SalesMsg;
import com.wangfj.wms.domain.view.saleMsgVO;


public interface SalesMsgMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(SalesMsg record);

    int insertSelective(SalesMsg record);

    SalesMsg selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SalesMsg record);

    int updateByPrimaryKey(SalesMsg record);
    
    Integer selectCountByParms(saleMsgVO record);
	 
	 List<SalesMsg> selectByPrams(saleMsgVO record);
    
    
    
}