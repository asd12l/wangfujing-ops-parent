package com.wangfj.order.controller.suppot.refund;

import java.math.BigDecimal;
import java.util.Date;

public class OfRefundGetSplitDto {
	private Long sid;

    private String refundItemNo;//退货单商品行

    private String code;//券编码

    private String name;//券名称

    private String getType;//返利类型

    private String getChannel;//返利渠道

    private Date getTime;//返利日期

    private BigDecimal amount;//值

    private String couponBatch;//券批次
    
    private String deleteFlag;//删除标记

    public String getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Long getSid() {
        return sid;
    }

    public void setSid(Long sid) {
        this.sid = sid;
    }

    public String getRefundItemNo() {
        return refundItemNo;
    }

    public void setRefundItemNo(String refundItemNo) {
        this.refundItemNo = refundItemNo;
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

	@Override
	public String toString() {
		return "OfRefundGetSplitDto [sid=" + sid + ", refundItemNo=" + refundItemNo + ", code="
				+ code + ", name=" + name + ", getType=" + getType + ", getChannel=" + getChannel
				+ ", getTime=" + getTime + ", amount=" + amount + ", couponBatch=" + couponBatch
				+ ", deleteFlag=" + deleteFlag + "]";
	}
}
