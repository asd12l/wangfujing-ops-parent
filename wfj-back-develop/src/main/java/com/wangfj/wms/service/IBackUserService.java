package com.wangfj.wms.service;

import java.util.List;
import java.util.Map;

import com.wangfj.wms.domain.entity.BackUser;
import com.wangfj.wms.domain.entity.BackUserRole;
import com.wangfj.wms.domain.entity.LogisticsUser;


/**
 * @Class Name IBackUserService
 * @Author wwb
 * @Create In 2014-12-2
 */
public interface IBackUserService {

	BackUser queryUserByName(String username);

	List getByParam(BackUser backUser);

	List getAll();

	void insertUserRole(BackUserRole userRole);

	void updateUserRole(BackUserRole userRole);

	void insertBackUser(BackUser backUser);

	void deleteBackUser(int parseInt);
	//根据usersid获取该用户的角色以信息
	Map getBackUserRoleInfo(Integer sid);
	
	//保存物流专员
	boolean saveLogiticsUser(BackUser backUser,LogisticsUser logisticsUser);
	
	//获取物流用户信息
	Map getBLUserInfo(Integer sid);
	//获取符合条件的条数
	int getTotalByParam(BackUser backUser);

}
