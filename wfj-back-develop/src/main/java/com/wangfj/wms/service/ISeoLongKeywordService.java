/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceISeoBrand.java
 * @Create By Rooney
 * @Create In 2014-6-30 下午4:49:11
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.SeoLongKeyword;


/**
 * @Class Name ISeoBrand
 * @Author chengsj
 * @Create In 2014-6-30
 */
public interface ISeoLongKeywordService {

    int deleteByPrimaryKey(Integer sid);

    int insert(SeoLongKeyword record);

    int insertSelective(SeoLongKeyword record);

    SeoLongKeyword selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SeoLongKeyword record);

    int updateByPrimaryKey(SeoLongKeyword record);

	List<SeoLongKeyword> queryAllLongkey();
	
	int selectCountByLongName(String longName);

}
