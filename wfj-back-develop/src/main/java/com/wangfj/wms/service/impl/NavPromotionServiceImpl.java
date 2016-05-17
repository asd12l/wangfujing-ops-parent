/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.impl.NavPromotionServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:36:59
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.NavPromotion;
import com.wangfj.wms.persistence.NavPromotionMapper;
import com.wangfj.wms.service.INavPromotionService;


/**
 * @Class Name NavPromotionServiceImpl
 * @Author chengsj
 * @Create In 2013-7-22
 */
@Component("navPromotionService")
@Scope("prototype")
@Transactional
public class NavPromotionServiceImpl implements INavPromotionService {

	@Autowired
	NavPromotionMapper navPromotionMapper;
	
	@Override
	public int insert(NavPromotion record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.insert(record);
	}

	@Override
	public int insertSelective(NavPromotion record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.insertSelective(record);
	}

	

	@Override
	public List<NavPromotion> selectByNavSid(NavPromotion record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.selectByNavSid(record);
	}

	@Override
	public int deleteByNavPro(NavPromotion record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.deleteByNavPro(record);
	}

	@Override
	public int countNavPromotionRecord(NavPromotion record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.countNavPromotionRecord(record);
	}

	@Override
	public NavPromotion selectByInfo(NavPromotion record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.selectByInfo(record);
	}

	@Override
	public int updateByPrimaryKeySelective(NavPromotion record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int selectMaxSeq(Long record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.selectMaxSeq(record);
	}

	@Override
	public int deleteBySid(NavPromotion record) {
		// TODO Auto-generated method stub
		return this.navPromotionMapper.deleteBySid(record);
	}

	

	

}
