package com.wangfj.wms.domain.entity;

public class NavBrand {
    private Long sid;

    private Long navSid;

    private Long brandSid;

    private String brandName;

    private String brandPic;

    private String brandLink;
    
    private Integer isShow;
    
    private Integer seq;
    
    private Integer flag;
    
    

    public Integer getIsShow() {
		return isShow;
	}

	public void setIsShow(Integer isShow) {
		this.isShow = isShow;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Long getSid() {
        return sid;
    }

    public void setSid(Long sid) {
        this.sid = sid;
    }

    public Long getNavSid() {
        return navSid;
    }

    public void setNavSid(Long navSid) {
        this.navSid = navSid;
    }

    public Long getBrandSid() {
        return brandSid;
    }

    public void setBrandSid(Long brandSid) {
        this.brandSid = brandSid;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName == null ? null : brandName.trim();
    }

    public String getBrandPic() {
        return brandPic;
    }

    public void setBrandPic(String brandPic) {
        this.brandPic = brandPic == null ? null : brandPic.trim();
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
		return "NavBrand [sid=" + sid + ", navSid=" + navSid + ", brandSid="
				+ brandSid + ", brandName=" + brandName + ", brandPic="
				+ brandPic + ", brandLink=" + brandLink + ", isShow=" + isShow
				+ ", seq=" + seq + ", flag=" + flag + "]";
	}
    
    
}