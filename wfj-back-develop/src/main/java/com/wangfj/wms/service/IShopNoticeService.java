/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceIShopNoticeService.java
 * @Create By chengsj
 * @Create In 2013-11-19 下午2:31:46
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.ShopNotice;


/**
 * @Class Name IShopNoticeService
 * @Author chengsj
 * @Create In 2013-11-19
 */
public interface IShopNoticeService {
	
	int deleteByPrimaryKey(Integer sid);

    int insert(ShopNotice record);

    ShopNotice selectByPrimaryKey(Integer sid);

    int updateByPrimaryKey(ShopNotice record);
    
    int updateByPrimaryKeySelective(ShopNotice record);
    
    List<ShopNotice> selectByNoticeType(Integer typeSid);
}
