/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.IPromotionService.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:31:09
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.ErweimaPromotions;
import com.wangfj.wms.domain.view.ErweimaPromotionsVO;


/**
 * @Class Name IErweimaPromotionService
 * @Author chengsj
 * @Create In 2014-4-16
 */
public interface IErweimaPromotionService {

    int deleteByPrimaryKey(Integer sid);

    int insert(ErweimaPromotions record);

    int insertSelective(ErweimaPromotions record);

    ErweimaPromotions selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ErweimaPromotions record);

    int updateByPrimaryKey(ErweimaPromotions record);

	int selectCountByPrams(ErweimaPromotionsVO key);

	List selectByPrams(ErweimaPromotionsVO key);

}
