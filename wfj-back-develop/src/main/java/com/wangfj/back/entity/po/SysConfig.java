package com.wangfj.back.entity.po;

public class SysConfig {
    private Integer sid;

    private String sysKey;

    private String sysValue;
    
    private String sysDesc;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getSysKey() {
        return sysKey;
    }

    public void setSysKey(String sysKey) {
        this.sysKey = sysKey;
    }

    public String getSysValue() {
        return sysValue;
    }

    public void setSysValue(String sysValue) {
        this.sysValue = sysValue;
    }

	public String getSysDesc() {
		return sysDesc;
	}

	public void setSysDesc(String sysDesc) {
		this.sysDesc = sysDesc;
	}

	@Override
	public String toString() {
		return "SysConfig [sid=" + sid + ", sysKey=" + sysKey + ", sysValue="
				+ sysValue + ", sysDesc=" + sysDesc + "]";
	}

}