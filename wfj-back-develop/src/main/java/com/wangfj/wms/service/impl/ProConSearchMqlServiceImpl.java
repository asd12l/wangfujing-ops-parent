/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.impl.ProConSearchMqlServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-9-16 下午2:09:11
 * TODO
 */
package com.wangfj.wms.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.back.view.ProductKey;
import com.wangfj.wms.domain.entity.ProConSearchMql;
import com.wangfj.wms.persistence.ProConSearchMqlMapper;
import com.wangfj.wms.service.IProConSearchMqlService;


/**
 * @Class Name ProConSearchMqlServiceImpl
 * @Author chengsj
 * @Create In 2013-9-16
 */
@Component("proConSearchMqlService")
@Scope("prototype")
@Transactional
public class ProConSearchMqlServiceImpl implements IProConSearchMqlService {

	@Autowired
	ProConSearchMqlMapper proConSearchMapper;

	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.proConSearchMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(ProConSearchMql record) {
		// TODO Auto-generated method stub
		return this.proConSearchMapper.insert(record);
	}

	@Override
	public int insertSelective(ProConSearchMql record) {
		// TODO Auto-generated method stub
		return this.proConSearchMapper.insertSelective(record);
	}

	@Override
	public ProConSearchMql selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.proConSearchMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(ProConSearchMql record) {
		// TODO Auto-generated method stub
		return this.proConSearchMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(ProConSearchMql record) {
		// TODO Auto-generated method stub
		return this.proConSearchMapper.updateByPrimaryKey(record);
	}

	@Override
	public void updateProConSearch(ProductKey productKey) {
		this.updateProConSearch(productKey);

	}

}
