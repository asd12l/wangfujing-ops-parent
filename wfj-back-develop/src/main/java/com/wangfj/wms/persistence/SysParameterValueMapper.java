package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.SysParameterValue;


public interface SysParameterValueMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(SysParameterValue record);

    int insertSelective(SysParameterValue record);

    SysParameterValue selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SysParameterValue record);

    int updateByPrimaryKey(SysParameterValue record);
    
    List<SysParameterValue> selectByParamType(Integer typeSid);
}