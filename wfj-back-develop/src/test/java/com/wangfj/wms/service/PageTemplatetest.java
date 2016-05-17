/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.PageTemplatetest.java
 * @Create By chengsj
 * @Create In 2013-9-2 上午11:31:45
 * TODO
 */
package com.wangfj.wms.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.PageTemplate;

/**
 * @Class Name PageTemplatetest
 * @Author chengsj
 * @Create In 2013-9-2
 */
public class PageTemplatetest extends BaseTestContext {
	
	@Autowired
	IPageTemplateService pageTemplateService;
	
	@Test
	public void testQueryBySelective(){
		PageTemplate pageTemplate = new PageTemplate();
		pageTemplate.setType(2);
		System.out.println(this.pageTemplateService.queryBySelective(pageTemplate));
	}

}
