package com.wangfj.back.service;

import java.util.List;

import com.wangfj.back.entity.po.SysConfig;

public interface ISysConfigService {
	
	List<SysConfig> selectAll();
	
	boolean editSysConfig(SysConfig config);
	
	List<SysConfig> selectByKeys(List<String> keys);
	
	boolean saveOrEditSysConfigByKey(SysConfig config);

}
