package com.wangfj.back.mapper;

import java.util.List;
import java.util.Map;

import com.wangfj.back.entity.po.SysConfig;

public interface SysConfigMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(SysConfig record);

    int insertSelective(SysConfig record);

    SysConfig selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SysConfig record);

    int updateByPrimaryKey(SysConfig record);
    
    List<SysConfig> selectAll();
    
    List<SysConfig> selectByKeys(List<String> keys);
    
    Map<String, Object> selectByRoleCodes(Map<String, Object> paramMap);
}