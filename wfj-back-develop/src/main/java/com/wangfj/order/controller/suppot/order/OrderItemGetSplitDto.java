package com.wangfj.order.controller.suppot.order;

import java.math.BigDecimal;
import java.util.Date;

public class OrderItemGetSplitDto {
	private String orderItemNo;

    private String code;

    private String name;

    private String getType;

    private String getChannel;

    private Date getTime;

    private BigDecimal amount;

    private String couponBatch;

    private String deleteFlag;
    
    private String couponType;


    public String getOrderItemNo() {
        return orderItemNo;
    }

    public void setOrderItemNo(String orderItemNo) {
        this.orderItemNo = orderItemNo;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGetType() {
        return getType;
    }

    public void setGetType(String getType) {
        this.getType = getType;
    }

    public String getGetChannel() {
        return getChannel;
    }

    public void setGetChannel(String getChannel) {
        this.getChannel = getChannel;
    }

    public Date getGetTime() {
        return getTime;
    }

    public void setGetTime(Date getTime) {
        this.getTime = getTime;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getCouponBatch() {
        return couponBatch;
    }

    public void setCouponBatch(String couponBatch) {
        this.couponBatch = couponBatch;
    }

    public String getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(String deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

	public String getCouponType() {
		return couponType;
	}

	public void setCouponType(String couponType) {
		this.couponType = couponType;
	}
}
