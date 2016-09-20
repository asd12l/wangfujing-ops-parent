package com.wangfj.order.controller.suppot.order;

import java.math.BigDecimal;

public class PrPromotionSplitDto {
private Long sid;
	
	private String salesItemNo;//销售单商品行

    private String promotionCode;//促销编码

    private String promotionType;//促销类型

    private String promotionName;//促销名称

    private String promotionDesc;//促销描述

    private BigDecimal promotionAmount;//促销优惠分摊金额

    private String promotionRule;//促销规则

    private String promotionRuleName;//促销规则值

    private BigDecimal splitRate;//分摊比例

    private BigDecimal freightAmount;//运费促销分摊



   

	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}
	
	

	public String getSalesItemNo() {
		return salesItemNo;
	}

	public void setSalesItemNo(String salesItemNo) {
		this.salesItemNo = salesItemNo;
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

	@Override
	public String toString() {
		return "PrPromotionSplitDto [sid=" + sid + ", salesItemNo=" + salesItemNo
				+ ", promotionCode=" + promotionCode + ", promotionType=" + promotionType
				+ ", promotionName=" + promotionName + ", promotionDesc=" + promotionDesc
				+ ", promotionAmount=" + promotionAmount + ", promotionRule=" + promotionRule
				+ ", promotionRuleName=" + promotionRuleName + ", splitRate=" + splitRate
				+ ", freightAmount=" + freightAmount + "]";
	}
}
