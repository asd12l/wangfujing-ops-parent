package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.MobilePromotionProduct;
import com.wangfj.wms.persistence.MobilePromotionProductMapper;
import com.wangfj.wms.service.IMobilePromotionProductService;




/**
 * @Class Name IMobilePromotionProduct
 * @Author chengsj
 * @Create In 2014-3-27
 */

@Component("mobilepromotionproductService")
@Scope("prototype")
@Transactional
public class MobilePromotionProductServiceImpl implements IMobilePromotionProductService {
   
	@Autowired
   MobilePromotionProductMapper mobilePromotionProductmapper;
	
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(MobilePromotionProduct record) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.insert(record);
	}

	@Override
	public int insertSelective(MobilePromotionProduct record) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.insertSelective(record);
	}

	@Override
	public MobilePromotionProduct selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(MobilePromotionProduct record) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(MobilePromotionProduct record) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.updateByPrimaryKey(record);
	}

	@Override
	public List<MobilePromotionProduct> selectByPromotionSid(Integer sid) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.selectByPromotionSid(sid);
	}

	@Override
	public void deleteByInfo(MobilePromotionProduct pro) {
		this.mobilePromotionProductmapper.deleteByInfo(pro);
		
	}

	@Override
	public int selectMaxSid() {
		return this.mobilePromotionProductmapper.selectMaxSid();
	}

	@Override
	public MobilePromotionProduct queryBySelect(MobilePromotionProduct pro) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.queryBySelect(pro);
	}

	@Override
	public int queryMaxSeqBypromotionSid(Integer promotionSid) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.queryMaxSeqBypromotionSid(promotionSid);
	}

	@Override
	public int queryCountSeqBypromotionSid(Integer promotionSid) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.queryCountSeqBypromotionSid(promotionSid);
	}

	@Override
	public int queryExist(MobilePromotionProduct pro) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.queryExist(pro);
	}

	@Override
	public List<MobilePromotionProduct> selectByStockFlag(int promotionSid) {
		// TODO Auto-generated method stub
		return this.mobilePromotionProductmapper.selectByStockFlag(promotionSid);
	}


}
