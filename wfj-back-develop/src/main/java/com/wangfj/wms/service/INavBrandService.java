/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.INavBrandService.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:32:13
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.NavBrand;


/**
 * @Class Name INavBrandService
 * @Author chengsj
 * @Create In 2013-7-22
 */
public interface INavBrandService {

	int deleteByPrimaryKey(Long sid);

    int insert(NavBrand record);

    int insertSelective(NavBrand record);

    NavBrand selectByPrimaryKey(Long sid);

    int updateByPrimaryKeySelective(NavBrand record);

    int updateByPrimaryKey(NavBrand record);
    
    int updateBybrandSid(NavBrand record);
    
    List selectNavBrandByNavSid(NavBrand record);
    
    int countNavBrandRecord(NavBrand record);
    
    int countSeq(NavBrand record);
    
    int maxSeq(NavBrand record);
    
    
}
