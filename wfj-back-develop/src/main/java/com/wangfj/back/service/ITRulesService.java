/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceIRuleChannelService.java
 * @Create By chengsj
 * @Create In 2013-6-19 上午9:48:23
 * TODO
 */
package com.wangfj.back.service;

import java.sql.SQLException;
import java.util.List;

import com.wangfj.back.view.ChannelsVO;



/**
 * @Class Name IRuleChannelService
 * @Author chengsj
 * @Create In 2013-6-19
 */
public interface ITRulesService  {
	
//	List<RulesVO> queryRulesInfo(String sid);
//	List<RulesVO> queryAllRulesInfo();
	List<ChannelsVO> findRules() throws SQLException;

}
