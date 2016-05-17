/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.mapperProBestDetailMapper.java
 * @Create By chengsj
 * @Create In 2013-5-13 上午11:32:53
 * TODO
 */
package com.wangfj.back.mapper;

import java.util.List;

import com.framework.IAbstractDAO;
import com.framework.persistence.WangfjMapper;
import com.wangfj.back.entity.cond.ProBestDetailCond;
import com.wangfj.back.entity.po.ProBestDetail;
import com.wangfj.back.entity.vo.ProBestDetailVO;

/**
 * @Class Name ProBestDetailMapper
 * @Author chengsj
 * @Create In 2013-5-13
 */
@WangfjMapper
public interface ProBestDetailMapper extends IAbstractDAO<ProBestDetailCond, ProBestDetail, ProBestDetailVO> {

	List queryProductsByPsid(Long pageLayoutSid);

	void updateProBestDetail(Integer productListSid, Integer pageLayoutSid);

	ProBestDetailVO queryOrderNumber(ProBestDetailCond cond);

	int deleteByProductListSid(ProBestDetail proBestDetail);


	Integer queryMaxOrderNum(Long pageLayoutSid);

	
	
}
