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

import com.wangfj.wms.domain.entity.SeoLongKeyword;
import com.wangfj.wms.persistence.SeoLongKeywordMapper;
import com.wangfj.wms.service.ISeoLongKeywordService;


/**
 * @Class Name SeoBrandServiceImpl
 * @Author chengsj
 * @Create In 2014-6-30
 */
@Service(value="seoLongKeywordService")
public class SeoLongKeywordServiceImpl implements ISeoLongKeywordService {
    @Autowired
    SeoLongKeywordMapper seoLongKeywordMapper;
  
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.seoLongKeywordMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(SeoLongKeyword record) {
		// TODO Auto-generated method stub
		return this.seoLongKeywordMapper.insert(record);
	}

	@Override
	public int insertSelective(SeoLongKeyword record) {
		// TODO Auto-generated method stub
		return this.seoLongKeywordMapper.insertSelective(record);
	}

	@Override
	public SeoLongKeyword selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.seoLongKeywordMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(SeoLongKeyword record) {
		// TODO Auto-generated method stub
		return this.seoLongKeywordMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(SeoLongKeyword record) {
		// TODO Auto-generated method stub
		return this.seoLongKeywordMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<SeoLongKeyword> queryAllLongkey() {
		// TODO Auto-generated method stub
		return this.seoLongKeywordMapper.queryAllLongkey();
	}

	@Override
	public int selectCountByLongName(String longName) {
		// TODO Auto-generated method stub
		return this.seoLongKeywordMapper.selectCountByLongName(longName);
	}}
