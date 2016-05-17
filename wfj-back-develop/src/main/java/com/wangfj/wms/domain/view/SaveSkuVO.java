package com.wangfj.wms.domain.view;

import java.io.Serializable;

/**
 * 插入一条商品基本信息(SKU) dto
 * 
 * @Class Name ProductAddVO
 * @Author wangsy
 * @Create In 2015年8月24日
 */
public class SaveSkuVO implements Serializable {
	/**
	 * @Field long serialVersionUID
	 */
	private static final long serialVersionUID = -1514916562859805498L;
	private String brandSid;/* 集团品牌SID。 */
	private String productNum;/* 款号（吊牌或者外包装上的款号） */
	private String prodCategoryCode;/* 末级工业分类SID */
	private String finalClassiFicationCode;/* 末级统计分类SID */
	private String yearToMarket;/* 上市年份(yyyy) */
	private String seasonCode;/* 季节表SID */
	private String crowdUser;/* 适用人群 */
	private String mainAttribute;/* 主属性 */
	private String categoryName;/* 分类名 */
	private String parameters;/* 属性/属性值 */
	private String type;/* 类型（0百货，1超市) */
	private String skuProps;
	private String proTypeSid;/* 商品类型 */

	public String getBrandSid() {
		return brandSid;
	}

	public void setBrandSid(String brandSid) {
		this.brandSid = brandSid;
	}

	public String getProductNum() {
		return productNum;
	}

	public void setProductNum(String productNum) {
		this.productNum = productNum;
	}

	public String getProdCategoryCode() {
		return prodCategoryCode;
	}

	public void setProdCategoryCode(String prodCategoryCode) {
		this.prodCategoryCode = prodCategoryCode;
	}

	public String getFinalClassiFicationCode() {
		return finalClassiFicationCode;
	}

	public void setFinalClassiFicationCode(String finalClassiFicationCode) {
		this.finalClassiFicationCode = finalClassiFicationCode;
	}

	public String getYearToMarket() {
		return yearToMarket;
	}

	public void setYearToMarket(String yearToMarket) {
		this.yearToMarket = yearToMarket;
	}

	public String getSeasonCode() {
		return seasonCode;
	}

	public void setSeasonCode(String seasonCode) {
		this.seasonCode = seasonCode;
	}

	public String getCrowdUser() {
		return crowdUser;
	}

	public void setCrowdUser(String crowdUser) {
		this.crowdUser = crowdUser;
	}

	public String getMainAttribute() {
		return mainAttribute;
	}

	public void setMainAttribute(String mainAttribute) {
		this.mainAttribute = mainAttribute;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getParameters() {
		return parameters;
	}

	public void setParameters(String parameters) {
		this.parameters = parameters;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSkuProps() {
		return skuProps;
	}

	public void setSkuProps(String skuProps) {
		this.skuProps = skuProps;
	}

	public String getProTypeSid() {
		return proTypeSid;
	}

	public void setProTypeSid(String proTypeSid) {
		this.proTypeSid = proTypeSid;
	}

	@Override
	public String toString() {
		return "SaveSkuVO [brandSid=" + brandSid + ", productNum=" + productNum
				+ ", prodCategoryCode=" + prodCategoryCode + ", finalClassiFicationCode="
				+ finalClassiFicationCode + ", yearToMarket=" + yearToMarket + ", seasonCode="
				+ seasonCode + ", crowdUser=" + crowdUser + ", mainAttribute=" + mainAttribute
				+ ", categoryName=" + categoryName + ", parameters=" + parameters + ", type="
				+ type + ", skuProps=" + skuProps + ", proTypeSid=" + proTypeSid + "]";
	}

}
