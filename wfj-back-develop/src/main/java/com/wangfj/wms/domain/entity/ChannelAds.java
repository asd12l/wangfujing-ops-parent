package com.wangfj.wms.domain.entity;

public class ChannelAds {
    private Integer sid;

    private Integer shopChannelSid;

    private String positiotag;

    private String positioname;

    private String pic;

    private String link;

    private String memo;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getShopChannelSid() {
        return shopChannelSid;
    }

    public void setShopChannelSid(Integer shopChannelSid) {
        this.shopChannelSid = shopChannelSid;
    }

    public String getPositiotag() {
        return positiotag;
    }

    public void setPositiotag(String positiotag) {
        this.positiotag = positiotag == null ? null : positiotag.trim();
    }

    public String getPositioname() {
        return positioname;
    }

    public void setPositioname(String positioname) {
        this.positioname = positioname == null ? null : positioname.trim();
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic == null ? null : pic.trim();
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link == null ? null : link.trim();
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo == null ? null : memo.trim();
    }
}