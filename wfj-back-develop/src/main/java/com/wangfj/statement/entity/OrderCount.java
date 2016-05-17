package com.wangfj.statement.entity;

public class OrderCount {
	private String saleAllSum;//订单交易数量
	private String saleAllPrice;//交易金额
	private String paymentTypeSid;// 付款方式 
	private String saleTime;//销售时间
	private String paymentTypeDesc;//支付方式描述
	private String priceAccount;//金额占比
	private String numAccount;//数量占比
	private String inceptProvince;// 收货人地址省份
	private String inceptCity;// 收货人城市区县名称
	private String paySaleAllSum;//已付款订单交易数量
	private String paySaleAllPrice;//已付款订单交易金额
	private String orderSourceSid;// 订单来源sid
	private String orderSource;//订单来源
	private String ifPay;//是否支付
	private String ifRefund;//是否退货
	public String getSaleAllSum() {
		return saleAllSum;
	}
	public void setSaleAllSum(String saleAllSum) {
		this.saleAllSum = saleAllSum;
	}
	public String getSaleAllPrice() {
		return saleAllPrice;
	}
	public void setSaleAllPrice(String saleAllPrice) {
		this.saleAllPrice = saleAllPrice;
	}
	public String getPaymentTypeSid() {
		return paymentTypeSid;
	}
	public void setPaymentTypeSid(String paymentTypeSid) {
		this.paymentTypeSid = paymentTypeSid;
	}
	public String getSaleTime() {
		return saleTime;
	}
	public void setSaleTime(String saleTime) {
		this.saleTime = saleTime;
	}
	public String getPaymentTypeDesc() {
		return paymentTypeDesc;
	}
	public void setPaymentTypeDesc(String paymentTypeDesc) {
		this.paymentTypeDesc = paymentTypeDesc;
	}
	public String getPriceAccount() {
		return priceAccount;
	}
	public void setPriceAccount(String priceAccount) {
		this.priceAccount = priceAccount;
	}
	public String getNumAccount() {
		return numAccount;
	}
	public void setNumAccount(String numAccount) {
		this.numAccount = numAccount;
	}
	public String getInceptProvince() {
		return inceptProvince;
	}
	public void setInceptProvince(String inceptProvince) {
		this.inceptProvince = inceptProvince;
	}
	public String getInceptCity() {
		return inceptCity;
	}
	public void setInceptCity(String inceptCity) {
		this.inceptCity = inceptCity;
	}
	public String getPaySaleAllSum() {
		return paySaleAllSum;
	}
	public void setPaySaleAllSum(String paySaleAllSum) {
		this.paySaleAllSum = paySaleAllSum;
	}
	public String getPaySaleAllPrice() {
		return paySaleAllPrice;
	}
	public void setPaySaleAllPrice(String paySaleAllPrice) {
		this.paySaleAllPrice = paySaleAllPrice;
	}
	public String getOrderSourceSid() {
		return orderSourceSid;
	}
	public void setOrderSourceSid(String orderSourceSid) {
		this.orderSourceSid = orderSourceSid;
	}
	public String getOrderSource() {
		return orderSource;
	}
	public void setOrderSource(String orderSource) {
		this.orderSource = orderSource;
	}
	public String getIfPay() {
		return ifPay;
	}
	public void setIfPay(String ifPay) {
		this.ifPay = ifPay;
	}
	public String getIfRefund() {
		return ifRefund;
	}
	public void setIfRefund(String ifRefund) {
		this.ifRefund = ifRefund;
	}
	
}
