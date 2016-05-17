package com.wangfj.wms.persistence;

import java.util.HashMap;
import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.MobileFlashPromotions;
import com.wangfj.wms.domain.view.MobileFlashPromotionsVO;
import com.wangfj.wms.util.MobileFlashPromotionsKey;


@WangfjMysqlMapper
public interface MobileFlashPromotionsMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(MobileFlashPromotions record);

    int insertSelective(MobileFlashPromotions record);

    MobileFlashPromotions selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(MobileFlashPromotions record);

    int updateByPrimaryKey(MobileFlashPromotions record);

	List<MobileFlashPromotions> selectByPrams(MobileFlashPromotionsVO record);
	
	List<MobileFlashPromotions> queryPromotionsByEndTime(MobileFlashPromotionsKey record);

	Integer selectCountByPrams(MobileFlashPromotionsVO record);

	int queryMaxSid();

	List<MobileFlashPromotions> getAllPromotions();

	List<MobileFlashPromotions> getGoingPromotions(HashMap map);
}