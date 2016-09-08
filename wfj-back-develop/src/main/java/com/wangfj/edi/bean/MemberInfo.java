package com.wangfj.edi.bean;

import java.util.List;

public class MemberInfo {
	private List<Member> data;
	private String success;


	public List<Member> getData() {
		return data;
	}

	public void setData(List<Member> data) {
		this.data = data;
	}

	public String getSuccess() {
		return success;
	}

	public void setSuccess(String success) {
		this.success = success;
	}

}
