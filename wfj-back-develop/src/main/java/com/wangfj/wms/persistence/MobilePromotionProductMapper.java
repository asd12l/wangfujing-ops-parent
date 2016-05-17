package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.MobilePromotionProduct;


@WangfjMysqlMapper
public interface MobilePromotionProductMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(MobilePromotionProduct record);

    int insertSelective(MobilePromotionProduct record);

    MobilePromotionProduct selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(MobilePromotionProduct record);

    int updateByPrimaryKey(MobilePromotionProduct record);

	List<MobilePromotionProduct> selectByPromotionSid(Integer sid);

	void deleteByInfo(MobilePromotionProduct pro);
	
	int selectMaxSid();
	
	int queryMaxSeqBypromotionSid(Integer promotionSid);
	
	int queryCountSeqBypromotionSid(Integer promotionSid);
	
	MobilePromotionProduct queryBySelect(MobilePromotionProduct pro);

	int queryExist(MobilePromotionProduct pro);

	List<MobilePromotionProduct> selectByStockFlag(int promotionSid);

}