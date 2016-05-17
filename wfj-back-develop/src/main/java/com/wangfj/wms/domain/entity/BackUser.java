package com.wangfj.wms.domain.entity;

import com.wangfj.wms.util.PageModel;


/**
 * @Class Name BackUser
 * @Author wwb
 * @Create In 2014-12-2
 */
public class BackUser extends PageModel{
	private Integer sid;
	private Integer orgDepartSid;
	private String realName;
	private String userName;
	private String passWord;
	private Integer status;
	private Integer type;
	
	
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getOrgDepartSid() {
		return orgDepartSid;
	}
	public void setOrgDepartSid(Integer orgDepartSid) {
		this.orgDepartSid = orgDepartSid;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}	
}
