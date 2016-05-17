/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerPriceRuleController.java
 * @Create By chengsj
 * @Create In 2013-11-22 下午2:50:09
 * TODO
 */
package com.wangfj.wms.controller;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.wms.domain.entity.PriceProduct;
import com.wangfj.wms.domain.entity.PriceRule;
import com.wangfj.wms.domain.entity.ProBestDetailMql;
import com.wangfj.wms.service.IPriceProductService;
import com.wangfj.wms.service.IPriceRuleService;
import com.wangfj.wms.service.IProBestDetailMqlService;
import com.wangfj.wms.util.HttpUtil;
import com.wangfj.wms.util.PriceRuleKey;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name PriceRuleController
 * @Author chengsj
 * @Create In 2013-11-22
 */
@Controller
@RequestMapping("/priceRule")
public class PriceRuleController {

	@Autowired
			@Qualifier("priceRuleService")
	IPriceRuleService priceRuleService;

	@Autowired
			@Qualifier("proBestDetailMqlService")
	IProBestDetailMqlService proBestDetailService;

	@Autowired
			@Qualifier("priceProductService")
	IPriceProductService priceProductService;

	@ResponseBody
	@RequestMapping(value = { "/changePrice" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String changePrice(Model mode, PriceRuleKey key,
			HttpServletRequest request, HttpServletResponse response) {
		String resultJson = "";
		try {
			this.savePriceRule(key);
			this.savePriceProduct(key);
			this.saveProBestDetail(key);
			resultJson = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			return "{success:false,result:[]}";
		}
		return resultJson;
	}

	public void saveProBestDetail(PriceRuleKey key) {
		String proSids = key.getProductSids().substring(0,
				key.getProductSids().length() - 1);
		String[] sidArray = proSids.split(",");
		Integer ordernum = this.proBestDetailService.queryMaxOrderNum(Integer
				.valueOf(key.getPageLayoutSid()));
		ordernum = (ordernum == null) ? 0 : ordernum;
		for (int i = 0; i < sidArray.length; i++) {
			ProBestDetailMql proBestDetail = new ProBestDetailMql();
			proBestDetail.setProductListSid(Integer.valueOf(sidArray[i]));
			proBestDetail.setPageLayoutSid(Integer.valueOf(key
					.getPageLayoutSid()));
			proBestDetail.setOrderNumber(++ordernum);
			this.proBestDetailService.insertSelective(proBestDetail);
		}
	}

	public void savePriceRule(PriceRuleKey key) throws ParseException {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		PriceRule priceRule = new PriceRule();

		priceRule.setPageLayoutSid(Integer.valueOf(key.getPageLayoutSid()));
		priceRule.setTsid(Integer.valueOf(key.getTsid()));
		priceRule.setValue(Double.valueOf(key.getValue()));
		priceRule.setBeginTime(sf.parse(key.getStartTime()));
		priceRule.setEndTime(sf.parse(key.getEndTime()));
		priceRule.setSupplysids(key.getSupplySids());
		priceRule.setFlag(0);
		this.priceRuleService.insertSelective(priceRule);

	}

	public void savePriceProduct(PriceRuleKey key) {
		String proPrice = "";
		String proSids = "";
		String[] priceArray = null;
		String[] sidArray = null;
		if (key.getPromotionPrice() != null
				&& !"".equals(key.getPromotionPrice())) {

			proPrice = key.getPromotionPrice().substring(0,
					key.getPromotionPrice().length() - 1);
			priceArray = proPrice.split(",");
		}
		if (key.getProductSids() != null && !"".equals(key.getProductSids())) {
			proSids = key.getProductSids().substring(0,
					key.getProductSids().length() - 1);
			sidArray = proSids.split(",");
		}
		for (int i = 0; i < priceArray.length; i++) {
			PriceProduct priceProduct = new PriceProduct();
			if (key.getPageLayoutSid() != null
					&& !"".equals(key.getPageLayoutSid())) {
				priceProduct.setPageLayoutSid(Integer.valueOf(key
						.getPageLayoutSid()));
			}
			if (priceArray[i] != null && !"".equals(priceArray[i])) {
				priceProduct.setPromotionPrice(new BigDecimal(priceArray[i]));
			}
			if (sidArray[i] != null && !"".equals(sidArray[i])) {
				priceProduct.setProductListSid(Integer.valueOf(sidArray[i]));
			}
			if (key.getOptor() != null && !"".equals(key.getOptor())) {
				priceProduct.setOptor(key.getOptor());
			}
			priceProduct.setFlag(0);
			this.priceProductService.insertSelective(priceProduct);

		}

	}

	/**
	 * 说明： 闪购商品定时变价(每分钟抓取一次)
	 * 
	 * @Methods Name changePriceOnTime
	 * @Create In 2013-11-26 By chengsj
	 * @throws ParseException
	 *             void
	 */
//	@Scheduled(cron = "0 0/1 * * * ?")
	public void changePriceOnTime() throws ParseException {
		String json = "";
		StringBuffer prolistSid = new StringBuffer();
		StringBuffer PromotionPrice = new StringBuffer();
		StringBuffer supplySids = new StringBuffer();
		StringBuffer optor = new StringBuffer();

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:00");
		SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:59");
		PriceRuleKey key = new PriceRuleKey();
		key.setStartDay(df.format(new Date()));
		key.setEndDay(df2.format(new Date()));
		List<PriceRule> pageLayoutSids = this.priceRuleService
				.queryPageLayoutByTime(key);
		if (pageLayoutSids == null || pageLayoutSids.size() == 0) {
			//System.out.println("------没有可查询的变价活动");
			return;
		}
		Set set = new HashSet();
		for (int j = 0; j < pageLayoutSids.size(); j++) {
			supplySids.append(pageLayoutSids.get(j).getSupplysids() + ",");

			PriceRule priceRule = new PriceRule();
			priceRule
					.setPageLayoutSid(pageLayoutSids.get(j).getPageLayoutSid());
			priceRule.setSid(pageLayoutSids.get(j).getSid());
			priceRule.setFlag(1);
			this.priceRuleService.updateByPrimaryKeySelective(priceRule);
			if (!(set.add(pageLayoutSids.get(j).getPageLayoutSid()))) {
				continue;
			}
			List<PriceProduct> list = this.priceProductService
					.queryByPageLayoutSid(pageLayoutSids.get(j)
							.getPageLayoutSid());
			if (list == null || list.size() == 0) {
				continue;
			}
			System.out.println("-----此栏目下有" + list.size() + "款变价商品");
			for (int i = 0; i < list.size(); i++) {
				PromotionPrice.append(list.get(i).getPromotionPrice() + ",");
				prolistSid.append(list.get(i).getProductListSid() + ",");
				optor.append(list.get(i).getOptor() + ",");

				list.get(i).setFlag(1);
				this.priceProductService.updateByPrimaryKeySelective(list
						.get(i));
			}

		}
		String supplySid = supplySids.substring(0, supplySids.length() - 1);
		String proSid = prolistSid.substring(0, prolistSid.length() - 1);
		String price = PromotionPrice.substring(0, PromotionPrice.length() - 1);
		String optors = optor.substring(0, optor.length() - 1);

		Map parmMap = new HashMap();
		parmMap.put("productSids", proSid);
		parmMap.put("prices", price);
		parmMap.put("supplySids", supplySid);
		parmMap.put("user", optors);
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bw/setFlashPrice.html", parmMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	/**
	 * 说明： 闪购商品定时撤销变价（每分钟抓取一次）
	 * 
	 * @Methods Name changePriceBackOnTime
	 * @Create In 2013-11-26 By chengsj
	 * @throws ParseException
	 *             void
	 */
//	@Scheduled(cron = "30 0/1 * * * ?")
	public void changePriceBackOnTime() throws ParseException {
		String json = "";
		StringBuffer prolistSid = new StringBuffer();
		StringBuffer PromotionPrice = new StringBuffer();
		StringBuffer supplySids = new StringBuffer();

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:00");
		SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:59");
		PriceRuleKey key = new PriceRuleKey();
		key.setStartDay(df.format(new Date()));
		key.setEndDay(df2.format(new Date()));
		List<PriceRule> pageLayoutSids = this.priceRuleService
				.changPriceBackByEndTime(key);
		if (pageLayoutSids == null || pageLayoutSids.size() == 0) {
			return;
		}
		Set set = new HashSet();
		for (int j = 0; j < pageLayoutSids.size(); j++) {
			PriceRule priceRule = new PriceRule();
			priceRule.setSid(pageLayoutSids.get(j).getSid());
			priceRule.setFlag(2);
			this.priceRuleService.updateByPrimaryKeySelective(priceRule);

			if (!(set.add(pageLayoutSids.get(j).getPageLayoutSid()))) {
				continue;
			}
			List<PriceProduct> list = this.priceProductService
					.queryByPageLayoutSidFlg(pageLayoutSids.get(j)
							.getPageLayoutSid());
			for (int i = 0; i < list.size(); i++) {
				Integer proSid = list.get(i).getProductListSid();
				Map parmMap = new HashMap();
				parmMap.put("productSid", proSid);
				parmMap.put("activityFlg", 0);
				parmMap.put("user", "system");
				try {
					json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
							"/photo/updateFlg.html", parmMap);

					if (json.contains("true")) {
						list.get(i).setFlag(2);
						this.priceProductService
								.updateByPrimaryKeySelective(list.get(i));
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}

		}

	}

}
