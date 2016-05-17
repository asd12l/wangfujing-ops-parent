/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.servicePageLayoutMqlServiceTest.java
 * @Create By chengsj
 * @Create In 2013-9-2 下午4:37:33
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.ProBestDetailMql;
import com.wangfj.wms.persistence.ProBestDetailMqlMapper;

/**
 * @Class Name PageLayoutMqlServiceTest
 * @Author chengsj
 * @Create In 2013-9-2
 */
public class PageLayoutMqlServiceTest  extends BaseTestContext{
	@Autowired
	private IPageLayoutMqlService pageLayoutMqlService;
	
	@Autowired
	private IProBestDetailMqlService proBestDetailMqlService;
	
	@Autowired
	private IPageLayoutTemplateMqlService pageLayoutTemplateMqlService;
	
	@Autowired
	private ProBestDetailMqlMapper proBestDetailMqlMapper;
	//@Test
	public void testSelectList() {
		Long pageLayoutSid =70136l;
		List list = this.pageLayoutMqlService.queryChildPageLayout(pageLayoutSid);
		
		System.out.println(list);
		System.out.println(list.size());
	}
	
	//@Test
	public void testQueryProList() {
		Integer pageLayoutSid =70138;
		List list = this.proBestDetailMqlService.queryProList(pageLayoutSid);
		
		System.out.println(list);
		System.out.println(list.size());
	}
	
	//@Test
	public void testQueryAllTemplates() {
		
		List list = this.pageLayoutTemplateMqlService.queryAllTemplates();
		
		System.out.println(list);
		System.out.println(list.size());
	}
	
	//@Test
	public void testMaxPbdOrderNum() {
		
		Integer pageLayoutSid =70138;
		Integer i=this.proBestDetailMqlMapper.queryMaxOrderNum(pageLayoutSid);
		System.out.println(i);
		
	}
	
	//@Test
	public void testCountPbdOrderNum() {
		
		Integer pageLayoutSid =70138;
		Integer proListSid =21315;
		ProBestDetailMql record = new ProBestDetailMql();
		record.setPageLayoutSid(pageLayoutSid);
		record.setProductListSid(proListSid);
		
		Integer i=this.proBestDetailMqlMapper.queryObjsCount(record);
		System.out.println(i);
		
	}
	
//	@Test
		public void testDeletePro() {
			
			Integer pageLayoutSid =70138;
			Integer proListSid =21315;
			ProBestDetailMql record = new ProBestDetailMql();
			record.setPageLayoutSid(pageLayoutSid);
			record.setProductListSid(proListSid);
			
			this.proBestDetailMqlMapper.deleteByProductListSid(record);
			
			
		}
	
	@Test
	public void testOrderNumber() {
		
		Integer pageLayoutSid =70048;
		Integer proListSid =800;
		ProBestDetailMql record = new ProBestDetailMql();
		record.setPageLayoutSid(pageLayoutSid);
		record.setProductListSid(proListSid);
		
		ProBestDetailMql record1=this.proBestDetailMqlMapper.queryOrderNumber(record);
		
		System.out.println(record1.getSid());
	}

}
