/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceISeoBrand.java
 * @Create By Rooney
 * @Create In 2014-6-30 下午4:49:11
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.SeoBrand;


/**
 * @Class Name ISeoBrand
 * @Author chengsj
 * @Create In 2014-6-30
 */
public interface ISeoBrandService {

    int deleteByPrimaryKey(Integer sid);

    int insert(SeoBrand record);

    int insertSelective(SeoBrand record);

    SeoBrand selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SeoBrand record);

    int updateByPrimaryKey(SeoBrand record);
    
    List<SeoBrand> queryAllBrand();
    
    int selectCountByBrandName(String brandName);

}
