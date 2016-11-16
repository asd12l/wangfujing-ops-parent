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
	private Double payTotalFee;
	private Integer payToalCount;
	private Double refundTotalFee;
	private Integer refundTotalCount;
	private Double couponTotalFee;
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
	public Double getPayTotalFee() {
		return payTotalFee;
	}
	public void setPayTotalFee(Double payTotalFee) {
		this.payTotalFee = payTotalFee;
	}
	public Integer getPayToalCount() {
		return payToalCount;
	}
	public void setPayToalCount(Integer payToalCount) {
		this.payToalCount = payToalCount;
	}
	public Double getRefundTotalFee() {
		return refundTotalFee;
	}
	public void setRefundTotalFee(Double refundTotalFee) {
		this.refundTotalFee = refundTotalFee;
	}
	public Integer getRefundTotalCount() {
		return refundTotalCount;
	}
	public void setRefundTotalCount(Integer refundTotalCount) {
		this.refundTotalCount = refundTotalCount;
	}
	public Double getCouponTotalFee() {
		return couponTotalFee;
	}
	public void setCouponTotalFee(Double couponTotalFee) {
		this.couponTotalFee = couponTotalFee;
	}
	@Override
	public String toString() {
		return "ExcelPayStaticsVo [storeNo=" + storeNo + ", storeName=" + storeName + ", payTotalFee=" + payTotalFee
				+ ", payToalCount=" + payToalCount + ", refundTotalFee=" + refundTotalFee + ", refundTotalCount="
				+ refundTotalCount + ", couponTotalFee=" + couponTotalFee + "]";
	}
	
	
	
}
