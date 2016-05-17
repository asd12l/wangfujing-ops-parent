/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperTRuleNewChannleMapper.java
 * @Create By Administrator
 * @Create In 2013-5-28 下午1:28:57
 * TODO
 */
package com.wangfj.back.mapper;

import java.util.List;

import com.framework.IAbstractDAO;
import com.framework.persistence.WangfjMapper;
import com.wangfj.back.entity.cond.TRuleNewChannelCond;
import com.wangfj.back.entity.po.TRuleNewChannel;
import com.wangfj.back.entity.vo.TRuleNewChannelVO;

/**
 * @Class Name TRuleNewChannleMapper
 * @Author Administrator
 * @Create In 2013-5-28
 */
@WangfjMapper
public interface TRuleNewChannelMapper extends IAbstractDAO<TRuleNewChannelCond, TRuleNewChannel, TRuleNewChannelVO>{

	Integer queryMaxOrderNum();
	List<TRuleNewChannelVO> findObjByRuleSid(Integer ruleSid);
	List<TRuleNewChannelVO> findChannels();
	List<TRuleNewChannelVO> findRuleSid(Integer channelSid);
	public void deleteByRuleSid(Integer ruleSid);
}
