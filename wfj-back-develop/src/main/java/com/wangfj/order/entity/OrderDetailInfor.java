package com.wangfj.order.entity;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;


public class OrderDetailInfor {
	private Integer memberSid;
	private String sendCost;
	private String receptName;
	private String receptAddress;
	private String receptPhone;
	private Integer paymentTypeSid;
	private Integer sendType;
	private Integer orderSourceSid;
	private Integer extractFlag;
	private BigDecimal needSaleMoneySum;
	private List orderDetails = new ArrayList();
	
	
	
	
	
	public BigDecimal getNeedSaleMoneySum() {
		return needSaleMoneySum;
	}
	public void setNeedSaleMoneySum(BigDecimal needSaleMoneySum) {
		this.needSaleMoneySum = needSaleMoneySum;
	}
	public Integer getExtractFlag() {
		return extractFlag;
	}
	public void setExtractFlag(Integer extractFlag) {
		this.extractFlag = extractFlag;
	}
	public Integer getMemberSid() {
		return memberSid;
	}
	public void setMemberSid(Integer memberSid) {
		this.memberSid = memberSid;
	}
	public String getSendCost() {
		return sendCost;
	}
	public void setSendCost(String sendCost) {
		this.sendCost = sendCost;
	}
	public String getReceptName() {
		return receptName;
	}
	public void setReceptName(String receptName) {
		this.receptName = receptName;
	}
	public String getReceptAddress() {
		return receptAddress;
	}
	public void setReceptAddress(String receptAddress) {
		this.receptAddress = receptAddress;
	}
	public String getReceptPhone() {
		return receptPhone;
	}
	public void setReceptPhone(String receptPhone) {
		this.receptPhone = receptPhone;
	}
	public Integer getPaymentTypeSid() {
		return paymentTypeSid;
	}
	public void setPaymentTypeSid(Integer paymentTypeSid) {
		this.paymentTypeSid = paymentTypeSid;
	}
	public Integer getSendType() {
		return sendType;
	}
	public void setSendType(Integer sendType) {
		this.sendType = sendType;
	}
	public Integer getOrderSourceSid() {
		return orderSourceSid;
	}
	public void setOrderSourceSid(Integer orderSourceSid) {
		this.orderSourceSid = orderSourceSid;
	}
	public List getOrderDetails() {
		return orderDetails;
	}
	public void setOrderDetails(List orderDetails) {
		this.orderDetails = orderDetails;
	}


	
	
	
}
