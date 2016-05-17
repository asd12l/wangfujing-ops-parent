/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.service.impl.ChannelServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-7-5 下午7:46:45
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.wangfj.wms.domain.entity.Channel;
import com.wangfj.wms.domain.view.ChannelPromotionVO;
import com.wangfj.wms.persistence.ChannelMapper;
import com.wangfj.wms.service.IChannelService;


/**
 * @Class Name ChannelServiceImpl
 * @Author chengsj
 * @Create In 2013-7-5
 */
@Component("channelService")
@Scope("prototype")
@Transactional
public class ChannelServiceImpl implements IChannelService {

	@Autowired
	ChannelMapper channelMapper;

	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.channelMapper.deleteByPrimaryKey(sid);
	}

	@Override
	public int insert(Channel record) {
		// TODO Auto-generated method stub
		return this.channelMapper.insert(record);
	}

	public int insertSelective(Channel record) {
		// TODO Auto-generated method stub
		return this.channelMapper.insertSelective(record);
	}

	@Override
	public Channel selectByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.channelMapper.selectByPrimaryKey(sid);
	}

	@Override
	public int updateByPrimaryKeySelective(Channel record) {
		// TODO Auto-generated method stub
		return this.channelMapper.updateByPrimaryKeySelective(record);
	}

	@Override
	public int updateByPrimaryKey(Channel record) {
		// TODO Auto-generated method stub
		return this.channelMapper.updateByPrimaryKey(record);
	}

	@Override
	public List selectAllChannles() {
		// TODO Auto-generated method stub
		return this.channelMapper.selectAllChannels();
	}

	@Override
	public List selectChannelsBySid(List<Long> sids) {
		return this.channelMapper.selectChannelsBySid(sids);
	}

	@Override
	public List selectOthers(List<Long> sids) {
		return this.channelMapper.selectOthers(sids);
	}

	@Override
	public List<Integer> queryPromotionByChannelSid(Integer sid) {
		// TODO Auto-generated method stub
		return this.channelMapper.queryPromotionByChannelSid(sid);
	}

	@Override
	public int saveChannelPromotion(ChannelPromotionVO vo) {
		// TODO Auto-generated method stub
		return this.channelMapper.saveChannelPromotion(vo);
	}

	@Override
	public int delPeomotion(ChannelPromotionVO vo) {
		// TODO Auto-generated method stub
		return this.channelMapper.delPeomotion(vo);
	}

	@Override
	public int savePromotionBatch(Integer channelSid, String[] promotionsids) {
		for (int i = 0; i < promotionsids.length; i++) {
			ChannelPromotionVO vo = new ChannelPromotionVO();
			vo.setShopChannelSid(channelSid);
			vo.setPromotionSid(Integer.valueOf(promotionsids[i]));
			this.saveChannelPromotion(vo);
		}
		return 0;
	}

}
