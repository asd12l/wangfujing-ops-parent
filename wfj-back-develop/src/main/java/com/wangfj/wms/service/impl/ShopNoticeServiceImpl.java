/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implShopNoticeServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-11-19 下午2:33:43
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.ShopNotice;
import com.wangfj.wms.persistence.ShopNoticeMapper;
import com.wangfj.wms.service.IShopNoticeService;

/**
 * @Class Name ShopNoticeServiceImpl
 * @Author chengsj
 * @Create In 2013-11-19
 */
@Component("shopNoticeService")
@Scope("prototype")
@Transactional
public class ShopNoticeServiceImpl implements IShopNoticeService {

	@Autowired
	private ShopNoticeMapper shopNoticeMapper;
	
	public int deleteByPrimaryKey(Integer sid) {
		return this.shopNoticeMapper.deleteByPrimaryKey(sid);
	}

	public int insert(ShopNotice record) {
		return this.shopNoticeMapper.insert(record);
	}

	public ShopNotice selectByPrimaryKey(Integer sid) {
		return this.shopNoticeMapper.selectByPrimaryKey(sid);
	}

	public int updateByPrimaryKey(ShopNotice record) {
		return this.shopNoticeMapper.updateByPrimaryKey(record);
	}

	public List<ShopNotice> selectByNoticeType(Integer typeSid) {
		return this.shopNoticeMapper.selectByNoticeType(typeSid);
	}
	
	public int updateByPrimaryKeySelective(ShopNotice record) {
		return this.shopNoticeMapper.updateByPrimaryKeySelective(record);
	}

}
