package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.TRuleDetailMql;


public interface TRuleDetailMqlMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(TRuleDetailMql record);

    int insertSelective(TRuleDetailMql record);

    TRuleDetailMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(TRuleDetailMql record);

    int updateByPrimaryKey(TRuleDetailMql record);
    
    List<TRuleDetailMql> findObjByRuleSid(Integer ruleSid);
}