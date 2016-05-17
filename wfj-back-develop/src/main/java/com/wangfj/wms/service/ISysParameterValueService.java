/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceISysParameterValueService.java
 * @Create By chengsj
 * @Create In 2013-11-28 下午4:08:00
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.SysParameterValue;


/**
 * @Class Name ISysParameterValueService
 * @Author chengsj
 * @Create In 2013-11-28
 */
public interface ISysParameterValueService {
	
	int deleteByPrimaryKey(Integer sid);

    int insert(SysParameterValue record);

    int updateByPrimaryKeySelective(SysParameterValue record);

    List<SysParameterValue> selectByParamType(Integer typeSid);
}
