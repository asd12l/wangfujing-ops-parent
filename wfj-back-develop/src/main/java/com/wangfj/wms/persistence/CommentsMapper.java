package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.Comments;


@WangfjMysqlMapper
public interface CommentsMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(Comments record);

    int insertSelective(Comments record);

    Comments selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Comments record);

    int updateByPrimaryKey(Comments record);
    
    List<Comments> getAllComments();
}