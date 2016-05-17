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
 * @Class Name PromotionsKey
 * @Author chengsj
 * @Create In 2013-8-30
 */
public class MobileFlashPromotionsVO extends Page{

	private Integer sid;
	private String title;
	private String startTime;
	private String endTime;
	private Integer promotionTypeSid;
	private Integer flag;
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public Integer getSid() {
		return sid;
	}
	public void setSid(Integer sid) {
		this.sid = sid;
	}
	public Integer getFlag() {
		return flag;
	}
	public void setFlag(Integer flag) {
		this.flag = flag;
	}
	
	
	public Integer getPromotionTypeSid() {
		return promotionTypeSid;
	}
	public void setPromotionTypeSid(Integer promotionTypeSid) {
		this.promotionTypeSid = promotionTypeSid;
	}
	@Override
	public String toString() {
		return "MobileFlashPromotionsVO [sid=" + sid + ", title=" + title
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", promotionTypeSid=" + promotionTypeSid + ", flag=" + flag
				+ ", start=" + start + ", limit=" + limit + ", pageSize="
				+ pageSize + ", currentPage=" + currentPage + ", totalRecords="
				+ totalRecords + ", totalPages=" + totalPages
				+ ", startRecords=" + startRecords + ", endRecords="
				+ endRecords + ", getTitle()=" + getTitle()
				+ ", getStartTime()=" + getStartTime() + ", getEndTime()="
				+ getEndTime() + ", getSid()=" + getSid() + ", getFlag()="
				+ getFlag() + ", getPromotionTypeSid()="
				+ getPromotionTypeSid() + ", getPageSize()=" + getPageSize()
				+ ", getCurrentPage()=" + getCurrentPage()
				+ ", getTotalRecords()=" + getTotalRecords()
				+ ", getTotalPages()=" + getTotalPages()
				+ ", getStartRecords()=" + getStartRecords()
				+ ", getEndRecords()=" + getEndRecords() + ", getStart()="
				+ getStart() + ", getLimit()=" + getLimit() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}


	
	
}
