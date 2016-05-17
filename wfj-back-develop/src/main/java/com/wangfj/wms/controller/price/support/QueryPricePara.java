package com.wangfj.wms.controller.price.support;

public class QueryPricePara {
	
	private String shoppeProSid;

	/**
	 * 价格渠道(默认为0)
	 */
	private String channelSid;

	public String getShoppeProSid() {
		return shoppeProSid;
	}

	public void setShoppeProSid(String shoppeProSid) {
		this.shoppeProSid = shoppeProSid;
	}

	public String getChannelSid() {
		return channelSid;
	}

	public void setChannelSid(String channelSid) {
		this.channelSid = channelSid;
	}
	
	
}
