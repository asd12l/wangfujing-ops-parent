/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceShopChannelsSeerviceTest.java
 * @Create By chengsj
 * @Create In 2013-5-9 下午8:42:06
 * TODO
 */
package com.wangfj.back.service;

import java.sql.SQLException;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.util.Assert;

import com.framework.returnObj.Infos;
import com.framework.testCase.AbstractTest;
import com.wangfj.wms.domain.entity.ShopNotice;
import com.wangfj.wms.service.IShopNoticeService;

/**
 * @Class Name ShopChannelsSeerviceTest
 * @Author chengsj
 * @Create In 2013-5-10
 */
public class ShopNoticeServiceTest extends AbstractTest {

	IShopNoticeService shopNoticeService;
	Infos infos;

	@Before
	public void setUp() throws Exception {
		super.setUp();
		this.shopNoticeService = context.getBean(IShopNoticeService.class);
	}

//	@Test
	public void testFindObjBySid() {
		Assert.notNull(this.shopNoticeService);
		List<ShopNotice> list = this.shopNoticeService.selectByNoticeType(1);
		for(ShopNotice n : list) {
			System.out.println(n.getSid());
		}
	}

	//@Test
	public void testQueryObjsList() throws SQLException {
		
	}

	@Test
	public void testInsert() throws SQLException {
		ShopNotice shopNotice = new ShopNotice();
		shopNotice.setTitle("111");
		shopNotice.setLink("1111");
		shopNotice.setContent("1111");
		shopNotice.setSeq("1111");
		shopNotice.setNoticeTypeSid(4);
		this.shopNoticeService.insert(shopNotice);
	}

	//@Test
	public void testUpdate() throws SQLException {

		
	}

	//@Test
	public void testDelete() throws SQLException {

		
	}

}
