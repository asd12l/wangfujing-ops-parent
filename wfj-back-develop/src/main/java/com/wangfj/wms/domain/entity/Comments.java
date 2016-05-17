package com.wangfj.wms.domain.entity;

import java.util.Date;

public class Comments {
    private Integer sid;

    private Integer salesSid;

    private String user;

    private String content;

    private Date commentTime;

    private String shopSid;

    private String parentUser;

    private Integer parentSid;

    private Integer review;

    private String reviewUser;

    private Date reviewTime;

    private Integer flag;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getSalesSid() {
        return salesSid;
    }

    public void setSalesSid(Integer salesSid) {
        this.salesSid = salesSid;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user == null ? null : user.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getShopSid() {
        return shopSid;
    }

    public void setShopSid(String shopSid) {
        this.shopSid = shopSid == null ? null : shopSid.trim();
    }

    public String getParentUser() {
        return parentUser;
    }

    public void setParentUser(String parentUser) {
        this.parentUser = parentUser == null ? null : parentUser.trim();
    }

    public Integer getParentSid() {
        return parentSid;
    }

    public void setParentSid(Integer parentSid) {
        this.parentSid = parentSid;
    }

    public Integer getReview() {
        return review;
    }

    public void setReview(Integer review) {
        this.review = review;
    }

    public String getReviewUser() {
        return reviewUser;
    }

    public void setReviewUser(String reviewUser) {
        this.reviewUser = reviewUser == null ? null : reviewUser.trim();
    }

    public Date getReviewTime() {
        return reviewTime;
    }

    public void setReviewTime(Date reviewTime) {
        this.reviewTime = reviewTime;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

	@Override
	public String toString() {
		return "Comments [sid=" + sid + ", salesSid=" + salesSid + ", user="
				+ user + ", content=" + content + ", commentTime="
				+ commentTime + ", shopSid=" + shopSid + ", parentUser="
				+ parentUser + ", parentSid=" + parentSid + ", review="
				+ review + ", reviewUser=" + reviewUser + ", reviewTime="
				+ reviewTime + ", flag=" + flag + "]";
	}
    
    
}