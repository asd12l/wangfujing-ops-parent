/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceITRuleNewChannelChannelService.java
 * @Create By chengsj
 * @Create In 2013-5-28 下午2:19:58
 * TODO
 */
package com.wangfj.back.service;

import java.util.List;

import com.framework.IAbstractService;
import com.wangfj.back.entity.cond.TRuleNewChannelCond;
import com.wangfj.back.entity.po.TRuleNewChannel;
import com.wangfj.back.entity.vo.TRuleNewChannelVO;

/**
 * @Class Name ITRuleNewChannelChannelService
 * @Author chengsj
 * @Create In 2013-5-28
 */
public interface ITRuleNewChannelService extends IAbstractService<TRuleNewChannelCond,TRuleNewChannel,TRuleNewChannelVO> {

	Integer queryMaxOrderNum();
	List<TRuleNewChannelVO> findObjByRuleSid(Integer ruleSid);
	List<TRuleNewChannelVO> findChannels();
	List<TRuleNewChannelVO> findRuleSid(Integer channelSid);
	public void deleteByRuleSid(Integer ruleSid);
}
