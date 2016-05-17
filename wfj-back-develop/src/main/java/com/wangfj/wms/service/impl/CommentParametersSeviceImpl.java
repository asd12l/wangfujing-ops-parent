package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.CommentParameters;
import com.wangfj.wms.persistence.CommentParametersMapper;
import com.wangfj.wms.service.ICommentParametersSerice;


@Component("commentParametersSevice")
@Scope("prototype")
@Transactional
public class CommentParametersSeviceImpl implements ICommentParametersSerice {

	@Autowired
	private CommentParametersMapper commentParametersMapper;
	
	
	@Override
	public int deleteByPrimaryKey(Integer sid) {
		return this.commentParametersMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(CommentParameters record) {
		return this.commentParametersMapper.insert(record);
	}

	@Override
	public int insertSelective(CommentParameters record) {
		return this.commentParametersMapper.insertSelective(record);
	}

	@Override
	public CommentParameters selectByPrimaryKey(Integer sid) {
		return this.commentParametersMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(CommentParameters record) {
		return this.commentParametersMapper.updateByPrimaryKey(record);
	}

	@Override
	public int updateByPrimaryKey(CommentParameters record) {
		return this.commentParametersMapper.updateByPrimaryKey(record);
	}

	@Override
	public List querytByselective(CommentParameters record) {
		// TODO Auto-generated method stub
		return this.commentParametersMapper.querytByselective(record);
	}

}
