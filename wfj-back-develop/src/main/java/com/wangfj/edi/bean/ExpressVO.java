package com.wangfj.edi.bean;

public class ExpressVO {

	private String id ; //主键ID
	private String expressName ; //快递公司名称
	private String expressCode ; //快递公司编码
	private String wfjExpressName ; //王府井快递公司名称
	private String wfjExpressCode ; //王府井快递公司编码
	private Integer status ; //启用状态,1:启用, 0:停用
	private String operaterLoginid ;  //操作人
	
	
	public String getOperaterLoginid() {
		return operaterLoginid;
	}
	public void setOperaterLoginid(String operaterLoginid) {
		this.operaterLoginid = operaterLoginid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getExpressName() {
		return expressName;
	}
	public void setExpressName(String expressName) {
		this.expressName = expressName;
	}
	public String getExpressCode() {
		return expressCode;
	}
	public void setExpressCode(String expressCode) {
		this.expressCode = expressCode;
	}
	public String getWfjExpressName() {
		return wfjExpressName;
	}
	public void setWfjExpressName(String wfjExpressName) {
		this.wfjExpressName = wfjExpressName;
	}
	public String getWfjExpressCode() {
		return wfjExpressCode;
	}
	public void setWfjExpressCode(String wfjExpressCode) {
		this.wfjExpressCode = wfjExpressCode;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
}
