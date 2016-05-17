package com.wangfj.wms.controller.payment.support;

public class QueryPaymentTypePara {
	private String sid;
	/**
	 * 中台门店编码
	 */
	private String storeCode;
	/**
	 * 门店名称
	 */
	private String storeName;
	/**
	 * 付款方式编码
	 */
	private String payCode;

	/**
	 * 付款方式名称
	 */
	private String name;

	/**
	 * 上一级编码
	 */
	private String parentCode;

	/**
	 * 银行识别码
	 */
	public String bankBIN;

	/**
	 * 当前页
	 */
	private Integer currentPage;

	/**
	 * 单页行数
	 */
	private Integer pageSize;
	
	private String fromSystem;
	
	
	
	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getFromSystem() {
		return fromSystem;
	}

	public void setFromSystem(String fromSystem) {
		this.fromSystem = fromSystem;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
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

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	

}
