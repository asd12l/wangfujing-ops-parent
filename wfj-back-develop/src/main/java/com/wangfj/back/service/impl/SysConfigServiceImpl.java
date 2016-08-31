package com.wangfj.back.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wangfj.back.entity.po.SysConfig;
import com.wangfj.back.mapper.SysConfigMapper;
import com.wangfj.back.service.ISysConfigService;

/**
 * @Class Name SysConfigServiceImpl
 * @Author zhangdl
 * @Create In 2016-8-30
 */
@Service(value="sysConfigService")
public class SysConfigServiceImpl implements ISysConfigService {
	
	@Autowired
	SysConfigMapper sysConfigMapper;

	@Override
	public List<SysConfig> selectAll() {
		// TODO Auto-generated method stub
		return sysConfigMapper.selectAll();
	}

	@Override
	public boolean editSysConfig(SysConfig config) {
		// TODO Auto-generated method stub
		int i = sysConfigMapper.updateByPrimaryKeySelective(config);
		if(i > 0){
			return true;
		}
		return false;
	}

	@Override
	public List<SysConfig> selectByKeys(List<String> keys) {
		// TODO Auto-generated method stub
		return sysConfigMapper.selectByKeys(keys);
	}

	@Override
	public boolean saveOrEditSysConfigByKey(SysConfig config) {
		// TODO Auto-generated method stub
		List<String> paramList = new ArrayList<String>();
		paramList.add(config.getKey());
		List<SysConfig> list = sysConfigMapper.selectByKeys(paramList);
		if(list == null || list.size() == 0){
			int i = sysConfigMapper.insertSelective(config);
			if(i > 0){
				return true;
			}
		} else {
			config.setSid(list.get(0).getSid());
			int i = sysConfigMapper.updateByPrimaryKeySelective(config);
			if(i > 0){
				return true;
			}
		}
		return false;
	}

}
