package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.NoticeType;

@WangfjMysqlMapper
public interface NoticeTypeMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(NoticeType record);

    int insertSelective(NoticeType record);

    NoticeType selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(NoticeType record);

    int updateByPrimaryKey(NoticeType record);
    
    /**
     * 说明：
     * 		查询所有公告类型
     * @Methods Name selectAll
     * @Create In 2013-11-18 By chengsj
     * @return List<NoticeType>
     */
    List<NoticeType> selectAll();
    /**
     * 说明：
     * 		根据参数查询公告类型
     * @Methods Name selectByParams
     * @Create In 2013-11-18 By chengsj
     * @return List<NoticeType>
     */
    List<NoticeType> selectByParams(NoticeType record);
}