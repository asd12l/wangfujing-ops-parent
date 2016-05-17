package com.framework;

import java.io.Serializable;

import org.codehaus.jackson.map.annotate.JsonSerialize;

/**
 * desc   : 抽象vo对象
 * author : luxiangxing
 * data   : 2013-2-14
 * email  : xiangxingchina@163.com
 **/
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class AbstractVOEntity implements Serializable{
	protected Integer sid;			//主键SID
	protected String status;		//状态 1：公开 2：私人
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}
