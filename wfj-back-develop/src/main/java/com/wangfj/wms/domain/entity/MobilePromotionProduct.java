package com.wangfj.wms.domain.entity;

public class MobilePromotionProduct {
	private Integer sid;

	private Integer promotionSid;

	private Integer productSid;

	private Integer shopSid;

	private Integer seq;

	private Integer stockFlag;

	private String supplySid;

	public String getSupplySid() {
		return supplySid;
	}

	public void setSupplySid(String supplySid) {
		this.supplySid = supplySid;
	}

	public Integer getStockFlag() {
		return stockFlag;
	}

	public void setStockFlag(Integer stockFlag) {
		this.stockFlag = stockFlag;
	}

	public Integer getSid() {
		return sid;
	}

	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public Integer getPromotionSid() {
		return promotionSid;
	}

	public void setPromotionSid(Integer promotionSid) {
		this.promotionSid = promotionSid;
	}

	public Integer getProductSid() {
		return productSid;
	}

	public void setProductSid(Integer productSid) {
		this.productSid = productSid;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getShopSid() {
		return shopSid;
	}

	public void setShopSid(Integer shopSid) {
		this.shopSid = shopSid;
	}

	@Override
	public String toString() {
		return "MobilePromotionProduct [sid=" + sid + ", promotionSid="
				+ promotionSid + ", productSid=" + productSid + ", shopSid="
				+ shopSid + ", seq=" + seq + ", stockFlag=" + stockFlag
				+ ", supplySid=" + supplySid + "]";
	}

}