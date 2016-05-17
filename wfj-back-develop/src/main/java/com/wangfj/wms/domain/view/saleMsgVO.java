package com.wangfj.wms.domain.view;

import com.framework.page.Page;

public class saleMsgVO extends Page {

    private Integer sid;//信息编号

    private String type;//消息类型

    private String title;//消息标题

    private String content;//消息内容

    private String daogouName;//导购姓名

    private Integer supportCount;//点赞数量

    private String createTime;//发布时间

    private String shopSid;//门店sid

    private String pic;//图片地址
    
    private String startTime;
    
    private String endTime;
    
	/**
	 * @Return the String startTime
	 */
	public String getStartTime() {
		return startTime;
	}

	/**
	 * @Param String startTime to set
	 */
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	/**
	 * @Return the String endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @Param String endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @Return the Integer sid
	 */
	public Integer getSid() {
		return sid;
	}

	/**
	 * @Param Integer sid to set
	 */
	public void setSid(Integer sid) {
		this.sid = sid;
	}

	/**
	 * @Return the String type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @Param String type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @Return the String title
	 */
	public String getTitle() {
		return title;
	}

	/**
	 * @Param String title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}

	/**
	 * @Return the String content
	 */
	public String getContent() {
		return content;
	}

	/**
	 * @Param String content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}

	/**
	 * @Return the String daogouName
	 */
	public String getDaogouName() {
		return daogouName;
	}

	/**
	 * @Param String daogouName to set
	 */
	public void setDaogouName(String daogouName) {
		this.daogouName = daogouName;
	}

	/**
	 * @Return the Integer supportCount
	 */
	public Integer getSupportCount() {
		return supportCount;
	}

	/**
	 * @Param Integer supportCount to set
	 */
	public void setSupportCount(Integer supportCount) {
		this.supportCount = supportCount;
	}


	/**
	 * @Return the String createTime
	 */
	public String getCreateTime() {
		return createTime;
	}

	/**
	 * @Param String createTime to set
	 */
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	/**
	 * @Return the String shopSid
	 */
	public String getShopSid() {
		return shopSid;
	}

	/**
	 * @Param String shopSid to set
	 */
	public void setShopSid(String shopSid) {
		this.shopSid = shopSid;
	}

	/**
	 * @Return the String pic
	 */
	public String getPic() {
		return pic;
	}

	/**
	 * @Param String pic to set
	 */
	public void setPic(String pic) {
		this.pic = pic;
	}
	
}
