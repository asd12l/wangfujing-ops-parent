package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.LeaveMessage;
import com.wangfj.wms.domain.view.LeaveMessageVO;

@WangfjMysqlMapper
public interface LeaveMessageMapper {
    int deleteByPrimaryKey(Integer msgid);

    int insert(LeaveMessage record);

    int insertSelective(LeaveMessage record);

    LeaveMessage selectByPrimaryKey(Integer msgid);

    int updateByPrimaryKeySelective(LeaveMessage record);

    int updateByPrimaryKey(LeaveMessage record);
    
    List<LeaveMessage> selectByParms(LeaveMessageVO record);
    
    int selectPageCount(LeaveMessageVO record);
}