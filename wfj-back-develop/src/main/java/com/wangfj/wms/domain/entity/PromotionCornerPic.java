package com.wangfj.wms.domain.entity;

import java.util.Date;

public class PromotionCornerPic {
    private Integer sid;

    private String cornerName;

    private String picLink;

    private Date createTime;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getCornerName() {
        return cornerName;
    }

    public void setCornerName(String cornerName) {
        this.cornerName = cornerName == null ? null : cornerName.trim();
    }

    public String getPicLink() {
        return picLink;
    }

    public void setPicLink(String picLink) {
        this.picLink = picLink == null ? null : picLink.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	@Override
	public String toString() {
		return "PromotionCornerPic [sid=" + sid + ", cornerName=" + cornerName
				+ ", picLink=" + picLink + ", createTime=" + createTime + "]";
	}
    
    
}