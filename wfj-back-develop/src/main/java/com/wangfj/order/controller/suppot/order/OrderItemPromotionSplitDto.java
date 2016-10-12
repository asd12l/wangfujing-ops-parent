package com.wangfj.order.controller.suppot.order;

import java.math.BigDecimal;

public class OrderItemPromotionSplitDto {
	private String orderItemNo;

	private String promotionCode;

	private String promotionType;

	private String promotionName;

	private String promotionDesc;

	private BigDecimal promotionAmount;

	private String promotionRule;

	private String promotionRuleName;

	private BigDecimal splitRate;

	private BigDecimal freightAmount;

	private String deleteFlag;

	public String getOrderItemNo() {
		return orderItemNo;
	}

	public void setOrderItemNo(String orderItemNo) {
		this.orderItemNo = orderItemNo;
	}

	public String getPromotionCode() {
		return promotionCode;
	}

	public void setPromotionCode(String promotionCode) {
		this.promotionCode = promotionCode;
	}

	public String getPromotionType() {
		return promotionType;
	}

	public void setPromotionType(String promotionType) {
		this.promotionType = promotionType;
	}

	public String getPromotionName() {
		return promotionName;
	}

	public void setPromotionName(String promotionName) {
		this.promotionName = promotionName;
	}

	public String getPromotionDesc() {
		return promotionDesc;
	}

	public void setPromotionDesc(String promotionDesc) {
		this.promotionDesc = promotionDesc;
	}

	public BigDecimal getPromotionAmount() {
		return promotionAmount;
	}

	public void setPromotionAmount(BigDecimal promotionAmount) {
		this.promotionAmount = promotionAmount;
	}

	public String getPromotionRule() {
		return promotionRule;
	}

	public void setPromotionRule(String promotionRule) {
		this.promotionRule = promotionRule;
	}

	public String getPromotionRuleName() {
		return promotionRuleName;
	}

	public void setPromotionRuleName(String promotionRuleName) {
		this.promotionRuleName = promotionRuleName;
	}

	public BigDecimal getSplitRate() {
		return splitRate;
	}

	public void setSplitRate(BigDecimal splitRate) {
		this.splitRate = splitRate;
	}

	public BigDecimal getFreightAmount() {
		return freightAmount;
	}

	public void setFreightAmount(BigDecimal freightAmount) {
		this.freightAmount = freightAmount;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
}
