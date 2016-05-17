/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.impl.NavigationServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-7-22 上午11:38:37
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.Navigation;
import com.wangfj.wms.persistence.NavigationMapper;
import com.wangfj.wms.service.INavigationService;


/**
 * @Class Name NavigationServiceImpl
 * @Author chengsj
 * @Create In 2013-7-22
 */
@Component("navigationService")
@Scope("prototype")
@Transactional
public class NavigationServiceImpl implements INavigationService {

	@Autowired
	NavigationMapper navigationMapper;

	@Override
	public int deleteByPrimaryKey(Long sid) {
		return this.navigationMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(Navigation record) {
		// TODO Auto-generated method stub
		return this.navigationMapper.insert(record);
	}

	@Override
	public int insertSelective(Navigation record) {
		// TODO Auto-generated method stub
		return this.navigationMapper.insertSelective(record);
	}

	@Override
	public Navigation selectByPrimaryKey(Long sid) {
		// TODO Auto-generated method stub
		return this.navigationMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(Navigation record) {
		// TODO Auto-generated method stub
		return this.navigationMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Navigation record) {
		// TODO Auto-generated method stub
		return this.navigationMapper.updateByPrimaryKey(record);
	}

	@Override
	public List selectList(Navigation record) {
		// TODO Auto-generated method stub
		return this.navigationMapper.selectList(record);
	}

	@Override
	public int selectCountBycalssSid(String classSid) {
		// TODO Auto-generated method stub
		return this.navigationMapper.selectCountBycalssSid(classSid);
	}

	

}
