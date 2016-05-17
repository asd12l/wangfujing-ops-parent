package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.SysParameterType;


public interface SysParameterTypeMapper {
	
    int deleteByPrimaryKey(Integer sid);

    int insert(SysParameterType record);

    int insertSelective(SysParameterType record);

    SysParameterType selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(SysParameterType record);

    int updateByPrimaryKey(SysParameterType record);
    
    /**
     * 说明：
     * 		
     * @Methods Name selectByCode
     * @Create In 2013-11-26 By chengsj
     * @param title
     * @return List<SysParameterType>
     */
    List<SysParameterType> selectByCode(String code);
}