/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.entity.boShopChannelsBO.java
 * @Create By chengsj
 * @Create In 2013-5-9 下午4:33:56
 * TODO
 */
package com.wangfj.back.entity.bo;

import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import com.wangfj.back.entity.cond.ShopChannelsCond;
import com.wangfj.back.entity.po.ShopChannels;

/**
 * @Class Name ShopChannelsBO
 * @Author chengsj
 * @Create In 2013-5-9
 */
public class ShopChannelsBO {
	
	public static void Con2Po(ShopChannelsCond cond,ShopChannels shopChannels){
		try {
			BeanUtils.copyProperties(shopChannels, cond);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	
	public static void Po2Con(ShopChannels shopChannels,ShopChannelsCond cond){
		try {
			BeanUtils.copyProperties(cond,shopChannels);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
}
