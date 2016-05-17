package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.Comments;
import com.wangfj.wms.persistence.CommentsMapper;
import com.wangfj.wms.service.ICommentsService;


@Service("commentsService")
@Scope("prototype")
@Transactional
public class CommentsServiceImpl implements ICommentsService {
	
	@Autowired
	CommentsMapper commentsMapper;

	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.commentsMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(Comments record) {
		// TODO Auto-generated method stub
		return this.commentsMapper.insert(record);
	}

	@Override
	public int insertSelective(Comments record) {
		// TODO Auto-generated method stub
		return this.commentsMapper.insertSelective(record);
	}

	@Override
	public Comments selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.commentsMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(Comments record) {
		// TODO Auto-generated method stub
		return this.commentsMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Comments record) {
		// TODO Auto-generated method stub
		return this.commentsMapper.updateByPrimaryKey(record);
	}

	@Override
	public List<Comments> getAllComments() {
		// TODO Auto-generated method stub
		return this.commentsMapper.getAllComments();
	}
	
}
