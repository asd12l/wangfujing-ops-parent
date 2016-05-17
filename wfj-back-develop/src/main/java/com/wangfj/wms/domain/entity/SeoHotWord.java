package com.wangfj.wms.domain.entity;

public class SeoHotWord {
    private Integer sid;

    private String hotName;

    private String hotLink;

    private Integer flag;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getHotName() {
        return hotName;
    }

    public void setHotName(String hotName) {
        this.hotName = hotName == null ? null : hotName.trim();
    }

    public String getHotLink() {
        return hotLink;
    }

    public void setHotLink(String hotLink) {
        this.hotLink = hotLink == null ? null : hotLink.trim();
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }
}