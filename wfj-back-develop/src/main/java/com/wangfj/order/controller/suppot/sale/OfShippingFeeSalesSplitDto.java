package com.wangfj.order.controller.suppot.sale;

import java.math.BigDecimal;

public class OfShippingFeeSalesSplitDto {
	private Long sid;

	private String saleNo;

	private String paymentClass;

	private String paymentType;

	private BigDecimal amount;

	private BigDecimal acturalAmount;

	private String accountNo;

	private String memberNo;

	private BigDecimal rate;

	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String getSaleNo() {
		return saleNo;
	}

	public void setSaleNo(String saleNo) {
		this.saleNo = saleNo;
	}

	public String getPaymentClass() {
		return paymentClass;
	}

	public void setPaymentClass(String paymentClass) {
		this.paymentClass = paymentClass;
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

	public BigDecimal getActuralAmount() {
		return acturalAmount;
	}

	public void setActuralAmount(BigDecimal acturalAmount) {
		this.acturalAmount = acturalAmount;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public String getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}

	public BigDecimal getRate() {
		return rate;
	}

	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}
}
