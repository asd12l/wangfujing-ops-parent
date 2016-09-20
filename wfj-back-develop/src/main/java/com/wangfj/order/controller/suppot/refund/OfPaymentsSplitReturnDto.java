package com.wangfj.order.controller.suppot.refund;

import java.math.BigDecimal;

public class OfPaymentsSplitReturnDto {
	private Long sid;

    private String refundItemNo;//退货单号

    private String paymentClass;//一级支付介质

    private String paymentType;//二级支付介质

    private BigDecimal amount;//支付金额

    private BigDecimal acturalAmount;//实际抵扣金额

    private BigDecimal rate;//汇率（折现率）

    private String account;//支付账号

    private String userId;//会员id

    private String payFlowNo;//支付流水号

    private String couponType;//优惠券类型

    private String couponBatch;//优惠券批次

    private String couponName;//券模板名称

    private String activityNo;//活动号

    private String couponRule;//收券规则

    private String couponRuleName;//收券规则描述

    private String remark;//备注

    private BigDecimal cashBalance;//结余

    public Long getSid() {
        return sid;
    }

    public void setSid(Long sid) {
        this.sid = sid;
    }

    public String getRefundItemNo() {
        return refundItemNo;
    }

    public void setRefundItemNo(String refundItemNo) {
        this.refundItemNo = refundItemNo;
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

	@Override
	public String toString() {
		return "OfPaymentsSplitReturnDto [sid=" + sid + ", refundItemNo=" + refundItemNo
				+ ", paymentClass=" + paymentClass + ", paymentType=" + paymentType + ", amount="
				+ amount + ", acturalAmount=" + acturalAmount + ", rate=" + rate + ", account="
				+ account + ", userId=" + userId + ", payFlowNo=" + payFlowNo + ", couponType="
				+ couponType + ", couponBatch=" + couponBatch + ", couponName=" + couponName
				+ ", activityNo=" + activityNo + ", couponRule=" + couponRule + ", couponRuleName="
				+ couponRuleName + ", remark=" + remark + ", cashBalance=" + cashBalance + "]";
	}
}
