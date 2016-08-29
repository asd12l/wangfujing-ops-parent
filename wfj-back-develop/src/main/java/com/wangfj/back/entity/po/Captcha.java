package com.wangfj.back.entity.po;

public class Captcha {
    private Integer sid;

    private Integer random;

    private String bigImg;

    private String litImg;

    private Integer startX;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getRandom() {
        return random;
    }

    public void setRandom(Integer random) {
        this.random = random;
    }

    public String getBigImg() {
        return bigImg;
    }

    public void setBigImg(String bigImg) {
        this.bigImg = bigImg;
    }

    public String getLitImg() {
        return litImg;
    }

    public void setLitImg(String litImg) {
        this.litImg = litImg;
    }

    public Integer getStartX() {
        return startX;
    }

    public void setStartX(Integer startX) {
        this.startX = startX;
    }
}