package com.wangfj.wms.util;


public class PriceRuleKey {

	String pageLayoutSid;
	String productSids;
	String promotionPrice;
	String value;
	String tsid;
	String startTime;
	String endTime;
	String supplySids;
	String startDay;
	String endDay;
	String optor;
	
	

	public String getOptor() {
		return optor;
	}

	public void setOptor(String optor) {
		this.optor = optor;
	}

	public String getStartDay() {
		return startDay;
	}

	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}

	public String getEndDay() {
		return endDay;
	}

	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}

	public String getSupplySids() {
		return supplySids;
	}

	public void setSupplySids(String supplySids) {
		this.supplySids = supplySids;
	}

	public String getPageLayoutSid() {
		return pageLayoutSid;
	}

	public void setPageLayoutSid(String pageLayoutSid) {
		this.pageLayoutSid = pageLayoutSid;
	}

	public String getProductSids() {
		return productSids;
	}

	public void setProductSids(String productSids) {
		this.productSids = productSids;
	}

	public String getPromotionPrice() {
		return promotionPrice;
	}

	public void setPromotionPrice(String promotionPrice) {
		this.promotionPrice = promotionPrice;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getTsid() {
		return tsid;
	}

	public void setTsid(String tsid) {
		this.tsid = tsid;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	@Override
	public String toString() {
		return "PriceRuleKey [pageLayoutSid=" + pageLayoutSid
				+ ", productSids=" + productSids + ", promotionPrice="
				+ promotionPrice + ", value=" + value + ", tsid=" + tsid
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", supplySids=" + supplySids + ", startDay=" + startDay
				+ ", endDay=" + endDay + ", optor=" + optor + "]";
	}

	

}
