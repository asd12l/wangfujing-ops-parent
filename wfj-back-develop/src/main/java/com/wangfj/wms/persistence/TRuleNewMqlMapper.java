package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.TRuleNewMql;

@WangfjMysqlMapper
public interface TRuleNewMqlMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(TRuleNewMql record);

    int insertSelective(TRuleNewMql record);

    TRuleNewMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(TRuleNewMql record);

    int updateByPrimaryKey(TRuleNewMql record);

	List<TRuleNewMql> findAllRules();
	
	Integer queryMaxSidNum();
}