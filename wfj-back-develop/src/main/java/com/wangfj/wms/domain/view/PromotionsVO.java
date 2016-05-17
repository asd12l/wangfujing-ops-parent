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
public class PromotionsVO extends Page{

	private Integer proSid;
	private String title;
	private String startTime;
	private String endTime;

	private Integer proStatus;
	private Integer promotionTypeSid;
	private Integer pageLayoutSid;
	
	private Integer delFlag;
	private String  creater;
	private String promotionInfo;//活动详情
	
	
	/**
	 * @Return the String promotionInfo
	 */
	public String getPromotionInfo() {
		return promotionInfo;
	}
	/**
	 * @Param String promotionInfo to set
	 */
	public void setPromotionInfo(String promotionInfo) {
		this.promotionInfo = promotionInfo;
	}
	/**
	 * @Return the String creater
	 */
	public String getCreater() {
		return creater;
	}
	/**
	 * @Param String creater to set
	 */
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public Integer getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(Integer delFlag) {
		this.delFlag = delFlag;
	}
	public Integer getProSid() {
		return proSid;
	}
	public void setProSid(Integer proSid) {
		this.proSid = proSid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getProStatus() {
		return proStatus;
	}
	public void setProStatus(Integer proStatus) {
		this.proStatus = proStatus;
	}
	public Integer getPageLayoutSid() {
		return pageLayoutSid;
	}
	public void setPageLayoutSid(Integer pageLayoutSid) {
		this.pageLayoutSid = pageLayoutSid;
	}
	public Integer getPromotionTypeSid() {
		return promotionTypeSid;
	}
	public void setPromotionTypeSid(Integer promotionTypeSid) {
		this.promotionTypeSid = promotionTypeSid;
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
		return "PromotionsVO [proSid=" + proSid + ", title=" + title
				+ ", startTime=" + startTime + ", endTime=" + endTime
				+ ", proStatus=" + proStatus + ", promotionTypeSid="
				+ promotionTypeSid + ", pageLayoutSid=" + pageLayoutSid
				+ ", delFlag=" + delFlag + ", start=" + start + ", limit="
				+ limit + ", pageSize=" + pageSize + ", currentPage="
				+ currentPage + ", totalRecords=" + totalRecords
				+ ", totalPages=" + totalPages + ", startRecords="
				+ startRecords + ", endRecords=" + endRecords
				+ ", getDelFlag()=" + getDelFlag() + ", getProSid()="
				+ getProSid() + ", getTitle()=" + getTitle()
				+ ", getProStatus()=" + getProStatus()
				+ ", getPageLayoutSid()=" + getPageLayoutSid()
				+ ", getPromotionTypeSid()=" + getPromotionTypeSid()
				+ ", getStartTime()=" + getStartTime() + ", getEndTime()="
				+ getEndTime() + ", getPageSize()=" + getPageSize()
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
