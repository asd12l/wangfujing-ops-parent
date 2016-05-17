package com.wangfj.wms.domain.entity;

public class SysParameterValue {
    private Integer sid;

    private Integer sysParameterTypeSid;

    private String name;

    private String value;

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Integer getSysParameterTypeSid() {
        return sysParameterTypeSid;
    }

    public void setSysParameterTypeSid(Integer sysParameterTypeSid) {
        this.sysParameterTypeSid = sysParameterTypeSid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value == null ? null : value.trim();
    }
}