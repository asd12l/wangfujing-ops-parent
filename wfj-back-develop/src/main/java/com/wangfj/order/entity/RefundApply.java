package com.wangfj.order.entity;

import java.math.BigDecimal;

public class RefundApply {
    private Long sid;

    private String orderNo;

    private String customerPostage;

    private String companyPostage;

    private String applyTime;

    private String optUserSid;

    private String optRealName;

    private String optUpdateTime;

    private String refundNum;

    private String refundMoneySum;

    private String paymentUserSid;

    private String paymentRealName;

    private Long updateUserSid;

    private String updateRealName;

    private String updateTime;

    private Long refundUserSid;

    private String refundRealName;

    private String refundTime;

    private String finaceConfirmTime;

    private String logisticsConfirmTime;

    private Integer version;

    private String customerMemo;

    private String customerServiceMemo;

    private String logisticsMemo;

    private String financeMemo;

    private String bankName;

    private String bankAddress;

    private String bankNumber;

    private String bankUser;

    private String deliveryNo;

    private String deliveryCompany;

    private String refundApplyNo;

    private Integer refundStatus;

    private Integer refundmentType;

    private Integer refundGoodType;

    private String checkTime;

    private Long returnFinaceUserSid;

    private Long takeDeliveryUserSid;

    private Long checkUserSid;

    private String memberEmail;

    private Long memberSid;

    private String fromSystem;

    private String refundPhone;
    
    private String refundName;
    
    private String postageMemo;
    
    private Long paymentTypeSid;
    
    private BigDecimal needRefundMoney;//实际退款金额',
    
    private BigDecimal refundTicketSnPrice;//退卷金额',
    
    private String refundStatusDesc;//'退货状态描述',
    
    private String logisticsStatus;//'退货物流状态',
    
    private String logisticsStatusDesc;//退货物流状态描述',
    
    private String paymentTypeDesc;//'支付方式描述',
    
    private String refundGoodDesc;//'退货类型描述',
    
    private String refundMentDesc;//'退款类型描述',
    
    private BigDecimal ticketSnUsePrice;//用户使用优惠券金额
    
    private String receptName;//收货人姓名
    
    private String shopSid;//门店号
    
    private BigDecimal comePostage;
    
    private BigDecimal goPostage;
    
    private String parentOrderNo;
	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getCustomerPostage() {
		return customerPostage;
	}

	public void setCustomerPostage(String customerPostage) {
		this.customerPostage = customerPostage;
	}

	public String getCompanyPostage() {
		return companyPostage;
	}

	public void setCompanyPostage(String companyPostage) {
		this.companyPostage = companyPostage;
	}

	public String getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

	public String getOptUserSid() {
		return optUserSid;
	}

	public void setOptUserSid(String optUserSid) {
		this.optUserSid = optUserSid;
	}

	public String getOptRealName() {
		return optRealName;
	}

	public void setOptRealName(String optRealName) {
		this.optRealName = optRealName;
	}

	public String getOptUpdateTime() {
		return optUpdateTime;
	}

	public void setOptUpdateTime(String optUpdateTime) {
		this.optUpdateTime = optUpdateTime;
	}

	public String getRefundNum() {
		return refundNum;
	}

	public void setRefundNum(String refundNum) {
		this.refundNum = refundNum;
	}

	public String getRefundMoneySum() {
		return refundMoneySum;
	}

	public void setRefundMoneySum(String refundMoneySum) {
		this.refundMoneySum = refundMoneySum;
	}

	public String getPaymentUserSid() {
		return paymentUserSid;
	}

	public void setPaymentUserSid(String paymentUserSid) {
		this.paymentUserSid = paymentUserSid;
	}

	public String getPaymentRealName() {
		return paymentRealName;
	}

	public void setPaymentRealName(String paymentRealName) {
		this.paymentRealName = paymentRealName;
	}

	public Long getUpdateUserSid() {
		return updateUserSid;
	}

	public void setUpdateUserSid(Long updateUserSid) {
		this.updateUserSid = updateUserSid;
	}

	public String getUpdateRealName() {
		return updateRealName;
	}

	public void setUpdateRealName(String updateRealName) {
		this.updateRealName = updateRealName;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public Long getRefundUserSid() {
		return refundUserSid;
	}

	public void setRefundUserSid(Long refundUserSid) {
		this.refundUserSid = refundUserSid;
	}

	public String getRefundRealName() {
		return refundRealName;
	}

	public void setRefundRealName(String refundRealName) {
		this.refundRealName = refundRealName;
	}

	public String getRefundTime() {
		return refundTime;
	}

	public void setRefundTime(String refundTime) {
		this.refundTime = refundTime;
	}

	public String getFinaceConfirmTime() {
		return finaceConfirmTime;
	}

	public void setFinaceConfirmTime(String finaceConfirmTime) {
		this.finaceConfirmTime = finaceConfirmTime;
	}

	public String getLogisticsConfirmTime() {
		return logisticsConfirmTime;
	}

	public void setLogisticsConfirmTime(String logisticsConfirmTime) {
		this.logisticsConfirmTime = logisticsConfirmTime;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	public String getCustomerMemo() {
		return customerMemo;
	}

	public void setCustomerMemo(String customerMemo) {
		this.customerMemo = customerMemo;
	}

	public String getCustomerServiceMemo() {
		return customerServiceMemo;
	}

	public void setCustomerServiceMemo(String customerServiceMemo) {
		this.customerServiceMemo = customerServiceMemo;
	}

	public String getLogisticsMemo() {
		return logisticsMemo;
	}

	public void setLogisticsMemo(String logisticsMemo) {
		this.logisticsMemo = logisticsMemo;
	}

	public String getFinanceMemo() {
		return financeMemo;
	}

	public void setFinanceMemo(String financeMemo) {
		this.financeMemo = financeMemo;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankAddress() {
		return bankAddress;
	}

	public void setBankAddress(String bankAddress) {
		this.bankAddress = bankAddress;
	}

	public String getBankNumber() {
		return bankNumber;
	}

	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}

	public String getBankUser() {
		return bankUser;
	}

	public String getParentOrderNo() {
		return parentOrderNo;
	}

	public void setParentOrderNo(String parentOrderNo) {
		this.parentOrderNo = parentOrderNo;
	}

	public void setBankUser(String bankUser) {
		this.bankUser = bankUser;
	}

	public String getDeliveryNo() {
		return deliveryNo;
	}

	public void setDeliveryNo(String deliveryNo) {
		this.deliveryNo = deliveryNo;
	}

	public String getDeliveryCompany() {
		return deliveryCompany;
	}

	public void setDeliveryCompany(String deliveryCompany) {
		this.deliveryCompany = deliveryCompany;
	}

	public String getRefundApplyNo() {
		return refundApplyNo;
	}

	public void setRefundApplyNo(String refundApplyNo) {
		this.refundApplyNo = refundApplyNo;
	}

	public Integer getRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(Integer refundStatus) {
		this.refundStatus = refundStatus;
	}

	public Integer getRefundmentType() {
		return refundmentType;
	}

	public void setRefundmentType(Integer refundmentType) {
		this.refundmentType = refundmentType;
	}

	public Integer getRefundGoodType() {
		return refundGoodType;
	}

	public void setRefundGoodType(Integer refundGoodType) {
		this.refundGoodType = refundGoodType;
	}

	public String getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(String checkTime) {
		this.checkTime = checkTime;
	}

	public Long getReturnFinaceUserSid() {
		return returnFinaceUserSid;
	}

	public void setReturnFinaceUserSid(Long returnFinaceUserSid) {
		this.returnFinaceUserSid = returnFinaceUserSid;
	}

	public Long getTakeDeliveryUserSid() {
		return takeDeliveryUserSid;
	}

	public void setTakeDeliveryUserSid(Long takeDeliveryUserSid) {
		this.takeDeliveryUserSid = takeDeliveryUserSid;
	}

	public Long getCheckUserSid() {
		return checkUserSid;
	}

	public void setCheckUserSid(Long checkUserSid) {
		this.checkUserSid = checkUserSid;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public Long getMemberSid() {
		return memberSid;
	}

	public void setMemberSid(Long memberSid) {
		this.memberSid = memberSid;
	}

	public String getFromSystem() {
		return fromSystem;
	}

	public void setFromSystem(String fromSystem) {
		this.fromSystem = fromSystem;
	}

	public String getRefundPhone() {
		return refundPhone;
	}

	public void setRefundPhone(String refundPhone) {
		this.refundPhone = refundPhone;
	}

	public String getRefundName() {
		return refundName;
	}

	public void setRefundName(String refundName) {
		this.refundName = refundName;
	}

	public String getPostageMemo() {
		return postageMemo;
	}

	public void setPostageMemo(String postageMemo) {
		this.postageMemo = postageMemo;
	}

	public Long getPaymentTypeSid() {
		return paymentTypeSid;
	}

	public void setPaymentTypeSid(Long paymentTypeSid) {
		this.paymentTypeSid = paymentTypeSid;
	}

	public BigDecimal getNeedRefundMoney() {
		return needRefundMoney;
	}

	public void setNeedRefundMoney(BigDecimal needRefundMoney) {
		this.needRefundMoney = needRefundMoney;
	}

	public BigDecimal getRefundTicketSnPrice() {
		return refundTicketSnPrice;
	}

	public void setRefundTicketSnPrice(BigDecimal refundTicketSnPrice) {
		this.refundTicketSnPrice = refundTicketSnPrice;
	}

	public String getRefundStatusDesc() {
		return refundStatusDesc;
	}

	public void setRefundStatusDesc(String refundStatusDesc) {
		this.refundStatusDesc = refundStatusDesc;
	}

	public String getLogisticsStatus() {
		return logisticsStatus;
	}

	public void setLogisticsStatus(String logisticsStatus) {
		this.logisticsStatus = logisticsStatus;
	}

	public String getLogisticsStatusDesc() {
		return logisticsStatusDesc;
	}

	public void setLogisticsStatusDesc(String logisticsStatusDesc) {
		this.logisticsStatusDesc = logisticsStatusDesc;
	}

	public String getPaymentTypeDesc() {
		return paymentTypeDesc;
	}

	public void setPaymentTypeDesc(String paymentTypeDesc) {
		this.paymentTypeDesc = paymentTypeDesc;
	}

	public String getRefundGoodDesc() {
		return refundGoodDesc;
	}

	public void setRefundGoodDesc(String refundGoodDesc) {
		this.refundGoodDesc = refundGoodDesc;
	}

	public String getRefundMentDesc() {
		return refundMentDesc;
	}

	public void setRefundMentDesc(String refundMentDesc) {
		this.refundMentDesc = refundMentDesc;
	}

	public BigDecimal getTicketSnUsePrice() {
		return ticketSnUsePrice;
	}

	public void setTicketSnUsePrice(BigDecimal ticketSnUsePrice) {
		this.ticketSnUsePrice = ticketSnUsePrice;
	}

	public String getReceptName() {
		return receptName;
	}

	public void setReceptName(String receptName) {
		this.receptName = receptName;
	}

	public String getShopSid() {
		return shopSid;
	}

	public void setShopSid(String shopSid) {
		this.shopSid = shopSid;
	}

	public BigDecimal getComePostage() {
		return comePostage;
	}

	public void setComePostage(BigDecimal comePostage) {
		this.comePostage = comePostage;
	}

	public BigDecimal getGoPostage() {
		return goPostage;
	}

	public void setGoPostage(BigDecimal goPostage) {
		this.goPostage = goPostage;
	}
	
    
   
}