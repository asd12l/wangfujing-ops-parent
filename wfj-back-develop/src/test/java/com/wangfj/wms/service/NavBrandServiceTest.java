/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceResourcesServiceTest.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午4:21:50
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.NavBrand;

/**
 * @Class Name ResourcesServiceTest
 * @Author chengsj
 * @Create In 2013-7-5
 */
public class NavBrandServiceTest extends BaseTestContext{
	
	@Autowired
	private INavBrandService navBrandService;
	
	
	
	@Test
	public void testSelect(){
		Assert.notNull(this.navBrandService);
		NavBrand nav = new NavBrand();
		nav.setNavSid(1l);
		List record =  this.navBrandService.selectNavBrandByNavSid(nav);
		System.out.println(record);
	}
	
	
}
