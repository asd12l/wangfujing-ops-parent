/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceISeoBrand.java
 * @Create By Rooney
 * @Create In 2014-6-30 下午4:49:11
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.SeoHotWord;


/**
 * @Class Name ISeoBrand
 * @Author chengsj
 * @Create In 2014-6-30
 */
public interface ISeoHotWordService {

    int deleteByPrimaryKey(Integer sid);

    int insert(SeoHotWord record);

    int insertSelective(SeoHotWord record);

    SeoHotWord selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SeoHotWord record);

    int updateByPrimaryKey(SeoHotWord record);

	List<SeoHotWord> queryAllHotWord();
	
    int selectCountByHotName(String hotName);

}
