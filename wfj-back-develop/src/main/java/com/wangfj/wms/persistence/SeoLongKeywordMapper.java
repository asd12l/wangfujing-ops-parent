package com.wangfj.wms.persistence;

import java.util.List;
import java.util.Map;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.SeoLongKeyword;


@WangfjMysqlMapper
public interface SeoLongKeywordMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(SeoLongKeyword record);

    int insertSelective(SeoLongKeyword record);

    SeoLongKeyword selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SeoLongKeyword record);

    int updateByPrimaryKey(SeoLongKeyword record);
    
    List<SeoLongKeyword> selectListByParam(Map<String,Object> map);

	List<SeoLongKeyword> queryAllLongkey();
	
	int selectCountByLongName(String longName);
}