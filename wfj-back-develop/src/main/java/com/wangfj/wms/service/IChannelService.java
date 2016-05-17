/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.serviceIShopChannelService.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午3:51:24
 * TODO
 */
package com.wangfj.wms.service;

import java.util.List;

import com.wangfj.wms.domain.entity.Channel;
import com.wangfj.wms.domain.view.ChannelPromotionVO;



/**
 * @Class Name IShopChannelService
 * @Author chengsj
 * @Create In 2013-7-5
 */
public interface IChannelService {

	int deleteByPrimaryKey(Integer sid);

    int insert(Channel record);

    int insertSelective(Channel record);

    Channel selectByPrimaryKey(Integer sid);

    int updateByPrimaryKeySelective(Channel record);

    int updateByPrimaryKey(Channel record);
    
    List selectAllChannles();
    
    List selectChannelsBySid(List<Long> sids);
    
    List selectOthers(List<Long> sids);
    
    List<Integer> queryPromotionByChannelSid(Integer sid);
    
	int saveChannelPromotion(ChannelPromotionVO vo);
	
	int savePromotionBatch(Integer channelSid,String[] promotionsids);
	
	int delPeomotion(ChannelPromotionVO vo);
}
