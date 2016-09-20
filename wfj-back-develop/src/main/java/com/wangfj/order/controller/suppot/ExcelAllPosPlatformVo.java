package com.wangfj.order.controller.suppot;

import java.math.BigDecimal;
import java.util.Date;

public class ExcelAllPosPlatformVo {
	private BigDecimal totalAmount;//总金额
	private String activity;//业务类型
	private BigDecimal refundAmount;//退款金额
	private BigDecimal amount;//金额
	
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getActivity() {
		return activity;
	}

	public void setActivity(String activity) {
		this.activity = activity;
	}

	public BigDecimal getRefundAmount() {
		return refundAmount;
	}

	public void setRefundAmount(BigDecimal refundAmount) {
		this.refundAmount = refundAmount;
	}
//以下面为准
	private String refundClass;//业务类型

	private String paymentType;//支付方式
	
	private BigDecimal paymentAmount;//应收金额
	private BigDecimal Amount;//应收金额

	public BigDecimal getAmount() {
		return Amount;
	}

	public void setAmount(BigDecimal amount) {
		Amount = amount;
	}

	public String getRefundClass() {
		return refundClass;
	}

	public void setRefundClass(String refundClass) {
		this.refundClass = refundClass;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}

	public BigDecimal getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(BigDecimal paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	@Override
	public String toString() {
		return "ExcelAllPosPlatformVo [refundClass=" + refundClass + ", paymentType=" + paymentType
				+ ", paymentAmount=" + paymentAmount + "]";
	}
	
}
