package com.framework.returnObj;
/**
 * 说 明     : 传递信息
 * author: 陆湘星
 * data  : 2012-12-13
 * email : xiangxingchina@163.com
 **/
public class Info {
	private String code;
	private String codeInfo;
	private String codeDesc;
	public Info(String code,String codeInfo) {
		this.code = code;
		this.codeInfo = codeInfo;
	}
	public Info(String code,String codeInfo,String codeDesc) {
		this.code = code;
		this.codeInfo = codeInfo;
		this.codeDesc = codeDesc;
	}
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
	public String getCodeDesc() {
		return codeDesc;
	}
	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}
	
	
}
