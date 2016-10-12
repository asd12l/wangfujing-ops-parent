package com.wangfj.order.controller.suppot;

import java.math.BigDecimal;
import java.util.Date;

public class ExcelPosPlatformVo {

	private Date checkTime;//对账时间
	private Date createdTime;//对账时间
	private String checkTimeStr;
	private String createdTimeStr;
	private Long count;
	
	public Date getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}
	public Date getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	public String getCheckTimeStr() {
		return checkTimeStr;
	}
	public void setCheckTimeStr(String checkTimeStr) {
		this.checkTimeStr = checkTimeStr;
	}
	public String getCreatedTimeStr() {
		return createdTimeStr;
	}
	public void setCreatedTimeStr(String createdTimeStr) {
		this.createdTimeStr = createdTimeStr;
	}
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	//原本的
	private String orderNo;//订单号

	private String outOrderNo;//外部订单号

	private String paymentType;//支付方式
	private BigDecimal amount;//订单金额
	private BigDecimal paymentAmount;//支付金额
	
	public BigDecimal getPaymentAmount() {
		return paymentAmount;
	}
	public void setPaymentAmount(BigDecimal paymentAmount) {
		this.paymentAmount = paymentAmount;
	}
	private Date payTime;//支付时间
	private Date reconciliationTime;//对账时间
	private String payTimeStr;
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getOutOrderNo() {
		return outOrderNo;
	}
	public void setOutOrderNo(String outOrderNo) {
		this.outOrderNo = outOrderNo;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public Date getPayTime() {
		return payTime;
	}
	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	public Date getReconciliationTime() {
		return reconciliationTime;
	}
	public void setReconciliationTime(Date reconciliationTime) {
		this.reconciliationTime = reconciliationTime;
	}
	public String getPayTimeStr() {
		return payTimeStr;
	}
	public void setPayTimeStr(String payTimeStr) {
		this.payTimeStr = payTimeStr;
	}
	@Override
	public String toString() {
		return "ExcelPosPlatformVo [orderNo=" + orderNo + ", outOrderNo=" + outOrderNo
				+ ", paymentType=" + paymentType + ", amount=" + amount + ", payTime=" + payTime
				+ ", reconciliationTime=" + reconciliationTime + ", payTimeStr=" + payTimeStr + "]";
	}
}
