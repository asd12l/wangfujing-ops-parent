/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperTRuleDetail.java
 * @Create By chengsj
 * @Create In 2013-6-24 下午2:16:02
 * TODO
 */
package com.wangfj.back.mapper;

import java.util.List;

import com.framework.IAbstractDAO;
import com.framework.persistence.WangfjMapper;
import com.wangfj.back.entity.cond.TRuleDetailCond;
import com.wangfj.back.entity.po.TRuleDetail;
import com.wangfj.back.entity.vo.TRuleDetailVO;

/**
 * @Class Name TRuleDetail
 * @Author chengsj
 * @Create In 2013-6-24
 */
@WangfjMapper
public interface  TRuleDetailMapper extends IAbstractDAO<TRuleDetailCond, TRuleDetail, TRuleDetailVO>{

	List<TRuleDetailVO> findObjByRuleSid(Integer ruleSid);
	public void deleteByRuleSid(Integer ruleSid);
}
