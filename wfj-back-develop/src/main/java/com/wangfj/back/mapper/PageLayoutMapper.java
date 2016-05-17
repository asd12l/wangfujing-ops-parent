/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperPageLayoutMapper.java
 * @Create By chengsj
 * @Create In 2013-5-9 下午5:05:27
 * TODO
 */
package com.wangfj.back.mapper;

import java.util.List;

import com.framework.IAbstractDAO;
import com.framework.persistence.WangfjMapper;
import com.wangfj.back.entity.cond.PageLayoutCond;
import com.wangfj.back.entity.po.PageLayout;
import com.wangfj.back.entity.vo.PageLayoutVO;
/**
 * desc 页面展示表  mapper接口
 * @Class Name PageLayoutMapper
 * @Author chengsj
 * @Create In 2013-5-9
 */
@WangfjMapper
public interface PageLayoutMapper extends IAbstractDAO<PageLayoutCond,PageLayout,PageLayoutVO>{

	
	List  queryPageLayoutByChannel(Integer channelSid);
	
	List  queryChildPageLayout(Long pageLayoutSid);
	
	PageLayoutVO selectQueryBySid(Long pageLayoutSid);
	
	
}
