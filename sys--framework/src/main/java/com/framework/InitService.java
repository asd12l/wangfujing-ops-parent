package com.framework;
/**
 * desc   : 初始service
 * author : luxiangxing
 * data   : 2013-2-17
 * email  : xiangxingchina@163.com
 **/
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;





import org.springframework.beans.BeansException;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.constants.SystemConfig;

public class InitService  extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doGet(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		super.doPost(request, response);
	}

	@Override
	public void init() throws ServletException {
		initCron();
	}
	
	/**
	 * 部署为任务机
	 * 初始化任务配置文件
	 */
	private void initCron() throws BeansException{
		String deploy = SystemConfig.SYSTEM_PROPERTIES_DEPLOYTYPE_VALUE;
		if(deploy.equals(String.valueOf(SystemConfig.SYSTEM_PROPERTIES_CRONTYPE_VALUE))){//加载任务机制
			 new ClassPathXmlApplicationContext(SystemConfig.CRON_CONFIG_FILE_NAME);
		}
	}
	
	
}
