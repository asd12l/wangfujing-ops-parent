package com.wangfj.wms.domain.entity;

import java.util.Date;

public class MobileFlashPromotions {
    private Integer sid;

    private String title;

    private String proDesc;

    private String link;

    private Date startTime;

    private Date endTime;

    private String pict;

    private Integer seq;

    private Date createTime;

    private String creater;

    private String createShopName;

    private Integer createShopSid;

    private Integer flag;
    
    private String promotionType;
    
    private Integer promotionTypeSid;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

   

  

	public String getProDesc() {
		return proDesc;
	}

	public void setProDesc(String proDesc) {
		this.proDesc = proDesc;
	}

	public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link == null ? null : link.trim();
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getPict() {
        return pict;
    }

    public void setPict(String pict) {
        this.pict = pict == null ? null : pict.trim();
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater == null ? null : creater.trim();
    }

    public String getCreateShopName() {
        return createShopName;
    }

    public void setCreateShopName(String createShopName) {
        this.createShopName = createShopName == null ? null : createShopName.trim();
    }

    public Integer getCreateShopSid() {
        return createShopSid;
    }

    public void setCreateShopSid(Integer createShopSid) {
        this.createShopSid = createShopSid;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }
    
    

	

	public String getPromotionType() {
		return promotionType;
	}

	public void setPromotionType(String promotionType) {
		this.promotionType = promotionType;
	}

	public Integer getPromotionTypeSid() {
		return promotionTypeSid;
	}

	public void setPromotionTypeSid(Integer promotionTypeSid) {
		this.promotionTypeSid = promotionTypeSid;
	}

	@Override
	public String toString() {
		return "MobileFlashPromotions [sid=" + sid + ", title=" + title
				+ ", proDesc=" + proDesc + ", link=" + link + ", startTime="
				+ startTime + ", endTime=" + endTime + ", pict=" + pict
				+ ", seq=" + seq + ", createTime=" + createTime + ", creater="
				+ creater + ", createShopName=" + createShopName
				+ ", createShopSid=" + createShopSid + ", flag=" + flag
				+ ", promotionType=" + promotionType + ", promotionTypeSid="
				+ promotionTypeSid + "]";
	}
    
    
}