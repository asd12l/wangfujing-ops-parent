package com.wangfj.pay.web.vo;

import java.io.Serializable;
/**
 * 统计
 * @author Administrator
 * @date 2016年11月10日 下午1:23:19
 */
public class ExcelPayStaticsVo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1061624897811933444L;
	
	private String storeNo;
	private String storeName;
	private String payTotalFee;
	private Integer payToalCount;
	private String refundTotalFee;
	private Integer refundTotalCount;
	private String couponTotalFee;
	public String getStoreNo() {
		return storeNo;
	}
	public void setStoreNo(String storeNo) {
		this.storeNo = storeNo;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getPayTotalFee() {
		return payTotalFee;
	}
	public void setPayTotalFee(String payTotalFee) {
		this.payTotalFee = payTotalFee;
	}
	public Integer getPayToalCount() {
		return payToalCount;
	}
	public void setPayToalCount(Integer payToalCount) {
		this.payToalCount = payToalCount;
	}
	public String getRefundTotalFee() {
		return refundTotalFee;
	}
	public void setRefundTotalFee(String refundTotalFee) {
		this.refundTotalFee = refundTotalFee;
	}
	public Integer getRefundTotalCount() {
		return refundTotalCount;
	}
	public void setRefundTotalCount(Integer refundTotalCount) {
		this.refundTotalCount = refundTotalCount;
	}
	public String getCouponTotalFee() {
		return couponTotalFee;
	}
	public void setCouponTotalFee(String couponTotalFee) {
		this.couponTotalFee = couponTotalFee;
	}
	@Override
	public String toString() {
		return "ExcelPayStaticsVo [storeNo=" + storeNo + ", storeName=" + storeName + ", payTotalFee=" + payTotalFee
				+ ", payToalCount=" + payToalCount + ", refundTotalFee=" + refundTotalFee + ", refundTotalCount="
				+ refundTotalCount + ", couponTotalFee=" + couponTotalFee + "]";
	}
	
	
	
}
