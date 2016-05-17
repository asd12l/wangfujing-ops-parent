/**
 * 说 明     : 
 * author: 陆湘星
 * data  : 2011-8-5
 * email : xiangxingchina@163.com
 **/
package com.framework.testCase;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class LoadApplicationContext {
	public static ApplicationContext context;
	public  void setUp() throws Exception {
		synchronized (this) {
			if(context==null){
				context = new ClassPathXmlApplicationContext("/applicationContext.xml");
			}
		} 
	}
}
