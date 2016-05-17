/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceITRuleNewChannel.java
 * @Create By Administrator
 * @Create In 2013-9-22 上午11:29:41
 * TODO
 */
package com.wangfj.wms.service;

import com.wangfj.wms.domain.entity.TRuleNewChannelMql;

/**
 * @Class Name ITRuleNewChannel
 * @Author Administrator
 * @Create In 2013-9-22
 */
public interface ITRuleNewChannelMqlService {
	int deleteByPrimaryKey(Integer sid);

    int insert(TRuleNewChannelMql record);

    int insertSelective(TRuleNewChannelMql record);

    TRuleNewChannelMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(TRuleNewChannelMql record);

    int updateByPrimaryKey(TRuleNewChannelMql record);
}
