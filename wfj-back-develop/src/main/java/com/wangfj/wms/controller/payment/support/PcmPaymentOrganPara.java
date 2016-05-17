package com.wangfj.wms.controller.payment.support;

public class PcmPaymentOrganPara {
	/**
	 * sid
	 */
	private String sid;

	/**
	 * 门店编号
	 */
	private String shopSid;

	/**
	 * 支付方式编码
	 */
	private String code;
	
	private String bankBin;
	

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getShopSid() {
		return shopSid;
	}

	public void setShopSid(String shopSid) {
		this.shopSid = shopSid;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getBankBin() {
		return bankBin;
	}

	public void setBankBin(String bankBin) {
		this.bankBin = bankBin;
	}
	
	
	
}
