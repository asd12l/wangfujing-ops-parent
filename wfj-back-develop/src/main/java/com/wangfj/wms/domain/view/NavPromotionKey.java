/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.domain.viewNavPromotionKey.java
 * @Create By chengsj
 * @Create In 2013-7-24 下午2:30:14
 * TODO
 */
package com.wangfj.wms.domain.view;

/**
 * @Class Name NavPromotionKey
 * @Author chengsj
 * @Create In 2013-7-24
 */
public class NavPromotionKey {
	String sid;
	String navSid;
	String promotionSid;
	String seq;
	String flag;
	String promotionName;
	String promotionLink;
	String isShow;
	
	public String getIsShow() {
		return isShow;
	}
	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getPromotionName() {
		return promotionName;
	}
	public void setPromotionName(String promotionName) {
		this.promotionName = promotionName;
	}
	public String getPromotionLink() {
		return promotionLink;
	}
	public void setPromotionLink(String promotionLink) {
		this.promotionLink = promotionLink;
	}
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getNavSid() {
		return navSid;
	}
	public void setNavSid(String navSid) {
		this.navSid = navSid;
	}
	public String getPromotionSid() {
		return promotionSid;
	}
	public void setPromotionSid(String promotionSid) {
		this.promotionSid = promotionSid;
	}
	@Override
	public String toString() {
		return "NavPromotionKey [sid=" + sid + ", navSid=" + navSid
				+ ", promotionSid=" + promotionSid + ", seq=" + seq + ", flag="
				+ flag + ", promotionName=" + promotionName
				+ ", promotionLink=" + promotionLink + ", isShow=" + isShow
				+ "]";
	}
	
	

}
