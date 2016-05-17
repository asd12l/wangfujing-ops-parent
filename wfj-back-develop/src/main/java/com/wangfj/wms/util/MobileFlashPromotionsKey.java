/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.util.PromotionsKey.java
 * @Create By chengsj
 * @Create In 2013-8-30 下午4:46:37
 * TODO
 */
package com.wangfj.wms.util;


/**
 * @Class Name MobileFlashPromotionsKey
 * @Author chengsj
 * @Create In 2014-3-25
 */
public class MobileFlashPromotionsKey {
    private String sid;

    private String title;

    private String proDesc;

    private String link;

    private String startTime;

    private String endTime;

    private String pict;

    private String seq;

    private String createTime;

    private String creater;

    private String createShopName;

    private String createShopSid;
    
    private String promotionTypeSid;

    private String promotionType;

    private String flag;
    
   //根据时间定时查询活动
    private String startDay;
    
	private String endDay;
	

	public String getStartDay() {
		return startDay;
	}

	public void setStartDay(String startDay) {
		this.startDay = startDay;
	}

	public String getEndDay() {
		return endDay;
	}

	public void setEndDay(String endDay) {
		this.endDay = endDay;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getProDesc() {
		return proDesc;
	}

	public void setProDesc(String proDesc) {
		this.proDesc = proDesc;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
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

	public String getPict() {
		return pict;
	}

	public void setPict(String pict) {
		this.pict = pict;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getCreateShopName() {
		return createShopName;
	}

	public void setCreateShopName(String createShopName) {
		this.createShopName = createShopName;
	}

	public String getCreateShopSid() {
		return createShopSid;
	}

	public void setCreateShopSid(String createShopSid) {
		this.createShopSid = createShopSid;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getPromotionTypeSid() {
		return promotionTypeSid;
	}

	public void setPromotionTypeSid(String promotionTypeSid) {
		this.promotionTypeSid = promotionTypeSid;
	}

	public String getPromotionType() {
		return promotionType;
	}

	public void setPromotionType(String promotionType) {
		this.promotionType = promotionType;
	}

	@Override
	public String toString() {
		return "MobileFlashPromotionsKey [sid=" + sid + ", title=" + title
				+ ", proDesc=" + proDesc + ", link=" + link + ", startTime="
				+ startTime + ", endTime=" + endTime + ", pict=" + pict
				+ ", seq=" + seq + ", createTime=" + createTime + ", creater="
				+ creater + ", createShopName=" + createShopName
				+ ", createShopSid=" + createShopSid + ", promotionTypeSid="
				+ promotionTypeSid + ", promotionType=" + promotionType
				+ ", flag=" + flag + ", startDay=" + startDay + ", endDay="
				+ endDay + "]";
	}

    
    

}
