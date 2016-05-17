package com.wangfj.wms.domain.entity;



/**
 * @Class Name BackUser
 * @Author wwb
 * @Create In 2014-12-2
 */
public class LogisticsUser {
	private Integer sid;
	private Integer supplySid;
	private Integer shopSid;
	private Integer userSid;
	private String supplyName;
	private String shopName;
	
	
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getSupplySid() {
		return supplySid;
	}
	public void setSupplySid(Integer supplySid) {
		this.supplySid = supplySid;
	}
	public Integer getShopSid() {
		return shopSid;
	}
	public void setShopSid(Integer shopSid) {
		this.shopSid = shopSid;
	}
	public Integer getUserSid() {
		return userSid;
	}
	public void setUserSid(Integer userSid) {
		this.userSid = userSid;
	}
	public String getSupplyName() {
		return supplyName;
	}
	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	
	
}
