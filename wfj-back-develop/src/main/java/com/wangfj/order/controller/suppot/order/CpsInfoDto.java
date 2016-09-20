package com.wangfj.order.controller.suppot.order;

import java.util.Date;

public class CpsInfoDto {
	private String orderNo; //订单号

	private String src; //广告来源

	private String tid; //广告类型

	private String lid; //广告序号

	private String cid; //广告点击数

	private String mid; //广告主在CPS网站的ID

	private String aid; //CPS网站下联盟会员ID
	
	private String whetherCoupon; //是否用券

	private String userName; //账户

	private String userEmail; //

	private String loginChannel; //用户登录渠道

	private String registerDate; //用户注册时间
	
	private String couponNo; //优惠券编号
    
    private Date clickTime; //点击时间
    
    private String flowSource; //流量来源
    

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getWhetherCoupon() {
		return whetherCoupon;
	}

	public void setWhetherCoupon(String whetherCoupon) {
		this.whetherCoupon = whetherCoupon;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getLoginChannel() {
		return loginChannel;
	}

	public void setLoginChannel(String loginChannel) {
		this.loginChannel = loginChannel;
	}

	public String getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getLid() {
		return lid;
	}

	public void setLid(String lid) {
		this.lid = lid;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getAid() {
		return aid;
	}

	public void setAid(String aid) {
		this.aid = aid;
	}

	public String getCouponNo() {
		return couponNo;
	}

	public void setCouponNo(String couponNo) {
		this.couponNo = couponNo;
	}

	public Date getClickTime() {
		return clickTime;
	}

	public void setClickTime(Date clickTime) {
		this.clickTime = clickTime;
	}

	public String getFlowSource() {
		return flowSource;
	}

	public void setFlowSource(String flowSource) {
		this.flowSource = flowSource;
	}

	@Override
	public String toString() {
		return "CpsInfoDto [orderNo=" + orderNo + ", src=" + src + ", tid="
				+ tid + ", lid=" + lid + ", cid=" + cid + ", mid=" + mid
				+ ", aid=" + aid + ", whetherCoupon=" + whetherCoupon
				+ ", userName=" + userName + ", userEmail=" + userEmail
				+ ", loginChannel=" + loginChannel + ", registerDate="
				+ registerDate + ", couponNo=" + couponNo + ", clickTime="
				+ clickTime + ", flowSource=" + flowSource + "]";
	}

}
