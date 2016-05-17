/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceIPromotionTypeService.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:45:41
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.PromotionType;


/**
 * @Class Name IPromotionTypeService
 * @Author chengsj
 * @Create In 2013-8-29
 */
public interface IPromotionTypeService {
	int deleteByPrimaryKey(Integer sid);

    int insert(PromotionType record);

    int insertSelective(PromotionType record);

    PromotionType selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PromotionType record);

    int updateByPrimaryKey(PromotionType record);
    
    List queryBySelective(PromotionType record);
}
