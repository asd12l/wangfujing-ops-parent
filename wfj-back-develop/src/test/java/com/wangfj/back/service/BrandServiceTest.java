/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceBrandServiceTest.java
 * @Create By chengsj
 * @Create In 2013-5-13 下午2:02:58
 * TODO
 */
package com.wangfj.back.service;

import java.sql.SQLException;

import org.junit.Before;
import org.springframework.util.Assert;

import com.framework.page.Paginator;
import com.framework.returnObj.Infos;
import com.framework.testCase.AbstractTest;
import com.wangfj.back.entity.cond.BrandCond;
import com.wangfj.back.entity.po.Brand;
import com.wangfj.back.entity.vo.BrandVO;

/**
 * @Class Name BrandServiceTest
 * @Author chengsj
 * @Create In 2013-5-13
 */
public class BrandServiceTest extends AbstractTest {
	
	IBrandservice brandService;
	BrandCond cond;
	Infos infos;
	@Before
	public void setUp() throws Exception {
		super.setUp();
		this.brandService = context.getBean(IBrandservice.class);
	}

	//@Test
	public void testFindObjBySid() {
		Assert.notNull(this.brandService);

		try {
			BrandVO vo = brandService.findObjBySid(infos, 145L);
			System.out.println(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//@Test
	public void testQueryObjsList() throws SQLException {

		cond = new BrandCond();
		Paginator page = null;
		page = brandService.queryObjs(infos, cond);
		System.out.println(page);
	}

	//@Test
	public void testInsert() throws SQLException {
		cond = new BrandCond();
		Brand table = new Brand();

		table.setSid(2500L);
		table.setBrandName("sss");
		table.setBrandActiveBit(1);
		table.setPhotoBlacklistBit(1);

		cond.setBrand(table);
		brandService.insert(infos, cond);
		System.out.println(cond.getBrand().getSid());
	}

	//@Test
	public void testUpdate() throws SQLException {

		cond = new BrandCond();
		Brand brand = new Brand();
		brand.setSid(2500L);
		brand.setBrandName("eeee");
		cond.setBrand(brand);

		brandService.update(infos, cond);
		System.out.print(cond.getBrand().getBrandName());

	}

	//@Test
	public void testDelete() throws SQLException {

		brandService.delete(infos, 2500L);
	}
}
