/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implSeoBrandServiceImpl.java
 * @Create By Rooney
 * @Create In 2014-6-30 下午4:53:47
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wangfj.wms.domain.entity.SeoBrand;
import com.wangfj.wms.persistence.SeoBrandMapper;
import com.wangfj.wms.service.ISeoBrandService;


/**
 * @Class Name SeoBrandServiceImpl
 * @Author chengsj
 * @Create In 2014-6-30
 */
@Service(value="seoBrandService")
public class SeoBrandServiceImpl implements ISeoBrandService {

	@Autowired
	SeoBrandMapper seoBrandMapper;
	
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.seoBrandMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(SeoBrand record) {
		// TODO Auto-generated method stub
		return this.seoBrandMapper.insert(record);
	}

	@Override
	public int insertSelective(SeoBrand record) {
		// TODO Auto-generated method stub
		return this.seoBrandMapper.insertSelective(record);
	}

	@Override
	public SeoBrand selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.seoBrandMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(SeoBrand record) {
		// TODO Auto-generated method stub
		return this.seoBrandMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(SeoBrand record) {
		// TODO Auto-generated method stub
		return this.seoBrandMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<SeoBrand> queryAllBrand() {
		// TODO Auto-generated method stub
		return this.seoBrandMapper.queryAllBrand();
	}

	@Override
	public int selectCountByBrandName(String brandName) {
		// TODO Auto-generated method stub
		return this.seoBrandMapper.selectCountByBrandName(brandName);
	}

}
