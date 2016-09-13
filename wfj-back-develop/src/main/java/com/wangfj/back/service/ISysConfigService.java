package com.wangfj.back.service;

import java.util.List;
import java.util.Map;

import com.wangfj.back.entity.po.SysConfig;

public interface ISysConfigService {
	
	List<SysConfig> selectAll();
	
	boolean editSysConfig(SysConfig config);
	
	List<SysConfig> selectByKeys(List<String> keys);
	
	boolean saveOrEditSysConfigByKey(SysConfig config);

	Map<String, Object> selectByRoleCodes(Map<String, Object> paramMap);

	boolean saveOrEditSysConfigByRoleCode(Map<String, Object> paramMap);

}
