package com.wfj.member.pojo;

import java.util.Date;

public class Withdraw {

	private Long sid;//申请单号

	private Long memberSid;//申请单号

	private String applyNo;//在富基申请提现时返回单号

	private String applyName;//申请人

	private String applyNameStr;

	private Date applyTime;//申请时间

	private Date startApplyTime;
	private Date endApplyTime;

	private String applyTimeStr;

	private String withdrowReason;//申请原因

	private String bank;//银行名称

	private String name;//开户名称

	private String nameStr;

	private String bankCardNo;//银行卡号

	private String bankCardNoStr;

	private String mobile;//申请人手机号

	private String mobileStr;

	private Double withdrowMoney;//提现金额

	private String withdrowMoneyStatus;//提现状态

	private Double balance;//余额

	private String cancelReason;//取消提现原因

	private String checkStatus;//审核状态

	private String checkMemo;//审核备注

	private String checkName;//审核人

	private Date checkTime;//审核时间

	private String checkTimeStr;

	private Date startCheckTime;
	private Date endCheckTime;

	private String refundStatus; //退款状态

	private String failReason;//失败原因

	private String refundName;

	private String refundNameStr;

	private Date refundTime; //退款时间

	private String refundTimeStr;

	private String withdrowType; //退款类型

	private String withdrowMedium; //退款介质

	private String seqno; //20位的申请单号

	private String billno; //流水单号

	private String applyCustomer; //申请客服

	private Integer pageNo;

	private Integer pageSize;


	public String getApplyNameStr() {
		return applyNameStr;
	}

	public void setApplyNameStr(String applyNameStr) {
		this.applyNameStr = applyNameStr;
	}

	public String getNameStr() {
		return nameStr;
	}

	public void setNameStr(String nameStr) {
		this.nameStr = nameStr;
	}

	public String getBankCardNoStr() {
		return bankCardNoStr;
	}

	public void setBankCardNoStr(String bankCardNoStr) {
		this.bankCardNoStr = bankCardNoStr;
	}

	public String getMobileStr() {
		return mobileStr;
	}

	public void setMobileStr(String mobileStr) {
		this.mobileStr = mobileStr;
	}

	public String getRefundNameStr() {
		return refundNameStr;
	}

	public void setRefundNameStr(String refundNameStr) {
		this.refundNameStr = refundNameStr;
	}

	public String getApplyCustomer() {
		return applyCustomer;
	}

	public void setApplyCustomer(String applyCustomer) {
		this.applyCustomer = applyCustomer;
	}

	public Date getStartCheckTime() {
		return startCheckTime;
	}

	public void setStartCheckTime(Date startCheckTime) {
		this.startCheckTime = startCheckTime;
	}

	public Date getEndCheckTime() {
		return endCheckTime;
	}

	public void setEndCheckTime(Date endCheckTime) {
		this.endCheckTime = endCheckTime;
	}

	public Date getStartApplyTime() {
		return startApplyTime;
	}

	public void setStartApplyTime(Date startApplyTime) {
		this.startApplyTime = startApplyTime;
	}

	public Date getEndApplyTime() {
		return endApplyTime;
	}

	public void setEndApplyTime(Date endApplyTime) {
		this.endApplyTime = endApplyTime;
	}

	public Date getRefundTime() {
		return refundTime;
	}

	public void setRefundTime(Date refundTime) {
		this.refundTime = refundTime;
	}

	public String getBillno() {
		return billno;
	}

	public void setBillno(String billno) {
		this.billno = billno;
	}

	public String getSeqno() {
		return seqno;
	}

	public void setSeqno(String seqno) {
		this.seqno = seqno;
	}

	public String getWithdrowType() {
		return withdrowType;
	}

	public void setWithdrowType(String withdrowType) {
		this.withdrowType = withdrowType;
	}

	public String getWithdrowMedium() {
		return withdrowMedium;
	}

	public void setWithdrowMedium(String withdrowMedium) {
		this.withdrowMedium = withdrowMedium;
	}

	public String getWithdrowMoneyStatus() {
		return withdrowMoneyStatus;
	}

	public void setWithdrowMoneyStatus(String withdrowMoneyStatus) {
		this.withdrowMoneyStatus = withdrowMoneyStatus;
	}

	public Long getMemberSid() {
		return memberSid;
	}

	public void setMemberSid(Long memberSid) {
		this.memberSid = memberSid;
	}

	public String getRefundName() {
		return refundName;
	}

	public void setRefundName(String refundName) {
		this.refundName = refundName;
	}

	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public String getRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}

	public String getApplyTimeStr() {
		return applyTimeStr;
	}

	public void setApplyTimeStr(String applyTimeStr) {
		this.applyTimeStr = applyTimeStr;
	}

	public String getCheckTimeStr() {
		return checkTimeStr;
	}

	public void setCheckTimeStr(String checkTimeStr) {
		this.checkTimeStr = checkTimeStr;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Double getWithdrowMoney() {
		return withdrowMoney;
	}

	public void setWithdrowMoney(Double withdrowMoney) {
		this.withdrowMoney = withdrowMoney;
	}

	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String getApplyNo() {
		return applyNo;
	}

	public void setApplyNo(String applyNo) {
		this.applyNo = applyNo;
	}

	public String getApplyName() {
		return applyName;
	}

	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public String getWithdrowReason() {
		return withdrowReason;
	}

	public void setWithdrowReason(String withdrowReason) {
		this.withdrowReason = withdrowReason;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBankCardNo() {
		return bankCardNo;
	}

	public void setBankCardNo(String bankCardNo) {
		this.bankCardNo = bankCardNo;
	}

	public Double getBalance() {
		return balance;
	}

	public void setBalance(Double balance) {
		this.balance = balance;
	}

	public String getCancelReason() {
		return cancelReason;
	}

	public void setCancelReason(String cancelReason) {
		this.cancelReason = cancelReason;
	}


	public String getCheckMemo() {
		return checkMemo;
	}

	public void setCheckMemo(String checkMemo) {
		this.checkMemo = checkMemo;
	}

	public String getCheckName() {
		return checkName;
	}

	public void setCheckName(String checkName) {
		this.checkName = checkName;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	public String getFailReason() {
		return failReason;
	}

	public void setFailReason(String failReason) {
		this.failReason = failReason;
	}

	public String getRefundTimeStr() {
		return refundTimeStr;
	}

	public void setRefundTimeStr(String refundTimeStr) {
		this.refundTimeStr = refundTimeStr;
	}

}