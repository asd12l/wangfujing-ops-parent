/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperProConSearchMapper.java
 * @Create By k
 * @Create In 2013-5-9 下午3:22:46
 * TODO
 */
package com.wangfj.back.mapper;


import com.framework.IAbstractDAO;
import com.framework.persistence.WangfjMapper;
import com.wangfj.back.entity.cond.ProConSearchCond;
import com.wangfj.back.entity.po.ProConSearch;
import com.wangfj.back.entity.vo.ProConSearchVO;
import com.wangfj.back.view.ProductKey;

/**
 * @desc  mapper 
 * @Class Name ProConSearchMapper
 * @Author chengsj
 * @Create In 2013-5-9
 */
@WangfjMapper
public interface ProConSearchMapper extends IAbstractDAO<ProConSearchCond, ProConSearch, ProConSearchVO>{

	void updateProConSearch(ProductKey productKey);
	
}
