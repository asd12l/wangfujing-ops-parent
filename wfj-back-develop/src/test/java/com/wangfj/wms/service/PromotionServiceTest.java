/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.PromotionServiceTest.java
 * @Create By chengsj
 * @Create In 2013-9-10 上午10:21:26
 * TODO
 */
package com.wangfj.wms.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.wangfj.wms.base.BaseTestContext;
import com.wangfj.wms.domain.entity.Promotions;

/**
 * @Class Name PromotionServiceTest
 * @Author chengsj
 * @Create In 2013-9-10
 */
public class PromotionServiceTest extends BaseTestContext {
	
	@Autowired
	IPromotionService promotionService;
	
	@Test
	public void testPromotionUpdate(){
		Promotions pro = new Promotions();
		pro.setSid(120);
		this.promotionService.updateByPrimaryKeySelective(pro);
	}

}
