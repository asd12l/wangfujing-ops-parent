package com.wangfj.wms.domain.view;

import java.io.Serializable;

public class ExcelProductVo implements Serializable{
	/**
	 * @Field long serialVersionUID 
	 */
	private static final long serialVersionUID = 1L;
	public String proSKU;
	public String productName;
	public String proSPU;
	public String channelPrice;
	public String marketPrice;
	public String getProSKU() {
		return proSKU;
	}
	public void setProSKU(String proSKU) {
		this.proSKU = proSKU;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProSPU() {
		return proSPU;
	}
	public void setProSPU(String proSPU) {
		this.proSPU = proSPU;
	}
	public String getChannelPrice() {
		return channelPrice;
	}
	public void setChannelPrice(String channelPrice) {
		this.channelPrice = channelPrice;
	}
	public String getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(String marketPrice) {
		this.marketPrice = marketPrice;
	}
	@Override
	public String toString() {
		return "ExcelProductVo [proSKU=" + proSKU + ", productName="
				+ productName + ", proSPU=" + proSPU + ", channelPrice="
				+ channelPrice + ", marketPrice=" + marketPrice + "]";
	}
	
	
	
	
}
