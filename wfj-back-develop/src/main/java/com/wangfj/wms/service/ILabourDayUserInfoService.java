/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.IPromotionService.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:31:09
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.LabourDayUserInfo;
import com.wangfj.wms.util.MobileFlashPromotionsKey;


/**
 * @Class Name IPromotionService
 * @Author chengsj
 * @Create In 2013-7-22
 */
public interface ILabourDayUserInfoService {

    int deleteByPrimaryKey(Integer sid);

    int insert(LabourDayUserInfo record);

    int insertSelective(LabourDayUserInfo record);

    LabourDayUserInfo selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(LabourDayUserInfo record);

    int updateByPrimaryKey(LabourDayUserInfo record);
    
    List<LabourDayUserInfo> selectAllUserInfoByTime(MobileFlashPromotionsKey record);

}
