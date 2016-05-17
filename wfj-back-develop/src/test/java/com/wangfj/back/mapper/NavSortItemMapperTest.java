package com.wangfj.back.mapper;


import org.junit.Before;
import org.junit.Test;
import org.springframework.util.Assert;

import com.framework.testCase.AbstractTest;
import com.wangfj.wms.persistence.NavSortItemMapper;

public class NavSortItemMapperTest extends AbstractTest{

	NavSortItemMapper navSortItemMapper;
	@Before
	public void setUp() throws Exception {
		super.setUp();
		this.navSortItemMapper = context.getBean(NavSortItemMapper.class);
		Assert.notNull(navSortItemMapper, "mapper can not be null");
	}
	
	//@Test
	public void testInsert() {
	
	}
//	@Test
	public void testUpdate() {
		
	}
   @Test
	public void testSelectByParms() {
		System.out.println((this.navSortItemMapper.queryList(102)).toString());
	}

}
