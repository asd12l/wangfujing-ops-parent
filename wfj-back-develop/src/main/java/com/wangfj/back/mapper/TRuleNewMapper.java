/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperTRuleNewMapper.java
 * @Create By Administrator
 * @Create In 2013-5-27 下午7:00:52
 * TODO
 */
package com.wangfj.back.mapper;

import java.util.List;

import com.framework.IAbstractDAO;
import com.framework.persistence.WangfjMapper;
import com.wangfj.back.entity.cond.TRuleNewCond;
import com.wangfj.back.entity.po.TRuleNew;
import com.wangfj.back.entity.vo.TRuleNewVO;

/**
 * @Class Name TRuleNewMapper
 * @Author Administrator
 * @Create In 2013-5-27
 */
@WangfjMapper
public interface TRuleNewMapper extends IAbstractDAO<TRuleNewCond, TRuleNew, TRuleNewVO>{
	
	Integer queryMaxSidNum();
	List<TRuleNewVO> findAllRules();
}
