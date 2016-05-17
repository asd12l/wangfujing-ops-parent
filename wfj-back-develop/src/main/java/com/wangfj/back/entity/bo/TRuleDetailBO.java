/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.entity.boTRuleDetailBO.java
 * @Create By chengsj
 * @Create In 2013-6-24 下午1:59:55
 * TODO
 */
package com.wangfj.back.entity.bo;

import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import com.wangfj.back.entity.cond.TRuleDetailCond;
import com.wangfj.back.entity.po.TRuleDetail;

/**
 * @Class Name TRuleDetailBO
 * @Author chengsj
 * @Create In 2013-6-24
 */
public class TRuleDetailBO {
	

	
	public static void Con2Po(TRuleDetailCond cond,TRuleDetail truleDetail){
		try {
			BeanUtils.copyProperties(truleDetail, cond);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	public static void Po2Con(TRuleDetail truleDetail,TRuleDetailCond cond){
		try {
			BeanUtils.copyProperties(cond, truleDetail);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}

}
