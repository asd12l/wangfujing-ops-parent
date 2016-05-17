/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implSysParameterTypeServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-11-27 下午1:56:51
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.SysParameterType;
import com.wangfj.wms.persistence.SysParameterTypeMapper;
import com.wangfj.wms.service.ISysParameterTypeService;

/**
 * @Class Name SysParameterTypeServiceImpl
 * @Author chengsj
 * @Create In 2013-11-27
 */
@Component("sysParameterTypeService")
@Scope("prototype")
@Transactional
public class SysParameterTypeServiceImpl implements ISysParameterTypeService {

	@Autowired
	private SysParameterTypeMapper sysParameterTypeMapper;
	public int deleteByPrimaryKey(Integer sid) {
		return this.sysParameterTypeMapper.deleteByPrimaryKey(sid);
	}


	public int insert(SysParameterType record) {
		return this.sysParameterTypeMapper.insert(record);
	}


	public int updateByPrimaryKeySelective(SysParameterType record) {
		return this.sysParameterTypeMapper.updateByPrimaryKeySelective(record);
	}


	@Override
	public List<SysParameterType> selectByCode(String code) {
		return this.sysParameterTypeMapper.selectByCode(code);
	}

}
