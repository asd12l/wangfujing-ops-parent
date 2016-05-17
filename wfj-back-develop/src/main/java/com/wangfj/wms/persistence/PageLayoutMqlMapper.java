package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.PageLayoutMql;


@WangfjMysqlMapper
public interface PageLayoutMqlMapper {
	int deleteByPrimaryKey(Integer sid);

	int insert(PageLayoutMql record);

	int insertSelective(PageLayoutMql record);

	PageLayoutMql selectByPrimaryKey(Integer sid);

	int updateByPrimaryKeySelective(PageLayoutMql record);

	int updateByPrimaryKey(PageLayoutMql record);

	int queryObjsCount(PageLayoutMql record);

	List queryBySelective(Integer channelSid);
	
	List queryByPrimaryKeySelective(PageLayoutMql record);

	int queryMaxSid();
	
	int queryMaxSeqByPageLayoutSid(Integer pageLayoutSid);
	
	int queryCountByPageLayoutSid(Integer pageLayoutSid);

	List queryChildPageLayout(Long pageLayoutSid);
}