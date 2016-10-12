package com.wangfj.order.controller.suppot.sale;

import java.math.BigDecimal;
import java.util.Date;

public class OfOrderGetSplitDto {
private Long sid;
	
	private String salesItemNo;//销售单商品行

    private String code;//券编码

    private String name;//券名称

    private String getType;//返利类型

    private String getChannel;//返利渠道

    private Date getTime;//返利日期

    private BigDecimal amount;//值

    private String couponBatch;//券批次

    private String couponType;
   

	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public String getSalesItemNo() {
		return salesItemNo;
	}

	public void setSalesItemNo(String salesItemNo) {
		this.salesItemNo = salesItemNo;
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

	public String getCouponType() {
		return couponType;
	}

	public void setCouponType(String couponType) {
		this.couponType = couponType;
	}

	@Override
	public String toString() {
		return "OfOrderGetSplitDto [sid=" + sid + ", salesItemNo="
				+ salesItemNo + ", code=" + code + ", name=" + name
				+ ", getType=" + getType + ", getChannel=" + getChannel
				+ ", getTime=" + getTime + ", amount=" + amount
				+ ", couponBatch=" + couponBatch + ", couponType=" + couponType
				+ "]";
	}
}
