package com.wangfj.wms.domain.entity;

import java.util.Date;

public class LabourDayUserInfo {
    private Integer sid;

    private String username;

    private String tel;

    private String address;

    private String email;

    private Date createTime;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel == null ? null : tel.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

	@Override
	public String toString() {
		return "LabourDayUserInfo [sid=" + sid + ", username=" + username
				+ ", tel=" + tel + ", address=" + address + ", email=" + email
				+ ", createTime=" + createTime + "]";
	}
    
}