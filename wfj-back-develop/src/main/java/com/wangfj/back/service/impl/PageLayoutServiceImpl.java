/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.service.implPageLayoutService.java
 * @Create By chengsj
 * @Create In 2013-5-10 下午2:35:15
 * TODO
 */
package com.wangfj.back.service.impl;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.page.Paginator;
import com.framework.returnObj.Infos;
import com.wangfj.back.entity.cond.PageLayoutCond;
import com.wangfj.back.entity.cond.ShopChannelsCond;
import com.wangfj.back.entity.vo.PageLayoutVO;
import com.wangfj.back.mapper.PageLayoutMapper;
import com.wangfj.back.mapper.ShopChannelsMapper;
import com.wangfj.back.service.IPageLayoutService;


/**
 * @Class Name PageLayoutService
 * @Author chengsj
 * @Create In 2013-5-10
 */
@Service(value = "pageLayoutService")
public class PageLayoutServiceImpl implements IPageLayoutService{
	@Autowired
	private PageLayoutMapper pageLayoutMapper;
	
	@Autowired
	private ShopChannelsMapper shopChannelsMapper;
	
	public PageLayoutVO findObjBySid(Infos infos,Long sid) throws SQLException{
		return pageLayoutMapper.findObjBySid(sid);
	}
	
	public Paginator queryObjs(Infos infos, PageLayoutCond cond) throws SQLException {
		Paginator page = new Paginator();
		page.setList(pageLayoutMapper.queryObjsList(cond));
		page.setTotalRecords(pageLayoutMapper.queryObjsCount(cond));
		page.setPage(cond);
		return page;
	}
	
	public void insert(Infos infos, PageLayoutCond cond) throws SQLException {
		pageLayoutMapper.insert(cond.getPageLayout());
	}
	
	public void update(Infos infos, PageLayoutCond cond) throws SQLException {
		pageLayoutMapper.update(cond.getPageLayout());
	}

	public void delete(Infos infos, Long sid) throws SQLException {
		pageLayoutMapper.delete(sid);
	}

	/* (non-Javadoc)
	 * @see com.wangfj.back.service.IPageLayoutService#queryPageLayoutByChannel(com.framework.returnObj.Infos, com.wangfj.back.entity.cond.PageLayoutCond)
	 */
	public Paginator queryPageLayoutByChannel(Infos infos, PageLayoutCond cond) throws SQLException {
		Paginator page = new Paginator();
		List list = this.pageLayoutMapper.queryPageLayoutByChannel(cond.getChannelSid());
		ShopChannelsCond scond  = null;
		for(Iterator iter  = list.iterator();iter.hasNext();){
			PageLayoutVO vo  = (PageLayoutVO) iter.next();
			scond  = new ShopChannelsCond();
			scond.setPageLayoutSid(vo.getSid());
			scond.setSid(Long.valueOf(vo.getChannelSid()));
			int count = this.shopChannelsMapper.queryObjsCount(scond);
			vo.setPageType(count == 0?0:1 );
		}
		page.setList(list);
		page.setTotalRecords(1);
		page.setPage(cond);
		return page;	
	}
	
		


	/* (non-Javadoc)
	 * @see com.wangfj.back.service.IPageLayoutService#queryChildPageLayout(java.lang.Long)
	 */
	public List queryChildPageLayout(Long pageLayoutSid) {
		List list = this.pageLayoutMapper.queryChildPageLayout(pageLayoutSid);
		return list;
	}

	
	public int QueryObjsCount(PageLayoutCond cond) throws SQLException {
		
		int num = this.pageLayoutMapper.queryObjsCount(cond);
		return num;
	}


	public PageLayoutVO selectQueryBySid(Long sid) {
		
		return this.pageLayoutMapper.selectQueryBySid(sid);
	}

}
