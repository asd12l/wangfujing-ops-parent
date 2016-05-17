package com.wangfj.cms.dto;

public class MsgHeaderDto {
	private String version;
    private String sourceSysID;
    private String serviceID;
    private String priority;
    private String count;
    private String bizType;
    private String token;
    private String createTime;
	private String field1;
    private String field2;
    private String field3;
    private String messageID;
    private String messageType;//消息类型 0：普通消息 1：补偿消息
    private String routeKey;  //路由KEY
    private String destUrl;  //目标系统URL
//    private String errorCallUrl;  //错误返回URL
    private String callbackUrl;  //错误返回URL
    private Integer destCallType; //0-默认POST 1-WS(SOAP) 只点对点有效

    public String getVersion() {

        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getSourceSysID() {
        return sourceSysID;
    }

    public void setSourceSysID(String sourceSysID) {
        this.sourceSysID = sourceSysID;
    }

    public String getServiceID() {
        return serviceID;
    }

    public void setServiceID(String serviceID) {
        this.serviceID = serviceID;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public String getBizType() {
        return bizType;
    }

    public void setBizType(String bizType) {
        this.bizType = bizType;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getField1() {
        return field1;
    }

    public void setField1(String field1) {
        this.field1 = field1;
    }

    public String getField2() {
        return field2;
    }

    public void setField2(String field2) {
        this.field2 = field2;
    }

    public String getField3() {
        return field3;
    }

    public void setField3(String field3) {
        this.field3 = field3;
    }

    public String getMessageID() {
        return messageID;
    }

    public void setMessageID(String messageID) {
        this.messageID = messageID;
    }

    public String getMessageType() {
        return messageType;
    }

    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    public String getRouteKey() {
        return routeKey;
    }

    public void setRouteKey(String routeKey) {
        this.routeKey = routeKey;
    }

    public String getDestUrl() {
        return destUrl;
    }

    public void setDestUrl(String destUrl) {
        this.destUrl = destUrl;
    }

    public String getCallbackUrl() {
        return callbackUrl;
    }

    public void setCallbackUrl(String callbackUrl) {
        this.callbackUrl = callbackUrl;
    }

    public Integer getDestCallType() {
        return destCallType;
    }

    public void setDestCallType(Integer destCallType) {
        this.destCallType = destCallType;
    }

}
