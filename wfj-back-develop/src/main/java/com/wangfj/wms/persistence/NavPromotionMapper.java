package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.NavPromotion;


@WangfjMysqlMapper
public interface NavPromotionMapper {
	int insert(NavPromotion record);
	
	int deleteByNavPro(NavPromotion record);
	
	int countNavPromotionRecord(NavPromotion record);
	
	int selectMaxSeq(Long record);
	
	int insertSelective(NavPromotion record);
	
	List<NavPromotion> selectByNavSid(NavPromotion record);
	
	NavPromotion selectByInfo(NavPromotion record);
	
    int updateByPrimaryKeySelective(NavPromotion record);

	int deleteBySid(NavPromotion record);

}