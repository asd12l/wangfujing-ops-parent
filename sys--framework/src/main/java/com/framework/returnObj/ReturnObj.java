/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2012-1-3
 * email : xiangxingchina@163.com
 **/
package com.framework.returnObj;

import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.constants.InfoConstants;

@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public final class ReturnObj {
	private Object data;					//结果对象  -- 多对象则在封装
	private Map<String, Object> dataExt;	//返回对象扩展
	private String code;					//返回消息编码
	private String codeInfo;				//返回消息内容
	private String codeDesc;				//返回编码详细描述
	
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public Map<String, Object> getDataExt() {
		return dataExt;
	}
	public void setDataExt(Map<String, Object> dataExt) {
		this.dataExt = dataExt;
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
	public void setCodeResult(String code,String codeInfo) {
		this.code = code;
		this.codeInfo = codeInfo;
	}
	public void setDataExt(String key,Object value){
		if(dataExt == null) dataExt = new HashMap<String, Object>();
		dataExt.put(key, value);
	}
	public void setCode(String code,String codeInfo,String msg) {
		setCode(code, codeInfo);
		this.codeDesc = msg;
	}
	
	public void setCode(String code,String codeInfo) {
		if(code==null||"".equals(code)){
			this.code = InfoConstants.CodeInfo.操作成功.getCode();
			this.codeInfo = InfoConstants.CodeInfo.操作成功.getCodeInfo();
		} else{
			this.code = code;
			this.codeInfo = codeInfo;	
		}
	}
	
	public String getCodeDesc() {
		return codeDesc;
	}
	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}
	
}
