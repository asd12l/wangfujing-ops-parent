package com.wangfj.wms.controller.promotionLabel;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.utils.StringUtils;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping("/productTag")
public class ProductTagController {

	/**
	 * 商品模块-商品信息管理-商品管理-查询所有商品
	 * 
	 * @Methods Name selectAllProduct
	 * @Create In 2015-4-17 By wangsy
	 * @param request
	 * @param response
	 * @param ssdProduct
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectAllProduct", method = { RequestMethod.POST, RequestMethod.GET })
	public String selectAllProduct(HttpServletRequest request, HttpServletResponse response,
			String skuName, String spuName, String skuCode, String spuCode, String spuSid,
			String proType, String brandGroupCode, String modelCode, String colorSid,
			String photoStatus, String skuSale, String proActiveBit, String isAddTag, String tagSid) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		Map<String, Object> proMap = new HashMap<String, Object>();
		try {
			proMap.put("pageSize", size);// 每页显示数量
			proMap.put("currentPage", currPage);// 当前第几页
			if (StringUtils.isNotEmpty(skuName)) {
				proMap.put("skuName", skuName.trim());
			}
			if (StringUtils.isNotEmpty(spuName)) {
				proMap.put("spuName", spuName.trim());
			}
			if (StringUtils.isNotEmpty(skuCode)) {
				proMap.put("skuCode", skuCode.trim());
			}
			if (StringUtils.isNotEmpty(spuCode)) {
				proMap.put("spuCode", spuCode.trim());
			}
			if (StringUtils.isNotEmpty(spuSid)) {
				proMap.put("spuSid", spuSid.trim());
			}
			if (StringUtils.isNotEmpty(proType)) {
				proMap.put("proType", proType.trim());
			}
			if (StringUtils.isNotEmpty(brandGroupCode)) {
				proMap.put("brandGroupCode", brandGroupCode.trim());
			}
			if (StringUtils.isNotEmpty(modelCode)) {
				proMap.put("modelCode", modelCode.trim());
			}
			if (StringUtils.isNotEmpty(colorSid)) {
				proMap.put("colorSid", colorSid.trim());
			}
			if (StringUtils.isNotEmpty(photoStatus)) {
				proMap.put("photoStatus", photoStatus.trim());
			}
			if (StringUtils.isNotEmpty(skuSale)) {
				proMap.put("skuSale", skuSale.trim());
			}
			if (StringUtils.isNotEmpty(proActiveBit)) {
				proMap.put("proActiveBit", proActiveBit.trim());
			}
			// 是否已加入标签
			if (StringUtils.isNotEmpty(isAddTag)) {
				proMap.put("isAddTag", isAddTag.trim());
			}
			// 标签sid
			if (StringUtils.isNotEmpty(tagSid)) {
				proMap.put("tagSid", tagSid.trim());
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productTag/selectBaseSkuPageByPara.htm", JsonUtil.getJSONString(proMap));
			proMap.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					proMap.put("list", jsonPage.get("list"));
					proMap.put("pageCount",
							jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
				} else {
					proMap.put("list", null);
					proMap.put("pageCount", 0);
				}
			} else {
				proMap.put("list", null);
				proMap.put("pageCount", 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
			json = "{'success':false}";
		}
		JSONObject jsonArray = JSONObject.fromObject(proMap);
		return jsonArray.toString();

	}

	/**
	 * 批量导入商品(SKU)与关键字的关系
	 * 
	 * @Methods Name selectAllProduct
	 * @Create In 2015-4-17 By zdl
	 * @param request
	 * @param response
	 * @param ssdProduct
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveProductTagBySelects", method = { RequestMethod.POST, RequestMethod.GET })
	public String saveProductTagBySelects(HttpServletRequest request, HttpServletResponse response,
			String skuName, String spuName, String skuCode, String spuCode, String spuSid,
			String proType, String brandGroupCode, String modelCode, String colorSid,
			String photoStatus, String skuSale, String proActiveBit, String isAddTag, String tagSid) {
		String json = "";
		Map<String, Object> proMap = new HashMap<String, Object>();
		try {
			if (StringUtils.isNotEmpty(skuName)) {
				proMap.put("skuName", skuName.trim());
			}
			if (StringUtils.isNotEmpty(spuName)) {
				proMap.put("spuName", spuName.trim());
			}
			if (StringUtils.isNotEmpty(skuCode)) {
				proMap.put("skuCode", skuCode.trim());
			}
			if (StringUtils.isNotEmpty(spuCode)) {
				proMap.put("spuCode", spuCode.trim());
			}
			if (StringUtils.isNotEmpty(spuSid)) {
				proMap.put("spuSid", spuSid.trim());
			}
			if (StringUtils.isNotEmpty(proType)) {
				proMap.put("proType", proType.trim());
			}
			if (StringUtils.isNotEmpty(brandGroupCode)) {
				proMap.put("brandGroupCode", brandGroupCode.trim());
			}
			if (StringUtils.isNotEmpty(modelCode)) {
				proMap.put("modelCode", modelCode.trim());
			}
			if (StringUtils.isNotEmpty(colorSid)) {
				proMap.put("colorSid", colorSid.trim());
			}
			if (StringUtils.isNotEmpty(photoStatus)) {
				proMap.put("photoStatus", photoStatus.trim());
			}
			if (StringUtils.isNotEmpty(skuSale)) {
				proMap.put("skuSale", skuSale.trim());
			}
			if (StringUtils.isNotEmpty(proActiveBit)) {
				proMap.put("proActiveBit", proActiveBit.trim());
			}
			// 标签sid
			if (StringUtils.isNotEmpty(tagSid)) {
				proMap.put("tagSid", tagSid.trim());
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productTag/addSkuTagList.htm", JsonUtil.getJSONString(proMap));
		} catch (Exception e) {
			e.printStackTrace();
			json = "{'success':false}";
		}
		return json;
	}
	
	/**
	 * 查询专柜商品列表(用于专柜商品列表加载)
	 * 
	 * @Methods Name selectShoppeProduct
	 * @Create In 2015-9-8 By dongliang
	 * @param request
	 * @param response
	 * @param shoppeProduct
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectShoppeProduct", method = { RequestMethod.POST,
			RequestMethod.GET })
	public String selectShoppeProduct(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		Map<String, Object> proMap = new HashMap<String, Object>();
		try {
			proMap.put("pageSize", size);// 每页显示数量
			proMap.put("currentPage", currPage);// 当前第几页

			// 门店编码
			if (null != request.getParameter("storeCode")
					&& !"".equals(request.getParameter("storeCode"))) {
				proMap.put("storeCode", request.getParameter("storeCode"));
			}
			// 供应商编码
			if (null != request.getParameter("supplierCode")
					&& !"".equals(request.getParameter("supplierCode"))) {
				proMap.put("supplierCode", request.getParameter("supplierCode"));
			}
			// 管理分类
			if (null != request.getParameter("manageCategory")
					&& !"".equals(request.getParameter("manageCategory"))) {
				proMap.put("manageCategory", request.getParameter("manageCategory"));
			}
			// 专柜名称
			if (null != request.getParameter("counterCode")
					&& !"".equals(request.getParameter("counterCode"))) {
				proMap.put("counterCode", request.getParameter("counterCode"));
			}
			// 门店品牌编码
			if (null != request.getParameter("brandCode")
					&& !"".equals(request.getParameter("brandCode"))) {
				proMap.put("brandSid", request.getParameter("brandCode"));
			}
			// 专柜商品编码
			if (null != request.getParameter("productCode")
					&& !"".equals(request.getParameter("productCode"))) {
				proMap.put("productCode", request.getParameter("productCode"));
			}
			// 是否已加入标签
			if (null != request.getParameter("isAddTag")
					&& !"".equals(request.getParameter("isAddTag"))) {
				proMap.put("isAddTag", request.getParameter("isAddTag"));
			}
			// 标签sid
			if (null != request.getParameter("tagSid")
					&& !"".equals(request.getParameter("tagSid"))) {
				proMap.put("tagSid", request.getParameter("tagSid"));
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productTag/selectBaseProPageByPara.htm", JsonUtil.getJSONString(proMap));
			proMap.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					proMap.put("list", jsonPage.get("list"));
					proMap.put("pageCount",
							jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
				} else {
					proMap.put("list", null);
					proMap.put("pageCount", 0);
				}
			} else {
				proMap.put("list", null);
				proMap.put("pageCount", 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
			json = "{'success':false}";
		}
		JSONObject jsonArray = JSONObject.fromObject(proMap);
		return jsonArray.toString();
	}
	
	/**
	 * 批量导入专柜商品与促销标签的关系
	 * 
	 * @Methods Name saveProductTagBySelects
	 * @Create In 2015-9-8 By dongliang
	 * @param request
	 * @param response
	 * @param shoppeProduct
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveShoppeProductTagBySelects", method = { RequestMethod.POST,
			RequestMethod.GET })
	public String saveShoppeProductTagBySelects(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String, Object> proMap = new HashMap<String, Object>();
		try {
			// 门店编码
			if (null != request.getParameter("storeCode")
					&& !"".equals(request.getParameter("storeCode"))) {
				proMap.put("storeCode", request.getParameter("storeCode"));
			}
			// 专柜商品编码
			if (null != request.getParameter("productCode")
					&& !"".equals(request.getParameter("productCode"))) {
				proMap.put("productCode", request.getParameter("productCode"));
			}
			// 供应商编码
			if (null != request.getParameter("supplierCode")
					&& !"".equals(request.getParameter("supplierCode"))) {
				proMap.put("supplierCode", request.getParameter("supplierCode"));
			}
			// 管理分类
			if (null != request.getParameter("manageCategory")
					&& !"".equals(request.getParameter("manageCategory"))) {
				proMap.put("manageCategory", request.getParameter("manageCategory"));
			}
			// 专柜名称
			if (null != request.getParameter("counterCode")
					&& !"".equals(request.getParameter("counterCode"))) {
				proMap.put("counterCode", request.getParameter("counterCode"));
			}
			// 门店品牌编码
			if (null != request.getParameter("brandCode")
					&& !"".equals(request.getParameter("brandCode"))) {
				proMap.put("brandSid", request.getParameter("brandCode"));
			}
			// 标签sid
			if (null != request.getParameter("tagSid")
					&& !"".equals(request.getParameter("tagSid"))) {
				proMap.put("tagSid", request.getParameter("tagSid"));
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productTag/addShoppeProductTagList.htm", JsonUtil.getJSONString(proMap));
		} catch (Exception e) {
			e.printStackTrace();
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 添加关系
	 * 
	 * @Methods Name saveProductTag
	 * @Create In 2015年12月14日 By dongliang
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/saveProductTag", method = { RequestMethod.POST, RequestMethod.GET })
	public String saveProductTag(String tagSid, String productSids) {
		String json = "";
		Map<String, Object> proMap = new HashMap<String, Object>();
		try {
			proMap.put("tagSid", tagSid);
			proMap.put("productSids", productSids);

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productTag/saveProductTag.htm", JsonUtil.getJSONString(proMap));
		} catch (Exception e) {
			e.printStackTrace();
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 删除关系
	 * 
	 * @Methods Name deleteProductTag
	 * @Create In 2015年12月14日 By dongliang
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteProductTag", method = { RequestMethod.POST, RequestMethod.GET })
	public String deleteProductTag(String tagSid, String productSids) {
		String json = "";
		Map<String, Object> proMap = new HashMap<String, Object>();
		try {
			proMap.put("tagSid", tagSid);
			proMap.put("productSids", productSids);

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/productTag/deleteProductTag.htm", JsonUtil.getJSONString(proMap));
		} catch (Exception e) {
			e.printStackTrace();
			json = "{'success':false}";
		}
		return json;
	}
}
