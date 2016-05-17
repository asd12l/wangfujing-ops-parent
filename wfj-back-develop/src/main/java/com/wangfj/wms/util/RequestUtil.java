/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.utilRequestUtil.java
 * @Create By chengsj
 * @Create In 2013-5-16 下午8:31:54
 * TODO
 */
package com.wangfj.wms.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.util.Assert;

/**
 * @Class Name RequestUtil
 * @Author chengsj
 * @Create In 2013-5-16
 */
public class RequestUtil {

	/**
	 * @Methods Name getRequestParaMap
	 * @Create In 2013-5-16 By chengsj
	 * @param productKey
	 * @return Map
	 */
	public static Map getRequestParaMap(ProductKey productKey) {
		Assert.notNull(productKey, "productkey can not be null");
		Map resultMap = new HashMap();
		String saleCode = productKey.getSaleCode();
		if (saleCode != null && !"".equals(saleCode)) {
			resultMap.put("saleCode", saleCode);
		}
		String proSku = productKey.getProSku();
		if (proSku != null && !"".equals(proSku)) {
			resultMap.put("proSku", proSku);
		}
		String offMin = productKey.getOffMin();
		if (offMin != null && !"".equals(offMin)) {
			resultMap.put("offMin", offMin);
		}
		String offMax = productKey.getOffMax();
		if (offMax != null && !"".equals(offMax)) {
			resultMap.put("offMax", offMax);
		}
		String brandName = productKey.getBrandName();
		if (brandName != null && !"".equals(brandName)) {
			resultMap.put("brandName", brandName);
		}
		String brandSid = productKey.getBrandSid();
		if (brandSid != null && !"".equals(brandName)) {
			resultMap.put("brandSid", brandSid);
		}
		String stockMin = productKey.getStockMin();
		if (stockMin != null && !"".equals(stockMin)) {
			resultMap.put("stockMin", stockMin);
		}
		String stockMax = productKey.getStockMax();
		if (stockMax != null && !"".equals(stockMax)) {
			resultMap.put("stockMax", stockMax);
		}
		String priceMin = productKey.getPriceMin();
		if (priceMin != null && !"".equals(priceMin)) {
			resultMap.put("priceMin", priceMin);
		}
		String priceMax = productKey.getPriceMax();
		if (priceMax != null && !"".equals(priceMax)) {
			resultMap.put("priceMax", priceMax);
		}
		String saleMoneyMin = productKey.getSaleMoneyMin();
		if (saleMoneyMin != null && !"".equals(saleMoneyMin)) {
			resultMap.put("saleMoneyMin", saleMoneyMin);
		}
		String saleMoneyMax = productKey.getSaleMoneyMax();
		if (saleMoneyMax != null && !"".equals(saleMoneyMax)) {
			resultMap.put("saleMoneyMax", saleMoneyMax);
		}
		String proSellingBeginTime = productKey.getProSellingBeginTime();
		if (proSellingBeginTime != null && !"".equals(proSellingBeginTime)) {
			resultMap.put("proSellingBeginTime", proSellingBeginTime);
		}

		String proSellingEndTime = productKey.getProSellingEndTime();
		if (proSellingEndTime != null && !"".equals(proSellingEndTime)) {
			resultMap.put("proSellingEndTime", proSellingEndTime);
		}
		String proBeginTime = productKey.getProBeginTime();
		if (proBeginTime != null && !"".equals(proBeginTime)) {
			resultMap.put("proBeginTime", proBeginTime);
		}
		String proEndTime = productKey.getProEndTime();
		if (proEndTime != null && !"".equals(proEndTime)) {
			resultMap.put("proEndTime", proEndTime);
		}
		String productClassSid = productKey.getProductClassSid();
		if (productClassSid != null && !"".equals(productClassSid)) {
			resultMap.put("productClassSid", productClassSid);
		}
		String shopName = productKey.getShopName();
		if (shopName != null && !"".equals(shopName)) {
			resultMap.put("shopName", shopName);
		}

		String supplySids = productKey.getSupplySids();
		if (supplySids != null && !"".equals(supplySids)) {
			resultMap.put("supplySids", supplySids);
		}
		
		String supplySid = productKey.getSupplySid();
		if (supplySid != null && !"".equals(supplySid)) {
			resultMap.put("supplySid", supplySid);
		}

		return resultMap;
	}

}
