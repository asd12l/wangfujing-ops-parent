package com.wangfj.wms.persistence;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.NavContent;


@WangfjMysqlMapper
public interface NavContentMapper {
	int deleteByPrimaryKey(Long sid);

	int insert(NavContent record);

	int insertSelective(NavContent record);

	NavContent selectByPrimaryKey(Long sid);

	int updateByPrimaryKeySelective(NavContent record);

	int updateByPrimaryKey(NavContent record);
}