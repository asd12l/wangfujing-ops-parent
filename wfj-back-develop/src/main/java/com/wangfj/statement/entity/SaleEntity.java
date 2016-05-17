package com.wangfj.statement.entity;


public class SaleEntity {
	 private String shopSid;//'门店信息表SID'
	 private String shopName;//'门店名称'
	 private String saleTime;//销售单日期
	 private String saleCode;//'销售编码'
	 private String brandSid;// '品牌字典表的SID'
	 private String brandName;//'品牌名称'
	 private String saleNo;//'销售单号'
	 private String cashierNumber;//'收银流水号' 小票号
	 private String shopSaleNumber;//实体销售数量
	 private String netSaleNumber;//网络销售数量
	 private String shopRefundNumber;//实体退货数量
	 private String netRefundNumber;//网络退货数量
	 private String saleType;//'销售类别 0 实体 1 网络'
	 private String shopSalePrice;//实体交易金额
	 private String shopRefundPrice;//实体退货金额
	 private String shopSaleAvgPrice;//实体销售平均价格
	 private String shopRefundAvgPrice;//实体销售平均价格
	 private String saleSid;//销售单sid
	 private String shopRealPrice;//实体交易金额 - 实体退货金额
	public String getShopSid() {
		return shopSid;
	}
	public void setShopSid(String shopSid) {
		this.shopSid = shopSid;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getSaleTime() {
		return saleTime;
	}
	public void setSaleTime(String saleTime) {
		this.saleTime = saleTime;
	}
	public String getSaleCode() {
		return saleCode;
	}
	public void setSaleCode(String saleCode) {
		this.saleCode = saleCode;
	}
	public String getBrandSid() {
		return brandSid;
	}
	public void setBrandSid(String brandSid) {
		this.brandSid = brandSid;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getSaleNo() {
		return saleNo;
	}
	public void setSaleNo(String saleNo) {
		this.saleNo = saleNo;
	}
	public String getCashierNumber() {
		return cashierNumber;
	}
	public void setCashierNumber(String cashierNumber) {
		this.cashierNumber = cashierNumber;
	}
	public String getShopSaleNumber() {
		return shopSaleNumber;
	}
	public void setShopSaleNumber(String shopSaleNumber) {
		this.shopSaleNumber = shopSaleNumber;
	}
	public String getNetSaleNumber() {
		return netSaleNumber;
	}
	public void setNetSaleNumber(String netSaleNumber) {
		this.netSaleNumber = netSaleNumber;
	}
	public String getShopRefundNumber() {
		return shopRefundNumber;
	}
	public void setShopRefundNumber(String shopRefundNumber) {
		this.shopRefundNumber = shopRefundNumber;
	}
	public String getNetRefundNumber() {
		return netRefundNumber;
	}
	public void setNetRefundNumber(String netRefundNumber) {
		this.netRefundNumber = netRefundNumber;
	}
	public String getSaleType() {
		return saleType;
	}
	public void setSaleType(String saleType) {
		this.saleType = saleType;
	}
	public String getShopSalePrice() {
		return shopSalePrice;
	}
	public void setShopSalePrice(String shopSalePrice) {
		this.shopSalePrice = shopSalePrice;
	}
	public String getShopRefundPrice() {
		return shopRefundPrice;
	}
	public void setShopRefundPrice(String shopRefundPrice) {
		this.shopRefundPrice = shopRefundPrice;
	}
	public String getShopSaleAvgPrice() {
		return shopSaleAvgPrice;
	}
	public void setShopSaleAvgPrice(String shopSaleAvgPrice) {
		this.shopSaleAvgPrice = shopSaleAvgPrice;
	}
	public String getShopRefundAvgPrice() {
		return shopRefundAvgPrice;
	}
	public void setShopRefundAvgPrice(String shopRefundAvgPrice) {
		this.shopRefundAvgPrice = shopRefundAvgPrice;
	}
	public String getSaleSid() {
		return saleSid;
	}
	public void setSaleSid(String saleSid) {
		this.saleSid = saleSid;
	}
	public String getShopRealPrice() {
		return shopRealPrice;
	}
	public void setShopRealPrice(String shopRealPrice) {
		this.shopRealPrice = shopRealPrice;
	}
	 
}
