package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.LabourDayUserInfo;
import com.wangfj.wms.persistence.LabourDayUserInfoMapper;
import com.wangfj.wms.service.ILabourDayUserInfoService;
import com.wangfj.wms.util.MobileFlashPromotionsKey;


@Component("labourdayuserinfoservice")
@Scope("prototype")
@Transactional
public class LabourDayUserInfoServiceImpl implements ILabourDayUserInfoService {
	@Autowired
	LabourDayUserInfoMapper labourDayUserInfoMapper;
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.labourDayUserInfoMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(LabourDayUserInfo record) {
		// TODO Auto-generated method stub
		return this.labourDayUserInfoMapper.insert(record);
	}

	@Override
	public int insertSelective(LabourDayUserInfo record) {
		// TODO Auto-generated method stub
		return this.labourDayUserInfoMapper.insertSelective(record);
	}

	@Override
	public LabourDayUserInfo selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.labourDayUserInfoMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(LabourDayUserInfo record) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateByPrimaryKey(LabourDayUserInfo record) {
		// TODO Auto-generated method stub
		return this.labourDayUserInfoMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<LabourDayUserInfo> selectAllUserInfoByTime(
			MobileFlashPromotionsKey record) {
		List<LabourDayUserInfo> list =this.labourDayUserInfoMapper.selectAllUserInfoByTime(record);
		return list;
	}

}
