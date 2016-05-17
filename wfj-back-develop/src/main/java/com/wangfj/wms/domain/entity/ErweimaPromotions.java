package com.wangfj.wms.domain.entity;

import java.util.Date;

public class ErweimaPromotions {
    private Integer sid;

    private String title;

    private String proDesc;

    private String url;

    private Date startTime;

    private Date endTime;

	private Integer flag;

    private Integer seq;

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
        this.proDesc = proDesc == null ? null : proDesc.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
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

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }
    @Override
   	public String toString() {
   		return "ErweimaPromotions [sid=" + sid + ", title=" + title
   				+ ", proDesc=" + proDesc + ", url=" + url + ", startTime="
   				+ startTime + ", endTime=" + endTime + ", flag=" + flag
   				+ ", seq=" + seq + "]";
   	}
}