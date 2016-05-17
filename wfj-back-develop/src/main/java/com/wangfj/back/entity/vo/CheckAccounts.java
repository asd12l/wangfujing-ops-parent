package com.wangfj.back.entity.vo;

import java.math.BigDecimal;
import java.util.Date;

public class CheckAccounts {
	
	private Long sid;// 主键 AUTO_INCREMENT
	private String cashierNumber;// 收银流水号
	private Date cashTime;// 收银时间
	private Date createTime;// 创建时间
	private Integer saleType;// 销售类型。1销售，4退货
	private Integer orderType;// 订单类型。0实体，1网络
	private String saleNo;//销售单号
	private Long shopSid;//门店sid
	private String shopName;//门店名称
	private Long supplyInfoSid;//'供应商SID'
	private Integer omsSaleSum;//oms销售数量
	private BigDecimal omsMoneySum;//oms销售金额
	private Integer futureSaleSum;//富基销售数量
	private BigDecimal futureMoneySum;//富基销售金额
	private Integer sapSaleSum;//sap销售数量
	private BigDecimal sapMoneySum;//sap销售金额
	private Integer checkStatus;//三个平台对账结果状态。0表示三个平台平账；1表示oms与富基平账；2表示oms与sap平账；3表示富基与sap平账；4表示三个平台都不一样；5表示SAP与OMS平账，富基销售记录为空；6表示SAP与OMS不平账，富基销售记录为空；7表示富基与OMS平账，SAP销售记录为空；8表示富基与OMS不平账，SAP销售记录为空；9表示富基和SAP销售记录为空
	private String checkStatusDesc;//三个平台对账结果状态。0表示三个平台平账；1表示oms与富基平账；2表示oms与sap平账；3表示富基与sap平账；4表示三个平台都不一样；5表示SAP与OMS平账，富基销售记录为空；6表示SAP与OMS不平账，富基销售记录为空；7表示富基与OMS平账，SAP销售记录为空；8表示富基与OMS不平账，SAP销售记录为空；9表示富基和SAP销售记录为空
	private String orderNo;//订单号
	private String omsPaymentMode;//oms的支付方式
	private String futurePaymentMode;//富基的支付方式
	private String sapPaymentMode;//sap的支付方式
	private Date updateTime;//修改时间
	
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Long getSid() {
		return sid;
	}
	public void setSid(Long sid) {
		this.sid = sid;
	}
	public String getCashierNumber() {
		return cashierNumber;
	}
	public void setCashierNumber(String cashierNumber) {
		this.cashierNumber = cashierNumber;
	}
	public Date getCashTime() {
		return cashTime;
	}
	public void setCashTime(Date cashTime) {
		this.cashTime = cashTime;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Integer getSaleType() {
		return saleType;
	}
	public void setSaleType(Integer saleType) {
		this.saleType = saleType;
	}
	public String getSaleNo() {
		return saleNo;
	}
	public void setSaleNo(String saleNo) {
		this.saleNo = saleNo;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public Long getSupplyInfoSid() {
		return supplyInfoSid;
	}
	public void setSupplyInfoSid(Long supplyInfoSid) {
		this.supplyInfoSid = supplyInfoSid;
	}
	public Integer getOmsSaleSum() {
		return omsSaleSum;
	}
	public void setOmsSaleSum(Integer omsSaleSum) {
		this.omsSaleSum = omsSaleSum;
	}
	public BigDecimal getOmsMoneySum() {
		return omsMoneySum;
	}
	public void setOmsMoneySum(BigDecimal omsMoneySum) {
		this.omsMoneySum = omsMoneySum;
	}
	public Integer getFutureSaleSum() {
		return futureSaleSum;
	}
	public void setFutureSaleSum(Integer futureSaleSum) {
		this.futureSaleSum = futureSaleSum;
	}
	public BigDecimal getFutureMoneySum() {
		return futureMoneySum;
	}
	public void setFutureMoneySum(BigDecimal futureMoneySum) {
		this.futureMoneySum = futureMoneySum;
	}
	public Integer getSapSaleSum() {
		return sapSaleSum;
	}
	public void setSapSaleSum(Integer sapSaleSum) {
		this.sapSaleSum = sapSaleSum;
	}
	public BigDecimal getSapMoneySum() {
		return sapMoneySum;
	}
	public void setSapMoneySum(BigDecimal sapMoneySum) {
		this.sapMoneySum = sapMoneySum;
	}
	public Integer getCheckStatus() {
		return checkStatus;
	}
	public void setCheckStatus(Integer checkStatus) {
		this.checkStatus = checkStatus;
	}
	public String getCheckStatusDesc() {
		return checkStatusDesc;
	}
	public void setCheckStatusDesc(String checkStatusDesc) {
		this.checkStatusDesc = checkStatusDesc;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getOmsPaymentMode() {
		return omsPaymentMode;
	}
	public void setOmsPaymentMode(String omsPaymentMode) {
		this.omsPaymentMode = omsPaymentMode;
	}
	public String getFuturePaymentMode() {
		return futurePaymentMode;
	}
	public void setFuturePaymentMode(String futurePaymentMode) {
		this.futurePaymentMode = futurePaymentMode;
	}
	public String getSapPaymentMode() {
		return sapPaymentMode;
	}
	public void setSapPaymentMode(String sapPaymentMode) {
		this.sapPaymentMode = sapPaymentMode;
	}
	public Long getShopSid() {
		return shopSid;
	}
	public void setShopSid(Long shopSid) {
		this.shopSid = shopSid;
	}
	public Integer getOrderType() {
		return orderType;
	}
	public void setOrderType(Integer orderType) {
		this.orderType = orderType;
	}
	
}
