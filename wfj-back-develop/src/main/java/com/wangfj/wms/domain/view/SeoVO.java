package com.wangfj.wms.domain.view;

/**
 * sitemap 数据封装对象
 * @Class Name SeoVO
 * @Author liheng
 * @Create In 2014年3月12日
 */
public class SeoVO {
	/**
	 * 页面地址
	 */
	private String loc;
	/**
	 * 最后更新时间 ,格式yyyy-MM-dd 等
	 */
	private String lastmod;
	/**
	 * 更新频率
	 */
	private String changefreq;
	
	/**
	 * 定义更新频率可以使用的值
	 * @Class Name ChangefreqValues
	 * @Author liheng
	 * @Create In 2014年3月12日
	 */
	public static enum ChangefreqValues{
		always, hourly, daily, weekly, monthly, yearly, never
	}
	/**
	 * 优先级，需要为数字值
	 */
	private String priority;
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	public String getLastmod() {
		return lastmod;
	}
	public void setLastmod(String lastmod) {
		this.lastmod = lastmod;
	}
	public String getChangefreq() {
		return changefreq;
	}
	public void setChangefreq(String changefreq) {
		this.changefreq = changefreq;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	

}








