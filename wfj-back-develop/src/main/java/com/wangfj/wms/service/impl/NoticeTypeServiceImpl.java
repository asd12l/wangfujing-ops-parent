/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implNoticeTypeServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-11-18 下午3:00:17
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.NoticeType;
import com.wangfj.wms.persistence.NoticeTypeMapper;
import com.wangfj.wms.service.INoticeTypeService;

/**
 * @Class Name NoticeTypeServiceImpl
 * @Author chengsj
 * @Create In 2013-11-18
 */
@Component("noticeTypeService")
@Scope("prototype")
@Transactional
public class NoticeTypeServiceImpl implements INoticeTypeService{
	
	@Autowired
	private NoticeTypeMapper noticeTypeMapper; 
	
	public List<NoticeType> selectAll() {
		return this.noticeTypeMapper.selectAll();
	}
	
	public List<NoticeType> selectByParams(NoticeType record) {
		return this.noticeTypeMapper.selectByParams(record);
	}
	
	public void deleteByPrimaryKey(Integer sid) {
		this.noticeTypeMapper.deleteByPrimaryKey(sid);
	}
	public Integer updateByPrimaryKey(NoticeType record) {
		return this.noticeTypeMapper.updateByPrimaryKey(record);
	}

	public void insert(NoticeType record) {
		this.noticeTypeMapper.insert(record);
	}

	public NoticeType selectByPrimaryKey(Integer sid) {
		return this.noticeTypeMapper.selectByPrimaryKey(sid);
	}
}
