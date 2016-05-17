/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.impl.PromotionServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:37:48
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.ErweimaPromotions;
import com.wangfj.wms.domain.view.ErweimaPromotionsVO;
import com.wangfj.wms.persistence.ErweimaPromotionsMapper;
import com.wangfj.wms.service.IErweimaPromotionService;


/**
 * @Class Name PromotionServiceImpl
 * @Author chengsj
 * @Create In 2014-4-16
 */
@Component("erweimapromotionService")
@Scope("prototype")
@Transactional
public class ErweimaPromotionServiceImpl implements IErweimaPromotionService {
	
	@Autowired
	ErweimaPromotionsMapper erweimaPromotionMapper;

	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.erweimaPromotionMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(ErweimaPromotions record) {
		// TODO Auto-generated method stub
		return this.erweimaPromotionMapper.insert(record);
	}

	@Override
	public int insertSelective(ErweimaPromotions record) {
		// TODO Auto-generated method stub
		return this.erweimaPromotionMapper.insertSelective(record);
	}

	@Override
	public ErweimaPromotions selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.erweimaPromotionMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(ErweimaPromotions record) {
		// TODO Auto-generated method stub
		return this.erweimaPromotionMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ErweimaPromotions record) {
		// TODO Auto-generated method stub
		return this.erweimaPromotionMapper.updateByPrimaryKey(record);
	}

	@Override
	public int selectCountByPrams(ErweimaPromotionsVO key) {
		// TODO Auto-generated method stub
		return this.erweimaPromotionMapper.selectCountByPrams(key);
	}

	@Override
	public List<ErweimaPromotions> selectByPrams(ErweimaPromotionsVO key) {
		// TODO Auto-generated method stub
		return this.erweimaPromotionMapper.selectByPrams(key);
	}

	
	
}
