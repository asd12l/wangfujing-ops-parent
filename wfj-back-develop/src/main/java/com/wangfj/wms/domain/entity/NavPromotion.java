package com.wangfj.wms.domain.entity;

public class NavPromotion {
	private Long sid;
	
	private Integer seq;
	
    private Long navSid;

    private Integer promotionSid;
    
    private Integer isShow;
    
    private Integer flag;
    
    private  String promotionName;
    
    private String promotionLink;
    
    

    public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public String getPromotionName() {
		return promotionName;
	}

	public void setPromotionName(String promotionName) {
		this.promotionName = promotionName;
	}

	public String getPromotionLink() {
		return promotionLink;
	}

	public void setPromotionLink(String promotionLink) {
		this.promotionLink = promotionLink;
	}

	public Integer getIsShow() {
		return isShow;
	}

	public void setIsShow(Integer isShow) {
		this.isShow = isShow;
	}

	public Long getSid() {
		return sid;
	}

	public void setSid(Long sid) {
		this.sid = sid;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Long getNavSid() {
        return navSid;
    }

    public void setNavSid(Long navSid) {
        this.navSid = navSid;
    }

    public Integer getPromotionSid() {
        return promotionSid;
    }

    public void setPromotionSid(Integer promotionSid) {
        this.promotionSid = promotionSid;
    }

	@Override
	public String toString() {
		return "NavPromotion [sid=" + sid + ", seq=" + seq + ", navSid="
				+ navSid + ", promotionSid=" + promotionSid + ", isShow="
				+ isShow + ", flag=" + flag + ", promotionName="
				+ promotionName + ", promotionLink=" + promotionLink + "]";
	}
    
}