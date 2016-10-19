package com.wangfj.pay.web.vo;

import java.io.Serializable;
import java.nio.charset.Charset;
import java.util.List;

/**
 * 支付介质节点PO
 */
public class ZtreeNodesVO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3598617754335850740L;
	
	private String id;

	private String pId;
	
	private String name;
	
	private boolean open;
	
	private boolean checked;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isOpen() {
		return open;
	}

	public void setOpen(boolean open) {
		this.open = open;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	@Override
	public String toString() {
		return "ZtreeNodesVO [id=" + id + ", pId=" + pId + ", name=" + name + ", open=" + open + ", checked=" + checked
				+ "]";
	}

	

	


	
}
