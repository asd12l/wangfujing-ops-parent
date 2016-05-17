/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceIShopChannelsService.java
 * @Create By chengsj
 * @Create In 2013-5-9 下午7:30:53
 * TODO
 */
package com.wangfj.back.service;

import java.util.List;

import com.framework.IAbstractService;
import com.wangfj.back.entity.cond.ShopChannelsCond;
import com.wangfj.back.entity.po.ShopChannels;
import com.wangfj.back.entity.vo.ShopChannelsVO;

/**
 * @Class Name IShopChannelsService
 * @Author chengsj
 * @Create In 2013-5-9
 */
public interface IShopChannelsService extends IAbstractService<ShopChannelsCond, ShopChannels, ShopChannelsVO> {

	public List  queryAllChannels();
}
