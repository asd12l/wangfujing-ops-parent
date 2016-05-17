package com.wangfj.wms.persistence;

import java.util.List;
import java.util.Map;

/**
 * @Class Name SiteMapMapper
 * @Author dangxf
 * @Create In 2014-3-19
 */
public interface SiteMapMapper {
	
	/**
	 * 获取频道链接的总数量
	 * @Methods Name selectChannelCount
	 * @Create In 2014-3-19 By dangxf
	 * @return int
	 */
	int selectChannelCount();	
	/**
	 * 获取文章链接的总数量
	 * @Methods Name selectArticleCount
	 * @Create In 2014-3-19 By dangxf
	 * @return int
	 */
	int selectArticleCount();
	
	/**
	 *获取促销活动链接的数量
	 * @Methods Name selectPromotionCount
	 * @Create In 2014-5-12 By dangxf
	 * @param map
	 * @return int
	 */
	int selectPromotionCount(Map<String, Object> map);
	
	/**
	 * 获取品牌链接的数量
	 * @Methods Name selectBrandCount
	 * @Create In 2014-6-30 By dangxf
	 * @return int
	 */
	int selectBrandCount();
	
	/**
	 * 获取热词链接的数量
	 * @Methods Name selectHotWordCount
	 * @Create In 2014-6-30 By dangxf
	 * @return int
	 */
	int selectHotWordCount();
	
	/**
	 * 获取long_keyWord链接的数量
	 * @Methods Name selectLongKeyWordCount
	 * @Create In 2014-6-30 By dangxf
	 * @return int
	 */
	int selectLongKeyWordCount();
	
	/**
	 * 获取频道页面的数据
	 * @Methods Name selectChallelUrl
	 * @Create In 2014-3-19 By dangxf
	 * @param map 请求的参数集合，包含的数据有pageNo 页码，pageCount 每页记录数量
	 * @return List<String>
	 */
	List<String> selectChallelUrl(Map<String, Object> map);
	
	/**
	 * @Methods Name selectArticleUrl
	 * @Create In 2014-3-19 By dangxf
	 * @param map 请求的参数集合，包含的数据有pageNo 页码，pageCount 每页记录数量
	 * @return List<String>
	 */
	List<String> selectArticleUrl(Map<String, Object> map);
	
	/**
	 * @Methods Name selectPromotionUrl
	 * @Create In 2014-3-19 By dangxf
	 * @param map 请求的参数集合，包含的数据有pageNo 页码，pageCount 每页记录数量
	 * @return List<String>
	 */
	List<String> selectPromotionUrl(Map<String, Object> map);
	
	
	/**
	 * 获取品牌链接的数据
	 * @Methods Name selectBrandLinks
	 * @Create In 2014-6-30 By dangxf
	 * @param map 请求的参数集合，包含的数据有pageNo 页码，pageCount 每页记录数量
	 * @return List<String>
	 */
	List<String> selectBrandLinks(Map<String, Object> map);
	
	/**
	 * 获取热词链接的数量
	 * @Methods Name selectHotWordLinks
	 * @Create In 2014-6-30 By dangxf
	 * @param map 请求的参数集合，包含的数据有pageNo 页码，pageCount 每页记录数量
	 * @return List<String>
	 */
	List<String> selectHotWordLinks(Map<String, Object> map);
		
	/**
	 * 获取long_keyWord链接的数量
	 * @Methods Name selectLongKeyWordLinks
	 * @Create In 2014-6-30 By dangxf
	 * @param map	请求的参数集合，包含的数据有pageNo 页码，pageCount 每页记录数量
	 * @return List<String>
	 */
	List<String> selectLongKeyWordLinks(Map<String, Object> map);
	
}
