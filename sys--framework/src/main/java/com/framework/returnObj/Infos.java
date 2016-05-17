package com.framework.returnObj;

import java.util.Date;

import com.constants.InfoConstants.CodeInfo;
import com.framework.AbstractCondtion;
import com.framework.logger.LoggerUtil;
import com.utils.JsonUtil;

/**
 * 说 明     : 信息实体对象
 * author: 陆湘星
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 **/
public class Infos {
	//--------------集成日志信息
	LoggerUtil logger  = null;
	private String fromUrl;
	private String action;
	private String method ;
	private Date  start;
	private AbstractCondtion cond;
	private String code;
	private String codeInfo;
	private ReturnObj returnObj;

	public Infos(String fromUrl,String action,String method,AbstractCondtion cond){
		this.fromUrl = fromUrl;
		this.action=action;
		this.method=method;
		this.cond = cond;
		start = new Date();
		logger = LoggerUtil.getLogger("fromUrl = "+fromUrl+" action = "+ action + " method = " +method,cond.toString());
		returnObj = new ReturnObj();
	}
	public Infos(String fromUrl,String action,String method,String condStr){
		this.fromUrl = fromUrl;
		this.action=action;
		this.method=method;
		start = new Date();
		logger = LoggerUtil.getLogger("fromUrl = "+fromUrl+" action = "+ action + " method = " +method,condStr);
		returnObj = new ReturnObj();
	}
	
	public void setReturnObj(Object data){
		if(data!=null) returnObj.setData(data);
	}
	
	public String getReturnJson(){
		if(info==null) info = new Info(CodeInfo.操作成功.getCode(), CodeInfo.操作成功.getCodeInfo());
		returnObj.setCode(info.getCode(), info.getCodeInfo(),info.getCodeDesc());
		String JsonStr = "";
		if(this.returnObj.getData() instanceof String){JsonStr = (String)this.returnObj.getData();}
		else JsonStr = JsonUtil.Object2Json(this.returnObj);
		doLogPrint(JsonStr);
		return JsonStr;
	}
	/***************集成日志 *********************/
	private StringBuffer loggerBuffer = new StringBuffer();
	private Info info = null; 
	/***************集成日志 *********************/
	/*
	 * @return
	 */
	public LoggerUtil getLogger() {
		return logger;
	}

	public void setLogger(LoggerUtil logger) {
		this.logger = logger;
	}

	public String getFromUrl() {
		return fromUrl;
	}

	public void setFromUrl(String fromUrl) {
		this.fromUrl = fromUrl;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	};

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}


	public String getCodeInfo() {
		return codeInfo;
	}

	public void setCodeInfo(String codeInfo) {
		this.codeInfo = codeInfo;
	}

	public Info getInfo() {
		return info;
	}

	public void setInfo(Info info) {
		this.info = info;
	}


	public void printLogInfo(CodeInfo codeInfo){
		printLogInfo(codeInfo, "");
	}
	public void printLogInfo(CodeInfo codeInfo,String msg){
		String logInfoBase =  codeInfo.getCode()+" "+ codeInfo.getCodeInfo();
		if(msg!=null && !"".equals(msg) && msg.length()>0) logInfoBase+=" "+msg.trim();
		loggerBuffer.append(logInfoBase).append("\r\n");
		info = new Info(codeInfo.getCode(),codeInfo.getCodeInfo(),msg.trim());
	}
	public void printLogExceptionLog(CodeInfo codeInfo,Throwable e){
		printLogExceptionLog(codeInfo, "", e);
	}
	public void printLogExceptionLog(CodeInfo codeInfo,String msg,Throwable e){
		String logInfoBase =  codeInfo.getCode()+" "+ codeInfo.getCodeInfo();
		if(msg!=null && !"".equals(msg) && msg.length()>0) logInfoBase+=""+msg.trim();
		loggerBuffer.append(logInfoBase).append("\r\n");
		info = new Info(codeInfo.getCode(),codeInfo.getCodeInfo(),msg.trim());
		logger.printException(loggerBuffer.toString(), e,start);
	}
	
	//打印基本信息
	public  void  doLogPrint(String objJson){
		logger.printResultInfo(loggerBuffer.toString(),objJson, start);
	}

	public AbstractCondtion getCond() {
		return cond;
	}

	public void setCond(AbstractCondtion cond) {
		this.cond = cond;
	}
	
	
}
