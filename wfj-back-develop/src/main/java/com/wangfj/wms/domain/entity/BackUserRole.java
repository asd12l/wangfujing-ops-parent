package com.wangfj.wms.domain.entity;

/**
 * @Class Name 后台用户角色实体类
 * @Author wwb
 * @Create In 2014-12-8
 */
public class BackUserRole {
	private Integer sid;//主键id
	private Integer userSid;//用户id
	private Integer roleSid;//角色id
	private String userName;//用户名
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getUserSid() {
		return userSid;
	}
	public void setUserSid(Integer userSid) {
		this.userSid = userSid;
	}
	public Integer getRoleSid() {
		return roleSid;
	}
	public void setRoleSid(Integer roleSid) {
		this.roleSid = roleSid;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	

}
