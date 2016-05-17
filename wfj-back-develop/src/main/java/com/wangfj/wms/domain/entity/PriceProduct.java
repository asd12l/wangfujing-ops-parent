package com.wangfj.wms.domain.entity;

import java.math.BigDecimal;

public class PriceProduct {
    private Integer sid;

    private Integer pageLayoutSid;

    private Integer productListSid;

    private BigDecimal promotionPrice;
    
    private Integer flag;
    
    private String optor;
    
    

    public String getOptor() {
		return optor;
	}

	public void setOptor(String optor) {
		this.optor = optor;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getPageLayoutSid() {
        return pageLayoutSid;
    }

    public void setPageLayoutSid(Integer pageLayoutSid) {
        this.pageLayoutSid = pageLayoutSid;
    }

    public Integer getProductListSid() {
        return productListSid;
    }

    public void setProductListSid(Integer productListSid) {
        this.productListSid = productListSid;
    }

    public BigDecimal getPromotionPrice() {
        return promotionPrice;
    }

    public void setPromotionPrice(BigDecimal promotionPrice) {
        this.promotionPrice = promotionPrice;
    }
}