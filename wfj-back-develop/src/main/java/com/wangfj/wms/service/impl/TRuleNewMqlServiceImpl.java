/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implTRuleNewMqlServiceImpl.java
 * @Create By Administrator
 * @Create In 2013-9-18 上午11:05:14
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wangfj.wms.domain.entity.TRuleNewMql;
import com.wangfj.wms.persistence.TRuleNewMqlMapper;
import com.wangfj.wms.service.ITRuleNewMqlService;

/**
 * @Class Name TRuleNewMqlServiceImpl
 * @Author Administrator
 * @Create In 2013-9-18
 */
@Service(value="truleNewMqlService")
public class TRuleNewMqlServiceImpl implements ITRuleNewMqlService{
	@Autowired
	private TRuleNewMqlMapper truleNewMqlMapper;

	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.truleNewMqlMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(TRuleNewMql record) {
		// TODO Auto-generated method stub
		return this.truleNewMqlMapper.insert(record);
	}

	@Override
	public int insertSelective(TRuleNewMql record) {
		// TODO Auto-generated method stub
		return this.truleNewMqlMapper.insertSelective(record);
	}

	@Override
	public TRuleNewMql selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.truleNewMqlMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(TRuleNewMql record) {
		// TODO Auto-generated method stub
		return this.truleNewMqlMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(TRuleNewMql record) {
		// TODO Auto-generated method stub
		return this.truleNewMqlMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<TRuleNewMql> findAllRules() {
		// TODO Auto-generated method stub
		return this.truleNewMqlMapper.findAllRules();
	}

	@Override
	public Integer queryMaxSidNum() {
		// TODO Auto-generated method stub
		Integer num = this.truleNewMqlMapper.queryMaxSidNum();
		return num;
	}

}
