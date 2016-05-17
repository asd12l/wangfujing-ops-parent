/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperBrandMapper.java
 * @Create By chengsj
 * @Create In 2013-5-13 上午10:14:32
 * TODO
 */
package com.wangfj.back.mapper;



import com.framework.IAbstractDAO;
import com.framework.persistence.WangfjMapper;
import com.wangfj.back.entity.cond.BrandCond;
import com.wangfj.back.entity.po.Brand;
import com.wangfj.back.entity.vo.BrandVO;

/**
 * @Class Name BrandMapper
 * @Author chengsj
 * @Create In 2013-5-13
 */
@WangfjMapper
public interface BrandMapper extends IAbstractDAO<BrandCond, Brand, BrandVO>{

	
}
