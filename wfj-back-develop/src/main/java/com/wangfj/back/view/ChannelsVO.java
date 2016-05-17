/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.viewChannelsVO.java
 * @Create By chengsj
 * @Create In 2013-6-25 下午2:12:11
 * TODO
 */
package com.wangfj.back.view;

import java.io.Serializable;
import java.util.List;

/**
 * @Class Name ChannelsVO
 * @Author chengsj
 * @Create In 2013-6-25
 */
public class ChannelsVO implements Serializable{
	
	//private String sid;
	//private String ruleSid;
	private String channelSid;
	private String channelName;
	//private String seq;
	
	List<RulesVO> rules;
	
	public List<RulesVO> getRules() {
		return rules;
	}
	public void setRules(List<RulesVO> rules) {
		this.rules = rules;
	}

	public String getChannelSid() {
		return channelSid;
	}
	public void setChannelSid(String channelSid) {
		this.channelSid = channelSid;
	}
	public String getChannelName() {
		return channelName;
	}
	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	@Override
	public String toString() {
		return "[channelSid=" + channelSid + ", channelName=" + channelName
				+ ", rules=" + rules + "]";
	}

	
	
	

}
