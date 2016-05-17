package com.wangfj.wms.domain.view;

import java.util.Date;

public class CommentsVO {
	private Integer sid;

    private Integer salesSid;

    private String user;

    private String content;

    private Date commentTime;

    private String shopSid;
    
    private String type;//消息类型

    private String title;//消息标题
    
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
		this.user = user;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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
		this.shopSid = shopSid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		return "CommentsVO [sid=" + sid + ", salesSid=" + salesSid + ", user="
				+ user + ", content=" + content + ", commentTime="
				+ commentTime + ", shopSid=" + shopSid + ", type=" + type
				+ ", title=" + title + ", flag=" + flag + "]";
	}

//    private String parentUser;
//
//    private Integer parentSid;
//
//    private Integer review;
//
//    private String reviewUser;
//
//    private Date reviewTime;

 
	
}
