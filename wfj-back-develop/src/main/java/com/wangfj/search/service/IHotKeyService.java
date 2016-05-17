package com.wangfj.search.service;

import java.util.List;

import com.wangfj.search.entity.HotKey;


/**
 * 热词Service接口
 * @author liufl / 2014年4月26日
 */
public interface IHotKeyService {

	/**
	 * 查询频道显示热词数
	 * @param chnId 频道ID
	 * @return
	 */
	Integer getHotKeyShowCount(Integer chnId);

	/**
	 * 更新频道热词显示数
	 * @param chnId 频道ID
	 * @param count 显示数
	 */
	void updateHotKeyShowCount(Integer chnId, Integer count);

	/**
	 * 新建频道热词显示数
	 * @param chnId 频道ID
	 * @param count 显示数
	 */
	void newHotKeyShowCount(Integer chnId, Integer count);

	/**
	 * 获取频道热词列表
	 * @param chnId 频道ID
	 * @return
	 */
	List<HotKey> getChnHotKeys(Integer chnId);

	/**
	 * 修改热词
	 * @param hotKey
	 */
	void updateHotKey(HotKey hotKey);

	/**
	 * 新增热词
	 * @param hotKey
	 */
	void insert(HotKey hotKey);

	/**
	 * 删除热词
	 * @param sid 记录ID
	 */
	void deleteHotKey(Long sid);

}
