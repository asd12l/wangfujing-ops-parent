package com.wangfj.wms.domain.entity;

import java.util.Date;

public class ShopNotice {
    private Integer sid;

    private Integer noticeTypeSid;

    private String title;

    private String content;

    private Date noticesTime;

    private String seq;

    private Integer status;

    private String link;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getNoticeTypeSid() {
        return noticeTypeSid;
    }

    public void setNoticeTypeSid(Integer noticeTypeSid) {
        this.noticeTypeSid = noticeTypeSid;
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

    public Date getNoticesTime() {
        return noticesTime;
    }

    public void setNoticesTime(Date noticesTime) {
        this.noticesTime = noticesTime;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq == null ? null : seq.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link == null ? null : link.trim();
    }
}