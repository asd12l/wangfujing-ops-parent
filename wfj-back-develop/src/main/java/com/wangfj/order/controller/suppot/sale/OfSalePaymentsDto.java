package com.wangfj.order.controller.suppot.sale;

import java.math.BigDecimal;

public class OfSalePaymentsDto {
	private Long sid;

    private String saleNo;

    private String salesPaymentNo;

    private String paymentClass;

    private String paymentType;

    private BigDecimal amount;

    private BigDecimal acturalAmount;

    private BigDecimal rate;

    private String account;

    private String userId;

    private String payFlowNo;

    private String couponType;

    private String couponBatch;

    private String couponName;

    private String activityNo;

    private String couponRule;

    private String couponRuleName;

    private String remark;

    private BigDecimal cashBalance;
    
    private BigDecimal shippingFee;

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

    public String getSalesPaymentNo() {
        return salesPaymentNo;
    }

    public void setSalesPaymentNo(String salesPaymentNo) {
        this.salesPaymentNo = salesPaymentNo;
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

    public BigDecimal getRate() {
        return rate;
    }

    public void setRate(BigDecimal rate) {
        this.rate = rate;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPayFlowNo() {
        return payFlowNo;
    }

    public void setPayFlowNo(String payFlowNo) {
        this.payFlowNo = payFlowNo;
    }

    public String getCouponType() {
        return couponType;
    }

    public void setCouponType(String couponType) {
        this.couponType = couponType;
    }

    public String getCouponBatch() {
        return couponBatch;
    }

    public void setCouponBatch(String couponBatch) {
        this.couponBatch = couponBatch;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getActivityNo() {
        return activityNo;
    }

    public void setActivityNo(String activityNo) {
        this.activityNo = activityNo;
    }

    public String getCouponRule() {
        return couponRule;
    }

    public void setCouponRule(String couponRule) {
        this.couponRule = couponRule;
    }

    public String getCouponRuleName() {
        return couponRuleName;
    }

    public void setCouponRuleName(String couponRuleName) {
        this.couponRuleName = couponRuleName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public BigDecimal getCashBalance() {
        return cashBalance;
    }

    public void setCashBalance(BigDecimal cashBalance) {
        this.cashBalance = cashBalance;
    }

	public BigDecimal getShippingFee() {
		return shippingFee;
	}

	public void setShippingFee(BigDecimal shippingFee) {
		this.shippingFee = shippingFee;
	}

}
