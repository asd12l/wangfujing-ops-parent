package com.wangfj.pay.web.vo;

import java.io.Serializable;

public class ExcelBalanceVo implements Serializable {
	
	private static final long serialVersionUID = 9132042592318096691L;

	private String bpOrderId;
	
	private Long bpId;
	
	private String bpName;
	
	private String orderTradeNo;

	private Long payDate;

	private String content;

	private String account;

	private Double totalFee;

	private String finalPayTerminal;

	private String finalPayTerminalName;
	
	private String payType;
	
	private String payTypeName;
	
	private String payBank;
	
	private String payBankName;
	
	private Integer payService;
	
	private String payServiceName;

	private String paySerialNumber;
	
	private String rate;
	
	private Double channelFeeCost;

	private Double needPayPrice;

	private Double bargainIncome;

	private String unid;
	
	private String userName;

	public String getBpOrderId() {
		return bpOrderId;
	}


	public void setBpOrderId(String bpOrderId) {
		this.bpOrderId = bpOrderId;
	}

	public Long getBpId() {
		return bpId;
	}

	public void setBpId(Long bpId) {
		this.bpId = bpId;
	}

	public String getBpName() {
		return bpName;
	}

	public void setBpName(String bpName) {
		this.bpName = bpName;
	}

	public String getOrderTradeNo() {
		return orderTradeNo;
	}

	public void setOrderTradeNo(String orderTradeNo) {
		this.orderTradeNo = orderTradeNo;
	}

	public Long getPayDate() {
		return payDate;
	}

	public void setPayDate(Long payDate) {
		this.payDate = payDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Double getTotalFee() {
		return totalFee;
	}

	public void setTotalFee(Double totalFee) {
		this.totalFee = totalFee;
	}

	public String getFinalPayTerminal() {
		return finalPayTerminal;
	}

	public void setFinalPayTerminal(String finalPayTerminal) {
		this.finalPayTerminal = finalPayTerminal;
	}

	public String getFinalPayTerminalName() {
		return finalPayTerminalName;
	}

	public void setFinalPayTerminalName(String finalPayTerminalName) {
		this.finalPayTerminalName = finalPayTerminalName;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getPayTypeName() {
		return payTypeName;
	}

	public void setPayTypeName(String payTypeName) {
		this.payTypeName = payTypeName;
	}

	public String getPayBank() {
		return payBank;
	}

	public void setPayBank(String payBank) {
		this.payBank = payBank;
	}

	public String getPayBankName() {
		return payBankName;
	}

	public void setPayBankName(String payBankName) {
		this.payBankName = payBankName;
	}

	public Integer getPayService() {
		return payService;
	}

	public void setPayService(Integer payService) {
		this.payService = payService;
	}

	public String getPayServiceName() {
		return payServiceName;
	}

	public void setPayServiceName(String payServiceName) {
		this.payServiceName = payServiceName;
	}

	public String getPaySerialNumber() {
		return paySerialNumber;
	}

	public void setPaySerialNumber(String paySerialNumber) {
		this.paySerialNumber = paySerialNumber;
	}

	public String getRate() {
		return rate;
	}

	public void setRate(String rate) {
		this.rate = rate;
	}

	public Double getChannelFeeCost() {
		return channelFeeCost;
	}

	public void setChannelFeeCost(Double channelFeeCost) {
		this.channelFeeCost = channelFeeCost;
	}

	public Double getNeedPayPrice() {
		return needPayPrice;
	}

	public void setNeedPayPrice(Double needPayPrice) {
		this.needPayPrice = needPayPrice;
	}

	public Double getBargainIncome() {
		return bargainIncome;
	}

	public void setBargainIncome(Double bargainIncome) {
		this.bargainIncome = bargainIncome;
	}

	public String getUnid() {
		return unid;
	}

	public void setUnid(String unid) {
		this.unid = unid;
	}
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public ExcelBalanceVo() {
		super();
	}

	public ExcelBalanceVo(String bpOrderId, Long bpId, String bpName,
			String orderTradeNo, Long payDate, String content,
			String account, Double totalFee, String finalPayTerminal,
			String finalPayTerminalName, String payType, String payTypeName,
			String payBank, String payBankName, Integer payService,
			String payServiceName, String paySerialNumber, String rate,
			Double channelFeeCost, Double needPayPrice, Double bargainIncome,
			String unid) {
		this.bpOrderId = bpOrderId;
		this.bpId = bpId;
		this.bpName = bpName;
		this.orderTradeNo = orderTradeNo;
		this.payDate = payDate;
		this.content = content;
		this.account = account;
		this.totalFee = totalFee;
		this.finalPayTerminal = finalPayTerminal;
		this.finalPayTerminalName = finalPayTerminalName;
		this.payType = payType;
		this.payTypeName = payTypeName;
		this.payBank = payBank;
		this.payBankName = payBankName;
		this.payService = payService;
		this.payServiceName = payServiceName;
		this.paySerialNumber = paySerialNumber;
		this.rate = rate;
		this.channelFeeCost = channelFeeCost;
		this.needPayPrice = needPayPrice;
		this.bargainIncome = bargainIncome;
		this.unid = unid;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("VerificaResDTO [bpOrderId=");
		builder.append(bpOrderId);
		builder.append(", bpId=");
		builder.append(bpId);
		builder.append(", bpName=");
		builder.append(bpName);
		builder.append(", orderTradeNo=");
		builder.append(orderTradeNo);
		builder.append(", payDate=");
		builder.append(payDate);
		builder.append(", content=");
		builder.append(content);
		builder.append(", account=");
		builder.append(account);
		builder.append(", totalPrice=");
		builder.append(totalFee);
		builder.append(", finalPayTerminal=");
		builder.append(finalPayTerminal);
		builder.append(", finalPayTerminalName=");
		builder.append(finalPayTerminalName);
		builder.append(", payType=");
		builder.append(payType);
		builder.append(", payTypeName=");
		builder.append(payTypeName);
		builder.append(", payBank=");
		builder.append(payBank);
		builder.append(", payBankName=");
		builder.append(payBankName);
		builder.append(", payService=");
		builder.append(payService);
		builder.append(", payServiceName=");
		builder.append(payServiceName);
		builder.append(", paySerialNumber=");
		builder.append(paySerialNumber);
		builder.append(", rate=");
		builder.append(rate);
		builder.append(", channelFeeCost=");
		builder.append(channelFeeCost);
		builder.append(", needPayPrice=");
		builder.append(needPayPrice);
		builder.append(", bargainIncome=");
		builder.append(bargainIncome);
		builder.append(", unid=");
		builder.append(unid);
		builder.append("]");
		return builder.toString();
	}

}
