/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceIPageLayoutMqlService.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:41:53
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.PageLayoutMql;


/**
 * @Class Name IPageLayoutMqlService
 * @Author chengsj
 * @Create In 2013-8-29
 */
public interface IPageLayoutMqlService {
	int deleteByPrimaryKey(Integer sid);

    int insert(PageLayoutMql record);

    int insertSelective(PageLayoutMql record);

    PageLayoutMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PageLayoutMql record);

    int updateByPrimaryKey(PageLayoutMql record);
    
    int queryMaxSid();
    
    int queryMaxSeqByPageLayoutSid(Integer pageLayoutSid);
    
    int queryCountByPageLayoutSid(Integer pageLayoutSid);
    
    int queryObjsCount(PageLayoutMql record);
    
    List queryBySelective(Integer channelSid);
    
    List  queryChildPageLayout(Long pageLayoutSid);
    
    List queryByChannel(Integer channelSid);
    
    List queryByPrimaryKeySelective(PageLayoutMql record);
}
