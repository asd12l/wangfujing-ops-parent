package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.ProBestDetailMql;


public interface ProBestDetailMqlMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(ProBestDetailMql record);

    int insertSelective(ProBestDetailMql record);

    ProBestDetailMql selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(ProBestDetailMql record);

    int updateByPrimaryKey(ProBestDetailMql record);
    
    List<ProBestDetailMql>  queryProList(Integer pageLayoutSid);
    
    Integer queryMaxOrderNum(Integer pageLayoutSid);
    
    Integer queryObjsCount(ProBestDetailMql record);

    public void deleteByProductListSid(ProBestDetailMql proBestDetailMql);
    
    ProBestDetailMql queryOrderNumber(ProBestDetailMql record);
    
}