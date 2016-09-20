package com.wangfj.order.controller.suppot.refund;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class SaveOfRefundItemDTO {
	private Integer rowNo;// 行号
	private String refundItemNo;// 退货单商品行
	private String skuNo;// sku编号

	private String spuNo;// spu编号

	private String supplyProductNo;// 专柜商品编号

	private String erpProductNo;// ERP编号

	private String supplyProductInnerCode;// 供应商商品内部编码

	private String unit;// 商品单位

	private String barCode;// 条形码

	private String brandNo;// 品牌

	private String brandName;// 品牌名称

	private String colorNo;// 颜色编号

	private String colorName;// 颜色名称

	private String sizeNo;// 规格编号

	private String sizeName;// 规格名称

	private Integer refundNum;// 退货数量

	private BigDecimal salePrice;// 销售价

	private String isGift;// 是否为赠品
	private Date createTime;// 创建时间
	private String discountCode;// 扣率码
	private List<OfPromotionSplitRefundDto>  promotionSplits; //促销分摊信息
	private List<OfRefundGetSplitDto>  getSplits;//后返利分摊接收信息DTO
	private List<OfPaymentsSplitReturnDto> paymentsSplitReturns;//退货支付介质分摊
	private List<OfDeductionSplitDTO> prDeductionSplitDTO;//退货支付介质分摊
	private BigDecimal actualRefundAmount;//实退金额
	private BigDecimal refundAmount;// 应退金额
	private String refundNo;// 退货单号
	private String productClass;// 大中小类

	private String productType;// 商品类别
	private BigDecimal incomeAmount;
	private BigDecimal tax;
	private String managerCateNo;//
	private String staticsCateNo;// 统计分类
	private String saleItemNo;//销售单item
	private String saleItemRowNo;//销售单itemRow
	private String shoppeProName;//专柜商品名称
	private String refundReasionDesc;//退货原因
	private String shoppeGroup;//柜组
	private String bankServiceCharge;//商品编码类型（统码、特卖码等）
	private String materialNum;//折扣限额（底线）
	private String acceptancePhase;//验收状态
	private String unqualifiedNum;//不合格商品数量
	private String refuseToReturnReason;//拒退货原因
	private String xxhc;// 先销后采标识
	private String refundReasionNo;//退货原因
	
	private String refundReasion;//退货原因
	
	
	public String getRefundReasionNo() {
		return refundReasionNo;
	}
	public void setRefundReasionNo(String refundReasionNo) {
		this.refundReasionNo = refundReasionNo;
	}
	public List<OfDeductionSplitDTO> getPrDeductionSplitDTO() {
		return prDeductionSplitDTO;
	}
	public void setPrDeductionSplitDTO(List<OfDeductionSplitDTO> prDeductionSplitDTO) {
		this.prDeductionSplitDTO = prDeductionSplitDTO;
	}
	public String getXxhc() {
		return xxhc;
	}
	public void setXxhc(String xxhc) {
		this.xxhc = xxhc;
	}
	public Integer getRowNo() {
		return rowNo;
	}
	public void setRowNo(Integer rowNo) {
		this.rowNo = rowNo;
	}
	public String getRefundItemNo() {
		return refundItemNo;
	}
	public void setRefundItemNo(String refundItemNo) {
		this.refundItemNo = refundItemNo;
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
	public String getSupplyProductInnerCode() {
		return supplyProductInnerCode;
	}
	public void setSupplyProductInnerCode(String supplyProductInnerCode) {
		this.supplyProductInnerCode = supplyProductInnerCode;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getBarCode() {
		return barCode;
	}
	public void setBarCode(String barCode) {
		this.barCode = barCode;
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
	public Integer getRefundNum() {
		return refundNum;
	}
	public void setRefundNum(Integer refundNum) {
		this.refundNum = refundNum;
	}
	public BigDecimal getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(BigDecimal salePrice) {
		this.salePrice = salePrice;
	}
	public String getIsGift() {
		return isGift;
	}
	public void setIsGift(String isGift) {
		this.isGift = isGift;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getDiscountCode() {
		return discountCode;
	}
	public void setDiscountCode(String discountCode) {
		this.discountCode = discountCode;
	}
	public List<OfPromotionSplitRefundDto> getPromotionSplits() {
		return promotionSplits;
	}
	public void setPromotionSplits(List<OfPromotionSplitRefundDto> promotionSplits) {
		this.promotionSplits = promotionSplits;
	}
	public List<OfRefundGetSplitDto> getGetSplits() {
		return getSplits;
	}
	public void setGetSplits(List<OfRefundGetSplitDto> getSplits) {
		this.getSplits = getSplits;
	}
	public List<OfPaymentsSplitReturnDto> getPaymentsSplitReturns() {
		return paymentsSplitReturns;
	}
	public void setPaymentsSplitReturns(List<OfPaymentsSplitReturnDto> paymentsSplitReturns) {
		this.paymentsSplitReturns = paymentsSplitReturns;
	}
	public BigDecimal getActualRefundAmount() {
		return actualRefundAmount;
	}
	public void setActualRefundAmount(BigDecimal actualRefundAmount) {
		this.actualRefundAmount = actualRefundAmount;
	}
	public BigDecimal getRefundAmount() {
		return refundAmount;
	}
	public void setRefundAmount(BigDecimal refundAmount) {
		this.refundAmount = refundAmount;
	}
	public String getRefundNo() {
		return refundNo;
	}
	public void setRefundNo(String refundNo) {
		this.refundNo = refundNo;
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
	public String getManagerCateNo() {
		return managerCateNo;
	}
	public void setManagerCateNo(String managerCateNo) {
		this.managerCateNo = managerCateNo;
	}
	public String getStaticsCateNo() {
		return staticsCateNo;
	}
	public void setStaticsCateNo(String staticsCateNo) {
		this.staticsCateNo = staticsCateNo;
	}
	public String getSaleItemNo() {
		return saleItemNo;
	}
	public void setSaleItemNo(String saleItemNo) {
		this.saleItemNo = saleItemNo;
	}
	public String getSaleItemRowNo() {
		return saleItemRowNo;
	}
	public void setSaleItemRowNo(String saleItemRowNo) {
		this.saleItemRowNo = saleItemRowNo;
	}
	public String getShoppeProName() {
		return shoppeProName;
	}
	public void setShoppeProName(String shoppeProName) {
		this.shoppeProName = shoppeProName;
	}
	public String getRefundReasionDesc() {
		return refundReasionDesc;
	}
	public void setRefundReasionDesc(String refundReasionDesc) {
		this.refundReasionDesc = refundReasionDesc;
	}
	public String getShoppeGroup() {
		return shoppeGroup;
	}
	public void setShoppeGroup(String shoppeGroup) {
		this.shoppeGroup = shoppeGroup;
	}
	public String getBankServiceCharge() {
		return bankServiceCharge;
	}
	public void setBankServiceCharge(String bankServiceCharge) {
		this.bankServiceCharge = bankServiceCharge;
	}
	public String getMaterialNum() {
		return materialNum;
	}
	public void setMaterialNum(String materialNum) {
		this.materialNum = materialNum;
	}
	public String getAcceptancePhase() {
		return acceptancePhase;
	}
	public void setAcceptancePhase(String acceptancePhase) {
		this.acceptancePhase = acceptancePhase;
	}
	public String getUnqualifiedNum() {
		return unqualifiedNum;
	}
	public void setUnqualifiedNum(String unqualifiedNum) {
		this.unqualifiedNum = unqualifiedNum;
	}
	public String getRefuseToReturnReason() {
		return refuseToReturnReason;
	}
	public void setRefuseToReturnReason(String refuseToReturnReason) {
		this.refuseToReturnReason = refuseToReturnReason;
	}
	public String getRefundReasion() {
		return refundReasion;
	}
	public void setRefundReasion(String refundReasion) {
		this.refundReasion = refundReasion;
	}
	@Override
	public String toString() {
		return "SaveOfRefundItemDTO [rowNo=" + rowNo + ", refundItemNo=" + refundItemNo
				+ ", skuNo=" + skuNo + ", spuNo=" + spuNo + ", supplyProductNo=" + supplyProductNo
				+ ", erpProductNo=" + erpProductNo + ", supplyProductInnerCode="
				+ supplyProductInnerCode + ", unit=" + unit + ", barCode=" + barCode + ", brandNo="
				+ brandNo + ", brandName=" + brandName + ", colorNo=" + colorNo + ", colorName="
				+ colorName + ", sizeNo=" + sizeNo + ", sizeName=" + sizeName + ", refundNum="
				+ refundNum + ", salePrice=" + salePrice + ", isGift=" + isGift + ", createTime="
				+ createTime + ", discountCode=" + discountCode + ", promotionSplits="
				+ promotionSplits + ", getSplits=" + getSplits + ", paymentsSplitReturns="
				+ paymentsSplitReturns + ", prDeductionSplitDTO=" + prDeductionSplitDTO
				+ ", actualRefundAmount=" + actualRefundAmount + ", refundAmount=" + refundAmount
				+ ", refundNo=" + refundNo + ", productClass=" + productClass + ", productType="
				+ productType + ", incomeAmount=" + incomeAmount + ", tax=" + tax
				+ ", managerCateNo=" + managerCateNo + ", staticsCateNo=" + staticsCateNo
				+ ", saleItemNo=" + saleItemNo + ", saleItemRowNo=" + saleItemRowNo
				+ ", shoppeProName=" + shoppeProName + ", refundReasionDesc=" + refundReasionDesc
				+ ", shoppeGroup=" + shoppeGroup + ", bankServiceCharge=" + bankServiceCharge
				+ ", materialNum=" + materialNum + ", acceptancePhase=" + acceptancePhase
				+ ", unqualifiedNum=" + unqualifiedNum + ", refuseToReturnReason="
				+ refuseToReturnReason + ", xxhc=" + xxhc + ", refundReasionNo=" + refundReasionNo
				+ ", getRefundReasionNo()=" + getRefundReasionNo() + ", getPrDeductionSplitDTO()="
				+ getPrDeductionSplitDTO() + ", getXxhc()=" + getXxhc() + ", getRowNo()="
				+ getRowNo() + ", getRefundItemNo()=" + getRefundItemNo() + ", getSkuNo()="
				+ getSkuNo() + ", getSpuNo()=" + getSpuNo() + ", getSupplyProductNo()="
				+ getSupplyProductNo() + ", getErpProductNo()=" + getErpProductNo()
				+ ", getSupplyProductInnerCode()=" + getSupplyProductInnerCode() + ", getUnit()="
				+ getUnit() + ", getBarCode()=" + getBarCode() + ", getBrandNo()=" + getBrandNo()
				+ ", getBrandName()=" + getBrandName() + ", getColorNo()=" + getColorNo()
				+ ", getColorName()=" + getColorName() + ", getSizeNo()=" + getSizeNo()
				+ ", getSizeName()=" + getSizeName() + ", getRefundNum()=" + getRefundNum()
				+ ", getSalePrice()=" + getSalePrice() + ", getIsGift()=" + getIsGift()
				+ ", getCreateTime()=" + getCreateTime() + ", getDiscountCode()="
				+ getDiscountCode() + ", getPromotionSplits()=" + getPromotionSplits()
				+ ", getGetSplits()=" + getGetSplits() + ", getPaymentsSplitReturns()="
				+ getPaymentsSplitReturns() + ", getActualRefundAmount()="
				+ getActualRefundAmount() + ", getRefundAmount()=" + getRefundAmount()
				+ ", getRefundNo()=" + getRefundNo() + ", getProductClass()=" + getProductClass()
				+ ", getProductType()=" + getProductType() + ", getIncomeAmount()="
				+ getIncomeAmount() + ", getTax()=" + getTax() + ", getManagerCateNo()="
				+ getManagerCateNo() + ", getStaticsCateNo()=" + getStaticsCateNo()
				+ ", getSaleItemNo()=" + getSaleItemNo() + ", getSaleItemRowNo()="
				+ getSaleItemRowNo() + ", getShoppeProName()=" + getShoppeProName()
				+ ", getRefundReasionDesc()=" + getRefundReasionDesc() + ", getShoppeGroup()="
				+ getShoppeGroup() + ", getBankServiceCharge()=" + getBankServiceCharge()
				+ ", getMaterialNum()=" + getMaterialNum() + ", getAcceptancePhase()="
				+ getAcceptancePhase() + ", getUnqualifiedNum()=" + getUnqualifiedNum()
				+ ", getRefuseToReturnReason()=" + getRefuseToReturnReason() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString()
				+ "]";
	}
}
