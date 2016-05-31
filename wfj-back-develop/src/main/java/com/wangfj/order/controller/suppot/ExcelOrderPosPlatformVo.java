package com.wangfj.order.controller.suppot;

import java.math.BigDecimal;
import java.util.Date;

public class ExcelOrderPosPlatformVo {

	private BigDecimal refundAmount;//应退金额
	private BigDecimal needRefundAmount;//实退金额
	private String orderNo;//订单号
	private String paymentType;//应退款方式
	private BigDecimal money;//退货扣款金额
	private String payname;//扣款原因
	private String payType;//扣款说明
	private Date saleTime;//下单时间
	private String saleTimeStr;//下单时间
	private Date refundTime;//订单取消时间
	private String refundTimeStr;//订单取消时间
	private String saleNo;//订单取消时间
	
	public String getSaleNo() {
		return saleNo;
	}
	public void setSaleNo(String saleNo) {
		this.saleNo = saleNo;
	}
	public Date getRefundTime() {
		return refundTime;
	}
	public void setRefundTime(Date refundTime) {
		this.refundTime = refundTime;
	}
	public String getRefundTimeStr() {
		return refundTimeStr;
	}
	public void setRefundTimeStr(String refundTimeStr) {
		this.refundTimeStr = refundTimeStr;
	}
	public BigDecimal getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(BigDecimal refundAmount) {
		this.refundAmount = refundAmount;
	}
	public BigDecimal getNeedRefundAmount() {
		return needRefundAmount;
	}
	public void setNeedRefundAmount(BigDecimal needRefundAmount) {
		this.needRefundAmount = needRefundAmount;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public BigDecimal getMoney() {
		return money;
	}
	public void setMoney(BigDecimal money) {
		this.money = money;
	}
	public String getPayname() {
		return payname;
	}
	public void setPayname(String payname) {
		this.payname = payname;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public Date getSaleTime() {
		return saleTime;
	}
	public void setSaleTime(Date saleTime) {
		this.saleTime = saleTime;
	}
	public String getSaleTimeStr() {
		return saleTimeStr;
	}
	public void setSaleTimeStr(String saleTimeStr) {
		this.saleTimeStr = saleTimeStr;
	}
	@Override
	public String toString() {
		return "ExcelOrderPosPlatformVo [refundAmount=" + refundAmount + ", needRefundAmount="
				+ needRefundAmount + ", orderNo=" + orderNo + ", paymentType=" + paymentType
				+ ", money=" + money + ", payname=" + payname + ", payType=" + payType
				+ ", saleTime=" + saleTime + ", saleTimeStr=" + saleTimeStr + ", refundTime="
				+ refundTime + ", refundTimeStr=" + refundTimeStr + "]";
	}
	
}
