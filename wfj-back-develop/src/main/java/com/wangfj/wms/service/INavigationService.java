/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceINavigationService.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:24:18
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.Navigation;


/**
 * @Class Name INavigationService
 * @Author chengsj
 * @Create In 2013-7-22
 */
public interface INavigationService {

	int deleteByPrimaryKey(Long sid);

	int insert(Navigation record);

	int insertSelective(Navigation record);

	Navigation selectByPrimaryKey(Long sid);

	int updateByPrimaryKeySelective(Navigation record);

	int updateByPrimaryKey(Navigation record);

	List selectList(Navigation record);

	int selectCountBycalssSid(String classSid);
}
