package com.wangfj.back.view;

public class UacRoleVO {

	private String dn;
	private String cn;
	private String description;
	private String status;
	private String displayName;
	
	public String getDn() {
		return dn;
	}
	public void setDn(String dn) {
		this.dn = dn;
	}
	public String getCn() {
		return cn;
	}
	public void setCn(String cn) {
		this.cn = cn;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDisplayName() {
		return displayName;
	}
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
	
	@Override
	public String toString() {
		return "UacRoleVO [dn=" + dn + ", cn=" + cn + ", description="
				+ description + ", status=" + status + ", displayName="
				+ displayName + "]";
	}
}
