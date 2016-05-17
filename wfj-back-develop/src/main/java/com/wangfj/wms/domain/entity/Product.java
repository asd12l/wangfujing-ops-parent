package com.wangfj.wms.domain.entity;

import java.math.BigDecimal;

import com.framework.page.Page;

public class Product extends Page{
	private Integer sid;   //主键
	private String serialNumber;
	private String nodeName; 
	private BigDecimal fatherNodeSid;
	private Integer rootNodeSid;
	private Integer isDisplay;
	private String memo;
	private Integer nodeLevel;
	private Integer isLeaf;
	private Integer nodeSeq;
	
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber == null ?  null :serialNumber.trim();
	}
	public String getNodeName() {
		return nodeName;
	}
	public void setNodeName(String nodeName) {
		this.nodeName = nodeName == null ? null : nodeName.trim();
	}
	public BigDecimal getFatherNodeSid() {
		return fatherNodeSid;
	}
	public void setFatherNodeSid(BigDecimal fatherNodeSid) {
		this.fatherNodeSid = fatherNodeSid;
	}
	public Integer getRootNodeSid() {
		return rootNodeSid;
	}
	public void setRootNodeSid(Integer rootNodeSid) {
		this.rootNodeSid = rootNodeSid;
	}
	public Integer getIsDisplay() {
		return isDisplay;
	}
	public void setIsDisplay(Integer isDisplay) {
		this.isDisplay = isDisplay;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo == null ? null : memo.trim();
	}
	public Integer getNodeLevel() {
		return nodeLevel;
	}
	public void setNodeLevel(Integer nodeLevel) {
		this.nodeLevel = nodeLevel;
	}
	public Integer getIsLeaf() {
		return isLeaf;
	}
	public void setIsLeaf(Integer isLeaf) {
		this.isLeaf = isLeaf;
	}
	public Integer getNodeSeq() {
		return nodeSeq;
	}
	public void setNodeSeq(Integer nodeSeq) {
		this.nodeSeq = nodeSeq;
	}
	
	
}
