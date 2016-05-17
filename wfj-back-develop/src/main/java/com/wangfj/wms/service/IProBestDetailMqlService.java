/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceIProBestDetailMqlService.java
 * @Create By chengsj
 * @Create In 2013-8-29 下午6:43:43
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.ProBestDetailMql;


/**
 * @Class Name IProBestDetailMqlService
 * @Author chengsj
 * @Create In 2013-8-29
 */
public interface IProBestDetailMqlService {
	int deleteByPrimaryKey(Integer sid);

    int insert(ProBestDetailMql record);

    int insertSelective(ProBestDetailMql record);

    ProBestDetailMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ProBestDetailMql record);

    int updateByPrimaryKey(ProBestDetailMql record);
    
    List<ProBestDetailMql>  queryProList(Integer pageLayoutSid);
    
    public void deleteByProductListSid(ProBestDetailMql proBestDetailMql);
    
    void insertBatch(String pageLayoutSid, String[] productSidsArray);
    
    ProBestDetailMql queryOrderNumber(ProBestDetailMql record);
    
    Integer queryMaxOrderNum(Integer pageLayoutSid);
}
