/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperBrandMapperTest.java
 * @Create By chengsj
 * @Create In 2013-5-13 上午10:42:57
 * TODO
 */
package com.wangfj.back.mapper;

import java.sql.SQLException;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.util.Assert;

import com.framework.testCase.AbstractTest;
import com.wangfj.back.entity.cond.BrandCond;
import com.wangfj.back.entity.po.Brand;
import com.wangfj.back.entity.vo.BrandVO;

/**
 * @Class Name BrandMapperTest
 * @Author chengsj
 * @Create In 2013-5-13
 */
public class BrandMapperTest extends AbstractTest {

	BrandMapper brandMapper;

	@Before
	public void setUp() throws Exception {
		super.setUp();
		this.brandMapper = context.getBean(BrandMapper.class);
		Assert.notNull(brandMapper, "mapper can not be null");
	}

	@Test
	public void testFindObjBySid() {
		try {
			BrandVO vo = brandMapper.findObjBySid(145L);
			System.out.print(vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//@Test
	public void testQueryObjsList() {
		Assert.notNull(this.brandMapper);
		BrandCond cond = new BrandCond();
		cond.setSid(145L);
		// cond.setBrandActiveBit(1);
		cond.setStartRecords(0);
		cond.setEndRecords(10);
		try {
			List list = this.brandMapper.queryObjsList(cond);
			System.out.print(list.size());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	//@Test
	public void testQueryObjsCount() {
		BrandCond cond = new BrandCond();
		// cond.setSid(145L);
		cond.setBrandActiveBit(1);

		try {
			Integer num = brandMapper.queryObjsCount(cond);
			System.out.println("num - " + num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// @Test
	public void testInsert() {
		BrandCond cond = new BrandCond();
		Brand brand = new Brand();
		brand.setSid(2500L);
		brand.setBrandName("tt");
		brand.setBrandActiveBit(1);
		brand.setPhotoBlacklistBit(1);

		cond.setBrand(brand);
		try {
			brandMapper.insert(cond.getBrand());
			System.out.println("new sid = " + cond.getBrand().getSid());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// @Test
	public void testUpdate() {
		BrandCond cond = new BrandCond();
		Brand brand = new Brand();
		brand.setSid(2500L);
		brand.setBrandName("eeeee");
		cond.setBrand(brand);
		try {
			brandMapper.update(cond.getBrand());
			System.out.print(brand.getBrandName());
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testDelete() {
		try {
			brandMapper.delete(2371L);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
