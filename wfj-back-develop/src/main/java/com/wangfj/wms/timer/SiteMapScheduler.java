package com.wangfj.wms.timer;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.GZIPOutputStream;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.constants.SystemConfig;
import com.wangfj.wms.domain.view.SeoVO;
import com.wangfj.wms.service.ISiteMapService;

/**
 * 用于执行生成sitemap_index.xml 和sitemap.xml 文件的定时任务
 * 
 * @Class Name SiteMapScheduler
 * @Author liheng
 * @Create In 2014年3月12日
 */
@Component
public class SiteMapScheduler {
	/**
	 * 频道文件前缀
	 */
	private static final String CHANNEL_PREFIX = "c_";
	/**
	 * 产品文件前缀
	 */
	private static final String PRODUCT_PREFIX = "p_";
	/**
	 * 文章新闻类文件前缀
	 */
	private static final String ATTICLE_PREFIX = "a_";
	/**
	 * 促销类文件前缀
	 */
	private static final String PROMOTION_PREFIX = "sp_";
	/**
	 * 商标类文件的前缀
	 * */
	private static final String BRAND_PREFIX = "b_";
	/**
	 * 热词类文件的前缀
	 * */
	private static final String HOT_WORD_PREFIX = "hot_word_";
	/**
	 * (long_keyWord)类文件的前缀
	 * */
	private static final String LONG_KEYWORD_PREFIX = "long_keyWord_";

	/**
	 * sitemap文件的存储路径
	 */
	private static final String SITEMAP_PATH = "sitemap";
	/**
	 * 单个文件的最大记录值
	 */
	private static final int MAX_RECORD = 20000;
	/**
	 * 每次从数据库取出的数量
	 * */
	private int pageCount = 500;
	/**
	 * 生成压缩文件的后缀名称
	 * */
	public static final String SUFFIX = ".gz";
	/**
	 * 缓存字节数量
	 * **/
	public static final int BUFFER = 1024;
	@Autowired
	@Qualifier("siteMapService")
	private ISiteMapService siteMapService;
	protected final Logger log = LoggerFactory.getLogger(getClass());

	/**
	 * 生成sitemap的索引页面 顺序为： 1. 频道文件 2. 文章新闻类文件 3. 促销类文件 4. 产品文件
	 * 
	 * @Methods Name createIndex
	 * @Create In 2014年3月12日 By liheng void
	 */
//	@Scheduled(cron = "0 0 2 * * ?")
	public void createIndex() {
		log.info("用于执行生成sitemap_index.xml的任务开始");
		// 存放文件的目录
		String siteMapPath = SystemConfig.GEN_PATH;
		// 索引页面文件名称
		String siteIndex = "sitemap_index.xml";
		// 创建sitemap_index.xml文件
		try {
			// 格式化xml文件
			OutputFormat format = OutputFormat.createPrettyPrint();
			XMLWriter writer = new XMLWriter(new FileWriter(siteMapPath + "/"
					+ siteIndex), format);
			Map<String, Object> siteMap_pages = this.getSiteMap_page();
			if (siteMap_pages != null && !siteMap_pages.isEmpty()) {
				Document doc = this.createIndexDoc(siteMap_pages);
				writer.write(doc);
				writer.close();
				log.info("生成" + siteIndex + "文件成功");
			} else {
				log.info("siteMap_pages中是null或者没有数据");
			}

		} catch (Exception e) {
			log.error("生成" + siteIndex + "文件不成功 : " + e);
		}

	}

	/**
	 * 生成频道类链接的sitemap页面
	 * 
	 * @Methods Name createChannelSiteMap
	 * @Create In 2014年3月12日 By liheng void
	 */
//	@Scheduled(cron = "0 10 1 * * ?")
	public void createChannelSiteMap(){
		log.info("用于执行生成频道类链接的sitemap页面的任务开始");
		int channelCount = this.siteMapService.getChannelCount();
		int channelPage = this.getPageCount(channelCount);
		//每页的记录数
		if (channelPage > 0) {
			// 存放文件的目录，判断是不是存在，不存在建立
			String siteMapPath = SystemConfig.GEN_PATH + SITEMAP_PATH;
			File siteMapFile = new File(siteMapPath);
			if (!siteMapFile.exists()) {
				siteMapFile.mkdir();
			}
			for (int i = 0; i < channelPage; i++) {
				// sitemap.xml文件名称
				String siteMap = siteMapPath + "/" + CHANNEL_PREFIX
						+ "sitemap_" + i + ".xml";
				// 每次查询500
				// 每一页的最大限制是40000条，每次查询500条。理论上查询80次
				int count = (MAX_RECORD % pageCount == 0) ? (MAX_RECORD / pageCount)
						: (MAX_RECORD % pageCount) + 1;
				try {
					OutputFormat format = OutputFormat.createPrettyPrint();
					XMLWriter writer = new XMLWriter(new FileWriter(siteMap),
							format);
					Document doc = this.createSiteMap();
					// 每一个xml文件中需要的分页查询
					for (int j = 0; j < count; j++) {
						List<SeoVO> list = new ArrayList<SeoVO>();
						int pageNo = j + i * count;
						list = this.siteMapService.getChannelSeo(pageNo,
								pageCount);
						if (list != null && !list.isEmpty()) {
							doc = this.writeSiteMap(doc, list);

						} else {
							log.info("用于写入频道页面sitemap.xml的数据是null或者没有数据");
						}
						// 如果只有一页数据的话，取出的数据的数量少于pageCount,结束循环
						if (list.size() < pageCount) {
							break;
						}
					}
					writer.write(doc);
					writer.close();
					// 表示写完了一页数据，打包压缩
					this.compressFile(new File(siteMap), true);
					log.info("生成频道页面的sitemap.xml.gz文件的任务完成");
				} catch (Exception e) {
					log.error("生成" + siteMap + ".gz文件不成功" + e);
				}
			}
		} else {
			log.info("生成频道页面siteMap.xml文件有：" + channelPage + " 个");
		}
	}

	/**
	 * 生成文章及新闻的sitemap页面
	 * 
	 * @Methods Name createArticleSiteMap
	 * @Create In 2014年3月12日 By liheng void
	 */
//	@Scheduled(cron = "0 20 1 * * ?")
	public void createArticleSiteMap() {
		log.info("用于执行生成文章及新闻的sitemap页面的任务开始");
		int articleCount = this.siteMapService.getArticleCount();
		int articlePage = this.getPageCount(articleCount);
		// 每页的记录数
		if (articlePage > 0) {
			// 存放文件的目录，判断是不是存在，不存在建立
			String siteMapPath = SystemConfig.GEN_PATH + SITEMAP_PATH;
			File siteMapFile = new File(siteMapPath);
			if (!siteMapFile.exists()) {
				siteMapFile.mkdir();
			}
			for (int i = 0; i < articlePage; i++) {
				// sitemap.xml文件名称
				String siteMap = siteMapPath + "/" + ATTICLE_PREFIX
						+ "sitemap_" + i + ".xml";
				// 每次查询500
				// 每一页的最大限制是40000条，每次查询500条。理论上查询80次
				int count = (MAX_RECORD % pageCount == 0) ? (MAX_RECORD / pageCount)
						: (MAX_RECORD % pageCount) + 1;
				try {
					OutputFormat format = OutputFormat.createPrettyPrint();
					XMLWriter writer = new XMLWriter(new FileWriter(siteMap),
							format);
					Document doc = this.createSiteMap();
					// 每一个xml文件中需要的分页查询
					for (int j = 0; j < count; j++) {
						List<SeoVO> list = new ArrayList<SeoVO>();
						int pageNo = j + i * count;
						list = this.siteMapService.getArticleSeo(pageNo,
								pageCount);
						if (list != null && !list.isEmpty()) {
							doc = this.writeSiteMap(doc, list);
						} else {
							log.info("用于写入文章及新闻页面sitemap.xml的数据是null或者没有数据");
						}
						// 如果只有一页数据的话，取出的数据的数量少于pageCount,结束循环
						if (list.size() < pageCount) {
							break;
						}
					}
					writer.write(doc);
					writer.close();
					// 表示写完了一页数据，打包压缩
					this.compressFile(new File(siteMap), true);
					log.info("生成文章及新闻页面的sitemap.xml.gz文件的任务完成");
				} catch (Exception e) {
					log.error("生成" + siteMap + ".gz文件不成功" + e);
				}
			}
		} else {
			log.info("生成文章及新闻页面siteMap.xml.gz文件有：" + articlePage + " 个");
		}
	}

	/**
	 * 促销活动的sitemap页面
	 * 
	 * @Methods Name createPromotionSiteMap
	 * @Create In 2014年3月12日 By liheng void
	 */
//	@Scheduled(cron = "0 30 1 * * ?")
	public void createPromotionSiteMap() {

		log.info("用于执行生成促销活动的sitemap页面的任务开始");
		Date promotionTime = new Date();
		int promotionCount = this.siteMapService
				.getPromotionCount(promotionTime);
		int promotionPage = this.getPageCount(promotionCount);
		// 每页的记录数
		if (promotionPage > 0) {
			// 存放文件的目录，判断是不是存在，不存在建立
			String siteMapPath = SystemConfig.GEN_PATH + SITEMAP_PATH;
			File siteMapFile = new File(siteMapPath);
			if (!siteMapFile.exists()) {
				siteMapFile.mkdir();
			}
			for (int i = 0; i < promotionPage; i++) {
				// sitemap.xml文件名称
				String siteMap = siteMapPath + "/" + PROMOTION_PREFIX
						+ "sitemap_" + i + ".xml";
				// 每次查询500
				// 每一页的最大限制是40000条，每次查询500条。理论上查询80次
				int count = (MAX_RECORD % pageCount == 0) ? (MAX_RECORD / pageCount)
						: (MAX_RECORD % pageCount) + 1;
				try {
					OutputFormat format = OutputFormat.createPrettyPrint();
					XMLWriter writer = new XMLWriter(new FileWriter(siteMap),
							format);
					Document doc = this.createSiteMap();
					// 每一个xml文件中需要的分页查询
					for (int j = 0; j < count; j++) {
						List<SeoVO> list = new ArrayList<SeoVO>();
						int pageNo = j + i * count;
						list = this.siteMapService.getPromotionSeo(pageNo,
								pageCount, promotionTime);
						if (list != null && !list.isEmpty()) {
							// 写入数据
							doc = this.writeSiteMap(doc, list);
						} else {
							log.info("用于写入促销活动页面sitemap.xml的数据是null或者没有数据");
						}
						// 如果只有一页数据的话，取出的数据的数量少于pageCount,结束循环
						if (list.size() < pageCount) {
							break;
						}
					}
					writer.write(doc);
					writer.close();
					// 表示写完了一页数据，打包压缩
					this.compressFile(new File(siteMap), true);
					log.info("生成促销活动页面的sitemap.xml.gz文件的任务完成");
				} catch (Exception e) {
					log.error("生成" + siteMap + "文件不成功" + e);
				}
			}
		} else {
			log.info("生成促销活动页面siteMap.xml.gz文件有：" + promotionPage + " 个");
		}
	}

	/**
	 * 生成产品链接的sitemap页面
	 * 
	 * @Methods Name createProductSiteMap
	 * @Create In 2014年3月12日 By liheng void
	 */
//	@Scheduled(cron = "0 0 1 * * ?")
	public void createProductSiteMap() {
		log.info("用于执行生成产品链接的sitemap页面的任务开始");
		int productCount = this.siteMapService.getProductCount();
		int productPage = this.getPageCount(productCount);
		// 每页的记录数
		if (productPage > 0) {
			// 存放文件的目录，判断是不是存在，不存在建立
			String siteMapPath = SystemConfig.GEN_PATH + SITEMAP_PATH;
			File siteMapFile = new File(siteMapPath);
			if (!siteMapFile.exists()) {
				siteMapFile.mkdir();
			}
			for (int i = 0; i < productPage; i++) {
				// sitemap.xml文件名称
				String siteMap = siteMapPath + "/" + PRODUCT_PREFIX
						+ "sitemap_" + i + ".xml";
				// 每次查询500
				// 每一页的最大限制是40000条，每次查询500条。理论上查询80次
				int count = (MAX_RECORD % pageCount == 0) ? (MAX_RECORD / pageCount)
						: (MAX_RECORD % pageCount) + 1;
				try {
					OutputFormat format = OutputFormat.createPrettyPrint();
					XMLWriter writer = new XMLWriter(new FileWriter(siteMap),
							format);
					Document doc = this.createSiteMap();
					// 每一个xml文件中需要的分页查询
					for (int j = 0; j < count; j++) {
						List<SeoVO> list = new ArrayList<SeoVO>();
						int pageNo = j + i * count + 1;
						list = this.siteMapService.getProductSeo(pageNo,
								pageCount);
						if (list != null && !list.isEmpty()) {
							doc = this.writeSiteMap(doc, list);
						} else {
							log.info("用于写入产品页面sitemap.xml的数据是null或者没有数据");
						}
						// 如果只有一页数据的话，取出的数据的数量少于pageCount,结束循环
						if (list.size() < pageCount) {
							break;
						}
					}
					writer.write(doc);
					writer.close();
					this.compressFile(new File(siteMap), true);
					log.info("生成产品页面的sitemap.xml.gz文件的任务完成");
				} catch (Exception e) {
					log.error("生成" + siteMap + ".gz文件不成功" + e);
				}
			}
		} else {
			log.info("生成频道页面siteMap.xml.gz文件有：" + productPage + " 个");
		}
	}

	/**
	 * 生成brand链接的sitemap页面
	 * 
	 * @Methods Name createBrandSiteMap
	 * @Create In 2014-6-30 By dangxf void
	 * 每周6零点开始
	 */
//	@Scheduled(cron = "0 0 0 ? * SAT")
	public void createBrandSiteMap() {
		try {
			log.info("用于执行生成brand链接的sitemap页面的任务开始，调用method = createBrandSiteMap()");
			int brandCount = this.siteMapService.getBrandCount();
			int brandtPage = this.getPageCount(brandCount);
			log.info("满足条件的brand链接的数量 brandCount = " + brandCount
					+ "生成的b_siteMap文件有：" + brandtPage);
			if (brandtPage > 0) {
				// 判断存放siteMap文件的目录，判断是不是存在，不存在建立
				String siteMapPath = SystemConfig.GEN_PATH + SITEMAP_PATH;
				File siteMapFile = new File(siteMapPath);
				if (!siteMapFile.exists()) {
					siteMapFile.mkdir();
				}
				for (int i = 0; i < brandtPage; i++) {
					// sitemap.xml文件名称
					String siteMap = siteMapPath + "/" + BRAND_PREFIX
							+ "sitemap_" + i + ".xml";
					// 每一页的最大限制是MAX_RECORD = 40000条，每次查询pageCount =
					// 500条。理论上查询80次
					int count = (MAX_RECORD % pageCount == 0) ? (MAX_RECORD / pageCount)
							: (MAX_RECORD % pageCount) + 1;
					OutputFormat format = OutputFormat.createPrettyPrint();
					XMLWriter writer = new XMLWriter(new FileWriter(siteMap),
							format);
					Document doc = this.createSiteMap();
					// 每一个xml文件中需要的分页查询
					for (int j = 0; j < count; j++) {
						List<SeoVO> list = new ArrayList<SeoVO>();
						int pageNo = j + i * count;// 表示第几次查询数据库（这个次数要与生成的siteMap文件个数对应）
						list = this.siteMapService.getBrandSeo(pageNo,
								pageCount);
						if (list != null && !list.isEmpty()) {
							doc = this.writeSiteMap(doc, list);
						} else {
							log.info("用于写入brand链接的sitemap.xml的数据是null或者没有数据");
						}
						// 如果只有一页数据的话，取出的数据的数量少于pageCount,结束循环
						if (list.size() < pageCount) {
							break;
						}
					}
					writer.write(doc);
					writer.close();
					this.compressFile(new File(siteMap), true);
					log.info("生成了" + siteMap);
				}
			} else {
				log.info("生成 brand 链接的siteMap.xml.gz文件有：" + brandtPage + " 个");
			}
		} catch (Exception e) {
			log.error("调用createBrandSiteMap()方法，生成siteMap文件不成功:" + e);
		}
	}

	/**
	 * 生成hotWord链接的siteMap文件
	 * 
	 * @Methods Name createHotWordSiteMap
	 * @Create In 2014-6-30 By dangxf void
	 * 每周六 00 ：20开始运行
	 */
//	@Scheduled(cron = "0 20 0 ? * SAT")
	public void createHotWordSiteMap() {
		try {
			log.info("用于执行生成hotWord链接的sitemap页面的任务开始，调用method = createHotWordSiteMap()");
			int hotWordCount = this.siteMapService.getHotWordCount();
			int hotWordPage = this.getPageCount(hotWordCount);
			log.info("满足条件的hotWord链接的数量 hotWordCount = " + hotWordCount
					+ "生成的hot_word_siteMap文件有：" + hotWordPage);
			if (hotWordPage > 0) {
				// 判断存放siteMap文件的目录，判断是不是存在，若不存在建立
				String siteMapPath = SystemConfig.GEN_PATH + SITEMAP_PATH;
				File siteMapFile = new File(siteMapPath);
				if (!siteMapFile.exists()) {
					siteMapFile.mkdir();
				}
				for (int i = 0; i < hotWordPage; i++) {
					// sitemap.xml文件名称
					String siteMap = siteMapPath + "/" + HOT_WORD_PREFIX
							+ "sitemap_" + i + ".xml";
					// 每一页的最大限制是MAX_RECORD = 40000条，每次查询pageCount =
					// 500条。理论上查询80次
					int count = (MAX_RECORD % pageCount == 0) ? (MAX_RECORD / pageCount)
							: (MAX_RECORD % pageCount) + 1;
					OutputFormat format = OutputFormat.createPrettyPrint();
					XMLWriter writer = new XMLWriter(new FileWriter(siteMap),
							format);
					Document doc = this.createSiteMap();
					// 每一个xml文件中需要的分页查询
					for (int j = 0; j < count; j++) {
						List<SeoVO> list = new ArrayList<SeoVO>();
						int pageNo = j + i * count;// 表示第几次查询数据库（这个次数要与生成的siteMap文件个数对应）
						list = this.siteMapService.getHotWordSeo(pageNo,
								pageCount);
						if (list != null && !list.isEmpty()) {
							doc = this.writeSiteMap(doc, list);
						} else {
							log.info("用于写入hotWord链接的sitemap.xml的数据是null或者没有数据");
						}
						// 如果只有一页数据的话，取出的数据的数量少于pageCount,结束循环
						if (list.size() < pageCount) {
							break;
						}
					}
					writer.write(doc);
					writer.close();
					this.compressFile(new File(siteMap), true);
					log.info("生成了" + siteMap);
				}
			} else {
				log.info("生成 hotWord链接的siteMap.xml.gz文件有：" + hotWordPage + " 个");
			}
		} catch (Exception e) {
			log.error("调用createHotWordSiteMap()方法，生成siteMap文件不成功:" + e);
		}
	}

	/**
	 * 生成longkeyWord链接的siteMap文件
	 * 
	 * @Methods Name createLongKeyWordSiteMap
	 * @Create In 2014-6-30 By dangxf void
	 * 每周六00 : 40开始运行
	 */
//	@Scheduled(cron = "0 40 0 * * ?")
	public void createLongKeyWordSiteMap() {
		try {
			log.info("用于执行生成longkeyWord链接的sitemap页面的任务开始，调用method = createLongKeyWordSiteMap()");
			int longKeyWordCount = this.siteMapService.getLongKeyWordCount();
			int longKeyWordPage = this.getPageCount(longKeyWordCount);
			log.info("满足条件的longkeyWord链接的数量 longKeyWordCount = "
					+ longKeyWordCount + "生成的long_keyWord_siteMap文件有："
					+ longKeyWordPage);
			if (longKeyWordPage > 0) {
				// 判断存放siteMap文件的目录，判断是不是存在，若不存在建立
				String siteMapPath = SystemConfig.GEN_PATH + SITEMAP_PATH;
				File siteMapFile = new File(siteMapPath);
				if (!siteMapFile.exists()) {
					siteMapFile.mkdir();
				}
				for (int i = 0; i < longKeyWordPage; i++) {
					// sitemap.xml文件名称
					String siteMap = siteMapPath + "/" + LONG_KEYWORD_PREFIX
							+ "sitemap_" + i + ".xml";
					// 每一页的最大限制是MAX_RECORD = 40000条，每次查询pageCount =
					// 500条。理论上查询80次
					int count = (MAX_RECORD % pageCount == 0) ? (MAX_RECORD / pageCount)
							: (MAX_RECORD % pageCount) + 1;
					OutputFormat format = OutputFormat.createPrettyPrint();
					XMLWriter writer = new XMLWriter(new FileWriter(siteMap),
							format);
					Document doc = this.createSiteMap();
					// 每一个xml文件中需要的分页查询
					for (int j = 0; j < count; j++) {
						List<SeoVO> list = new ArrayList<SeoVO>();
						int pageNo = j + i * count;// 表示第几次查询数据库（这个次数要与生成的siteMap文件个数对应）
						list = this.siteMapService.getLongKeyWordSeo(pageNo,
								pageCount);
						if (list != null && !list.isEmpty()) {
							doc = this.writeSiteMap(doc, list);
						} else {
							log.info("用于写入longkeyWord链接的sitemap.xml的数据是null或者没有数据");
						}
						// 如果只有一页数据的话，取出的数据的数量少于pageCount,结束循环
						if (list.size() < pageCount) {
							break;
						}
					}
					writer.write(doc);
					writer.close();
					this.compressFile(new File(siteMap), true);
					log.info("生成了" + siteMap);
				}
			} else {
				log.info("生成 longkeyWord链接的siteMap.xml.gz文件有："
						+ longKeyWordPage + " 个");
			}
		} catch (Exception e) {
			log.error("调用createLongKeyWordSiteMap()方法，生成siteMap文件不成功:" + e);
		}
	}

	/**
	 * @Methods Name createIndexDoc
	 * @Create In 2014-3-16 By dangxf
	 * @param siteMap_pages
	 * @return Document 根据获取各个品类的页数，添加节点
	 */
	private Document createIndexDoc(Map<String, Object> siteMap_pages) {
		String webAdress = "http://www.shopin.net/" + SITEMAP_PATH + "/";
		Document doc = DocumentHelper.createDocument();
		// 添加根节点
		Element sitemapindex = doc.addElement("sitemapindex",
				"http://www.sitemaps.org/schemas/sitemap/0.9");
		// 分类添加节点
		if (siteMap_pages.containsKey("c_page")) {
			int c_page = (Integer) siteMap_pages.get("c_page");
			for (int i = 0; i < c_page; i++) {
				Element sitemap = sitemapindex.addElement("sitemap");
				Element loc = sitemap.addElement("loc");
				loc.addText(webAdress + CHANNEL_PREFIX + "sitemap_" + i
						+ ".xml.gz");
			}
		}
		if (siteMap_pages.containsKey("a_page")) {
			int a_page = (Integer) siteMap_pages.get("a_page");
			for (int i = 0; i < a_page; i++) {
				Element sitemap = sitemapindex.addElement("sitemap");
				Element loc = sitemap.addElement("loc");
				loc.addText(webAdress + ATTICLE_PREFIX + "sitemap_" + i
						+ ".xml.gz");
			}
		}
		if (siteMap_pages.containsKey("sp_page")) {
			int sp_page = (Integer) siteMap_pages.get("sp_page");
			for (int i = 0; i < sp_page; i++) {
				Element sitemap = sitemapindex.addElement("sitemap");
				Element loc = sitemap.addElement("loc");
				loc.addText(webAdress + PROMOTION_PREFIX + "sitemap_" + i
						+ ".xml.gz");
			}
		}
		if (siteMap_pages.containsKey("p_page")) {
			int p_page = (Integer) siteMap_pages.get("p_page");
			for (int i = 0; i < p_page; i++) {
				Element sitemap = sitemapindex.addElement("sitemap");
				Element loc = sitemap.addElement("loc");
				loc.addText(webAdress + PRODUCT_PREFIX + "sitemap_" + i
						+ ".xml.gz");
			}
		}
		if (siteMap_pages.containsKey("b_page")) {
			int b_page = (Integer) siteMap_pages.get("b_page");
			for (int i = 0; i < b_page; i++) {
				Element sitemap = sitemapindex.addElement("sitemap");
				Element loc = sitemap.addElement("loc");
				loc.addText(webAdress + BRAND_PREFIX + "sitemap_" + i
						+ ".xml.gz");
			}
		}
		if (siteMap_pages.containsKey("hot_word_page")) {
			int hot_word_page = (Integer) siteMap_pages.get("hot_word_page");
			for (int i = 0; i < hot_word_page; i++) {
				Element sitemap = sitemapindex.addElement("sitemap");
				Element loc = sitemap.addElement("loc");
				loc.addText(webAdress + HOT_WORD_PREFIX + "sitemap_" + i
						+ ".xml.gz");
			}
		}
		if (siteMap_pages.containsKey("long_keyWord_page")) {
			int long_keyWord_page = (Integer) siteMap_pages
					.get("long_keyWord_page");
			for (int i = 0; i < long_keyWord_page; i++) {
				Element sitemap = sitemapindex.addElement("sitemap");
				Element loc = sitemap.addElement("loc");
				loc.addText(webAdress + LONG_KEYWORD_PREFIX + "sitemap_" + i
						+ ".xml.gz");
			}
		}

		return doc;
	}

	/**
	 * @Methods Name getSiteMap_page
	 * @Create In 2014-3-16 By dangxf
	 * @return Map<String,Object> 获取频道sitemap.xml的数量，文章新闻类sitemap.xml的数量，
	 *         活动sitemap.xml的数量，产品sitemap.xml的数量
	 */
	public Map<String, Object> getSiteMap_page() {
		Map<String, Object> map = new HashMap<String, Object>();
		// 获取记录数
		int channelCount = this.siteMapService.getChannelCount();
		int articleCount = this.siteMapService.getArticleCount();
		int promotionCount = this.siteMapService.getPromotionCount(new Date());
		int productCount = this.siteMapService.getProductCount();
		
		int brandCount = this.siteMapService.getBrandCount();
		int hotWordCount = this.siteMapService.getHotWordCount();
		int longKeyWordCount = this.siteMapService.getLongKeyWordCount();
		
		// 根据count值计算产生的文件数
		int channelPageCount = this.getPageCount(channelCount);
		int articlePageCount = this.getPageCount(articleCount);
		int promotionPageCount = this.getPageCount(promotionCount);
		int productPageCount = this.getPageCount(productCount);
		
		int brandPageCount = this.getPageCount(brandCount);
		int hotWordPageCount = this.getPageCount(hotWordCount);
		int longKeyWordPageCount = this.getPageCount(longKeyWordCount);

		// 判断pagecount是不是0
		if (channelPageCount > 0) {
			map.put("c_page", channelPageCount);
		}
		if (articlePageCount > 0) {
			map.put("a_page", articlePageCount);
		}
		if (promotionPageCount > 0) {
			map.put("sp_page", promotionPageCount);
		}
		if (productPageCount > 0) {
			map.put("p_page", productPageCount);
		}

		if (brandPageCount > 0) {
			map.put("b_page", brandPageCount);
		}
		if (hotWordPageCount > 0) {
			map.put("hot_word_page", hotWordPageCount);
		}
		if (longKeyWordPageCount > 0) {
			map.put("long_keyWord_page", longKeyWordPageCount);
		}

		return map;

	}

	/**
	 * @Methods Name getPageCount
	 * @Create In 2014-3-16 By dangxf
	 * @param Count
	 * @return int 根据数量获取生成的sitemap.xml文件的数量
	 */
	private int getPageCount(int count) {
		int pageCount = 0;
		if (count > 0) {
			pageCount = (count % MAX_RECORD == 0) ? (count / MAX_RECORD)
					: (count / MAX_RECORD) + 1;
		}
		return pageCount;
	}

	/**
	 * @Methods Name createSiteMap
	 * @Create In 2014-5-12 By dangxf
	 * @return Document
	 */
	private Document createSiteMap() {
		Document doc = DocumentHelper.createDocument();
		doc.addElement("urlset", "http://www.sitemaps.org/schemas/sitemap/0.9");
		return doc;
	}

	/**
	 * 添加sitemmap文件中的链接
	 * 
	 * @Methods Name writeSiteMap
	 * @Create In 2014-5-12 By dangxf
	 * @param doc
	 * @param list
	 * @return Document
	 */
	private Document writeSiteMap(Document doc,List<SeoVO> list) {
		Element urlset = doc.getRootElement();
		// 添加sitemap文件链接
		for (int i = 0; i < list.size(); i++) {
			Element url = urlset.addElement("url");
			Element loc = url.addElement("loc");
			loc.addText(list.get(i).getLoc());
			Element lastmod = url.addElement("lastmod");
			lastmod.addText(list.get(i).getLastmod());
			Element changefreq = url.addElement("changefreq");
			changefreq.addText(list.get(i).getChangefreq());
			Element priority = url.addElement("priority");
			priority.addText(list.get(i).getPriority());
		}
		return doc;
	}

	/**
	 * @Methods Name compressFile
	 * @Create In 2014-3-21 By dangxf
	 * @param file
	 * @param delete
	 *            布尔值。表示是否删除
	 * @throws Exception
	 *             将生成xml文件压缩成.gz文件，并且删除xml文件
	 */
	private void compressFile(File file, boolean delete) throws Exception {
		FileInputStream fis = new FileInputStream(file);
		FileOutputStream fos = new FileOutputStream(file.getPath() + SUFFIX);
		this.compress(fis, fos);
		fis.close();
		fos.flush();
		fos.close();
		if (delete) {
			file.delete();
		}
	}

	/**
	 * @Methods Name compress
	 * @Create In 2014-3-21 By dangxf
	 * @param is
	 *            输出流
	 * @param os
	 *            输入流
	 * @throws Exception
	 */
	private void compress(InputStream is, OutputStream os) throws Exception {
		GZIPOutputStream gos = new GZIPOutputStream(os);
		int count;
		byte data[] = new byte[BUFFER];
		while ((count = is.read(data, 0, BUFFER)) != -1) {
			gos.write(data, 0, count);
		}
		gos.finish();
		gos.flush();
		gos.close();
	}


}
