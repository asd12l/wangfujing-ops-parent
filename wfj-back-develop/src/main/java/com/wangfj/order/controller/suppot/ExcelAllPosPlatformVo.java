package com.wangfj.order.controller.suppot;

import java.math.BigDecimal;
import java.util.Date;

public class ExcelAllPosPlatformVo {

	private String refundClass;//业务类型

	private String paymentType;//支付方式
	
	private BigDecimal paymentAmount;//应收金额

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
