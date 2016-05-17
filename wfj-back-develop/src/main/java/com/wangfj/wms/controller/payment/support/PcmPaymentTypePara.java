package com.wangfj.wms.controller.payment.support;

public class PcmPaymentTypePara {

	/**
	 * SID
	 */
	private String sid;
	/**
	 * 支付编码
	 */
	public String payCode;
	/**
	 * 支付名称
	 */
	public String name;
	/**
	 * 上级支付编码
	 */
	public String parentCode;
	/**
	 * 银行识别码
	 */
	public String bankBIN;

	/**
	 * 支付类型
	 */
	private String dealTime;

	/**
	 * 能否开发票(Y或N)
	 */
	private String isAllowInvoice;

	/**
	 * 最后修改人
	 */
	private String lastUpdBy;

	/**
	 * 创建时间
	 */
	private String createDate;

	/**
	 * 创建人
	 */
	private String createBy;

	/**
	 * 备注
	 */
	private String remark;

	private String fromSystem;

	public String getFromSystem() {
		return fromSystem;
	}

	public void setFromSystem(String fromSystem) {
		this.fromSystem = fromSystem;
	}

	public String getDealTime() {
		return dealTime;
	}

	public void setDealTime(String dealTime) {
		this.dealTime = dealTime;
	}

	public String getLastUpdBy() {
		return lastUpdBy;
	}

	public void setLastUpdBy(String lastUpdBy) {
		this.lastUpdBy = lastUpdBy;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getPayCode() {
		return payCode;
	}

	public void setPayCode(String payCode) {
		this.payCode = payCode;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getBankBIN() {
		return bankBIN;
	}

	public void setBankBIN(String bankBIN) {
		this.bankBIN = bankBIN;
	}

	public String getIsAllowInvoice() {
		return isAllowInvoice;
	}

	public void setIsAllowInvoice(String isAllowInvoice) {
		this.isAllowInvoice = isAllowInvoice;
	}

}
