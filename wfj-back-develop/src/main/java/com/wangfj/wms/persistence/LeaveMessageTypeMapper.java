package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.LeaveMessageType;


@WangfjMysqlMapper
public interface LeaveMessageTypeMapper {
    int deleteByPrimaryKey(Integer tid);

    int insert(LeaveMessageType record);

    int insertSelective(LeaveMessageType record);

    LeaveMessageType selectByPrimaryKey(Integer tid);

    int updateByPrimaryKeySelective(LeaveMessageType record);

    int updateByPrimaryKey(LeaveMessageType record);
    
    List selectByPid(Integer pid);
    
    List selectList(LeaveMessageType record);
    
    /**
     * 说明：
     * 		根据父类id获取留言类型（后台管理模块）
     * @Methods Name selectByParentId
     * @Create In 2013-12-2 By chengsj
     * @param pid
     * @return List<LeaveMessageType>
     */
    List<LeaveMessageType> selectByParentId(Integer pid);
    

}