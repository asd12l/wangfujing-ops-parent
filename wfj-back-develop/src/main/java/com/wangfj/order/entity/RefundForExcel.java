package com.wangfj.order.entity;

import java.math.BigDecimal;

public class RefundForExcel {
	
//	private Date 
	private String saleCode;//'实际的销售编码'sale
	
	private String refundNo;//退货单号 refund 
	
	private String orderNo;//订单号 refund sid
	
	private String saleNo;//原销售单号 refund sid sale
	
	private String shopName;//退货门店refund sid sale
	
	private Long shopSid;// '门店号'
	
	private int refundNum;//退货数量 refund
	
	private BigDecimal refundMoneySum;//退货金额  refund
	
	private String refundDesc;// '退货原因' refund
	
	private Long paymentTypeSid;//付款方式
	
	private String paymentTypeDesc;//支付方式order sid
	
	private String saleTime;//购买时间order
	
	private String printedTime;//退货单打印时间
	
	private String cashReturnedTime;//mis退款时间 对应状态
	
	private String cashierNumber;//流水号
	
	private String parentOrderNo;
	
	public String getParentOrderNo() {
		return parentOrderNo;
	}

	public void setParentOrderNo(String parentOrderNo) {
		this.parentOrderNo = parentOrderNo;
	}

	public String getCashierNumber() {
		return cashierNumber;
	}

	public void setCashierNumber(String cashierNumber) {
		this.cashierNumber = cashierNumber;
	}

	private String memo;//'备注'refund

	public String getSaleCode() {
		return saleCode;
	}

	public void setSaleCode(String saleCode) {
		this.saleCode = saleCode;
	}

	public String getRefundNo() {
		return refundNo;
	}

	public void setRefundNo(String refundNo) {
		this.refundNo = refundNo;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getSaleNo() {
		return saleNo;
	}

	public void setSaleNo(String saleNo) {
		this.saleNo = saleNo;
	}

	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public Long getShopSid() {
		return shopSid;
	}

	public void setShopSid(Long shopSid) {
		this.shopSid = shopSid;
	}

	public int getRefundNum() {
		return refundNum;
	}

	public void setRefundNum(int refundNum) {
		this.refundNum = refundNum;
	}

	public BigDecimal getRefundMoneySum() {
		return refundMoneySum;
	}

	public void setRefundMoneySum(BigDecimal refundMoneySum) {
		this.refundMoneySum = refundMoneySum;
	}

	public String getRefundDesc() {
		return refundDesc;
	}

	public void setRefundDesc(String refundDesc) {
		this.refundDesc = refundDesc;
	}

	public Long getPaymentTypeSid() {
		return paymentTypeSid;
	}

	public void setPaymentTypeSid(Long paymentTypeSid) {
		this.paymentTypeSid = paymentTypeSid;
	}

	public String getPaymentTypeDesc() {
		return paymentTypeDesc;
	}

	public void setPaymentTypeDesc(String paymentTypeDesc) {
		this.paymentTypeDesc = paymentTypeDesc;
	}



	public String getSaleTime() {
		return saleTime;
	}

	public void setSaleTime(String saleTime) {
		this.saleTime = saleTime;
	}

	public String getPrintedTime() {
		return printedTime;
	}

	public void setPrintedTime(String printedTime) {
		this.printedTime = printedTime;
	}

	public String getCashReturnedTime() {
		return cashReturnedTime;
	}

	public void setCashReturnedTime(String cashReturnedTime) {
		this.cashReturnedTime = cashReturnedTime;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}
