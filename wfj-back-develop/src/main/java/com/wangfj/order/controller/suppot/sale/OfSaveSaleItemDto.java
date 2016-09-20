package com.wangfj.order.controller.suppot.sale;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class OfSaveSaleItemDto {
	private Long sid;

    private String salesItemNo;

    private String shoppeProName;

    private String orderNo;

    private String saleNo;

    private String skuNo;

    private String spuNo;

    private String supplyProductNo;

    private String erpProductNo;

    private String supplyInnerProdNo;

    private String unit;

    private String brandNo;

    private String brandName;

    private String barcode;

    private String colorNo;

    private String sizeNo;

    private String colorName;

    private String sizeName;

    private String managerCateNo;

    private String statisticsCateNo;

    private BigDecimal standPrice;

    private BigDecimal salePrice;

    private String priceType;

    private Integer saleSum;

    private BigDecimal paymentAmount;
    
    private BigDecimal totalDiscount; //商品优惠金额

    private String shippingAttribute;

    private String isGift;

    private BigDecimal shippingFeeSplit;

    private Integer stockoutAmount;

    private String hasReturned;

    private String deleteFlag;

    private String cashIncomeFlag;

    private Date createdTime;
    
    private Date latestUpdateTime;
    
    private String createdTimeStr;
    
    private String latestUpdateTimeStr;
    
    private String latestUpdateMan;

    private Integer refundNum;

    private Integer pickSum;

    private String discountCode;
    
    private Integer rowNo;
    
    private String productClass;
    
    private String productType;
    
    private BigDecimal incomeAmount;
    
    private BigDecimal tax;
    
    private String stockMode;//库存方式 
    
    private String businessMode;//经营方式
    
    private String discountLimit;//折扣底限
	
	private String shoppeGroup;//柜组
	
	private Integer codeType;//大码类型：0  价格码,1 长期统码,2 促销统码,3 特卖统码,4 扣率码,5 促销扣率码,6 单品码 	
	
	private BigDecimal bankServiceCharge;//银行手续费
	
	private String materialNum;//货号
	
	private Date libraryOutTime; //出库时间 
	
	private String libraryOutTimeStr;
    
    private List<OfPromotionSplitDto> promotionSplitDto;
	
	private List<OfOrderGetSplitDto> ofOrderGetSplitDto;


	public Long getSid() {
        return sid;
    }

    public void setSid(Long sid) {
        this.sid = sid;
    }

    public String getSalesItemNo() {
        return salesItemNo;
    }

    public void setSalesItemNo(String salesItemNo) {
        this.salesItemNo = salesItemNo;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getSaleNo() {
        return saleNo;
    }

    public void setSaleNo(String saleNo) {
        this.saleNo = saleNo;
    }

    public String getSkuNo() {
        return skuNo;
    }

    public void setSkuNo(String skuNo) {
        this.skuNo = skuNo;
    }

    public String getSpuNo() {
        return spuNo;
    }

    public void setSpuNo(String spuNo) {
        this.spuNo = spuNo;
    }

    public String getSupplyProductNo() {
        return supplyProductNo;
    }

    public void setSupplyProductNo(String supplyProductNo) {
        this.supplyProductNo = supplyProductNo;
    }

    public String getErpProductNo() {
        return erpProductNo;
    }

    public void setErpProductNo(String erpProductNo) {
        this.erpProductNo = erpProductNo;
    }

    public String getSupplyInnerProdNo() {
        return supplyInnerProdNo;
    }

    public void setSupplyInnerProdNo(String supplyInnerProdNo) {
        this.supplyInnerProdNo = supplyInnerProdNo;
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

    public String getColorNo() {
        return colorNo;
    }

    public void setColorNo(String colorNo) {
        this.colorNo = colorNo;
    }

    public String getSizeNo() {
        return sizeNo;
    }

    public void setSizeNo(String sizeNo) {
        this.sizeNo = sizeNo;
    }

    public String getColorName() {
        return colorName;
    }

    public void setColorName(String colorName) {
        this.colorName = colorName;
    }

    public String getSizeName() {
        return sizeName;
    }

    public void setSizeName(String sizeName) {
        this.sizeName = sizeName;
    }

    public String getManagerCateNo() {
        return managerCateNo;
    }

    public void setManagerCateNo(String managerCateNo) {
        this.managerCateNo = managerCateNo;
    }

    public String getStatisticsCateNo() {
        return statisticsCateNo;
    }

    public void setStatisticsCateNo(String statisticsCateNo) {
        this.statisticsCateNo = statisticsCateNo;
    }

    public BigDecimal getStandPrice() {
        return standPrice;
    }

    public void setStandPrice(BigDecimal standPrice) {
        this.standPrice = standPrice;
    }

    public BigDecimal getSalePrice() {
        return salePrice;
    }

    public void setSalePrice(BigDecimal salePrice) {
        this.salePrice = salePrice;
    }

    public String getPriceType() {
        return priceType;
    }

    public void setPriceType(String priceType) {
        this.priceType = priceType;
    }

    public Integer getSaleSum() {
        return saleSum;
    }

    public void setSaleSum(Integer saleSum) {
        this.saleSum = saleSum;
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

    public String getIsGift() {
        return isGift;
    }

    public void setIsGift(String isGift) {
        this.isGift = isGift;
    }

    public BigDecimal getShippingFeeSplit() {
		return shippingFeeSplit;
	}

	public void setShippingFeeSplit(BigDecimal shippingFeeSplit) {
		this.shippingFeeSplit = shippingFeeSplit;
	}

	public Integer getStockoutAmount() {
		return stockoutAmount;
	}

	public void setStockoutAmount(Integer stockoutAmount) {
		this.stockoutAmount = stockoutAmount;
	}

	public String getHasReturned() {
        return hasReturned;
    }

    public void setHasReturned(String hasReturned) {
        this.hasReturned = hasReturned;
    }

    public String getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(String deleteFlag) {
        this.deleteFlag = deleteFlag;
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

    public Integer getRefundNum() {
        return refundNum;
    }

    public void setRefundNum(Integer refundNum) {
        this.refundNum = refundNum;
    }

    public Integer getPickSum() {
        return pickSum;
    }

    public void setPickSum(Integer pickSum) {
        this.pickSum = pickSum;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

	public Integer getRowNo() {
		return rowNo;
	}

	public void setRowNo(Integer rowNo) {
		this.rowNo = rowNo;
	}

	public String getProductClass() {
		return productClass;
	}

	public void setProductClass(String productClass) {
		this.productClass = productClass;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public BigDecimal getIncomeAmount() {
		return incomeAmount;
	}

	public void setIncomeAmount(BigDecimal incomeAmount) {
		this.incomeAmount = incomeAmount;
	}

	public BigDecimal getTax() {
		return tax;
	}

	public void setTax(BigDecimal tax) {
		this.tax = tax;
	}

	
	public List<OfPromotionSplitDto> getPromotionSplitDto() {
		return promotionSplitDto;
	}

	public void setPromotionSplitDto(List<OfPromotionSplitDto> promotionSplitDto) {
		this.promotionSplitDto = promotionSplitDto;
	}

	public List<OfOrderGetSplitDto> getOfOrderGetSplitDto() {
		return ofOrderGetSplitDto;
	}

	public void setOfOrderGetSplitDto(List<OfOrderGetSplitDto> ofOrderGetSplitDto) {
		this.ofOrderGetSplitDto = ofOrderGetSplitDto;
	}

	public String getShoppeProName() {
		return shoppeProName;
	}

	public void setShoppeProName(String shoppeProName) {
		this.shoppeProName = shoppeProName;
	}

	public String getStockMode() {
		return stockMode;
	}

	public void setStockMode(String stockMode) {
		this.stockMode = stockMode;
	}

	public String getBusinessMode() {
		return businessMode;
	}

	public void setBusinessMode(String businessMode) {
		this.businessMode = businessMode;
	}

	public BigDecimal getTotalDiscount() {
		return totalDiscount;
	}

	public void setTotalDiscount(BigDecimal totalDiscount) {
		this.totalDiscount = totalDiscount;
	}

	public String getDiscountLimit() {
		return discountLimit;
	}

	public void setDiscountLimit(String discountLimit) {
		this.discountLimit = discountLimit;
	}

	public String getShoppeGroup() {
		return shoppeGroup;
	}

	public void setShoppeGroup(String shoppeGroup) {
		this.shoppeGroup = shoppeGroup;
	}

	public Integer getCodeType() {
		return codeType;
	}

	public void setCodeType(Integer codeType) {
		this.codeType = codeType;
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

	public Date getLibraryOutTime() {
		return libraryOutTime;
	}

	public void setLibraryOutTime(Date libraryOutTime) {
		this.libraryOutTime = libraryOutTime;
	}

	public String getLibraryOutTimeStr() {
		return libraryOutTimeStr;
	}

	public void setLibraryOutTimeStr(String libraryOutTimeStr) {
		this.libraryOutTimeStr = libraryOutTimeStr;
	}

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
}
