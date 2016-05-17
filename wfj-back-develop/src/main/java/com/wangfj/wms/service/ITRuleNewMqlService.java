/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceITRuleNewMqlService.java
 * @Create By chengsj
 * @Create In 2013-9-18 上午11:00:04
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.wangfj.wms.domain.entity.TRuleNewMql;


/**
 * @Class Name ITRuleNewMqlService
 * @Author chengsj
 * @Create In 2013-9-18
 */
public interface ITRuleNewMqlService {
	int deleteByPrimaryKey(Integer sid);

    int insert(TRuleNewMql record);

    int insertSelective(TRuleNewMql record);

    TRuleNewMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(TRuleNewMql record);

    int updateByPrimaryKey(TRuleNewMql record);

	List<TRuleNewMql> findAllRules();
	
	Integer queryMaxSidNum();

}
