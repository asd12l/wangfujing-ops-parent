/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperShopChannelsMapper.java
 * @Create By chengsj
 * @Create In 2013-5-9 下午4:51:46
 * TODO
 */
package com.wangfj.back.mapper;

import java.util.List;

import com.framework.IAbstractDAO;
import com.framework.persistence.WangfjMapper;
import com.wangfj.back.entity.cond.ShopChannelsCond;
import com.wangfj.back.entity.po.ShopChannels;
import com.wangfj.back.entity.vo.ShopChannelsVO;

/**
 * @Class Name ShopChannelsMapper
 * @Author chengsj
 * @Create In 2013-5-9
 */
@WangfjMapper
public interface ShopChannelsMapper extends IAbstractDAO<ShopChannelsCond, ShopChannels, ShopChannelsVO> {

	
	List  queryAllChannels();
	
	
}
