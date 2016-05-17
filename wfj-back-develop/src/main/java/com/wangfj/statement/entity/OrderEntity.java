package com.wangfj.statement.entity;


public class OrderEntity {
	private String orderNo;
	private String saleMoneySum;// 订单总金额
	private String memberEmail;//邮箱
	private String memberName;//姓名
	private String memberPhone;//电话
	private String memberAdress;//地址
	private String brandName;//品牌名称 
	private String proSku;//商品sku
	private String proMoneySum;//每条明细中商品销售总额
	private String saleSum;//每条明细中数量
	private String refundNum;//已退货数量
	private String salePrice;//销售实价
	private String realSaleSum;//实际销售数量
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getSaleMoneySum() {
		return saleMoneySum;
	}
	public void setSaleMoneySum(String saleMoneySum) {
		this.saleMoneySum = saleMoneySum;
	}
	public String getMemberEmail() {
		return memberEmail;
	}
	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberPhone() {
		return memberPhone;
	}
	public void setMemberPhone(String memberPhone) {
		this.memberPhone = memberPhone;
	}
	public String getMemberAdress() {
		return memberAdress;
	}
	public void setMemberAdress(String memberAdress) {
		this.memberAdress = memberAdress;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getProSku() {
		return proSku;
	}
	public void setProSku(String proSku) {
		this.proSku = proSku;
	}
	public String getProMoneySum() {
		return proMoneySum;
	}
	public void setProMoneySum(String proMoneySum) {
		this.proMoneySum = proMoneySum;
	}
	public String getSaleSum() {
		return saleSum;
	}
	public void setSaleSum(String saleSum) {
		this.saleSum = saleSum;
	}
	public String getRefundNum() {
		return refundNum;
	}
	public void setRefundNum(String refundNum) {
		this.refundNum = refundNum;
	}
	public String getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(String salePrice) {
		this.salePrice = salePrice;
	}
	public String getRealSaleSum() {
		return realSaleSum;
	}
	public void setRealSaleSum(String realSaleSum) {
		this.realSaleSum = realSaleSum;
	}

	
	
}
