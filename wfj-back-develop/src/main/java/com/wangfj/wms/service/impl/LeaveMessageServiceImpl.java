/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implLeaveMessageServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-8-14 下午6:34:01
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.LeaveMessage;
import com.wangfj.wms.domain.view.LeaveMessageVO;
import com.wangfj.wms.persistence.LeaveMessageMapper;
import com.wangfj.wms.service.ILeaveMessageService;

/**
 * @Class Name LeaveMessageServiceImpl
 * @Author chengsj
 * @Create In 2013-8-14
 */
@Component("leaveMessageService")
@Scope("prototype")
@Transactional
public class LeaveMessageServiceImpl implements ILeaveMessageService {

	@Autowired
	LeaveMessageMapper leaveMessageMapper;
	@Override
	public int deleteByPrimaryKey(Integer msgid) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int insert(LeaveMessage record) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int insertSelective(LeaveMessage record) {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public LeaveMessage selectByPrimaryKey(Integer msgid) {
		// TODO Auto-generated method stub
		return this.leaveMessageMapper.selectByPrimaryKey(msgid);
	}
	@Override
	public int updateByPrimaryKeySelective(LeaveMessage record) {
		// TODO Auto-generated method stub
		return this.leaveMessageMapper.updateByPrimaryKeySelective(record);
	}
	@Override
	public int updateByPrimaryKey(LeaveMessage record) {
		return this.leaveMessageMapper.updateByPrimaryKey(record);
	}
	@Override
	public List<LeaveMessage> selectByParms(LeaveMessageVO record) {
		// TODO Auto-generated method stub
		return this.leaveMessageMapper.selectByParms(record);
	}
	@Override
	public int selectPageCount(LeaveMessageVO record) {
		// TODO Auto-generated method stub
		return this.leaveMessageMapper.selectPageCount(record);
	}

}
