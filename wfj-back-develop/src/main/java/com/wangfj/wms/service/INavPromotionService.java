/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.INavPromotionService.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:33:18
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.NavPromotion;


/**
 * @Class Name INavPromotionService
 * @Author chengsj
 * @Create In 2013-7-22
 */
public interface INavPromotionService {
	
	List<NavPromotion>  selectByNavSid(NavPromotion record);
	
	NavPromotion selectByInfo(NavPromotion record);
	
	int insert(NavPromotion record);
	
	int countNavPromotionRecord(NavPromotion record);
	
	int selectMaxSeq(Long record);
	
	int insertSelective(NavPromotion record);
	
	int deleteByNavPro(NavPromotion record);
	
	int deleteBySid(NavPromotion record);
	
    int updateByPrimaryKeySelective(NavPromotion record);

}
