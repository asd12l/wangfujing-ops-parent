package com.wangfj.wms.domain.entity;

public class CommentParameters {
    private Integer sid;

    private Integer commentTimes;

    private Integer intervals;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getCommentTimes() {
        return commentTimes;
    }

    public void setCommentTimes(Integer commentTimes) {
        this.commentTimes = commentTimes;
    }

    public Integer getInterval() {
        return intervals;
    }

    public void setInterval(Integer intervals) {
        this.intervals = intervals;
    }
}