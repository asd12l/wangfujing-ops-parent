/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceSYPageLayoutService.java
 * @Create By Administrator
 * @Create In 2013-5-10 下午2:28:24
 * TODO
 */
package com.wangfj.back.service;

import java.sql.SQLException;
import java.util.List;

import com.framework.IAbstractService;
import com.framework.page.Paginator;
import com.framework.returnObj.Infos;
import com.wangfj.back.entity.cond.PageLayoutCond;
import com.wangfj.back.entity.po.PageLayout;
import com.wangfj.back.entity.vo.PageLayoutVO;

/**
 * @Class Name IPageLayoutService
 * @Author chengsj
 * @Create In 2013-5-10
 */
public interface IPageLayoutService extends IAbstractService<PageLayoutCond,PageLayout,PageLayoutVO>{
		
	Paginator queryPageLayoutByChannel(Infos infos, PageLayoutCond cond) throws SQLException;
	
	List  queryChildPageLayout(Long pageLayoutSid);
	
	int QueryObjsCount(PageLayoutCond cond)throws SQLException;
	
	PageLayoutVO selectQueryBySid(Long sid);
}
