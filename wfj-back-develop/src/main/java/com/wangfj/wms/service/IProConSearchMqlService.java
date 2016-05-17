/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.IProConSearchMqlService.java
 * @Create By chengsj
 * @Create In 2013-9-16 下午2:06:15
 * TODO
 */
package com.wangfj.wms.service;

import com.wangfj.back.view.ProductKey;
import com.wangfj.wms.domain.entity.ProConSearchMql;

/**
 * @Class Name IProConSearchMqlService
 * @Author chengsj
 * @Create In 2013-9-16
 */
public interface IProConSearchMqlService {

	int deleteByPrimaryKey(Integer sid);

	int insert(ProConSearchMql record);

	int insertSelective(ProConSearchMql record);

	ProConSearchMql selectByPrimaryKey(Integer sid);

	int updateByPrimaryKeySelective(ProConSearchMql record);

	int updateByPrimaryKey(ProConSearchMql record);

	void updateProConSearch(ProductKey productKey);
}
