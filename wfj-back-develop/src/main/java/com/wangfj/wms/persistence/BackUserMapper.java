package com.wangfj.wms.persistence;

import java.util.List;
import java.util.Map;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.BackUser;
import com.wangfj.wms.domain.entity.BackUserRole;

/**
 * @Class Name BackUserMapper
 * @Author wwb
 * @Create In 2014-12-2
 */
@WangfjMysqlMapper
public interface BackUserMapper {

	BackUser queryUserByName(String username);

	List getByParam(BackUser backUser);

	List getAll();

	void insertUserRole(BackUserRole userRole);

	void updateUserRole(BackUserRole userRole);

	void insertBackUser(BackUser backUser);

	void deleteBackUser(int sid);
	/**
	 * 根据usersid获取该用户的角色信息
	 */
	Map getBackUserRoleInfo(Integer sid);

	Map getBLUserInfo(Integer sid);

	int getTotalByParam(BackUser backUser);
}
