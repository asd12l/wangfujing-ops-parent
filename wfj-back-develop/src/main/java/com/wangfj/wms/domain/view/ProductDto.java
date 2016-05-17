package com.wangfj.wms.domain.view;

public class ProductDto {
	private String skuCode;
	private String productSku;
	private String proStanSid;
	private String features;
	private String proColorName;
	private String primaryAttr;

	public String getSkuCode() {
		return skuCode;
	}

	public void setSkuCode(String skuCode) {
		this.skuCode = skuCode;
	}

	public String getProductSku() {
		return productSku;
	}

	public void setProductSku(String productSku) {
		this.productSku = productSku;
	}

	public String getProStanSid() {
		return proStanSid;
	}

	public void setProStanSid(String proStanSid) {
		this.proStanSid = proStanSid;
	}

	public String getFeatures() {
		return features;
	}

	public void setFeatures(String features) {
		this.features = features;
	}

	public String getProColorName() {
		return proColorName;
	}

	public void setProColorName(String proColorName) {
		this.proColorName = proColorName;
	}

	public String getPrimaryAttr() {
		return primaryAttr;
	}

	public void setPrimaryAttr(String primaryAttr) {
		this.primaryAttr = primaryAttr;
	}

	@Override
	public String toString() {
		return "ProductDto [skuCode=" + skuCode + ", productSku=" + productSku + ", proStanSid="
				+ proStanSid + ", features=" + features + ", proColorName=" + proColorName
				+ ", primaryAttr=" + primaryAttr + "]";
	}

}
