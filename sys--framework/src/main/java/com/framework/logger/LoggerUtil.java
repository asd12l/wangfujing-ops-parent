package com.framework.logger;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;

import com.constants.InfoConstants.DebugType;
import com.constants.SystemConfig;
import com.elong.api.ELogger;
import com.utils.DateUtils;

/**
 * 说 明     : 日志工具类
 * author: 陆湘星
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 **/
public class LoggerUtil {
	public static final String LOG_FILE_COMMON_LOG = "commonLog";				//普通日志
	public static final String LOG_FILE_EXCEPTION_LOG = "exceptionLog";			//异常日志
	
	private String baseMessage; // 存储类路径
	private String condMessage; // 存储条件对象
	private static int debug_level = 0;
	ELogger commonlog = null ;
	ELogger exceptionLog = null ;
	private LoggerUtil(String baseMessage) {
		this.baseMessage = baseMessage;
		commonlog = ELogger.getLogger("commonlog",this.getClass().getName(),false);
		exceptionLog = ELogger.getLogger("exceptionLog",this.getClass().getName(),false);
	}
	private LoggerUtil(String baseMessage,String condMessage) {
		this.baseMessage = baseMessage;
		this.condMessage = condMessage;
		commonlog = ELogger.getLogger("commonlog",this.getClass().getName(),false);
		exceptionLog = ELogger.getLogger("exceptionLog",this.getClass().getName(),false);
	}
	public static LoggerUtil getLogger(String baseMessage) {
		if (debug_level == 0) {
			String debug = SystemConfig.SYSTEM_PROPERTIES_DEBUG_LEVEL_VALUE;
			if (debug != null) {
				try {
					debug_level = Integer.valueOf(debug);
				} catch (Exception e) {
				}
			}
		}
		return new LoggerUtil(baseMessage);
	}

	public static LoggerUtil getLogger(String baseMessage, String condMessage) {
		if (debug_level == 0) {
			String debug = SystemConfig.SYSTEM_PROPERTIES_DEBUG_LEVEL_VALUE;
			if (debug != null) {
				try {
					debug_level = Integer.valueOf(debug);
				} catch (Exception e) {
				}
			}
		}
		return new LoggerUtil(baseMessage, condMessage);
	}
	
   public String getMessage(){
		StringBuffer msg = new StringBuffer();
		if(baseMessage!=null )msg.append("\r\n").append("["+baseMessage+"]");
		if(condMessage!=null) msg.append("\r\n").append("["+condMessage+"]");
		return msg.toString();
	}
	
   public  void  printResultInfo(String info,String resultJson,Date start){
	   if(debug_level<DebugType.nolog.getValue()){
		   StringBuffer infoStr = new StringBuffer();
		   infoStr.append(getMessage()).append("\r\n");
		   if(info!=null && info.length()>0)  infoStr.append("\r\n" + info)   ;
		    if(debug_level<=DebugType.debug.getValue()) {
				  int len =  0;
				  if(resultJson!=null) len = resultJson.toString().length();
				  infoStr.append("return len : "+len +"  return json : " + resultJson );
			  }			  
			 String useTime = DateUtils.PrintTimeGap("", start, new Date());
			 infoStr.append(useTime);
			 printLog(infoStr.toString());
	   }
   }
   
   public  void  printException(String msg,Throwable e,Date start){
	   	if(debug_level<=DebugType.exception.getValue()){
	   		StringBuffer infoStr = new StringBuffer();
		   infoStr.append(getMessage()).append("\r\n");
		   if(msg!=null && msg.length()>0)  infoStr.append("\r\n" + msg)   ;
			 String useTime = DateUtils.PrintTimeGap("", start, new Date());
			infoStr.append(useTime);
	   		exceptionLog.error(infoStr.toString(), e);
	   	}
   }
	   
	   
   public  void  printLog(String msg){
	   if(msg!=null){
		   commonlog.info(msg);
	   }
   }
   
   
	 //--私有方法
	private  String getTrace(Throwable t) {
	        StringWriter stringWriter= new StringWriter();
	        PrintWriter writer= new PrintWriter(stringWriter);
	        t.printStackTrace(writer);
	        StringBuffer buffer= stringWriter.getBuffer();
	        return buffer.toString();
	}
}
