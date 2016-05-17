/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceTRuleDetailMqlService.java
 * @Create By chengsj
 * @Create In 2013-9-22 上午11:22:56
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.TRuleDetailMql;


/**
 * @Class Name TRuleDetailMqlService
 * @Author chengsj
 * @Create In 2013-9-22
 */
public interface ITRuleDetailMqlService {
	
	List<TRuleDetailMql> findDetails(Integer ruleSid);
	
	int deleteByPrimaryKey(Integer sid);

    int insert(TRuleDetailMql record);

    int insertSelective(TRuleDetailMql record);

    TRuleDetailMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(TRuleDetailMql record);

    int updateByPrimaryKey(TRuleDetailMql record);

}
