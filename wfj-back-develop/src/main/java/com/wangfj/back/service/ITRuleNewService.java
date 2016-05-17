/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceITRuleNewService.java
 * @Create By chengsj
 * @Create In 2013-5-28 上午11:14:00
 * TODO
 */
package com.wangfj.back.service;

import java.text.ParseException;
import java.util.List;

import com.framework.IAbstractService;
import com.wangfj.back.entity.cond.TRuleNewCond;
import com.wangfj.back.entity.po.TRuleNew;
import com.wangfj.back.entity.vo.TRuleNewVO;
import com.wangfj.back.view.TRuleNewKey;

/**
 * @Class Name ITRuleNewService
 * @Author chengsj
 * @Create In 2013-5-28
 */
public interface ITRuleNewService extends IAbstractService<TRuleNewCond,TRuleNew,TRuleNewVO>{
	List<TRuleNewVO> findAllRules();
	Integer queryMaxSidNum();
	void insertRule(TRuleNewKey truleNewKey) throws ParseException;
	void updateRule(TRuleNewKey truleNewKey) throws ParseException;
}
