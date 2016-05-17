package com.wangfj.wms.domain.entity;

import java.util.List;

public class ProSizeColourEntity {

	private String colourId;
	private String colourValue;
	private List list;
	private	String sizeId;
	private String sizeValue;
	
	public List getList() {
		return list;
	}
	public void setList(List list) {
		this.list = list;
	}
	public String getColourId() {
		return colourId;
	}
	public void setColourId(String colourId) {
		this.colourId = colourId;
	}
	public String getColourValue() {
		return colourValue;
	}
	public void setColourValue(String colourValue) {
		this.colourValue = colourValue;
	}
	public String getSizeId() {
		return sizeId;
	}
	public void setSizeId(String sizeId) {
		this.sizeId = sizeId;
	}
	public String getSizeValue() {
		return sizeValue;
	}
	public void setSizeValue(String sizeValue) {
		this.sizeValue = sizeValue;
	}
	
	
}
