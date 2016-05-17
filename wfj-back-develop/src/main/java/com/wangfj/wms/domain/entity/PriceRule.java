package com.wangfj.wms.domain.entity;

import java.util.Date;

public class PriceRule {
    private Integer sid;

    private Integer tsid;

    private Integer pageLayoutSid;

    private Double value;

    private Date beginTime;

    private Date endTime;

    private Integer flag;

    private String supplysids;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getTsid() {
        return tsid;
    }

    public void setTsid(Integer tsid) {
        this.tsid = tsid;
    }

    public Integer getPageLayoutSid() {
        return pageLayoutSid;
    }

    public void setPageLayoutSid(Integer pageLayoutSid) {
        this.pageLayoutSid = pageLayoutSid;
    }

    
    public Double getValue() {
		return value;
	}

	public void setValue(Double value) {
		this.value = value;
	}

	public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public String getSupplysids() {
        return supplysids;
    }

    public void setSupplysids(String supplysids) {
        this.supplysids = supplysids == null ? null : supplysids.trim();
    }
}