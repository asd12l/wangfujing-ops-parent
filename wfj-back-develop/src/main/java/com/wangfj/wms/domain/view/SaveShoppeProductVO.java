package com.wangfj.wms.domain.view;

/**
 * 新增专柜商品
 * 
 * @Class Name SaveShoppeProductVO
 * @Author wangsy
 * @Create In 2015年8月24日
 */
public class SaveShoppeProductVO {

	private String skuSid;/* skuSID */
	private String skuName;/* sku名称 */
	private String shopCode; /* 门店编码 */
	private String counterCode; /* 专柜SID */
	private String supplierCode;/* 供应商SID */
	private String manageCateGory;/* 管理分类SID */
	private String finalClassiFicationCode;/* 统计分类SID */
	private String unitCode;/* 销售单位编码（单位字典中的编码）(销售单位) */
	private String productName;/* 商品名称/超市商品为注册商标名 */
	private String productAbbr;/* 商品简称(最多18个中文字符)。 */
	private String erpProductCode;/* 商品大码（商品对应的门店ERP编码） */
	private String marketPrice;/* 吊牌价（原价） */
	private String salePrice;/* 销售价 */
	private String inventory;/* 库存数 */
	private String purchasePrice;/* 扣率/进价 */
	private String buyingPrice;/* 扣率/含税进价 */
	private String rate;/* 扣率 */
	private String offerNumber;/* 要约号 */
	private String inputTax;/* 进项税 */
	private String outputTax;/* 销项税 */
	private String consumptionTax;/* 消费税 */
	private String discountLimit;/* 折扣底限 */
	private String isAdjustPrice;/* 是否允许ERP调价 */
	private String isPromotion;/* 是否允许ERP促销 */
	private String type;/* 类型（0百货，1超市) */
	private String modelNum;/* 货号 */

	private String processingType;/* 加工类型 */
	private String shopBrandSid;/* 门店品牌SID */
	private String barcodes;/* 自编商品条码/国标条码 */
	private String entryNumber;/* 录入人员编号 */
	private String procurementPersonnelNumber;/* 采购人员编号 */

	public String getModelNum() {
		return modelNum;
	}

	public void setModelNum(String modelNum) {
		this.modelNum = modelNum;
	}

	public String getSkuSid() {
		return skuSid;
	}

	public void setSkuSid(String skuSid) {
		this.skuSid = skuSid;
	}

	public String getShopCode() {
		return shopCode;
	}

	public void setShopCode(String shopCode) {
		this.shopCode = shopCode;
	}

	public String getCounterCode() {
		return counterCode;
	}

	public void setCounterCode(String counterCode) {
		this.counterCode = counterCode;
	}

	public String getSupplierCode() {
		return supplierCode;
	}

	public void setSupplierCode(String supplierCode) {
		this.supplierCode = supplierCode;
	}

	public String getManageCateGory() {
		return manageCateGory;
	}

	public void setManageCateGory(String manageCateGory) {
		this.manageCateGory = manageCateGory;
	}

	public String getFinalClassiFicationCode() {
		return finalClassiFicationCode;
	}

	public void setFinalClassiFicationCode(String finalClassiFicationCode) {
		this.finalClassiFicationCode = finalClassiFicationCode;
	}

	public String getUnitCode() {
		return unitCode;
	}

	public void setUnitCode(String unitCode) {
		this.unitCode = unitCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductAbbr() {
		return productAbbr;
	}

	public void setProductAbbr(String productAbbr) {
		this.productAbbr = productAbbr;
	}

	public String getErpProductCode() {
		return erpProductCode;
	}

	public void setErpProductCode(String erpProductCode) {
		this.erpProductCode = erpProductCode;
	}

	public String getMarketPrice() {
		return marketPrice;
	}

	public void setMarketPrice(String marketPrice) {
		this.marketPrice = marketPrice;
	}

	public String getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}

	public String getInventory() {
		return inventory;
	}

	public void setInventory(String inventory) {
		this.inventory = inventory;
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

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public String getOfferNumber() {
		return offerNumber;
	}

	public void setOfferNumber(String offerNumber) {
		this.offerNumber = offerNumber;
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

	public String getConsumptionTax() {
		return consumptionTax;
	}

	public void setConsumptionTax(String consumptionTax) {
		this.consumptionTax = consumptionTax;
	}

	public String getDiscountLimit() {
		return discountLimit;
	}

	public void setDiscountLimit(String discountLimit) {
		this.discountLimit = discountLimit;
	}

	public String getIsAdjustPrice() {
		return isAdjustPrice;
	}

	public void setIsAdjustPrice(String isAdjustPrice) {
		this.isAdjustPrice = isAdjustPrice;
	}

	public String getIsPromotion() {
		return isPromotion;
	}

	public void setIsPromotion(String isPromotion) {
		this.isPromotion = isPromotion;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getProcessingType() {
		return processingType;
	}

	public void setProcessingType(String processingType) {
		this.processingType = processingType;
	}

	public String getShopBrandSid() {
		return shopBrandSid;
	}

	public void setShopBrandSid(String shopBrandSid) {
		this.shopBrandSid = shopBrandSid;
	}

	public String getEntryNumber() {
		return entryNumber;
	}

	public void setEntryNumber(String entryNumber) {
		this.entryNumber = entryNumber;
	}

	public String getProcurementPersonnelNumber() {
		return procurementPersonnelNumber;
	}

	public void setProcurementPersonnelNumber(String procurementPersonnelNumber) {
		this.procurementPersonnelNumber = procurementPersonnelNumber;
	}

	public String getBarcodes() {
		return barcodes;
	}

	public void setBarcodes(String barcodes) {
		this.barcodes = barcodes;
	}

	public String getSkuName() {
		return skuName;
	}

	public void setSkuName(String skuName) {
		this.skuName = skuName;
	}

	@Override
	public String toString() {
		return "SaveShoppeProductVO [skuSid=" + skuSid + ", skuName=" + skuName + ", shopCode="
				+ shopCode + ", counterCode=" + counterCode + ", supplierCode=" + supplierCode
				+ ", manageCateGory=" + manageCateGory + ", unitCode=" + unitCode
				+ ", productName=" + productName + ", productAbbr=" + productAbbr
				+ ", erpProductCode=" + erpProductCode + ", marketPrice=" + marketPrice
				+ ", salePrice=" + salePrice + ", inventory=" + inventory + ", rate=" + rate
				+ ", offerNumber=" + offerNumber + ", inputTax=" + inputTax + ", outputTax="
				+ outputTax + ", consumptionTax=" + consumptionTax + ", discountLimit="
				+ discountLimit + ", isAdjustPrice=" + isAdjustPrice + ", isPromotion="
				+ isPromotion + ", type=" + type + ", processingType=" + processingType
				+ ", shopBrandSid=" + shopBrandSid + ", barcodes=" + barcodes + ", entryNumber="
				+ entryNumber + ", procurementPersonnelNumber=" + procurementPersonnelNumber + "]";
	}

}
