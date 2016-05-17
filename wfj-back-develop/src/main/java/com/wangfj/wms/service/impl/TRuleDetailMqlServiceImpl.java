/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.implTRuleDetailMqlServiceImpl.java
 * @Create By Administrator
 * @Create In 2013-9-22 上午11:25:51
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wangfj.wms.domain.entity.TRuleDetailMql;
import com.wangfj.wms.persistence.TRuleDetailMqlMapper;
import com.wangfj.wms.service.ITRuleDetailMqlService;


/**
 * @Class Name TRuleDetailMqlServiceImpl
 * @Author Administrator
 * @Create In 2013-9-22
 */
@Service(value="truleDetailMqlService")
public class TRuleDetailMqlServiceImpl implements ITRuleDetailMqlService {
	@Autowired
	private TRuleDetailMqlMapper truleDetailMqlMapper;
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.truleDetailMqlMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(TRuleDetailMql record) {
		// TODO Auto-generated method stub
		return this.truleDetailMqlMapper.insert(record);
	}

	@Override
	public int insertSelective(TRuleDetailMql record) {
		// TODO Auto-generated method stub
		return this.truleDetailMqlMapper.insertSelective(record);
	}

	@Override
	public TRuleDetailMql selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.truleDetailMqlMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(TRuleDetailMql record) {
		// TODO Auto-generated method stub
		return this.truleDetailMqlMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(TRuleDetailMql record) {
		// TODO Auto-generated method stub
		return this.truleDetailMqlMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<TRuleDetailMql> findDetails(Integer ruleSid) {
		// TODO Auto-generated method stub
		return  this.truleDetailMqlMapper.findObjByRuleSid(ruleSid);
	}

}
