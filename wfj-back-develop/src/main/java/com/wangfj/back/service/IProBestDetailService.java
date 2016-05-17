/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.serviceIProBestDetailService.java
 * @Create By chengsj
 * @Create In 2013-5-13 下午3:02:05
 * TODO
 */
package com.wangfj.back.service;

import java.util.List;

import com.framework.IAbstractService;
import com.wangfj.back.entity.cond.ProBestDetailCond;
import com.wangfj.back.entity.po.ProBestDetail;
import com.wangfj.back.entity.vo.ProBestDetailVO;

/**
 * @Class Name IProBestDetailService
 * @Author chengsj
 * @Create In 2013-5-13
 */
public interface IProBestDetailService extends IAbstractService<ProBestDetailCond,ProBestDetail,ProBestDetailVO>{

	List queryProductsByPsid(Long pageLayoutSid);
	

	void updateProBestDetail(Integer productListSid,Integer pageLayoutSid);
	
	ProBestDetailVO queryOrderNumber(ProBestDetailCond cond);
	 
	public void deleteByProductListSid(ProBestDetail proBestDetail);

	/**
	 * @Methods Name insertBatch
	 * @Create In 2013-5-20 By chengsj
	 * @param pageLayoutSid
	 * @param productSidsArray void
	 */
	void insertBatch(String pageLayoutSid, String[] productSidsArray);
	

}
