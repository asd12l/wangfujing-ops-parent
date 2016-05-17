/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.IPromotionService.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:31:09
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.PromotionCornerPic;
import com.wangfj.wms.domain.view.CornerPicVO;


/**
 * @Class Name IPromotionService
 * @Author chengsj
 * @Create In 2014-5-27
 */
public interface ICornerPicService {
	
	List<PromotionCornerPic> selectAllCorners();
	
    int deleteByPrimaryKey(Integer sid);

    int insert(PromotionCornerPic record);

    int insertSelective(PromotionCornerPic record);

    PromotionCornerPic selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PromotionCornerPic record);

    int updateByPrimaryKey(PromotionCornerPic record);

	int selectCountByPrams(CornerPicVO key);

	List selectByPrams(CornerPicVO key);

	Integer queryMaxSid();
}
