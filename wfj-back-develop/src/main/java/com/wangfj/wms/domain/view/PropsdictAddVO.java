package com.wangfj.wms.domain.view;

/**
 * 属性属性值添加VO
 * 
 * @Class Name PropsdictAddVO
 * @Author wangsy
 * @Create In 2015年8月28日
 */
public class PropsdictAddVO {

	private String id;
	private String sid;
	private String propsName;
	private String propsDesc;
	private String isKeyProp;
	private String isErpProp;
	private String erpType;
	private String status;
	private String isEnumProp;
	private String channelSid;
	private String insert1;
	private String update1;
	private String delete1;

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPropsName() {
		return propsName;
	}

	public void setPropsName(String propsName) {
		this.propsName = propsName;
	}

	public String getPropsDesc() {
		return propsDesc;
	}

	public void setPropsDesc(String propsDesc) {
		this.propsDesc = propsDesc;
	}

	public String getIsKeyProp() {
		return isKeyProp;
	}

	public void setIsKeyProp(String isKeyProp) {
		this.isKeyProp = isKeyProp;
	}

	public String getIsErpProp() {
		return isErpProp;
	}

	public void setIsErpProp(String isErpProp) {
		this.isErpProp = isErpProp;
	}

	public String getErpType() {
		return erpType;
	}

	public void setErpType(String erpType) {
		this.erpType = erpType;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIsEnumProp() {
		return isEnumProp;
	}

	public void setIsEnumProp(String isEnumProp) {
		this.isEnumProp = isEnumProp;
	}

	public String getChannelSid() {
		return channelSid;
	}

	public void setChannelSid(String channelSid) {
		this.channelSid = channelSid;
	}

	public String getInsert1() {
		return insert1;
	}

	public void setInsert1(String insert1) {
		this.insert1 = insert1;
	}

	public String getUpdate1() {
		return update1;
	}

	public void setUpdate1(String update1) {
		this.update1 = update1;
	}

	public String getDelete1() {
		return delete1;
	}

	public void setDelete1(String delete1) {
		this.delete1 = delete1;
	}

	@Override
	public String toString() {
		return "PropsdictAddVO [sid=" + sid + ", id=" + id + ", propsName=" + propsName
				+ ", propsDesc=" + propsDesc + ", isKeyProp=" + isKeyProp + ", isErpProp="
				+ isErpProp + ", erpType=" + erpType + ", status=" + status + ", isEnumProp="
				+ isEnumProp + ", channelSid=" + channelSid + ", insert1=" + insert1 + ", update1="
				+ update1 + ", delete1=" + delete1 + "]";
	}

}
