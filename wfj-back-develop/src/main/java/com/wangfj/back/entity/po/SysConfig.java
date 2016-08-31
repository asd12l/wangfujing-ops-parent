package com.wangfj.back.entity.po;

public class SysConfig {
    private Integer sid;

    private String key;

    private String value;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

	@Override
	public String toString() {
		return "SysConfig [sid=" + sid + ", key=" + key + ", value=" + value
				+ "]";
	}
    
}