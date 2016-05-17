package com.wangfj.order.entity;

import java.math.BigDecimal;
import java.util.Date;

public class Sale {
	
	 private Long sid;//AUTO_INCREMENT,
	 private String saleNo;//'销售单号'
	 private Long orderSid;//'商品订单表SID'
	 private String sapSaleNo;
	 private Integer saleType;//'销售类别 0 实体 1 网络'
	 private Integer saleStatus;//'-1 作废  0  草稿   1 等待导购确认是否有货  2 导购确认有货 3 已打印，未付款 4  已付款，未提货 5  已经付款,已经提货 6 导购确认无货'
	 private Date draftTime;//'网络销售 销售单生成时间 对应状态1'
	 private BigDecimal saleMoneySum;//'销售主单销售金额'
	 private Integer saleNumSum;// '销售主单销售数量'
	 private Integer userPackBit;// '是否需要导购包货'
	 private Long shopSid;//'门店信息表SID'
	 private String shopName;//'门店名称'
	 private String cashierNumber;//'收银流水号'
	 private Long supplyInfoSid;//'供应商SID'
	 private Date invalidTime;// '作废时间 对应状态-1'
	 private Integer alarmBit;//'PDA声音警告标志位'
	 private Integer refundTotalBit;//'退货类型 0 没有退货 1 部分 2 整单  默认0'
	 private Long paymentMode;//'顾客支付方式'
	 private Long paymentUserSid;//'收款确认用户SID  应该是财务的人'
	 private String paymentRealName;// '收款款确认姓名 '
	 private Date paymentTime;//'财务收款确认时间'
	 private Long saleCodeSid;//'供应商销售商品在店信息表SID'
	 private String saleCode;//'实际的销售编码'
	 private Integer allotBit;//'是否有调拨 0没有调拨 1 需要调拨'
	 private Integer allotStatus;//'0 草稿 1 等待调拨 2 调出未调入 3 调出已调入 -1 作废'
	 private Integer refundStatus;//'0 草稿 1 打印退货单 3 退货入收银 4导购确认收货  -1 作废 pda专用   和退货单冗余'
	 private Integer printTimes;//'打印次数'
	 private Long optUserSid;//'操作用户sid'
	 private String optRealName;//'操作用户real_name'
	 private Date optUpdateTime;//'操作时间'
	 private String memo;//'备注'
	 private Date guideGoodsTime;//'网络销售 导购确认可以销售时间 对应状态2'
	 private Date printedTime;//'打印时间 补打不更新 对应状态3'
	 private Date cashTakeTime;//'mis 收银时间 对应状态 4'
	 private Date guideCommitTime;//'导购确认提货时间  对应状态5'
	 private Date memoTime;//'备注时间'
	 private Integer offlineSaleBit;//'是否离线销售  1  表示离线 销售    0 为在线销售   默认值为0'
	 private Integer bavailableproduct;//'是否有货 1表示有， 0 表示没有， 默认0'
	 private Integer cashierNumberType;//'是否自动收银  1 自动   0 手工输入收银流水号'
	 private String posPaymentMode;//'pos 支付方式'
	 private String posPaymentMoney;//'pos支付金额'
	 private String vipNo;//'会员号
	 private String cardId;//'卡号'
	 private Long saleUserSid;//'销售用户sid'
	 private String saleRealName;//'销售用户real_name'
	 private String qrcode;//'二维码'
	 private Integer qrcodeStatus;//'二维码支付状态   -1 作废   0 初始  1 等待  2 成功'
	 private String alipayUserName;//'支付宝订单号'
	 private Integer invoiceStatus;//'发票状态    -1 已收回   0  未开启  1  已开取   '
	 private String alipayTradeNo;//'阿里订单号'
	 private Long usid;//
	 private String payCost;//顾客支付的邮费-------关联order表查询
	private String coupon;//优惠券
	 private String orderNo;//订单号
	 private String ticket;//网络购物券
	 private String orderMemo;//订单备注，用于显示三方的流水号
	 private String receptAddress;//收货地址
	 private String parentOrderNo;
	public String getParentOrderNo() {
		return parentOrderNo;
	}
	public void setParentOrderNo(String parentOrderNo) {
		this.parentOrderNo = parentOrderNo;
	}
	public Long getSid() {
		return sid;
	}
	public void setSid(Long sid) {
		this.sid = sid;
	}
	
	public String getTicket() {
		return ticket;
	}
	public void setTicket(String ticket) {
		this.ticket = ticket;
	}
	
	public String getOrderMemo() {
		return orderMemo;
	}
	public void setOrderMemo(String orderMemo) {
		this.orderMemo = orderMemo;
	}
	public String getSaleNo() {
		return saleNo;
	}
	public void setSaleNo(String saleNo) {
		this.saleNo = saleNo;
	}
	public Long getOrderSid() {
		return orderSid;
	}
	public void setOrderSid(Long orderSid) {
		this.orderSid = orderSid;
	}
	public String getSapSaleNo() {
		return sapSaleNo;
	}
	public String getPayCost() {
			return payCost;
	}
	public void setPayCost(String payCost) {
		this.payCost = payCost;
	}
	public void setSapSaleNo(String sapSaleNo) {
		this.sapSaleNo = sapSaleNo;
	}
	public Integer getSaleType() {
		return saleType;
	}
	public void setSaleType(Integer saleType) {
		this.saleType = saleType;
	}
	public Integer getSaleStatus() {
		return saleStatus;
	}
	public void setSaleStatus(Integer saleStatus) {
		this.saleStatus = saleStatus;
	}
	public Date getDraftTime() {
		return draftTime;
	}
	public void setDraftTime(Date draftTime) {
		this.draftTime = draftTime;
	}
	public BigDecimal getSaleMoneySum() {
		return saleMoneySum;
	}
	public void setSaleMoneySum(BigDecimal saleMoneySum) {
		this.saleMoneySum = saleMoneySum;
	}
	public Integer getSaleNumSum() {
		return saleNumSum;
	}
	public void setSaleNumSum(Integer saleNumSum) {
		this.saleNumSum = saleNumSum;
	}
	public Integer getUserPackBit() {
		return userPackBit;
	}
	public void setUserPackBit(Integer userPackBit) {
		this.userPackBit = userPackBit;
	}
	public Long getShopSid() {
		return shopSid;
	}
	public void setShopSid(Long shopSid) {
		this.shopSid = shopSid;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getCashierNumber() {
		return cashierNumber;
	}
	public void setCashierNumber(String cashierNumber) {
		this.cashierNumber = cashierNumber;
	}
	public Long getSupplyInfoSid() {
		return supplyInfoSid;
	}
	public void setSupplyInfoSid(Long supplyInfoSid) {
		this.supplyInfoSid = supplyInfoSid;
	}
	public Date getInvalidTime() {
		return invalidTime;
	}
	public void setInvalidTime(Date invalidTime) {
		this.invalidTime = invalidTime;
	}
	public Integer getAlarmBit() {
		return alarmBit;
	}
	public void setAlarmBit(Integer alarmBit) {
		this.alarmBit = alarmBit;
	}
	public Integer getRefundTotalBit() {
		return refundTotalBit;
	}
	public void setRefundTotalBit(Integer refundTotalBit) {
		this.refundTotalBit = refundTotalBit;
	}
	public Long getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(Long paymentMode) {
		this.paymentMode = paymentMode;
	}
	public Long getPaymentUserSid() {
		return paymentUserSid;
	}
	public void setPaymentUserSid(Long paymentUserSid) {
		this.paymentUserSid = paymentUserSid;
	}
	public String getPaymentRealName() {
		return paymentRealName;
	}
	public void setPaymentRealName(String paymentRealName) {
		this.paymentRealName = paymentRealName;
	}
	public Date getPaymentTime() {
		return paymentTime;
	}
	public void setPaymentTime(Date paymentTime) {
		this.paymentTime = paymentTime;
	}
	public Long getSaleCodeSid() {
		return saleCodeSid;
	}
	public void setSaleCodeSid(Long saleCodeSid) {
		this.saleCodeSid = saleCodeSid;
	}
	public String getSaleCode() {
		return saleCode;
	}
	public void setSaleCode(String saleCode) {
		this.saleCode = saleCode;
	}
	public Integer getAllotBit() {
		return allotBit;
	}
	public void setAllotBit(Integer allotBit) {
		this.allotBit = allotBit;
	}
	public Integer getAllotStatus() {
		return allotStatus;
	}
	public void setAllotStatus(Integer allotStatus) {
		this.allotStatus = allotStatus;
	}
	public Integer getRefundStatus() {
		return refundStatus;
	}
	public void setRefundStatus(Integer refundStatus) {
		this.refundStatus = refundStatus;
	}
	public Integer getPrintTimes() {
		return printTimes;
	}
	public void setPrintTimes(Integer printTimes) {
		this.printTimes = printTimes;
	}
	public Long getOptUserSid() {
		return optUserSid;
	}
	public void setOptUserSid(Long optUserSid) {
		this.optUserSid = optUserSid;
	}
	public String getOptRealName() {
		return optRealName;
	}
	public void setOptRealName(String optRealName) {
		this.optRealName = optRealName;
	}
	public Date getOptUpdateTime() {
		return optUpdateTime;
	}
	public void setOptUpdateTime(Date optUpdateTime) {
		this.optUpdateTime = optUpdateTime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Date getGuideGoodsTime() {
		return guideGoodsTime;
	}
	public void setGuideGoodsTime(Date guideGoodsTime) {
		this.guideGoodsTime = guideGoodsTime;
	}
	public Date getPrintedTime() {
		return printedTime;
	}
	public void setPrintedTime(Date printedTime) {
		this.printedTime = printedTime;
	}
	public Date getCashTakeTime() {
		return cashTakeTime;
	}
	public void setCashTakeTime(Date cashTakeTime) {
		this.cashTakeTime = cashTakeTime;
	}
	public Date getGuideCommitTime() {
		return guideCommitTime;
	}
	public void setGuideCommitTime(Date guideCommitTime) {
		this.guideCommitTime = guideCommitTime;
	}
	public Date getMemoTime() {
		return memoTime;
	}
	public void setMemoTime(Date memoTime) {
		this.memoTime = memoTime;
	}
	public Integer getOfflineSaleBit() {
		return offlineSaleBit;
	}
	public void setOfflineSaleBit(Integer offlineSaleBit) {
		this.offlineSaleBit = offlineSaleBit;
	}
	public Integer getBavailableproduct() {
		return bavailableproduct;
	}
	public void setBavailableproduct(Integer bavailableproduct) {
		this.bavailableproduct = bavailableproduct;
	}
	public Integer getCashierNumberType() {
		return cashierNumberType;
	}
	public void setCashierNumberType(Integer cashierNumberType) {
		this.cashierNumberType = cashierNumberType;
	}
	public String getPosPaymentMode() {
		return posPaymentMode;
	}
	public void setPosPaymentMode(String posPaymentMode) {
		this.posPaymentMode = posPaymentMode;
	}
	public String getPosPaymentMoney() {
		return posPaymentMoney;
	}
	public void setPosPaymentMoney(String posPaymentMoney) {
		this.posPaymentMoney = posPaymentMoney;
	}
	public String getVipNo() {
		return vipNo;
	}
	public void setVipNo(String vipNo) {
		this.vipNo = vipNo;
	}
	public String getCardId() {
		return cardId;
	}
	public void setCardId(String cardId) {
		this.cardId = cardId;
	}
	public Long getSaleUserSid() {
		return saleUserSid;
	}
	public void setSaleUserSid(Long saleUserSid) {
		this.saleUserSid = saleUserSid;
	}
	public String getSaleRealName() {
		return saleRealName;
	}
	public void setSaleRealName(String saleRealName) {
		this.saleRealName = saleRealName;
	}
	public String getQrcode() {
		return qrcode;
	}
	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
	public Integer getQrcodeStatus() {
		return qrcodeStatus;
	}
	public void setQrcodeStatus(Integer qrcodeStatus) {
		this.qrcodeStatus = qrcodeStatus;
	}
	public String getAlipayUserName() {
		return alipayUserName;
	}
	public void setAlipayUserName(String alipayUserName) {
		this.alipayUserName = alipayUserName;
	}
	public Integer getInvoiceStatus() {
		return invoiceStatus;
	}
	public void setInvoiceStatus(Integer invoiceStatus) {
		this.invoiceStatus = invoiceStatus;
	}
	public String getAlipayTradeNo() {
		return alipayTradeNo;
	}
	public void setAlipayTradeNo(String alipayTradeNo) {
		this.alipayTradeNo = alipayTradeNo;
	}
	public Long getUsid() {
		return usid;
	}
	public void setUsid(Long usid) {
		this.usid = usid;
	}
	public String getCoupon() {
		return coupon;
	}
	public void setCoupon(String coupon) {
		this.coupon = coupon;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getReceptAddress() {
		return receptAddress;
	}
	public void setReceptAddress(String receptAddress) {
		this.receptAddress = receptAddress;
	}
	
}
