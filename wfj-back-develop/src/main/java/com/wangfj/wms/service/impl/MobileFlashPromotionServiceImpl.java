/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.impl.PromotionServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:37:48
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.MobileFlashPromotions;
import com.wangfj.wms.domain.view.MobileFlashPromotionsVO;
import com.wangfj.wms.persistence.MobileFlashPromotionsMapper;
import com.wangfj.wms.service.IMobileFlashPromotionService;
import com.wangfj.wms.util.MobileFlashPromotionsKey;


/**
 * @Class Name PromotionServiceImpl
 * @Author chengsj
 * @Create In 2013-7-22
 */
@Component("mobileflashpromotionService")
@Scope("prototype")
@Transactional
public class MobileFlashPromotionServiceImpl implements IMobileFlashPromotionService {
	
	@Autowired
	MobileFlashPromotionsMapper mobileFlashPromotionsMapper;

	@Override
	public List<MobileFlashPromotions> selectByPrams(
			MobileFlashPromotionsVO record) {
		
		return this.mobileFlashPromotionsMapper.selectByPrams(record);
	}

	@Override
	public Integer selectCountByPrams(MobileFlashPromotionsVO record) {
		// TODO Auto-generated method stub
		return this.mobileFlashPromotionsMapper.selectCountByPrams(record);
	}

	@Override
	public int insertSelective(MobileFlashPromotions record) {
		// TODO Auto-generated method stub
		return this.mobileFlashPromotionsMapper.insertSelective(record);
	}

	@Override
	public int queryMaxSid() {
		// TODO Auto-generated method stub
		return this.mobileFlashPromotionsMapper.queryMaxSid();
	}

	@Override
	public int updateByPrimaryKeySelective(MobileFlashPromotions record) {
		// TODO Auto-generated method stub
		return this.mobileFlashPromotionsMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public MobileFlashPromotions selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.mobileFlashPromotionsMapper.selectByPrimaryKey(sid);
	}

	@Override
	public List<MobileFlashPromotions> queryPromotionsByEndTime(
			MobileFlashPromotionsKey record) {
		// TODO Auto-generated method stub
		return this.mobileFlashPromotionsMapper.queryPromotionsByEndTime(record);
	}

	@Override
	public List<MobileFlashPromotions> getAllPromotions() {
		// TODO Auto-generated method stub
		return this.mobileFlashPromotionsMapper.getAllPromotions();
	}

	@Override
	public List<MobileFlashPromotions> getGoingPromotions() {
		HashMap map = new HashMap();
		map.put("currentTime", new Date());
		map.put("flag", 1);
		return this.mobileFlashPromotionsMapper.getGoingPromotions(map);
	}
	
}
