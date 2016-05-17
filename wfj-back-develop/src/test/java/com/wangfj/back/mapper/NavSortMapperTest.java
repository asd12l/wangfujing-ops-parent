package com.wangfj.back.mapper;


import org.junit.Before;
import org.junit.Test;
import org.springframework.util.Assert;

import com.framework.testCase.AbstractTest;
import com.wangfj.wms.persistence.NavSortMapper;

public class NavSortMapperTest extends AbstractTest{

	NavSortMapper navSortMapper;
	@Before
	public void setUp() throws Exception {
		super.setUp();
		this.navSortMapper = context.getBean(NavSortMapper.class);
		Assert.notNull(navSortMapper, "mapper can not be null");
	}
	
	//@Test
	public void testInsert() {
	
	}
//	@Test
	public void testUpdate() {
		
	}
   @Test
	public void testSelectByParms() {
		System.out.println((this.navSortMapper.queryList(150)).toString());
	}

}
