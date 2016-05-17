/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceIPageLayoutContentService.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:41:17
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.PageLayoutContent;


/**
 * @Class Name IPageLayoutContentService
 * @Author chengsj
 * @Create In 2013-8-29
 */
public interface IPageLayoutContentService {
	int deleteByPrimaryKey(Integer sid);

    int insert(PageLayoutContent record);

    int insertSelective(PageLayoutContent record);

    PageLayoutContent selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(PageLayoutContent record);

    int updateByPrimaryKey(PageLayoutContent record);
    
    List queryByPageLayoutSid(Integer pageLayoutSid);
}
