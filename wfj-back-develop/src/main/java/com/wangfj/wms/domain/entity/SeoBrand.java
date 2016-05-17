package com.wangfj.wms.domain.entity;

public class SeoBrand {
    private Integer sid;

    private String brandName;

    private String brandLink;

    private Integer flag;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName == null ? null : brandName.trim();
    }

    public String getBrandLink() {
        return brandLink;
    }

    public void setBrandLink(String brandLink) {
        this.brandLink = brandLink == null ? null : brandLink.trim();
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

	@Override
	public String toString() {
		return "SeoBrand [sid=" + sid + ", brandName=" + brandName
				+ ", brandLink=" + brandLink + ", flag=" + flag + "]";
	}
    
}