package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.Promotions;
import com.wangfj.wms.domain.view.PromotionsVO;

@WangfjMysqlMapper
public interface PromotionsMapper {
	int deleteByPrimaryKey(Integer sid);

	int insert(Promotions record);

	int insertSelective(Promotions record);

	Promotions selectByPrimaryKey(Integer sid);

	int updateByPrimaryKeySelective(Promotions record);

	int updateByPrimaryKey(Promotions record);

	List selectAllPromotions();

	List selectByTitle(Promotions record);

	int queryMaxSid();

	List<Promotions> selectByPrams(PromotionsVO record);

	Integer selectCountByParms(PromotionsVO record);

	List<Promotions> queryBySids(List<Integer> sid);
}