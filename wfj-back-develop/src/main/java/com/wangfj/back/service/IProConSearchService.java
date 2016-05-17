/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceIProConSearchService.java
 * @Create By chengsj
 * @Create In 2013-5-10 下午1:36:11
 * TODO
 */
package com.wangfj.back.service;


import com.framework.IAbstractService;
import com.wangfj.back.entity.cond.ProConSearchCond;
import com.wangfj.back.entity.po.ProConSearch;
import com.wangfj.back.entity.vo.ProConSearchVO;
import com.wangfj.back.view.ProductKey;

/**
 * @Class Name IProConSearchService
 * @Author chengsj
 * @Create In 2013-5-10
 */
public interface IProConSearchService extends IAbstractService<ProConSearchCond, ProConSearch, ProConSearchVO>{

	void updateProConSearch(ProductKey productKey);
}
