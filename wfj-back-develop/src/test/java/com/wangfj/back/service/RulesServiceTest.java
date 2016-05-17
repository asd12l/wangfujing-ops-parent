/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceRuleChannelServiceTest.java
 * @Create By chengsj
 * @Create In 2013-6-19 下午12:39:26
 * TODO
 */
package com.wangfj.back.service;

import java.sql.SQLException;
import java.util.List;

import net.sf.json.JSONArray;

import org.junit.Before;
import org.junit.Test;

import com.framework.testCase.AbstractTest;
import com.wangfj.back.view.ChannelsVO;
import com.wangfj.wms.service.ITRuelsMqlService;

/**
 * @Class Name RuleChannelServiceTest
 * @Author chengsj
 * @Create In 2013-6-19
 */
public class RulesServiceTest  extends AbstractTest{
	
	ITRulesService rulesService;
	ITRuelsMqlService rulesMqlService;
	@Before
	public void setUp() throws Exception {
		super.setUp();
		this.rulesService = context.getBean(ITRulesService.class);
		this.rulesMqlService=context.getBean(ITRuelsMqlService.class);
	}
	//@Test
//	public void testQueryObjsList() throws SQLException {
//		String sid = "";
//		
//		List<RulesVO> vo = this.rulesService.queryRulesInfo(sid);
//		JSONArray.fromObject(vo);
//		
//		System.out.println(JSONArray.fromObject(vo));
//	}
//	
	@Test
	public void testfindRules() throws SQLException {
		String sid = "";
		
		List<ChannelsVO> vo = this.rulesService.findRules();
		JSONArray.fromObject(vo);
		
		System.out.println(JSONArray.fromObject(vo));
	}
	/*@Test
	public void testfindChannelRules() throws SQLException {
		List<ChannelsMqlVO> vo = this.rulesMqlService.findRules();
		
		
		System.out.println(JSONArray.fromObject(vo));
	}*/
	
}
