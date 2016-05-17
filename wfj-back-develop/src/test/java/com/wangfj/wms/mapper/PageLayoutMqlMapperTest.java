/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.mapperPageLayoutMqlMapperTest.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午5:14:07
 * TODO
 */
package com.wangfj.wms.mapper;

import java.util.ArrayList;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.framework.testCase.AbstractTest;
import com.wangfj.wms.domain.entity.PageTemplate;
import com.wangfj.wms.persistence.PageLayoutMqlMapper;
import com.wangfj.wms.persistence.PageTemplateMapper;
import com.wangfj.wms.persistence.ShopChannelsMqlMapper;
import com.wangfj.wms.persistence.TRuleNewChannelMqlMapper;

/**
 * @Class Name PageLayoutMqlMapperTest
 * @Author chengsj
 * @Create In 2013-8-29
 */
public class PageLayoutMqlMapperTest extends AbstractTest{
	@Autowired
	private PageLayoutMqlMapper pageLayoutMqlMapper;
	@Autowired
	private TRuleNewChannelMqlMapper channelMqlMapper;
	@Autowired
	private ShopChannelsMqlMapper shopchannelsMqlMapper;
	@Autowired
	private PageTemplateMapper pageTemMapper;
	
	@Before
	public void set() throws Exception {
		super.setUp();
		this.pageLayoutMqlMapper = context.getBean(PageLayoutMqlMapper.class);
		this.channelMqlMapper = context.getBean(TRuleNewChannelMqlMapper.class);
		this.pageTemMapper = context.getBean(PageTemplateMapper.class);
	}
	
	@Test
	public void testInsert() {
	
		List<PageTemplate> list=new ArrayList<PageTemplate>();
		list=this.pageTemMapper.findAllTem();
		System.out.println("list================"+list);
	}
	

}
