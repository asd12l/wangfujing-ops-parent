package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.SysParameterType;


public interface ISysParameterTypeService {
	
	int deleteByPrimaryKey(Integer sid);

    int insert(SysParameterType record);

    int updateByPrimaryKeySelective(SysParameterType record);

    List<SysParameterType> selectByCode(String code);
}
