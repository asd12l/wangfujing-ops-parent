/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.INavContentSerivce.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:33:43
 * TODO
 */
package com.wangfj.wms.service;

import com.wangfj.wms.domain.entity.NavContent;

/**
 * @Class Name INavContentSerivce
 * @Author chengsj
 * @Create In 2013-7-22
 */
public interface INavContentSerivce {

	 int deleteByPrimaryKey(Long sid);

	    int insert(NavContent record);

	    int insertSelective(NavContent record);

	    NavContent selectByPrimaryKey(Long sid);

	    int updateByPrimaryKeySelective(NavContent record);

	    int updateByPrimaryKey(NavContent record);
}
