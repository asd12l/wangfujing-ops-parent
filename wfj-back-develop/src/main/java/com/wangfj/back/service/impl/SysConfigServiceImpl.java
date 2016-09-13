package com.wangfj.back.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wangfj.back.entity.po.SysConfig;
import com.wangfj.back.mapper.SysConfigMapper;
import com.wangfj.back.service.ISysConfigService;
import com.wangfj.back.view.UacRoleVO;
import com.wangfj.wms.domain.entity.RolePermission;
import com.wangfj.wms.persistence.RolePermissionMapper;

/**
 * @Class Name SysConfigServiceImpl
 * @Author zhangdl
 * @Create In 2016-8-30
 */
@Service(value="sysConfigService")
public class SysConfigServiceImpl implements ISysConfigService {
	
	@Autowired
	SysConfigMapper sysConfigMapper;
	@Autowired
	RolePermissionMapper rolePermissionMapper;

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
	public Map<String, Object> selectByRoleCodes(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sysConfigMapper.selectByRoleCodes(paramMap);
	}

	@Override
	public boolean saveOrEditSysConfigByKey(SysConfig config) {
		// TODO Auto-generated method stub
		List<String> paramList = new ArrayList<String>();
		paramList.add(config.getSysKey());
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
	
	@Override
	public boolean saveOrEditSysConfigByRoleCode(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		String roleCode= paramMap.get("roleCode").toString();
		String sysKey = paramMap.get("sysKey").toString();
		String sysValue = paramMap.get("sysValue").toString();
		
		Map<String, Object> paramMap1 = new HashMap<String, Object>(); 
		List<String> paramList = new ArrayList<String>();
		paramList.add(roleCode);
		paramMap.put("roleCodes", paramList);
		paramMap.put("sysKey", sysKey);
		Map<String, Object> res = sysConfigMapper.selectByRoleCodes(paramMap1);
		if(res != null){
			long sid = Long.valueOf(res.get("sid").toString());
			RolePermission record = new RolePermission();
			record.setSid(sid);
			record.setCol1(sysValue);
			record.setOpttime(new Date());
			int num = rolePermissionMapper.updateByPrimaryKeySelective(record);
			if(num > 0){
				return true;
			} else {
				return false;
			}
		} else {
			String roleSid= paramMap.get("roleSid").toString();
			RolePermission record = new RolePermission();
			record.setRoleSid(Long.valueOf(roleSid));
			record.setPermission(sysKey);
			record.setCol1(sysValue);
			record.setPermissionType(3);
			record.setStatus(1);
			record.setOpttime(new Date());
			int num = rolePermissionMapper.insertSelective(record);
			if(num > 0){
				return true;
			} else {
				return false;
			}
		}
	}

}
