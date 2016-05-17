package com.wangfj.search.entity;

import java.io.Serializable;

/**
 * 热词Bean
 * @author liufl / 2014年4月26日
 */
public class HotKey implements Serializable{

	private Long sid; // 记录ID
	private String hotWord; // 热词
	private Integer sequence; // 顺序
	private boolean valid; // 生效
	private Long chnId; // 频道ID

	/**
	 * 取出记录ID
	 * @return
	 */
	public Long getSid() {
		return sid;
	}

	/**
	 * 设置记录ID
	 * @param sid
	 */
	public void setSid(Long sid) {
		this.sid = sid;
	}

	/**
	 * 取出热词
	 * @return
	 */
	public String getHotWord() {
		return hotWord;
	}

	/**
	 * 设置热词
	 * @param hotWord
	 */
	public void setHotWord(String hotWord) {
		this.hotWord = hotWord;
	}

	/**
	 * 取出顺序
	 * @return
	 */
	public Integer getSequence() {
		return sequence;
	}

	/**
	 * 设置顺序
	 * @param sequence
	 */
	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	/**
	 * 是否生效
	 * @return
	 */
	public boolean isValid() {
		return valid;
	}

	/**
	 * 设置生效
	 * @param valid
	 */
	public void setValid(boolean valid) {
		this.valid = valid;
	}

	/**
	 * 取出频道ID
	 * @return
	 */
	public Long getChnId() {
		return chnId;
	}

	/**
	 * 设置频道ID
	 * @param chnId
	 */
	public void setChnId(Long chnId) {
		this.chnId = chnId;
	}

}
