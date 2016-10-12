package com.wangfj.order.controller.suppot.order;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class OrderItemDto {
private String orderNo; //订单号
	
	private Integer rowNo;  //行号

	private String orderItemNo; //商品行项目编号
	
	private String itemStatus; //商品行项目状态
	
	private String shoppeProName; //商品名称 

	private String shoppeNo; //专柜编号

	private String shoppeName; //专柜名称

	private String shopNo; //门店编号

	private String storeName; //门店名称

	private String supplyCode; //供应商编码

	private String suppllyName; //供应商名称

	private String supplyProductNo; //专柜商品编号

	private String supplyInnerProdNo; //供应商内部商品编码

	private String erpProductCode; //ERP商品编码

	private String unit; //商品单位

	private String brandNo; //中台品牌

	private String brandName; //中台品牌名称

	private String barcode; //条形码

	private String spuNo; //产品编号

	private String skuNo; //sku编号

	private String colorNo; //颜色

	private String colorName; //颜色名称

	private String sizeNo; //规格

	private String sizeName; //规格名称

	private BigDecimal standPrice; //商品标准价

	private BigDecimal salesPrice; //商品售价

	private String priceType; //价格类型

	private Integer refundNum; //退货数量

	private Integer allowRefundNum; //允许退货数量

	private Integer stockoutAmount; //缺货数量

	private Integer saleSum; //销售数量

	private Integer pickSum; //提货数量

	private BigDecimal paymentAmount; //商品折后总额
	
	private BigDecimal totalDiscount; //商品优惠金额

	private String shippingAttribute; //物流属性

	private String productName; //商品描述

	private String isGift; //是否为赠品

	private String url; //商品图片地址

	private String businessMode; //经营方式

	private String warehouseType; //虚库类型

	private BigDecimal shippingFeeSplit; //运费分摊金额

	private BigDecimal deliveryShippingFeeSplit; //实际运费分摊

	private BigDecimal invoiceAmount; //发票金额

	private String hasRecommanded; //是否已评论

	private String deleteFlag; //删除标记

	private String statisticsCateNo; //统计分类

	private String mangerCateNo; //管理分类

	private String cashIncomeFlag; //标志收银损益在商品上还是在运费上

	private Date createdTime; //创建时间

	private Date latestUpdateTime; //最后更新时间

	private String latestUpdateMan; //最后更新人

	private String productOnlySn; //出库商品唯一编号
	
	private String stockMode;//库存方式 
	
	private BigDecimal bankServiceCharge;//银行手续费
	
	private String materialNum;//货号
	
	private String isPayReduce;//是否支付减
	
	private String oid;
	
	private String industryCategoryOne;//工业一级分类
	
	private String isGold;//是否为黄金珠宝类
	
	private String isSpecial;//是否为特例品
	
	private String proType;//商品分类

	private List<OrderItemPromotionSplitDto> orderItemPromotionSplitDto;

	private List<OrderItemGetSplitDto> prOrderGetSplitDto;
	
	private List<OrderItemPaymentSplitDto> orderItemPaymentSplitList;
	
	private String createdTimeStr;
	private String latestUpdateTimeStr;

	
	
	public String getCreatedTimeStr() {
		return createdTimeStr;
	}

	public void setCreatedTimeStr(String createdTimeStr) {
		this.createdTimeStr = createdTimeStr;
	}

	public String getLatestUpdateTimeStr() {
		return latestUpdateTimeStr;
	}

	public void setLatestUpdateTimeStr(String latestUpdateTimeStr) {
		this.latestUpdateTimeStr = latestUpdateTimeStr;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getOrderItemNo() {
		return orderItemNo;
	}

	public void setOrderItemNo(String orderItemNo) {
		this.orderItemNo = orderItemNo;
	}

	public String getShoppeNo() {
		return shoppeNo;
	}

	public void setShoppeNo(String shoppeNo) {
		this.shoppeNo = shoppeNo;
	}

	public String getShoppeName() {
		return shoppeName;
	}

	public void setShoppeName(String shoppeName) {
		this.shoppeName = shoppeName;
	}

	public String getShopNo() {
		return shopNo;
	}

	public void setShopNo(String shopNo) {
		this.shopNo = shopNo;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getSupplyCode() {
		return supplyCode;
	}

	public void setSupplyCode(String supplyCode) {
		this.supplyCode = supplyCode;
	}

	public String getSuppllyName() {
		return suppllyName;
	}

	public void setSuppllyName(String suppllyName) {
		this.suppllyName = suppllyName;
	}

	public String getSupplyProductNo() {
		return supplyProductNo;
	}

	public void setSupplyProductNo(String supplyProductNo) {
		this.supplyProductNo = supplyProductNo;
	}

	public String getSupplyInnerProdNo() {
		return supplyInnerProdNo;
	}

	public void setSupplyInnerProdNo(String supplyInnerProdNo) {
		this.supplyInnerProdNo = supplyInnerProdNo;
	}

	public String getErpProductCode() {
		return erpProductCode;
	}

	public void setErpProductCode(String erpProductCode) {
		this.erpProductCode = erpProductCode;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getBrandNo() {
		return brandNo;
	}

	public void setBrandNo(String brandNo) {
		this.brandNo = brandNo;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

	public String getSpuNo() {
		return spuNo;
	}

	public void setSpuNo(String spuNo) {
		this.spuNo = spuNo;
	}

	public String getSkuNo() {
		return skuNo;
	}

	public void setSkuNo(String skuNo) {
		this.skuNo = skuNo;
	}

	public String getColorNo() {
		return colorNo;
	}

	public void setColorNo(String colorNo) {
		this.colorNo = colorNo;
	}

	public String getColorName() {
		return colorName;
	}

	public void setColorName(String colorName) {
		this.colorName = colorName;
	}

	public String getSizeNo() {
		return sizeNo;
	}

	public void setSizeNo(String sizeNo) {
		this.sizeNo = sizeNo;
	}

	public String getSizeName() {
		return sizeName;
	}

	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}

	public BigDecimal getStandPrice() {
		return standPrice;
	}

	public void setStandPrice(BigDecimal standPrice) {
		this.standPrice = standPrice;
	}

	public BigDecimal getSalesPrice() {
		return salesPrice;
	}

	public void setSalesPrice(BigDecimal salesPrice) {
		this.salesPrice = salesPrice;
	}

	public String getPriceType() {
		return priceType;
	}

	public void setPriceType(String priceType) {
		this.priceType = priceType;
	}

	public Integer getRefundNum() {
		return refundNum;
	}

	public void setRefundNum(Integer refundNum) {
		this.refundNum = refundNum;
	}

	public Integer getAllowRefundNum() {
		return allowRefundNum;
	}

	public void setAllowRefundNum(Integer allowRefundNum) {
		this.allowRefundNum = allowRefundNum;
	}

	public Integer getStockoutAmount() {
		return stockoutAmount;
	}

	public void setStockoutAmount(Integer stockoutAmount) {
		this.stockoutAmount = stockoutAmount;
	}

	public Integer getSaleSum() {
		return saleSum;
	}

	public void setSaleSum(Integer saleSum) {
		this.saleSum = saleSum;
	}

	public Integer getPickSum() {
		return pickSum;
	}

	public void setPickSum(Integer pickSum) {
		this.pickSum = pickSum;
	}

	public BigDecimal getPaymentAmount() {
		return paymentAmount;
	}

	public void setPaymentAmount(BigDecimal paymentAmount) {
		this.paymentAmount = paymentAmount;
	}

	public String getShippingAttribute() {
		return shippingAttribute;
	}

	public void setShippingAttribute(String shippingAttribute) {
		this.shippingAttribute = shippingAttribute;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getIsGift() {
		return isGift;
	}

	public void setIsGift(String isGift) {
		this.isGift = isGift;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getBusinessMode() {
		return businessMode;
	}

	public void setBusinessMode(String businessMode) {
		this.businessMode = businessMode;
	}

	public String getWarehouseType() {
		return warehouseType;
	}

	public void setWarehouseType(String warehouseType) {
		this.warehouseType = warehouseType;
	}

	public BigDecimal getShippingFeeSplit() {
		return shippingFeeSplit;
	}

	public void setShippingFeeSplit(BigDecimal shippingFeeSplit) {
		this.shippingFeeSplit = shippingFeeSplit;
	}

	public BigDecimal getDeliveryShippingFeeSplit() {
		return deliveryShippingFeeSplit;
	}

	public void setDeliveryShippingFeeSplit(BigDecimal deliveryShippingFeeSplit) {
		this.deliveryShippingFeeSplit = deliveryShippingFeeSplit;
	}

	public BigDecimal getInvoiceAmount() {
		return invoiceAmount;
	}

	public void setInvoiceAmount(BigDecimal invoiceAmount) {
		this.invoiceAmount = invoiceAmount;
	}

	public String getHasRecommanded() {
		return hasRecommanded;
	}

	public void setHasRecommanded(String hasRecommanded) {
		this.hasRecommanded = hasRecommanded;
	}

	public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getStatisticsCateNo() {
		return statisticsCateNo;
	}

	public void setStatisticsCateNo(String statisticsCateNo) {
		this.statisticsCateNo = statisticsCateNo;
	}

	public String getMangerCateNo() {
		return mangerCateNo;
	}

	public void setMangerCateNo(String mangerCateNo) {
		this.mangerCateNo = mangerCateNo;
	}

	public String getCashIncomeFlag() {
		return cashIncomeFlag;
	}

	public void setCashIncomeFlag(String cashIncomeFlag) {
		this.cashIncomeFlag = cashIncomeFlag;
	}

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public Date getLatestUpdateTime() {
		return latestUpdateTime;
	}

	public void setLatestUpdateTime(Date latestUpdateTime) {
		this.latestUpdateTime = latestUpdateTime;
	}

	public String getLatestUpdateMan() {
		return latestUpdateMan;
	}

	public void setLatestUpdateMan(String latestUpdateMan) {
		this.latestUpdateMan = latestUpdateMan;
	}

	public String getProductOnlySn() {
		return productOnlySn;
	}

	public void setProductOnlySn(String productOnlySn) {
		this.productOnlySn = productOnlySn;
	}


	public List<OrderItemGetSplitDto> getPrOrderGetSplitDto() {
		return prOrderGetSplitDto;
	}

	public void setPrOrderGetSplitDto(List<OrderItemGetSplitDto> prOrderGetSplitDto) {
		this.prOrderGetSplitDto = prOrderGetSplitDto;
	}

	public String getShoppeProName() {
		return shoppeProName;
	}

	public void setShoppeProName(String shoppeProName) {
		this.shoppeProName = shoppeProName;
	}

	public List<OrderItemPaymentSplitDto> getOrderItemPaymentSplitList() {
		return orderItemPaymentSplitList;
	}

	public void setOrderItemPaymentSplitList(List<OrderItemPaymentSplitDto> orderItemPaymentSplitList) {
		this.orderItemPaymentSplitList = orderItemPaymentSplitList;
	}

	public List<OrderItemPromotionSplitDto> getOrderItemPromotionSplitDto() {
		return orderItemPromotionSplitDto;
	}

	public void setOrderItemPromotionSplitDto(List<OrderItemPromotionSplitDto> orderItemPromotionSplitDto) {
		this.orderItemPromotionSplitDto = orderItemPromotionSplitDto;
	}

	public Integer getRowNo() {
		return rowNo;
	}

	public void setRowNo(Integer rowNo) {
		this.rowNo = rowNo;
	}

	public String getStockMode() {
		return stockMode;
	}

	public void setStockMode(String stockMode) {
		this.stockMode = stockMode;
	}

	public BigDecimal getTotalDiscount() {
		return totalDiscount;
	}

	public void setTotalDiscount(BigDecimal totalDiscount) {
		this.totalDiscount = totalDiscount;
	}

	public String getItemStatus() {
		return itemStatus;
	}

	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}

	public BigDecimal getBankServiceCharge() {
		return bankServiceCharge;
	}

	public void setBankServiceCharge(BigDecimal bankServiceCharge) {
		this.bankServiceCharge = bankServiceCharge;
	}

	public String getMaterialNum() {
		return materialNum;
	}

	public void setMaterialNum(String materialNum) {
		this.materialNum = materialNum;
	}

	public String getIsPayReduce() {
		return isPayReduce;
	}

	public void setIsPayReduce(String isPayReduce) {
		this.isPayReduce = isPayReduce;
	}

	public String getOid() {
		return oid;
	}

	public void setOid(String oid) {
		this.oid = oid;
	}

	public String getIndustryCategoryOne() {
		return industryCategoryOne;
	}

	public void setIndustryCategoryOne(String industryCategoryOne) {
		this.industryCategoryOne = industryCategoryOne;
	}

	public String getIsGold() {
		return isGold;
	}

	public void setIsGold(String isGold) {
		this.isGold = isGold;
	}

	public String getIsSpecial() {
		return isSpecial;
	}

	public void setIsSpecial(String isSpecial) {
		this.isSpecial = isSpecial;
	}

	public String getProType() {
		return proType;
	}

	public void setProType(String proType) {
		this.proType = proType;
	}

	@Override
	public String toString() {
		return "OrderItemDto [orderNo=" + orderNo + ", rowNo=" + rowNo
				+ ", orderItemNo=" + orderItemNo + ", itemStatus=" + itemStatus
				+ ", shoppeProName=" + shoppeProName + ", shoppeNo=" + shoppeNo
				+ ", shoppeName=" + shoppeName + ", shopNo=" + shopNo
				+ ", storeName=" + storeName + ", supplyCode=" + supplyCode
				+ ", suppllyName=" + suppllyName + ", supplyProductNo="
				+ supplyProductNo + ", supplyInnerProdNo=" + supplyInnerProdNo
				+ ", erpProductCode=" + erpProductCode + ", unit=" + unit
				+ ", brandNo=" + brandNo + ", brandName=" + brandName
				+ ", barcode=" + barcode + ", spuNo=" + spuNo + ", skuNo="
				+ skuNo + ", colorNo=" + colorNo + ", colorName=" + colorName
				+ ", sizeNo=" + sizeNo + ", sizeName=" + sizeName
				+ ", standPrice=" + standPrice + ", salesPrice=" + salesPrice
				+ ", priceType=" + priceType + ", refundNum=" + refundNum
				+ ", allowRefundNum=" + allowRefundNum + ", stockoutAmount="
				+ stockoutAmount + ", saleSum=" + saleSum + ", pickSum="
				+ pickSum + ", paymentAmount=" + paymentAmount
				+ ", totalDiscount=" + totalDiscount + ", shippingAttribute="
				+ shippingAttribute + ", productName=" + productName
				+ ", isGift=" + isGift + ", url=" + url + ", businessMode="
				+ businessMode + ", warehouseType=" + warehouseType
				+ ", shippingFeeSplit=" + shippingFeeSplit
				+ ", deliveryShippingFeeSplit=" + deliveryShippingFeeSplit
				+ ", invoiceAmount=" + invoiceAmount + ", hasRecommanded="
				+ hasRecommanded + ", deleteFlag=" + deleteFlag
				+ ", statisticsCateNo=" + statisticsCateNo + ", mangerCateNo="
				+ mangerCateNo + ", cashIncomeFlag=" + cashIncomeFlag
				+ ", createdTime=" + createdTime + ", latestUpdateTime="
				+ latestUpdateTime + ", latestUpdateMan=" + latestUpdateMan
				+ ", productOnlySn=" + productOnlySn + ", stockMode="
				+ stockMode + ", bankServiceCharge=" + bankServiceCharge
				+ ", materialNum=" + materialNum + ", isPayReduce="
				+ isPayReduce + ", oid=" + oid + ", industryCategoryOne="
				+ industryCategoryOne + ", isGold=" + isGold + ", isSpecial="
				+ isSpecial + ", proType=" + proType
				+ ", orderItemPromotionSplitDto=" + orderItemPromotionSplitDto
				+ ", prOrderGetSplitDto=" + prOrderGetSplitDto
				+ ", orderItemPaymentSplitList=" + orderItemPaymentSplitList
				+ ", createdTimeStr=" + createdTimeStr
				+ ", latestUpdateTimeStr=" + latestUpdateTimeStr + "]";
	}

}
