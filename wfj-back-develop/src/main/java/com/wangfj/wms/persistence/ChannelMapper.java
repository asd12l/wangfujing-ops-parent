package com.wangfj.wms.persistence;

import java.util.List;

import com.framework.persistence.WangfjMysqlMapper;
import com.wangfj.wms.domain.entity.Channel;
import com.wangfj.wms.domain.view.ChannelPromotionVO;

@WangfjMysqlMapper
public interface ChannelMapper {
    int deleteByPrimaryKey(Integer sid);

    int insert(Channel record);

    int insertSelective(Channel record);

    Channel selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Channel record);

    int updateByPrimaryKey(Channel record);
    
    List selectAllChannels();
    
    List selectChannelsBySid(List<Long> sids);
    
    List selectOthers(List<Long> sids);
    
    int queryObjsCount(Channel record);
    
    List queryPromotionByChannelSid(Integer sid);
    
    int saveChannelPromotion(ChannelPromotionVO vo);
    
    int delPeomotion(ChannelPromotionVO vo);
}