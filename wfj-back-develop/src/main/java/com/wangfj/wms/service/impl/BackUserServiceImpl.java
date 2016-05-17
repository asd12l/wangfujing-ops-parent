package com.wangfj.wms.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.BackUser;
import com.wangfj.wms.domain.entity.BackUserRole;
import com.wangfj.wms.domain.entity.LogisticsUser;
import com.wangfj.wms.persistence.BackUserMapper;
import com.wangfj.wms.persistence.LogisticsUserMapper;
import com.wangfj.wms.service.IBackUserService;

/**
 * @Class Name BackUserServiceImpl
 * @Author wwb
 * @Create In 2014-12-2
 */
@Component("backUserService")
@Scope("prototype")
@Transactional
public class BackUserServiceImpl implements IBackUserService{
	@Autowired
	BackUserMapper backUserMapper;
	@Autowired
	LogisticsUserMapper logisticsUserMapper;
	@Override
	public BackUser queryUserByName(String username) {
		return backUserMapper.queryUserByName(username);
	}
	@Override
	public List getByParam(BackUser backUser) {
		return backUserMapper.getByParam(backUser);
	}
	@Override
	public List getAll() {
		return backUserMapper.getAll();
	}
	@Override
	public void insertUserRole(BackUserRole userRole) {
		backUserMapper.insertUserRole(userRole);
	}
	@Override
	public void updateUserRole(BackUserRole userRole) {
		backUserMapper.updateUserRole(userRole);
	}
	@Override
	public void insertBackUser(BackUser backUser) {
		backUserMapper.insertBackUser(backUser);
	}
	@Override
	public void deleteBackUser(int sid) {
		backUserMapper.deleteBackUser(sid);
	}
	@Override
	public Map getBackUserRoleInfo(Integer sid) {
		return (Map) backUserMapper.getBackUserRoleInfo(sid);
	}
	@Transactional
	@Override
	public boolean saveLogiticsUser(BackUser backUser,
			LogisticsUser logisticsUser) {
		// TODO Auto-generated method stub
		backUserMapper.insertBackUser(backUser);
		Integer userSid = backUser.getSid();
		if(userSid==null){
			return false;
		}
		logisticsUser.setUserSid(userSid);
		int num = logisticsUserMapper.insertLogiticsUser(logisticsUser);
		if (num>0) {
			return true;
		}
		return false;
	}
	@Override
	public Map getBLUserInfo(Integer sid) {
		return backUserMapper.getBLUserInfo(sid);
	}
	@Override
	public int getTotalByParam(BackUser backUser) {
		return backUserMapper.getTotalByParam(backUser);
	}
	
	
	

}
