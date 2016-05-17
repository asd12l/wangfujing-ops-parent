package com.wangfj.wms.persistence;

import java.util.List;
import java.util.Map;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.SeoHotWord;


@WangfjMysqlMapper
public interface SeoHotWordMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(SeoHotWord record);

    int insertSelective(SeoHotWord record);

    SeoHotWord selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SeoHotWord record);

    int updateByPrimaryKey(SeoHotWord record);
    
    List<SeoHotWord> selectListByParam(Map<String,Object> map);

	List<SeoHotWord> queryAllHotWord();
	
	int selectCountByHotName(String HotName);
}