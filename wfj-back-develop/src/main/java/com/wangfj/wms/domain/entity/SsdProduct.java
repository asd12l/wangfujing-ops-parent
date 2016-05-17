package com.wangfj.wms.domain.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import com.framework.page.Page;

public class SsdProduct extends Page implements Serializable {

	/**
	 * @Field long serialVersionUID
	 */
	private static final long serialVersionUID = 2762184797110030340L;

	private Long sid; // 商品ID

	private String skuName;// 商品名称

	private String spuName;// 产品名称

	private String skuCode; // 商品sku

	private String minSkuCode;// 商品明细表编码(分段查询最小值)

	private String maxSkuCode;// 商品明细表编码(分段查询最大值)

	private String spuCode;// SPU编码

	private String spuSid;

	private Long brandSid; // //品牌sid

	private String brandName; // 品牌名

	private Long proType;// 商品类型（是否是正式商品） 0 非正式商品 1 正式商品

	private Long proActiveBit; // 是否启用0未启用 1启用 默认 1

	private Long proSelling; // 是否上架0未上架 1上架 默认 0

	private Long presentFlg;

	private Long activityFlg;

	private String proPicture; // 商品图片

	private String categorySid;//品类

	private Long sexSid;

	private BigDecimal offValue;

	private BigDecimal promotionPrice;

	private BigDecimal currentPrice;

	private BigDecimal originalPrice;

	private Date createTime; // /时间

	private String brandRootSid;

	private String proPageDesc; // 商品描述

	private String productNameAlias;

	private String isPresent;// 拍照查询商品时，显示是否是赠品;
	private BigDecimal betweenCurrentPrice;
	private BigDecimal endCurrentPrice;

	private String betweenCreateTime;
	private String endCreateTime;

	private String sxStanCode; // 规格编码
	private String sxColorCode;// 色码

	private String modelCode;// 款号
	private String colorSid;// 色系编码
	private String skuSale;// 上架状态
	private Integer photoStatus;// 拍照计划状态 
	private String brandGroupCode;//集团品牌编码
	
	/**
	 * 缓存查询标识
	 */
	private String cache;

	public String getModelCode() {
		return modelCode;
	}

	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}

	public String getColorSid() {
		return colorSid;
	}

	public void setColorSid(String colorSid) {
		this.colorSid = colorSid;
	}

	public String getSkuSale() {
		return skuSale;
	}

	public void setSkuSale(String skuSale) {
		this.skuSale = skuSale;
	}

	public Integer getPhotoStatus() {
		return photoStatus;
	}

	public void setPhotoStatus(Integer photoStatus) {
		this.photoStatus = photoStatus;
	}

	public String getBrandGroupCode() {
		return brandGroupCode;
	}

	public void setBrandGroupCode(String brandGroupCode) {
		this.brandGroupCode = brandGroupCode;
	}

	public BigDecimal getEndCurrentPrice() {
		return endCurrentPrice;
	}

	public void setEndCurrentPrice(BigDecimal endCurrentPrice) {
		this.endCurrentPrice = endCurrentPrice;
	}

	public BigDecimal getBetweenCurrentPrice() {
		return betweenCurrentPrice;
	}

	public void setBetweenCurrentPrice(BigDecimal betweenCurrentPrice) {
		this.betweenCurrentPrice = betweenCurrentPrice;
	}

	public BigDecimal getEndnCurrentPrice() {
		return endCurrentPrice;
	}

	public void setEndnCurrentPrice(BigDecimal endCurrentPrice) {
		this.endCurrentPrice = endCurrentPrice;
	}

	public String getBetweenCreateTime() {
		return betweenCreateTime;
	}

	public void setBetweenCreateTime(String betweenCreateTime) {
		this.betweenCreateTime = betweenCreateTime;
	}

	public String getEndCreateTime() {
		return endCreateTime;
	}

	public void setEndCreateTime(String endCreateTime) {
		this.endCreateTime = endCreateTime;
	}

	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String getSkuName() {
		return skuName;
	}

	public void setSkuName(String skuName) {
		this.skuName = skuName == null ? null : skuName.trim();
	}

	public String getSkuCode() {
		return skuCode;
	}

	public void setSkuCode(String skuCode) {
		this.skuCode = skuCode == null ? null : skuCode.trim();
	}

	public String getSpuCode() {
		return spuCode;
	}

	public void setSpuCode(String spuCode) {
		this.spuCode = spuCode;
	}

	public Long getBrandSid() {
		return brandSid;
	}

	public void setBrandSid(Long brandSid) {
		this.brandSid = brandSid;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName == null ? null : brandName.trim();
	}

	public Long getProType() {
		return proType;
	}

	public void setProType(Long proType) {
		this.proType = proType;
	}

	public Long getProActiveBit() {
		return proActiveBit;
	}

	public void setProActiveBit(Long proActiveBit) {
		this.proActiveBit = proActiveBit;
	}

	public Long getProSelling() {
		return proSelling;
	}

	public void setProSelling(Long proSelling) {
		this.proSelling = proSelling;
	}

	public Long getPresentFlg() {
		return presentFlg;
	}

	public void setPresentFlg(Long presentFlg) {
		this.presentFlg = presentFlg;
	}

	public Long getActivityFlg() {
		return activityFlg;
	}

	public void setActivityFlg(Long activityFlg) {
		this.activityFlg = activityFlg;
	}

	public String getProPicture() {
		return proPicture;
	}

	public void setProPicture(String proPicture) {
		this.proPicture = proPicture == null ? null : proPicture.trim();
	}

	public String getCategorySid() {
		return categorySid;
	}

	public void setCategorySid(String categorySid) {
		this.categorySid = categorySid;
	}

	public Long getSexSid() {
		return sexSid;
	}

	public void setSexSid(Long sexSid) {
		this.sexSid = sexSid;
	}

	public BigDecimal getOffValue() {
		return offValue;
	}

	public void setOffValue(BigDecimal offValue) {
		this.offValue = offValue;
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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getBrandRootSid() {
		return brandRootSid;
	}

	public void setBrandRootSid(String brandRootSid) {
		this.brandRootSid = brandRootSid;
	}

	public String getProPageDesc() {
		return proPageDesc;
	}

	public void setProPageDesc(String proPageDesc) {
		this.proPageDesc = proPageDesc;
	}

	public String getProductNameAlias() {
		return productNameAlias;
	}

	public void setProductNameAlias(String productNameAlias) {
		this.productNameAlias = productNameAlias;
	}

	public String getIsPresent() {
		return isPresent;
	}

	public void setIsPresent(String isPresent) {
		this.isPresent = isPresent;
	}

	public String getSpuSid() {
		return spuSid;
	}

	public void setSpuSid(String spuSid) {
		this.spuSid = spuSid;
	}

	public String getSxStanCode() {
		return sxStanCode;
	}

	public void setSxStanCode(String sxStanCode) {
		this.sxStanCode = sxStanCode;
	}

	public String getSxColorCode() {
		return sxColorCode;
	}

	public void setSxColorCode(String sxColorCode) {
		this.sxColorCode = sxColorCode;
	}

	public String getSpuName() {
		return spuName;
	}

	public void setSpuName(String spuName) {
		this.spuName = spuName;
	}

	public String getCache() {
		return cache;
	}

	public void setCache(String cache) {
		this.cache = cache;
	}

	public String getMinSkuCode() {
		return minSkuCode;
	}

	public void setMinSkuCode(String minSkuCode) {
		this.minSkuCode = minSkuCode;
	}

	public String getMaxSkuCode() {
		return maxSkuCode;
	}

	public void setMaxSkuCode(String maxSkuCode) {
		this.maxSkuCode = maxSkuCode;
	}

	@Override
	public String toString() {
		return "SsdProduct{" +
				"sid=" + sid +
				", skuName='" + skuName + '\'' +
				", spuName='" + spuName + '\'' +
				", skuCode='" + skuCode + '\'' +
				", minSkuCode='" + minSkuCode + '\'' +
				", maxSkuCode='" + maxSkuCode + '\'' +
				", spuCode='" + spuCode + '\'' +
				", spuSid='" + spuSid + '\'' +
				", brandSid=" + brandSid +
				", brandName='" + brandName + '\'' +
				", proType=" + proType +
				", proActiveBit=" + proActiveBit +
				", proSelling=" + proSelling +
				", presentFlg=" + presentFlg +
				", activityFlg=" + activityFlg +
				", proPicture='" + proPicture + '\'' +
				", categorySid='" + categorySid + '\'' +
				", sexSid=" + sexSid +
				", offValue=" + offValue +
				", promotionPrice=" + promotionPrice +
				", currentPrice=" + currentPrice +
				", originalPrice=" + originalPrice +
				", createTime=" + createTime +
				", brandRootSid='" + brandRootSid + '\'' +
				", proPageDesc='" + proPageDesc + '\'' +
				", productNameAlias='" + productNameAlias + '\'' +
				", isPresent='" + isPresent + '\'' +
				", betweenCurrentPrice=" + betweenCurrentPrice +
				", endCurrentPrice=" + endCurrentPrice +
				", betweenCreateTime='" + betweenCreateTime + '\'' +
				", endCreateTime='" + endCreateTime + '\'' +
				", sxStanCode='" + sxStanCode + '\'' +
				", sxColorCode='" + sxColorCode + '\'' +
				", modelCode='" + modelCode + '\'' +
				", colorSid='" + colorSid + '\'' +
				", skuSale='" + skuSale + '\'' +
				", photoStatus=" + photoStatus +
				", brandGroupCode='" + brandGroupCode + '\'' +
				", cache='" + cache + '\'' +
				'}';
	}
}