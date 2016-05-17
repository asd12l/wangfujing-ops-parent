/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implPageLayoutMqlServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:58:45
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.Channel;
import com.wangfj.wms.domain.entity.PageLayoutMql;
import com.wangfj.wms.persistence.ChannelMapper;
import com.wangfj.wms.persistence.PageLayoutMqlMapper;
import com.wangfj.wms.service.IPageLayoutMqlService;


/**
 * @Class Name PageLayoutMqlServiceImpl
 * @Author chengsj
 * @Create In 2013-8-29
 */
@Component("pageLayoutMqlService")
@Scope("prototype")
@Transactional
public class PageLayoutMqlServiceImpl implements IPageLayoutMqlService {

	@Autowired
	PageLayoutMqlMapper pageLayoutMqlMapper;

	@Autowired
	ChannelMapper channelMapper;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.wangfj.wms.service.IPageLayoutMqlService#deleteByPrimaryKey(java.
	 * lang.Integer)
	 */
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.deleteByPrimaryKey(sid);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.wangfj.wms.service.IPageLayoutMqlService#insert(com.wangfj.wms.domain
	 * .entity.PageLayoutMql)
	 */
	@Override
	public int insert(PageLayoutMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.insert(record);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.wangfj.wms.service.IPageLayoutMqlService#insertSelective(com.wangfj
	 * .wms.domain.entity.PageLayoutMql)
	 */
	@Override
	public int insertSelective(PageLayoutMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.insertSelective(record);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.wangfj.wms.service.IPageLayoutMqlService#selectByPrimaryKey(java.
	 * lang.Integer)
	 */
	@Override
	public PageLayoutMql selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.selectByPrimaryKey(sid);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.wangfj.wms.service.IPageLayoutMqlService#updateByPrimaryKeySelective
	 * (com.wangfj.wms.domain.entity.PageLayoutMql)
	 */
	@Override
	public int updateByPrimaryKeySelective(PageLayoutMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.updateByPrimaryKeySelective(record);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.wangfj.wms.service.IPageLayoutMqlService#updateByPrimaryKey(com.wangfj
	 * .wms.domain.entity.PageLayoutMql)
	 */
	@Override
	public int updateByPrimaryKey(PageLayoutMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.updateByPrimaryKey(record);
	}

	@Override
	public int queryMaxSid() {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.queryMaxSid();
	}

	@Override
	public List queryChildPageLayout(Long pageLayoutSid) {
		List list = this.pageLayoutMqlMapper
				.queryChildPageLayout(pageLayoutSid);
		return list;
	}

	@Override
	public int queryObjsCount(PageLayoutMql record) {

		return this.pageLayoutMqlMapper.queryObjsCount(record);
	}

	@Override
	public List queryBySelective(Integer channelSid) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.queryBySelective(channelSid);
	}

	@Override
	public List queryByChannel(Integer channelSid) {
		List list = this.queryBySelective(channelSid);
		Channel channel = null;
		for (Iterator iter = list.iterator(); iter.hasNext();) {
			PageLayoutMql pageLayoutMql = (PageLayoutMql) iter.next();
			channel = new Channel();
			channel.setSid(channelSid);
			channel.setPageLayoutSid(pageLayoutMql.getSid());
			int count = this.channelMapper.queryObjsCount(channel);
			pageLayoutMql.setPageType(count == 0 ? 0 : 1);
		}
		return list;
	}

	@Override
	public int queryMaxSeqByPageLayoutSid(Integer pageLayoutSid) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.queryMaxSeqByPageLayoutSid(pageLayoutSid);
	}

	@Override
	public int queryCountByPageLayoutSid(Integer pageLayoutSid) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.queryCountByPageLayoutSid(pageLayoutSid);
	}

	@Override
	public List queryByPrimaryKeySelective(PageLayoutMql record) {
		// TODO Auto-generated method stub
		return this.pageLayoutMqlMapper.queryByPrimaryKeySelective(record);
	}

}
