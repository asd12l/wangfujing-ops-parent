package com.wangfj.order.controller.suppot;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ExcelRefundMonVo {
	private List<RefundMonItemDto> refundMonItemList;
	
public List<RefundMonItemDto> getRefundMonItemList() {
		return refundMonItemList;
	}
	public void setRefundMonItemList(List<RefundMonItemDto> refundMonItemList) {
		this.refundMonItemList = refundMonItemList;
	}
private String refundMonNo;
	
	private String orderNo;
	private String outOrderNo;
	private String applyNo;
	
	public String getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(String applyNo) {
		this.applyNo = applyNo;
	}
	public String getOutOrderNo() {
		return outOrderNo;
	}
	public void setOutOrderNo(String outOrderNo) {
		this.outOrderNo = outOrderNo;
	}
	private String saleNo;
	
	public String getSaleNo() {
		return saleNo;
	}
	public void setSaleNo(String saleNo) {
		this.saleNo = saleNo;
	}
	private String refundNo;
	
	private String orderSource;
	
	private String accountNo;
	
	private String memberNo;
	
	private String refundClass;
	
	private Integer reMonStatus;
	
	private BigDecimal needRefundMon;
	
	private BigDecimal readMoney;
	
	private String bankName;
	
	private String bankUser;
	
	private Integer bankType;
	
	private Date allRefTime;
	private String allRefTimeStr;
	private String allRefUser;
	private Date confirmRefundTime;
	public Date getConfirmRefundTime() {
		return confirmRefundTime;
	}
	public void setConfirmRefundTime(Date confirmRefundTime) {
		this.confirmRefundTime = confirmRefundTime;
	}
	private String confirmRefundTimeStr;
	
	public String getConfirmRefundTimeStr() {
		return confirmRefundTimeStr;
	}
	public void setConfirmRefundTimeStr(String confirmRefundTimeStr) {
		this.confirmRefundTimeStr = confirmRefundTimeStr;
	}
	public String getAllRefUser() {
		return allRefUser;
	}
	public void setAllRefUser(String allRefUser) {
		this.allRefUser = allRefUser;
	}
	private String paymentType;
	
	public String getPaymentType() {
		return paymentType;
	}
	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	public String getRefundMonNo() {
		return refundMonNo;
	}
	public void setRefundMonNo(String refundMonNo) {
		this.refundMonNo = refundMonNo;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getRefundNo() {
		return refundNo;
	}
	public void setRefundNo(String refundNo) {
		this.refundNo = refundNo;
	}
	public String getOrderSource() {
		return orderSource;
	}
	public void setOrderSource(String orderSource) {
		this.orderSource = orderSource;
	}
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public String getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(String memberNo) {
		this.memberNo = memberNo;
	}
	public String getRefundClass() {
		return refundClass;
	}
	public void setRefundClass(String refundClass) {
		this.refundClass = refundClass;
	}
	public Integer getReMonStatus() {
		return reMonStatus;
	}
	public void setReMonStatus(Integer reMonStatus) {
		this.reMonStatus = reMonStatus;
	}
	public BigDecimal getNeedRefundMon() {
		return needRefundMon;
	}
	public void setNeedRefundMon(BigDecimal needRefundMon) {
		this.needRefundMon = needRefundMon;
	}
	public BigDecimal getReadMoney() {
		return readMoney;
	}
	public void setReadMoney(BigDecimal readMoney) {
		this.readMoney = readMoney;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankUser() {
		return bankUser;
	}
	public void setBankUser(String bankUser) {
		this.bankUser = bankUser;
	}
	public Integer getBankType() {
		return bankType;
	}
	public void setBankType(Integer bankType) {
		this.bankType = bankType;
	}
	public Date getAllRefTime() {
		return allRefTime;
	}
	public void setAllRefTime(Date allRefTime) {
		this.allRefTime = allRefTime;
	}
	public String getAllRefTimeStr() {
		return allRefTimeStr;
	}
	public void setAllRefTimeStr(String allRefTimeStr) {
		this.allRefTimeStr = allRefTimeStr;
	}
	
}
