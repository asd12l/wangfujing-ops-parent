package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.LabourDayUserInfo;
import com.wangfj.wms.util.MobileFlashPromotionsKey;

@WangfjMysqlMapper
public interface LabourDayUserInfoMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(LabourDayUserInfo record);

    int insertSelective(LabourDayUserInfo record);

    LabourDayUserInfo selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(LabourDayUserInfo record);

    int updateByPrimaryKey(LabourDayUserInfo record);
    
    List<LabourDayUserInfo> selectAllUserInfoByTime(MobileFlashPromotionsKey record);
}