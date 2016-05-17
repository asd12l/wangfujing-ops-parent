package com.wangfj.order.entity;

import java.math.BigDecimal;

public class order {
	private Integer proDetailSid;
	private BigDecimal promotionPrice;
	private BigDecimal currentPrice;
	private BigDecimal originalPrice;
	private Integer quickBuyBit;
	private BigDecimal salePrice;
	private int saleSum;
	private long shopSid;
	 private Integer extractFlag;
	 
	
	
	public Integer getExtractFlag() {
		return extractFlag;
	}
	public void setExtractFlag(Integer extractFlag) {
		this.extractFlag = extractFlag;
	}
	public long getShopSid() {
		return shopSid;
	}
	public void setShopSid(long shopSid) {
		this.shopSid = shopSid;
	}
	public Integer getProDetailSid() {
		return proDetailSid;
	}
	public void setProDetailSid(Integer proDetailSid) {
		this.proDetailSid = proDetailSid;
	}
	public BigDecimal getPromotionPrice() {
		return promotionPrice;
	}
	public void setPromotionPrice(BigDecimal promotionPrice) {
		this.promotionPrice = promotionPrice;
	}
	public BigDecimal getCurrentPrice() {
		return currentPrice;
	}
	public void setCurrentPrice(BigDecimal currentPrice) {
		this.currentPrice = currentPrice;
	}
	public BigDecimal getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(BigDecimal originalPrice) {
		this.originalPrice = originalPrice;
	}
	public Integer getQuickBuyBit() {
		return quickBuyBit;
	}
	public void setQuickBuyBit(Integer quickBuyBit) {
		this.quickBuyBit = quickBuyBit;
	}
	public BigDecimal getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(BigDecimal salePrice) {
		this.salePrice = salePrice;
	}
	public int getSaleSum() {
		return saleSum;
	}
	public void setSaleSum(int saleSum) {
		this.saleSum = saleSum;
	}
	
	
}
