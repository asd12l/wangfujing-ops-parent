/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implSysParameterServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-11-28 下午4:10:36
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.SysParameterValue;
import com.wangfj.wms.persistence.SysParameterValueMapper;
import com.wangfj.wms.service.ISysParameterValueService;


/**
 * @Class Name SysParameterServiceImpl
 * @Author chengsj
 * @Create In 2013-11-28
 */
@Component("sysParameterValueService")
@Scope("prototype")
@Transactional
public class SysParameterServiceImpl implements ISysParameterValueService{

	@Autowired
	private SysParameterValueMapper sysParameterValueMapper;

	public int deleteByPrimaryKey(Integer sid) {
		return this.sysParameterValueMapper.deleteByPrimaryKey(sid);
	}

	public int insert(SysParameterValue record) {
		return this.sysParameterValueMapper.insert(record);
	}

	public int updateByPrimaryKeySelective(SysParameterValue record) {
		return this.sysParameterValueMapper.updateByPrimaryKeySelective(record);
	}

	public List<SysParameterValue> selectByParamType(Integer typeSid) {
		return this.sysParameterValueMapper.selectByParamType(typeSid);
	}

}
