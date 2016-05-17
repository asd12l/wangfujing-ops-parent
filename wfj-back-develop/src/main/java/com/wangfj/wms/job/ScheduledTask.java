/**
 * @Probject Name: shopin-back-new
 * @Path: com.wangfj.wms.jobScheduledTask.java
 * @Create By chengsj
 * @Create In 2013-11-26 上午10:01:18
 * TODO
 */
package com.wangfj.wms.job;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


/**
 * @Class Name ScheduledTask
 * @Author chengsj
 * @Create In 2013-11-26
 */
@Component
public class ScheduledTask {
	
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
	
//	@Scheduled(cron = "0 39 10 * * ?")
	public void run(){
		System.out.println("the time is now ++++++++++++++++++++"  + dateFormat.format(new Date()));
	}
	
	
}
