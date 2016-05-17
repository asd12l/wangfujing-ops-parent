/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.entity.boProBestDetailBO.java
 * @Create By chengsj
 * @Create In 2013-5-13 上午10:16:57
 * TODO
 */
package com.wangfj.back.entity.bo;

import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import com.wangfj.back.entity.cond.ProBestDetailCond;
import com.wangfj.back.entity.po.ProBestDetail;


/**
 * @Class Name ProBestDetailBO
 * @Author chengsj
 * @Create In 2013-5-13
 */
public class ProBestDetailBO {
	public static void Con2Po(ProBestDetailCond cond,ProBestDetail proBestDetail){
		try {
			BeanUtils.copyProperties(proBestDetail, cond);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	
	public static void Po2Con(ProBestDetail proBestDetail,ProBestDetailCond cond){
		try {
			BeanUtils.copyProperties(cond,proBestDetail);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}

}
