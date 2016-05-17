/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.ILeaveMessageTypeService.java
 * @Create By chengsj
 * @Create In 2013-8-14 下午5:10:32
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.LeaveMessageType;


/**
 * @Class Name ILeaveMessageTypeService
 * @Author chengsj
 * @Create In 2013-8-14
 */
public interface ILeaveMessageTypeService {

	int deleteByPrimaryKey(Integer tid);

	int insert(LeaveMessageType record);

	int insertSelective(LeaveMessageType record);

	LeaveMessageType selectByPrimaryKey(Integer tid);

	int updateByPrimaryKeySelective(LeaveMessageType record);

	int updateByPrimaryKey(LeaveMessageType record);
	
	/**
	 * 说明：
	 * 		根据父类pid获取子留言类型列表
	 * @Methods Name selectByPid
	 * @Create In 2013-8-15 By chengsj
	 * @param pid
	 * @return List
	 */
	List selectByPid(Integer pid);
	
	/**
	 * 说明：
	 * 		根据条件查找留言类型列表，若为空则返回全部列表
	 * @Methods Name selectList
	 * @Create In 2013-8-15 By chengsj
	 * @param record
	 * @return List
	 */
	List selectList(LeaveMessageType record);
	
	
	/**
	 * 说明：
	 * 		根据父类id获取留言类型列表（后台管理模块）
	 * @Methods Name selectByParentId
	 * @Create In 2013-12-2 By chengsj
	 * @param pid
	 * @return List<LeaveMessageType>
	 */
	List<LeaveMessageType> selectByParentId(Integer pid);
}
