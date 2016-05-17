/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceNoticeTypeService.java
 * @Create By chengsj
 * @Create In 2013-11-18 下午3:03:54
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.NoticeType;


/**
 * @Class Name NoticeTypeService
 * @Author chengsj
 * @Create In 2013-11-18
 */
public interface INoticeTypeService {
	
	public List<NoticeType> selectAll();
	
	public List<NoticeType> selectByParams(NoticeType record);
	
	public void deleteByPrimaryKey(Integer sid);
	
	public Integer updateByPrimaryKey(NoticeType record);
	
	public void insert(NoticeType record);
	
	public NoticeType selectByPrimaryKey(Integer sid);
}
