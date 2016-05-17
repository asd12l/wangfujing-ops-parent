package com.wangfj.edi.bean;

public class AddressVO {

	private String id ; //主键ID
	private String addressName ; //快递公司名称
	private String addressCode ; //快递公司编码
	private String wfjAddressName ; //王府井快递公司名称
	private String wfjAddressCode ; //王府井快递公司编码
	private Integer status ; //启用状态,1:启用, 0:停用
	private String operaterLoginid ;  //操作人
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAddressName() {
		return addressName;
	}
	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}
	public String getAddressCode() {
		return addressCode;
	}
	public void setAddressCode(String addressCode) {
		this.addressCode = addressCode;
	}
	public String getWfjAddressName() {
		return wfjAddressName;
	}
	public void setWfjAddressName(String wfjAddressName) {
		this.wfjAddressName = wfjAddressName;
	}
	public String getWfjAddressCode() {
		return wfjAddressCode;
	}
	public void setWfjAddressCode(String wfjAddressCode) {
		this.wfjAddressCode = wfjAddressCode;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getOperaterLoginid() {
		return operaterLoginid;
	}
	public void setOperaterLoginid(String operaterLoginid) {
		this.operaterLoginid = operaterLoginid;
	}
	
	
}
