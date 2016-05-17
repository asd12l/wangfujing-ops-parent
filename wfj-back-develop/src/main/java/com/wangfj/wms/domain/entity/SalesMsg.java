package com.wangfj.wms.domain.entity;

import java.util.Date;

public class SalesMsg {
    private Integer sid;//信息编号

    private String type;//消息类型

    private String title;//消息标题

    private String content;//消息内容

    private String daogouName;//导购姓名

    private Integer supportCount;//点赞数量

    private Date createTime;//发布时间

    private String shopSid;//门店sid

    private String pic;//图片地址

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type == null ? null : type.trim();
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getDaogouName() {
        return daogouName;
    }

    public void setDaogouName(String daogouName) {
        this.daogouName = daogouName == null ? null : daogouName.trim();
    }

    public Integer getSupportCount() {
        return supportCount;
    }

    public void setSupportCount(Integer supportCount) {
        this.supportCount = supportCount;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getShopSid() {
        return shopSid;
    }

    public void setShopSid(String shopSid) {
        this.shopSid = shopSid == null ? null : shopSid.trim();
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

	@Override
	public String toString() {
		return "SalesMsg [sid=" + sid + ", type=" + type + ", title=" + title
				+ ", content=" + content + ", daogouName=" + daogouName
				+ ", supportCount=" + supportCount + ", createTime="
				+ createTime + ", shopSid=" + shopSid + ", pic=" + pic + "]";
	}
    
    
}