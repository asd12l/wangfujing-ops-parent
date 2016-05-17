/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceITRuelsMqlService.java
 * @Create By Administrator
 * @Create In 2013-9-27 上午1:48:11
 * TODO
 */
package com.wangfj.wms.service;

import java.sql.SQLException;
import java.util.List;

import com.wangfj.wms.domain.entity.ShopChannelsMql;


/**
 * @Class Name ITRuelsMqlService
 * @Author Administrator
 * @Create In 2013-9-27
 */
public interface IShopChannelsMqlService {
	List<ShopChannelsMql> findChannels() throws SQLException;
	int saveShopChannels(ShopChannelsMql shopChannelsMql);
	int updateShopChannels(ShopChannelsMql shopChannelsMql);
	int deleteByPrimaryKey(Integer sid);
}
