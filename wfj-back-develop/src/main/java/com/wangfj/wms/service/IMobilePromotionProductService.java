package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.MobilePromotionProduct;


/**
 * @Class Name IMobilePromotionProduct
 * @Author chengsj
 * @Create In 2014-3-27
 */

public interface IMobilePromotionProductService {
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
