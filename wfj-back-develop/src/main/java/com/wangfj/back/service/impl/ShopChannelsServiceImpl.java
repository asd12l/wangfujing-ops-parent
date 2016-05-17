/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.service.implShopChannelsServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-5-9 下午7:35:56
 * TODO
 */
package com.wangfj.back.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.page.Paginator;
import com.framework.returnObj.Infos;
import com.wangfj.back.entity.cond.ShopChannelsCond;
import com.wangfj.back.entity.vo.ShopChannelsVO;
import com.wangfj.back.mapper.ShopChannelsMapper;
import com.wangfj.back.service.IShopChannelsService;


/**
 * @Class Name ShopChannelsServiceImpl
 * @Author chengsj
 * @Create In 2013-5-9
 */
@Service(value = "shopChannelsService")
public class ShopChannelsServiceImpl implements IShopChannelsService {

	@Autowired
	private ShopChannelsMapper shopChannelsMapper;
	
	/*
	 * (non-Javadoc)
	 * @see com.framework.IAbstractService#findObjBySid(com.framework.returnObj.Infos, java.lang.Long)
	 */
	public ShopChannelsVO findObjBySid(Infos infos, Long sid)throws SQLException {
		return shopChannelsMapper.findObjBySid(sid);
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.framework.IAbstractService#queryObjs(com.framework.returnObj.Infos, com.framework.AbstractCondtion)
	 */
	public Paginator queryObjs(Infos infos, ShopChannelsCond cond)throws SQLException {
		
		Paginator page = new Paginator();
		page.setList(shopChannelsMapper.queryObjsList(cond));
		page.setTotalRecords(shopChannelsMapper.queryObjsCount(cond));
		page.setPage(cond);
		return page;
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.framework.IAbstractService#insert(com.framework.returnObj.Infos, com.framework.AbstractCondtion)
	 */
	public void insert(Infos infos, ShopChannelsCond cond) throws SQLException {

		this.shopChannelsMapper.insert(cond.getShopChannels());
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.framework.IAbstractService#update(com.framework.returnObj.Infos, com.framework.AbstractCondtion)
	 */
	public void update(Infos infos, ShopChannelsCond cond) throws SQLException {
		this.shopChannelsMapper.update(cond.getShopChannels());
	}
	
	/*
	 * (non-Javadoc)
	 * @see com.framework.IAbstractService#delete(com.framework.returnObj.Infos, java.lang.Long)
	 */
	public void delete(Infos infos, Long sid) throws SQLException {
		this.shopChannelsMapper.delete(sid);
	}
  
	public List queryAllChannels(){
		
		return this.shopChannelsMapper.queryAllChannels();
		
		
	}
	
}
