package com.wangfj.wms.domain.entity;

import java.io.Serializable;
import java.math.BigDecimal;

import com.framework.page.Page;

/**
 * 专柜商品表
 * 
 * @Class Name PcmShoppeProduct
 * @Author zhangxy
 * @Create In 2015年7月2日
 */
public class PcmShoppeProductVo  extends Page implements Serializable {
	/**
	 * @Field long serialVersionUID
	 */
	private static final long serialVersionUID = 8301128110139097633L;
	private Long sid;
	/**
	 * 专柜商品编码
	 */
	private String shoppeProSid;
	private String minShoppeProSid;// 专柜商品编码(分段查询的最小值)
	private String maxShoppeProSid;// 专柜商品编码(分段查询的最大值)
	/**
	 * 商品表SKU编码
	 */
	private String productDetailSid;
	private String minProductDetailSid;// 商品表SKU 编码(分段查询的最小值)
	private String maxProductDetailSid;// 商品表SKU 编码(分段查询的最大值)
	/**
	 * 专柜编码
	 */
	private String shoppeSid;
	/**
	 * 供应商编码
	 */
	private String supplySid;
	/**
	 * 门店品牌编码
	 */
	private String brandSid;
	/**
	 * 管理分类编码
	 */
	private String categorySid;
	/**
	 * 扣率码
	 */
	private String rateCode;
	/**
	 * 专柜商品名称
	 */
	private String shoppeProName;
	/**
	 * 专柜商品简称(别名)
	 */
	private String shoppeProAlias;
	/**
	 * 专柜商品可售状态:0 可售，1 不可售(默认为0）
	 */
	private String saleStatus;
	
	/**
	 * 销售单位
	 */
	private String saleUnitCode;
	/**
	 * 大码
	 */
	private String erpproductcode;
	/**
	 * 供应商商品编码
	 */
	private String supplyProductCode;
	/**
	 * 物流属性
	 */
	private String tmsParam;
	/**
	 * 折扣底线（0到1.00的小数）
	 */
	private String discountLimit;
	/**
	 * 是否可包装(0可以，1不可以)
	 */
	private String isPacking;
	/**
	 * 原价
	 */
	private String originalPrice;
	/**
	 * 库存方式
	 */
	private String stockMode;
	/**
	 * 进项税
	 */
	private String inputTax;
	/**
	 * 销项税
	 */
	private String outputTax;
	/**
	 * 销售税
	 */
	private String salesTax;
	/**
	 * 扣率/进价
	 */
	private String purchasePrice;
	/**
	 * 扣率/含税进价
	 */
	private String buyingPrice;
	/**
	 * 加工方式
	 */
	private String processType;
	/**
	 * 产地
	 */
	private String originLand;
	/**
	 * 原产地
	 */
	private String originLand2;
	/**
	 * 订货方式
	 */
	private String orderType;
	/**
	 * 是否支持ERP促销
	 */
	private String isPromotion;
	/**
	 * 是否支持ERP变价
	 */
	private String isAdjustPrice;
	/**
	 * 预留
	 */
	private String field1;
	private String field2;
	private String field3;
	private String field4;
	private String field5;//做为门店传值用
	
	private String shopName;
	private String brandName;
	private String categoryName;
	private String supplyName;

	public String getShoppeProSid() {
		return shoppeProSid;
	}

	public void setShoppeProSid(String shoppeProSid) {
		this.shoppeProSid = shoppeProSid;
	}

	public String getProductDetailSid() {
		return productDetailSid;
	}

	public void setProductDetailSid(String productDetailSid) {
		this.productDetailSid = productDetailSid;
	}

	public String getShoppeSid() {
		return shoppeSid;
	}

	public void setShoppeSid(String shoppeSid) {
		this.shoppeSid = shoppeSid;
	}

	public String getSupplySid() {
		return supplySid;
	}

	public void setSupplySid(String supplySid) {
		this.supplySid = supplySid;
	}

	public String getBrandSid() {
		return brandSid;
	}

	public void setBrandSid(String brandSid) {
		this.brandSid = brandSid;
	}

	public String getCategorySid() {
		return categorySid;
	}

	public void setCategorySid(String categorySid) {
		this.categorySid = categorySid;
	}

	public String getSupplyProductCode() {
		return supplyProductCode;
	}

	public void setSupplyProductCode(String supplyProductCode) {
		this.supplyProductCode = supplyProductCode;
	}


	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String getRateCode() {
		return rateCode;
	}

	public void setRateCode(String rateCode) {
		this.rateCode = rateCode == null ? null : rateCode.trim();
	}

	public String getShoppeProName() {
		return shoppeProName;
	}

	public void setShoppeProName(String shoppeProName) {
		this.shoppeProName = shoppeProName == null ? null : shoppeProName.trim();
	}

	public String getShoppeProAlias() {
		return shoppeProAlias;
	}

	public void setShoppeProAlias(String shoppeProAlias) {
		this.shoppeProAlias = shoppeProAlias;
	}

	public String getSaleStatus() {
		return saleStatus;
	}

	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}

	public String getSaleUnitCode() {
		return saleUnitCode;
	}

	public void setSaleUnitCode(String saleUnitCode) {
		this.saleUnitCode = saleUnitCode;
	}

	public String getErpproductcode() {
		return erpproductcode;
	}

	public void setErpproductcode(String erpproductcode) {
		this.erpproductcode = erpproductcode;
	}

	public String getTmsParam() {
		return tmsParam;
	}

	public void setTmsParam(String tmsParam) {
		this.tmsParam = tmsParam;
	}

	public String getDiscountLimit() {
		return discountLimit;
	}

	public void setDiscountLimit(String discountLimit) {
		this.discountLimit = discountLimit;
	}

	public String getIsPacking() {
		return isPacking;
	}

	public void setIsPacking(String isPacking) {
		this.isPacking = isPacking;
	}

	public String getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}

	public String getStockMode() {
		return stockMode;
	}

	public void setStockMode(String stockMode) {
		this.stockMode = stockMode;
	}

	public String getInputTax() {
		return inputTax;
	}

	public void setInputTax(String inputTax) {
		this.inputTax = inputTax;
	}

	public String getOutputTax() {
		return outputTax;
	}

	public void setOutputTax(String outputTax) {
		this.outputTax = outputTax;
	}

	public String getSalesTax() {
		return salesTax;
	}

	public void setSalesTax(String salesTax) {
		this.salesTax = salesTax;
	}

	public String getPurchasePrice() {
		return purchasePrice;
	}

	public void setPurchasePrice(String purchasePrice) {
		this.purchasePrice = purchasePrice;
	}

	public String getBuyingPrice() {
		return buyingPrice;
	}

	public void setBuyingPrice(String buyingPrice) {
		this.buyingPrice = buyingPrice;
	}

	public String getProcessType() {
		return processType;
	}

	public void setProcessType(String processType) {
		this.processType = processType;
	}

	public String getOriginLand() {
		return originLand;
	}

	public void setOriginLand(String originLand) {
		this.originLand = originLand;
	}

	public String getOriginLand2() {
		return originLand2;
	}

	public void setOriginLand2(String originLand2) {
		this.originLand2 = originLand2;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getIsPromotion() {
		return isPromotion;
	}

	public void setIsPromotion(String isPromotion) {
		this.isPromotion = isPromotion;
	}

	public String getIsAdjustPrice() {
		return isAdjustPrice;
	}

	public void setIsAdjustPrice(String isAdjustPrice) {
		this.isAdjustPrice = isAdjustPrice;
	}

	public String getField1() {
		return field1;
	}

	public void setField1(String field1) {
		this.field1 = field1;
	}

	public String getField2() {
		return field2;
	}

	public void setField2(String field2) {
		this.field2 = field2;
	}

	public String getField3() {
		return field3;
	}

	public void setField3(String field3) {
		this.field3 = field3;
	}

	public String getField4() {
		return field4;
	}

	public void setField4(String field4) {
		this.field4 = field4;
	}

	public String getField5() {
		return field5;
	}

	public void setField5(String field5) {
		this.field5 = field5;
	}

	
	
	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getSupplyName() {
		return supplyName;
	}

	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getMinShoppeProSid() {
		return minShoppeProSid;
	}

	public void setMinShoppeProSid(String minShoppeProSid) {
		this.minShoppeProSid = minShoppeProSid;
	}

	public String getMaxShoppeProSid() {
		return maxShoppeProSid;
	}

	public void setMaxShoppeProSid(String maxShoppeProSid) {
		this.maxShoppeProSid = maxShoppeProSid;
	}

	public String getMinProductDetailSid() {
		return minProductDetailSid;
	}

	public void setMinProductDetailSid(String minProductDetailSid) {
		this.minProductDetailSid = minProductDetailSid;
	}

	public String getMaxProductDetailSid() {
		return maxProductDetailSid;
	}

	public void setMaxProductDetailSid(String maxProductDetailSid) {
		this.maxProductDetailSid = maxProductDetailSid;
	}

	@Override
	public String toString() {
		return "PcmShoppeProductVo{" +
				"sid=" + sid +
				", shoppeProSid='" + shoppeProSid + '\'' +
				", minShoppeProSid='" + minShoppeProSid + '\'' +
				", maxShoppeProSid='" + maxShoppeProSid + '\'' +
				", productDetailSid='" + productDetailSid + '\'' +
				", minProductDetailSid='" + minProductDetailSid + '\'' +
				", maxProductDetailSid='" + maxProductDetailSid + '\'' +
				", shoppeSid='" + shoppeSid + '\'' +
				", supplySid='" + supplySid + '\'' +
				", brandSid='" + brandSid + '\'' +
				", categorySid='" + categorySid + '\'' +
				", rateCode='" + rateCode + '\'' +
				", shoppeProName='" + shoppeProName + '\'' +
				", shoppeProAlias='" + shoppeProAlias + '\'' +
				", saleStatus='" + saleStatus + '\'' +
				", saleUnitCode='" + saleUnitCode + '\'' +
				", erpproductcode='" + erpproductcode + '\'' +
				", supplyProductCode='" + supplyProductCode + '\'' +
				", tmsParam='" + tmsParam + '\'' +
				", discountLimit='" + discountLimit + '\'' +
				", isPacking='" + isPacking + '\'' +
				", originalPrice='" + originalPrice + '\'' +
				", stockMode='" + stockMode + '\'' +
				", inputTax='" + inputTax + '\'' +
				", outputTax='" + outputTax + '\'' +
				", salesTax='" + salesTax + '\'' +
				", purchasePrice='" + purchasePrice + '\'' +
				", buyingPrice='" + buyingPrice + '\'' +
				", processType='" + processType + '\'' +
				", originLand='" + originLand + '\'' +
				", originLand2='" + originLand2 + '\'' +
				", orderType='" + orderType + '\'' +
				", isPromotion='" + isPromotion + '\'' +
				", isAdjustPrice='" + isAdjustPrice + '\'' +
				", field1='" + field1 + '\'' +
				", field2='" + field2 + '\'' +
				", field3='" + field3 + '\'' +
				", field4='" + field4 + '\'' +
				", field5='" + field5 + '\'' +
				", shopName='" + shopName + '\'' +
				", brandName='" + brandName + '\'' +
				", categoryName='" + categoryName + '\'' +
				", supplyName='" + supplyName + '\'' +
				'}';
	}
}