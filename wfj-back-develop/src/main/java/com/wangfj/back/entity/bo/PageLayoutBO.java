
package com.wangfj.back.entity.bo;
import java.lang.reflect.InvocationTargetException;

import org.apache.commons.beanutils.BeanUtils;

import com.wangfj.back.entity.cond.PageLayoutCond;
import com.wangfj.back.entity.po.PageLayout;
/**
 * desc   : 页面展示表 业务对象
 * author : chengsj
 * data   : 2013-05-09
 * 
 **/

public class PageLayoutBO {
	public static void Con2Po(PageLayoutCond cond,PageLayout pageLayout){
		try {
			BeanUtils.copyProperties(pageLayout, cond);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
	
	public static void Po2Con(PageLayout pageLayout,PageLayoutCond cond){
		try {
			BeanUtils.copyProperties(cond,pageLayout);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
	}
}
