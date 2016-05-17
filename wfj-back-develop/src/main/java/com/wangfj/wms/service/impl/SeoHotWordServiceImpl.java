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

import com.wangfj.wms.domain.entity.SeoHotWord;
import com.wangfj.wms.persistence.SeoHotWordMapper;
import com.wangfj.wms.service.ISeoHotWordService;


/**
 * @Class Name SeoBrandServiceImpl
 * @Author chengsj
 * @Create In 2014-6-30
 */
@Service(value="seoHotWordService")
public class SeoHotWordServiceImpl implements ISeoHotWordService {
    @Autowired
    SeoHotWordMapper seoHotWordMapper;
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.seoHotWordMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(SeoHotWord record) {
		// TODO Auto-generated method stub
		return this.seoHotWordMapper.insert(record);
	}

	@Override
	public int insertSelective(SeoHotWord record) {
		// TODO Auto-generated method stub
		return this.seoHotWordMapper.insertSelective(record);
	}

	@Override
	public SeoHotWord selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.seoHotWordMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(SeoHotWord record) {
		// TODO Auto-generated method stub
		return this.seoHotWordMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(SeoHotWord record) {
		// TODO Auto-generated method stub
		return this.seoHotWordMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<SeoHotWord> queryAllHotWord() {
		// TODO Auto-generated method stub
		return this.seoHotWordMapper.queryAllHotWord();
	}

	@Override
	public int selectCountByHotName(String hotName) {
		// TODO Auto-generated method stub
		return this.seoHotWordMapper.selectCountByHotName(hotName);		
	}
	
}
