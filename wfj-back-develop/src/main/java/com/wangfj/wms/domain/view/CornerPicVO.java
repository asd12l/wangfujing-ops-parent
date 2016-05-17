/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.util.PromotionsKey.java
 * @Create By chengsj
 * @Create In 2013-8-30 下午4:46:37
 * TODO
 */
package com.wangfj.wms.domain.view;


import com.framework.page.Page;



/**
 * @Class Name ErweimaPromotionsVO
 * @Author chengsj
 * @Create In 2014-4-16
 */
public class CornerPicVO extends Page{
	private Integer sid;
	private String cornerName;
	private String startTime;
	private String endTime;
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public String getCornerName() {
		return cornerName;
	}
	public void setCornerName(String cornerName) {
		this.cornerName = cornerName;
	}
	
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	@Override
	public String toString() {
		return "CornerPicVO [sid=" + sid + ", cornerName=" + cornerName
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", start=" + start + ", limit=" + limit + ", pageSize="
				+ pageSize + ", currentPage=" + currentPage + ", totalRecords="
				+ totalRecords + ", totalPages=" + totalPages
				+ ", startRecords=" + startRecords + ", endRecords="
				+ endRecords + ", getSid()=" + getSid() + ", getCornerName()="
				+ getCornerName() + ", getStartTime()=" + getStartTime()
				+ ", getEndTime()=" + getEndTime() + ", getPageSize()="
				+ getPageSize() + ", getCurrentPage()=" + getCurrentPage()
				+ ", getTotalRecords()=" + getTotalRecords()
				+ ", getTotalPages()=" + getTotalPages()
				+ ", getStartRecords()=" + getStartRecords()
				+ ", getEndRecords()=" + getEndRecords() + ", getStart()="
				+ getStart() + ", getLimit()=" + getLimit() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
	
}
