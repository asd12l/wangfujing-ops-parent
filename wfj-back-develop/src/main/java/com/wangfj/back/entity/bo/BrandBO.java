/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.entity.boBrandBO.java
 * @Create By chengsj
 * @Create In 2013-5-13 上午10:12:18
 * TODO
 */
package com.wangfj.back.entity.bo;

import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import com.wangfj.back.entity.cond.BrandCond;
import com.wangfj.back.entity.po.Brand;

/**
 * @Class Name BrandBO
 * @Author chengsj
 * @Create In 2013-5-13
 */
public class BrandBO {
	
	public static void Con2Po(BrandCond cond,Brand brand){
		try {
			BeanUtils.copyProperties(brand, cond);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	public static void Po2Con(Brand brand,BrandCond cond){
		try {
			BeanUtils.copyProperties(cond, brand);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
}
