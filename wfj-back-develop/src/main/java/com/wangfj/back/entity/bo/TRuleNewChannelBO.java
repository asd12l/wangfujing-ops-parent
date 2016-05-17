/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.entity.boTRuleNewChannelBO.java
 * @Create By Administrator
 * @Create In 2013-5-28 下午1:26:28
 * TODO
 */
package com.wangfj.back.entity.bo;

import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import com.wangfj.back.entity.cond.TRuleNewChannelCond;
import com.wangfj.back.entity.po.TRuleNewChannel;

/**
 * @Class Name TRuleNewChannelBO
 * @Author Administrator
 * @Create In 2013-5-28
 */
public class TRuleNewChannelBO {
	
	public static void Con2Po(TRuleNewChannelCond cond,TRuleNewChannel truleNewChannel){
		try {
			BeanUtils.copyProperties(truleNewChannel, cond);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	public static void Po2Con(TRuleNewChannel truleNewChannel,TRuleNewChannelCond cond){
		try {
			BeanUtils.copyProperties(cond, truleNewChannel);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}

}
