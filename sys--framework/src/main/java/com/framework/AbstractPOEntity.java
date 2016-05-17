package com.framework;

import java.io.Serializable;
import java.util.Date;

/**
 * desc   : 抽象实体对象
 * author : luxiangxing
 * data   : 2013-2-14
 * email  : xiangxingchina@163.com
 **/
public class AbstractPOEntity  implements Serializable{
	protected Long sid;			//主键SID
	protected String createUser;	//创建者
	protected Date createTime;		//创建时间
	protected String updateUser;	//更新者
	protected Date updateTime;		//更新时间
	protected String delflag;//删除Flag 1：未删除 2：已删除
	protected String status;//状态 1：公开 2：私人
	protected String extTableName; //扩展表名
	
	public Long getSid() {
		return sid;
	}
	public void setSid(Long sid) {
		this.sid = sid;
	}
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getDelflag() {
		return delflag;
	}
	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getExtTableName() {
		return extTableName;
	}
	public void setExtTableName(String extTableName) {
		this.extTableName = extTableName;
	}
	
}
