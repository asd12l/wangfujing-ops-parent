/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.service.implTRuleNewChannelServiceImpl.java
 * @Create By Administrator
 * @Create In 2013-5-28 下午2:22:18
 * TODO
 */
package com.wangfj.back.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.framework.page.Paginator;
import com.framework.returnObj.Infos;
import com.wangfj.back.entity.cond.TRuleNewChannelCond;
import com.wangfj.back.entity.vo.TRuleNewChannelVO;
import com.wangfj.back.mapper.TRuleNewChannelMapper;
import com.wangfj.back.service.ITRuleNewChannelService;

/**
 * @Class Name TRuleNewChannelServiceImpl
 * @Author Administrator
 * @Create In 2013-5-28
 */

@Service(value="truleNewChannelService")
public class TRuleNewChannelServiceImpl implements ITRuleNewChannelService {

	@Autowired
	TRuleNewChannelMapper truleNewChannelMapper;
	
	public TRuleNewChannelVO findObjBySid(Infos infos, Long sid)
			throws SQLException {
	
		return truleNewChannelMapper.findObjBySid(sid);
	}

	
	public Paginator queryObjs(Infos infos, TRuleNewChannelCond cond)
			throws SQLException {
		Paginator page = new Paginator();
		page.setList(this.truleNewChannelMapper.queryObjsList(cond));
		page.setTotalRecords(this.truleNewChannelMapper.queryObjsCount(cond));
		page.setPage(cond);
		return page;
	}

	
	public void insert(Infos infos, TRuleNewChannelCond cond)
			throws SQLException {
		this.truleNewChannelMapper.insert(cond.getTruleNewChannel());
		
	}

	
	public void update(Infos infos, TRuleNewChannelCond cond)
			throws SQLException {
		this.truleNewChannelMapper.update(cond.getTruleNewChannel());
		
	}

	
	public void delete(Infos infos, Long sid) throws SQLException {
		this.truleNewChannelMapper.delete(sid);
		
	}


	
	public Integer queryMaxOrderNum() {
	 Integer orderNum = this.truleNewChannelMapper.queryMaxOrderNum();
		return orderNum;
	}



	public List<TRuleNewChannelVO> findObjByRuleSid(Integer ruleSid) {
		
		return truleNewChannelMapper.findObjByRuleSid(ruleSid);
	}


	
	public List<TRuleNewChannelVO> findChannels() {
		
		return truleNewChannelMapper.findChannels();
	}


	
	public List<TRuleNewChannelVO> findRuleSid(Integer channelSid) {

		return truleNewChannelMapper.findRuleSid(channelSid);
	}


	public void deleteByRuleSid(Integer ruleSid) {
		this.truleNewChannelMapper.deleteByRuleSid(ruleSid);
	}

}
