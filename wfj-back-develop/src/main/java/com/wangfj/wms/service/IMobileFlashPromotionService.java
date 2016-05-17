/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.IPromotionService.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:31:09
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.MobileFlashPromotions;
import com.wangfj.wms.domain.view.MobileFlashPromotionsVO;
import com.wangfj.wms.util.MobileFlashPromotionsKey;


/**
 * @Class Name IPromotionService
 * @Author chengsj
 * @Create In 2013-7-22
 */
public interface IMobileFlashPromotionService {
	List<MobileFlashPromotions> selectByPrams(MobileFlashPromotionsVO record);

	Integer selectCountByPrams(MobileFlashPromotionsVO record);

	int insertSelective(MobileFlashPromotions record);

	int queryMaxSid();

	int updateByPrimaryKeySelective(MobileFlashPromotions record);

	MobileFlashPromotions selectByPrimaryKey(Integer sid);
	
	List<MobileFlashPromotions> queryPromotionsByEndTime(MobileFlashPromotionsKey record);

	List<MobileFlashPromotions> getAllPromotions();

	List<MobileFlashPromotions> getGoingPromotions();
}
