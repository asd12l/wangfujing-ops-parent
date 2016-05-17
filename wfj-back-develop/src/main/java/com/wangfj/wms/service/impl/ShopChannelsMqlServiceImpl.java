/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.service.implRuleChannelServiceImpl.java
 * @Create By chengsj
 * @Create In 2013-6-19 上午9:51:00
 * TODO
 */
package com.wangfj.wms.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wangfj.wms.domain.entity.PageLayoutMql;
import com.wangfj.wms.domain.entity.PageTemplate;
import com.wangfj.wms.domain.entity.ShopChannelsMql;
import com.wangfj.wms.persistence.PageLayoutMqlMapper;
import com.wangfj.wms.persistence.PageTemplateMapper;
import com.wangfj.wms.persistence.ShopChannelsMqlMapper;
import com.wangfj.wms.service.IShopChannelsMqlService;


/**
 * @Class Name RuleChannelServiceImpl
 * @Author chengsj
 * @Create In 2013-6-19
 */
@Service(value="shopChannelsMqlService")
public class ShopChannelsMqlServiceImpl implements IShopChannelsMqlService{
	
	
	@Autowired
	ShopChannelsMqlMapper shopChanelsMapper;
	@Autowired
	PageTemplateMapper pageTemplateMapper;
	@Autowired
	PageLayoutMqlMapper pageLayoutMapper;
	
	

	@Override
	public List<ShopChannelsMql> findChannels() throws SQLException {
		List<ShopChannelsMql> list=new ArrayList<ShopChannelsMql>();
		list=shopChanelsMapper.findAllChannels();
		return list;
	}




	@Override
	public int saveShopChannels(ShopChannelsMql shopChannelsMql) {
		try {
			PageTemplate pageTem = new PageTemplate();
			//获取模板
			pageTem=this.pageTemplateMapper.selectByPrimaryKey(shopChannelsMql.getPageTemplateSid());
			shopChannelsMql.setChannelUrl(pageTem.getPage()+".html");
			//创建频道模板
			this.shopChanelsMapper.insertSelective(shopChannelsMql);
			
			//相关主表：page_layout表 插入第一个栏目内容（有效的）
			int channelSid=this.shopChanelsMapper.getMaxSid();
			PageLayoutMql pageLayoutMql = new PageLayoutMql();
			pageLayoutMql.setPageType(1);//生效
	        pageLayoutMql.setNodeLevel(0);
	        pageLayoutMql.setTitle("频道: " + shopChannelsMql.getName());
	        pageLayoutMql.setChannelSid(channelSid);
	        pageLayoutMql.setNodeLevel(0);
	        this.pageLayoutMapper.insertSelective(pageLayoutMql);
	        int pageLayoutSid = this.pageLayoutMapper.queryMaxSid();
	        
	        //插入第二个栏目内容（无效的）
	        pageLayoutMql = new PageLayoutMql();
			pageLayoutMql.setPageType(0);//生效
	        pageLayoutMql.setNodeLevel(0);
	        pageLayoutMql.setTitle("频道: " + shopChannelsMql.getName());
	        pageLayoutMql.setChannelSid(channelSid);
	        pageLayoutMql.setNodeLevel(0);
	        this.pageLayoutMapper.insertSelective(pageLayoutMql);
	        
	        //更新得到pageLayoutSid后的频道表
	        shopChannelsMql.setPageLayoutSid(pageLayoutSid);
	        shopChannelsMql.setSid(channelSid);
	       return this.shopChanelsMapper.updateByPrimaryKeySelective(shopChannelsMql);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
	}




	@Override
	public int updateShopChannels(ShopChannelsMql shopChannelsMql) {
		// TODO Auto-generated method stub
		return this.shopChanelsMapper.updateByPrimaryKeySelective(shopChannelsMql);
	}




	@Override
	public int deleteByPrimaryKey(Integer sid) {
		// TODO Auto-generated method stub
		return this.shopChanelsMapper.deleteByPrimaryKey(sid);
	}







	
}
