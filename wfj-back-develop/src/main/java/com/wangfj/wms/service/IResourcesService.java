/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceIResourcesService.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午3:45:57
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.Resources;


/**
 * @Class Name IResourcesService
 * @Author chengsj
 * @Create In 2013-7-5
 */
public interface IResourcesService {
	
	 int deleteByPrimaryKey(Long sid);

	    int insert(Resources record);

	    int insertSelective(Resources record);

	    Resources selectByPrimaryKey(Long sid);

	    int updateByPrimaryKeySelective(Resources record);

	    int updateByPrimaryKey(Resources record);
	    
	    List selectAllResources();
	    
	    List selectResourceByName(Resources record);
	    
	    List selectList(Resources record);
	    
	    List selectOthersByPrimaryKey(List<Long> sids);
}
