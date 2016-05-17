/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceILeaveMessageService.java
 * @Create By chengsj
 * @Create In 2013-8-14 下午5:31:39
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.LeaveMessage;
import com.wangfj.wms.domain.view.LeaveMessageVO;




/**
 * @Class Name ILeaveMessageService
 * @Author chengsj
 * @Create In 2013-8-14
 */
public interface ILeaveMessageService {
	
    int deleteByPrimaryKey(Integer msgid);

    int insert(LeaveMessage record);

    int insertSelective(LeaveMessage record);

    LeaveMessage selectByPrimaryKey(Integer msgid);

    int updateByPrimaryKeySelective(LeaveMessage record);

    int updateByPrimaryKey(LeaveMessage record);
    /**
     * 说明：
     * 		多条件检索留言
     * @Methods Name selectByParms
     * @Create In 2013-8-15 By chengsj
     * @param record
     * @return List<LeaveMessage>
     */
    List<LeaveMessage> selectByParms(LeaveMessageVO record);
    
    int selectPageCount(LeaveMessageVO record);
}
