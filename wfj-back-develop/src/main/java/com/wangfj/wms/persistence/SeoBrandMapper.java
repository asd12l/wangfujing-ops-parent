package com.wangfj.wms.persistence;

import java.util.List;
import java.util.Map;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.SeoBrand;


@WangfjMysqlMapper
public interface SeoBrandMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(SeoBrand record);

    int insertSelective(SeoBrand record);

    SeoBrand selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SeoBrand record);

    int updateByPrimaryKey(SeoBrand record);
    
    List<SeoBrand> selectListByParam(Map<String,Object> map);

	List<SeoBrand> queryAllBrand();
	
	int selectCountByBrandName(String brandName);
}