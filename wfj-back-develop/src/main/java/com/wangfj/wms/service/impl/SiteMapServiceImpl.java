package com.wangfj.wms.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.constants.SystemConfig;
import com.utils.httpclient.HttpClientUtil;
import com.wangfj.wms.domain.view.SeoVO;
import com.wangfj.wms.domain.view.SeoVO.ChangefreqValues;
import com.wangfj.wms.persistence.SiteMapMapper;
import com.wangfj.wms.service.ISiteMapService;

/**
 * @Class Name SiteMapServiceImpl
 * @Author dangxf
 * @Create In 2014-3-14
 */
@Component("siteMapService")
public class SiteMapServiceImpl implements ISiteMapService {
	@Autowired
	private SiteMapMapper siteMapMaper;
	@Override
	public int getChannelCount() {
		int channelCount = this.siteMapMaper.selectChannelCount();
		return channelCount;
	}

	@Override
	public int getArticleCount() {
		int articleCount = this.siteMapMaper.selectArticleCount();
		return articleCount;
	}
	@Override
	public int getProductCount() {
		//请求地址
		String webUrl = SystemConfig.PRODUCT_COUNT_URL;
		String response = HttpClientUtil.GetUrlContent(webUrl, "UTF-8");
		//判断是不是空值
		if(StringUtils.isNotEmpty(response)){
			JSONObject json = JSONObject.fromObject(response);
			String success = json.getString("success");
			if(StringUtils.isNotEmpty(success) && "true".equals(success)){
				String result = json.getString("result");
				String count = JSONObject.fromObject(result).getString("seoCount");
				return Integer.valueOf(count);
			}
		}
		return 0;
	}

	@Override
	public int getPromotionCount(Date promotionTime) {
		//参数集合
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("promotionTime", promotionTime);
		int promotionCount = this.siteMapMaper.selectPromotionCount(map);
		return promotionCount;
	}	
	@Override
	public int getBrandCount() {
		int brandCount = this.siteMapMaper.selectBrandCount();
		return brandCount;
	}

	@Override
	public int getHotWordCount() {
		int hotWordCount = this.siteMapMaper.selectHotWordCount();
		return hotWordCount;
	}

	@Override
	public int getLongKeyWordCount() {
		int longKeyWordCount = this.siteMapMaper.selectLongKeyWordCount();
		return longKeyWordCount;
	}
	
	@Override
	public List<SeoVO> getChannelSeo(int pageNo, int pageCount) {
		List<SeoVO> list = new ArrayList<SeoVO>();
		//请求分页的每一页的开始的数据
		int startRecord = pageNo * pageCount;
		//参数集合
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("startRecord", startRecord);
		map.put("pageCount", pageCount);
		List<String> channelUrls = this.siteMapMaper.selectChallelUrl(map);
		//seo对象中的最后更新时间
		String lastmod = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		//网站地址
		String webAddress = SystemConfig.WEBADDRESS;
		for(int i=0; i<channelUrls.size(); i++){
			SeoVO vo = new SeoVO();
			vo.setLoc(webAddress +"/" + channelUrls.get(i));
			vo.setLastmod(lastmod);
			vo.setChangefreq(ChangefreqValues.daily.toString());
			vo.setPriority("" + 0.6);
			list.add(vo);
		}
		return list;
	}

	@Override
	public List<SeoVO> getArticleSeo(int pageNo, int pageCount) {
		List<SeoVO> list = new ArrayList<SeoVO>();
		int startRecord = pageNo * pageCount;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("startRecord", startRecord);
		map.put("pageCount", pageCount);
		List<String> articleUrls = this.siteMapMaper.selectArticleUrl(map);
		String lastmod = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		String webAddress = SystemConfig.WEBADDRESS;
		for(int i=0; i<articleUrls.size(); i++){
			SeoVO vo = new SeoVO();
			String loc = StringUtils.upperCase(articleUrls.get(i));
			if(loc.startsWith("HTTP")){
				vo.setLoc(articleUrls.get(i));
			}else{
				vo.setLoc(webAddress+ articleUrls.get(i));
			}	
			vo.setLastmod(lastmod);
			vo.setChangefreq(ChangefreqValues.daily.toString());
			vo.setPriority("" + 0.6);
			list.add(vo);
		}
		return list;
	}
	@Override
	public List<SeoVO> getPromotionSeo(int pageNo, int pageCount,Date promotionTime) {
		List<SeoVO> list = new ArrayList<SeoVO>();
		//请求分页的每一页的开始的数据
		int startRecord = pageNo * pageCount;
		//参数集合
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("startRecord", startRecord);
		map.put("pageCount", pageCount);
		map.put("promotionTime",promotionTime);
		List<String> promotionUrls = this.siteMapMaper.selectPromotionUrl(map);
		//seo对象中的最后更新时间
		String lastmod = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		//网站地址
		String webAddress = SystemConfig.WEBADDRESS;
		for(int i=0; i<promotionUrls.size(); i++){
			SeoVO vo = new SeoVO();
			String loc = StringUtils.upperCase(promotionUrls.get(i));
			if(loc.startsWith("HTTP")){
				vo.setLoc(promotionUrls.get(i));
			}else{
				vo.setLoc(webAddress + promotionUrls.get(i));
			}		
			vo.setLastmod(lastmod);
			vo.setChangefreq(ChangefreqValues.daily.toString());
			vo.setPriority("" + 0.6);
			list.add(vo);
		}
		return list;
	}

	@Override
	public List<SeoVO> getProductSeo(int pageNo, int pageCount) {
		List<SeoVO> list = new ArrayList<SeoVO>();	
		//请求地址和参数
		String webUrl = SystemConfig.PRODUCT_SEO_URL + "?pageNo=" + pageNo + "&pageCount=" + pageCount;
		//请求返回的结果
		String response = HttpClientUtil.GetUrlContent(webUrl, "UTF-8");
		//最后更新时间
		String lastmod = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		//网站地址
		String webAddress = SystemConfig.WEBADDRESS;
		if(StringUtils.isNotEmpty(response)){
			JSONObject json = JSONObject.fromObject(response);
			String success = json.getString("success");
			if(StringUtils.isNotEmpty(success) && "true".equals(success)){
				String result = json.getString("result");
				JSONArray jsonArray = JSONArray.fromObject(result);
				for(int i=0;i<jsonArray.size();i++){
					String sid = JSONObject.fromObject(jsonArray.get(i)).getString("sid");
					SeoVO vo = new SeoVO();
					vo.setLoc(webAddress + "/product/"+ sid +".html");
					vo.setLastmod(lastmod);
					vo.setChangefreq(ChangefreqValues.daily.toString());
					vo.setPriority("" + 1);
					list.add(vo);
				}
				return list;
			}										
		}
		return null;
	}

	@Override
	public List<SeoVO> getBrandSeo(int pageNo, int pageCount) {
		List<SeoVO> list = new ArrayList<SeoVO>();
		//请求分页的每一页的开始的数据
		int startRecord = pageNo * pageCount;
		//参数集合
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("startRecord", startRecord);
		map.put("pageCount", pageCount);
		List<String> brandLinks = this.siteMapMaper.selectBrandLinks(map);
		//seo对象中的最后更新时间
		String lastmod = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		//网站地址
		String webAddress = SystemConfig.WEBADDRESS;
		for(int i=0; i<brandLinks.size(); i++){
			SeoVO vo = new SeoVO();
			vo.setLoc(webAddress+"/" + brandLinks.get(i));
			vo.setLastmod(lastmod);
			vo.setChangefreq(ChangefreqValues.daily.toString());
			vo.setPriority("" + 0.6);
			list.add(vo);
		}
		return list;
	}

	@Override
	public List<SeoVO> getHotWordSeo(int pageNo, int pageCount) {
		List<SeoVO> list = new ArrayList<SeoVO>();
		//请求分页的每一页的开始的数据
		int startRecord = pageNo * pageCount;
		//参数集合
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("startRecord", startRecord);
		map.put("pageCount", pageCount);
		List<String> hotWordLinks = this.siteMapMaper.selectHotWordLinks(map);
		//seo对象中的最后更新时间
		String lastmod = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		//网站地址
		String webAddress = SystemConfig.WEBADDRESS;
		for(int i=0; i<hotWordLinks.size(); i++){
			SeoVO vo = new SeoVO();
			vo.setLoc(webAddress+"/" + hotWordLinks.get(i));
			vo.setLastmod(lastmod);
			vo.setChangefreq(ChangefreqValues.daily.toString());
			vo.setPriority("" + 0.6);
			list.add(vo);
		}
		return list;
	}

	@Override
	public List<SeoVO> getLongKeyWordSeo(int pageNo, int pageCount) {
		List<SeoVO> list = new ArrayList<SeoVO>();
		//请求分页的每一页的开始的数据
		int startRecord = pageNo * pageCount;
		//参数集合
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("startRecord", startRecord);
		map.put("pageCount", pageCount);
		List<String> longKeyWordLinks = this.siteMapMaper.selectLongKeyWordLinks(map);
		//seo对象中的最后更新时间
		String lastmod = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		//网站地址
		String webAddress = SystemConfig.WEBADDRESS;
		for(int i=0; i<longKeyWordLinks.size(); i++){
			SeoVO vo = new SeoVO();
			vo.setLoc(webAddress +"/"+ longKeyWordLinks.get(i));
			vo.setLastmod(lastmod);
			vo.setChangefreq(ChangefreqValues.daily.toString());
			vo.setPriority("" + 0.6);
			list.add(vo);
		}
		return list;
	}
}
