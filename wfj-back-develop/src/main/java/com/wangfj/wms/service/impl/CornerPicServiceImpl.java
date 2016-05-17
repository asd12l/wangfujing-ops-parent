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

import com.wangfj.wms.domain.entity.PromotionCornerPic;
import com.wangfj.wms.domain.view.CornerPicVO;
import com.wangfj.wms.persistence.PromotionCornerPicMapper;
import com.wangfj.wms.service.ICornerPicService;


/**
 * @Class Name PromotionServiceImpl
 * @Author chengsj
 * @Create In 2014-5-27
 */
@Component("cornerPicService")
@Scope("prototype")
@Transactional
public class CornerPicServiceImpl implements ICornerPicService {

	@Autowired PromotionCornerPicMapper promotionCornerPicMapper;
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(PromotionCornerPic record) {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.insert(record);
	}

	@Override
	public int insertSelective(PromotionCornerPic record) {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.insertSelective(record);
	}

	@Override
	public PromotionCornerPic selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(PromotionCornerPic record) {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(PromotionCornerPic record) {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<PromotionCornerPic> selectAllCorners() {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.selectAllCorners();
	}

	@Override
	public int selectCountByPrams(CornerPicVO key) {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.selectCountByPrams(key);
	}

	@Override
	public List selectByPrams(CornerPicVO key) {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.selectByPrams(key);
	}

	@Override
	public Integer queryMaxSid() {
		// TODO Auto-generated method stub
		return this.promotionCornerPicMapper.queryMaxSid();
	}
	
}
