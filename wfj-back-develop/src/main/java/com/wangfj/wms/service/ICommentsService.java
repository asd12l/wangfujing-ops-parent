package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.Comments;



public interface ICommentsService {
    int deleteByPrimaryKey(Integer sid);

    int insert(Comments record);

    int insertSelective(Comments record);

    Comments selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Comments record);

    int updateByPrimaryKey(Comments record);
    
    List<Comments> getAllComments();
	
	 
	
}
