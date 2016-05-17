package com.wangfj.wms.service;

import java.util.Date;
import java.util.List;

import com.wangfj.wms.domain.view.SeoVO;

/**
 * 用于seo优化获取sitemap数据的接口
 * @Class Name ISiteMapService
 * @Author liheng
 * @Create In 2014年3月12日
 */
public interface ISiteMapService {
	/**
	 * 获取频道页面的总数量
	 * @Methods Name getChannelCount
	 * @Create In 2014年3月12日 By liheng
	 * @return int
	 */
	int getChannelCount();
	/**
	 * 获取文章页面的总数量
	 * @Methods Name getArticleCount
	 * @Create In 2014年3月12日 By liheng
	 * @return int
	 */
	int getArticleCount();
	/**
	 * 获取产品页面的总数量
	 * @Methods Name getProductCount
	 * @Create In 2014年3月12日 By liheng
	 * @return int
	 */
	int getProductCount();
	/**
	 * 获取促销活动的数量
	 * @Methods Name getPromotionCount
	 * @Create In 2014-5-12 By dangxf
	 * @param promotionTime
	 * @return int
	 */
	int getPromotionCount(Date promotionTime);
	/**
	 * 获取品牌的数量
	 * @Methods Name getBrandCount
	 * @Create In 2014-6-30 By dangxf
	 * @return int
	 */
	 int getBrandCount();	
	/**
	 * 获取热词的数量
	 * @Methods Name getHotWordCount
	 * @Create In 2014-6-30 By dangxf
	 * @return int
	 */
	int getHotWordCount();	
	/**
	 * 获取长关键词的数量
	 * @Methods Name getLongKeyWordCount
	 * @Create In 2014-6-30 By dangxf
	 * @return int
	 */
	int getLongKeyWordCount();	
	/**
	 * 获取频道页面的数据
	 * @Methods Name getChannelSeo
	 * @Create In 2014年3月12日 By liheng
	 * @param pageNo 页码
	 * @param pageCount 每页记录数量
	 * @return List<SeoVO>
	 */
	List<SeoVO> getChannelSeo(int pageNo,int pageCount);
	/**
	 * 获取文章及新闻的数据
	 * @Methods Name getArticleSeo
	 * @Create In 2014年3月12日 By liheng
	 * @param pageNo 页码
	 * @param pageCount 每页记录数量
	 * @return List<SeoVO>
	 */
	List<SeoVO> getArticleSeo(int pageNo,int pageCount);
	/**
	 * 获取商品页面的数据
	 * @Methods Name getProductSeo
	 * @Create In 2014年3月12日 By liheng
	 * @param pageNo 页码
	 * @param pageCount 每页记录数量
	 * @return List<SeoVO>
	 */
	List<SeoVO> getProductSeo(int pageNo,int pageCount);
	/**
	 * 获取活动页面的数据
	 * @Methods Name getPromotionSeo
	 * @Create In 2014年3月12日 By liheng
	 * @param pageNo 页码
	 * @param pageCount 每页记录数量
	 * @return List<SeoVO>
	 */
	List<SeoVO> getPromotionSeo(int pageNo, int pageCount, Date promotionTime);	
	/**
	 * 获取品牌Seo的数据
	 * @Methods Name getBrandSeo
	 * @Create In 2014-6-30 By dangxf
	 * @param pageNo
	 * @param pageCount
	 * @return List<SeoVO>
	 */
	List<SeoVO> getBrandSeo(int pageNo,int pageCount);
	
	
	/**
	 * 获取热词相关的SEO数据
	 * @Methods Name getHotWordSeo
	 * @Create In 2014-6-30 By dangxf
	 * @param pageNo
	 * @param pageCount
	 * @return List<SeoVO>
	 */
	List<SeoVO> getHotWordSeo(int pageNo,int pageCount);
	
	
	/**
	 * 获取long_keyword相关的Seo数据
	 * @Methods Name getLongKeyWordSeo
	 * @Create In 2014-6-30 By dangxf
	 * @param pageNo
	 * @param pageCount
	 * @return List<SeoVO>
	 */
	List<SeoVO> getLongKeyWordSeo(int pageNo,int pageCount);
}
