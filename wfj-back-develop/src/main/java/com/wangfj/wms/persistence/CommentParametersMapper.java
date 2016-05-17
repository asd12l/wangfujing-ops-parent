package com.wangfj.wms.persistence;

import java.util.List;

import com.wangfj.wms.domain.entity.CommentParameters;


public interface CommentParametersMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(CommentParameters record);

    int insertSelective(CommentParameters record);

    CommentParameters selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(CommentParameters record);

    int updateByPrimaryKey(CommentParameters record);
    
    List querytByselective(CommentParameters record);
}