/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceITRuleDetailService.java
 * @Create By Administrator
 * @Create In 2013-6-24 下午4:07:59
 * TODO
 */
package com.wangfj.back.service;

import java.util.List;

import com.framework.IAbstractService;
import com.wangfj.back.entity.cond.TRuleDetailCond;
import com.wangfj.back.entity.po.TRuleDetail;
import com.wangfj.back.entity.vo.TRuleDetailVO;

/**
 * @Class Name ITRuleDetailService
 * @Author Administrator
 * @Create In 2013-6-24
 */
public interface ITRuleDetailService extends IAbstractService<TRuleDetailCond,TRuleDetail,TRuleDetailVO> {

	
	List<TRuleDetailVO> findDetails(Integer ruleSid);
	public void deleteByRuleSid(Integer ruleSid);


}
