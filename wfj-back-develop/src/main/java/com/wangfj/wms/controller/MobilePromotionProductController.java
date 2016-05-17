/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.PromotionController.java
 * @Create By chengsj
 * @Create In 2013-8-30 下午4:35:23
 * TODO
 */
package com.wangfj.wms.controller;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wangfj.wms.domain.entity.MobileFlashPromotions;
import com.wangfj.wms.domain.entity.MobilePromotionProduct;
import com.wangfj.wms.service.IMobileFlashPromotionService;
import com.wangfj.wms.service.IMobilePromotionProductService;
import com.wangfj.wms.util.HttpUtil;
import com.wangfj.wms.util.MobileFlashPromotionsKey;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name MobileFlashPromotionController
 * @Author chengsj
 * @Create In 2014-3-26
 */
@Controller
@RequestMapping("/mobilepromotionproduct")
public class MobilePromotionProductController {

	@Autowired
			@Qualifier("mobilepromotionproductService")
	IMobilePromotionProductService mobilePromotionProductService;

	@Autowired
			@Qualifier("mobileflashpromotionService")
	IMobileFlashPromotionService mobileFlashPromotionService;

	/**
	 * 
	 * @Methods Name queryPromotionProducts
	 * @Create In 2014-3-26 By chengsj
	 * @param m
	 * @param request
	 * @param response
	 * @param promotionSid
	 * @return String 说明： 根据活动id获取活动下的商品列表
	 */
	@ResponseBody
	@RequestMapping(value = { "/getpromotionproducts" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryPromotionProducts(Model m, HttpServletRequest request,
			HttpServletResponse response, String promotionSid) {
		String resultJson = "";
		List<MobilePromotionProduct> proList = this.mobilePromotionProductService
				.selectByPromotionSid(Integer.valueOf(promotionSid));

		if (proList.size() <= 0) {
			return ResultUtil.createSuccessResultJson(proList);
		}
		StringBuffer param = new StringBuffer();
		StringBuffer supplySid = new StringBuffer();
		Integer shopSid = null;
		JSONArray result = new JSONArray();
		for (int i = 0; i < proList.size(); i++) {
			shopSid = proList.get(i).getShopSid();
			param.append(proList.get(i).getProductSid().toString());
			param.append(",");
			supplySid.append(proList.get(i).getSupplySid().toString());
			supplySid.append(",");

		}

		try {
			Map paraMap = new HashMap();
			paraMap.put("param", param.substring(0, param.length() - 1));
			paraMap.put("supplySid",
					supplySid.substring(0, supplySid.length() - 1));
			if(shopSid != null && !"".equals(shopSid)){
				paraMap.put("shopSid", shopSid);
			}
			resultJson = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/wsg/getProductsByPids.html", paraMap);
			JSONObject obj = JSONObject.fromObject(resultJson);
			new GsonBuilder().create();
			JSONArray resultArray = obj.getJSONArray("result");
			JSONArray soldOutArray = obj.getJSONArray("soldout");
			for (int j = 0; j < resultArray.size(); j++) {
				JSONObject re = resultArray.getJSONObject(j);
				result.add(re);
			}

			for (int k = 0; k < soldOutArray.size(); k++) {
				JSONObject soldOut = soldOutArray.getJSONObject(k);
				result.add(soldOut);
			}

			JSONObject obj1 = new JSONObject();
			obj1.put("sucess", "true");
			obj1.put("result", result);
			Gson gson = new GsonBuilder().create();
			resultJson = gson.toJson(obj1);

		} catch (Exception e) {
			e.printStackTrace();
			resultJson = "{'success':false}";
		}

		return resultJson;

	}

	/**
	 * 
	 * @Methods Name insertpromotionproduct
	 * @Create In 2014-5-21 By chengsj
	 * @param request
	 * @param response
	 * @param promotionSid
	 * @param shopSid
	 * @param productSids
	 * @param promotionTypeSid
	 * @param supplySid
	 * @return String 说明： 保存查询后的微闪购商品
	 */
	@ResponseBody
	@RequestMapping(value = "/insertpromotionproduct", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String insertpromotionproduct(HttpServletRequest request,
			HttpServletResponse response, String promotionSid, String shopSid,
			String productSids, String promotionTypeSid, String supplySids) {
		String json = "";
		String[] productSidsArray = productSids.split(",");
		String[] supplySidsArray = supplySids.split(",");
		for (int i = 0; i < productSidsArray.length; i++) {
			MobilePromotionProduct pro = new MobilePromotionProduct();

			if (promotionSid != null && !"".equals(promotionSid)) {
				pro.setPromotionSid(Integer.valueOf(promotionSid));
			}

			if (shopSid != null && !"".equals(shopSid)) {
				pro.setShopSid(Integer.valueOf(shopSid));
			}

			if (productSidsArray[i] != null && !"".equals(productSidsArray[i])) {
				pro.setProductSid(Integer.valueOf(productSidsArray[i]));
			}
			if (supplySidsArray[i] != null && !"".equals(supplySidsArray[i])) {
				pro.setSupplySid(supplySidsArray[i]);
			}

			int exsit = this.mobilePromotionProductService.queryExist(pro);
			if (exsit >= 1) {
				continue;
			}
			int count = this.mobilePromotionProductService
					.queryCountSeqBypromotionSid(Integer.valueOf(promotionSid));
			if (count == 0) {
				pro.setSeq(1);
			} else {
				int maxSeq = this.mobilePromotionProductService
						.queryMaxSeqBypromotionSid(Integer
								.valueOf(promotionSid));
				pro.setSeq(maxSeq + 1);
			}

			try {
				int status = this.mobilePromotionProductService
						.insertSelective(pro);
				// 同步拍照系统数据
				if (status >= 1) {
					int maxSid = this.mobilePromotionProductService
							.selectMaxSid();
					MobilePromotionProduct mPro = this.mobilePromotionProductService
							.selectByPrimaryKey(maxSid);
					Map paramMap = new HashMap();
					paramMap.put("sid", String.valueOf(maxSid));
					paramMap.put("promotion_sid",
							String.valueOf(mPro.getPromotionSid()));
					paramMap.put("shop_sid", mPro.getShopSid());
					paramMap.put("product_sid",
							String.valueOf(mPro.getProductSid()));
					paramMap.put("seq", String.valueOf(mPro.getSeq()));
					paramMap.put("stock_flag",
							String.valueOf(mPro.getStockFlag()));
					paramMap.put("supplySid",
							String.valueOf(mPro.getSupplySid()));
					String parajson = new GsonBuilder().create().toJson(
							paramMap);
					String resultJson = HttpUtil.HttpPostForLogistics(
							SystemConfig.WSG_SYN, "PromotionProductInsert",
							parajson);

					resultJson = resultJson.replaceAll("\\\\", "");
					resultJson = resultJson.substring(1,
							resultJson.length() - 1);
					JsonParser parser = new JsonParser();
					JsonObject obj = parser.parse(resultJson).getAsJsonObject();
					String success = obj.get("success").toString();
					if (success.equals("\"true\"")) {
						Map parmMap = new HashMap();
						parmMap.put("productSid", mPro.getProductSid());
						parmMap.put("activityFlg", promotionTypeSid);
						json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
								"/photo/updateFlg.html", parmMap);
						// json = ResultUtil.createSuccessResult();
					} else {
						json = ResultUtil.createFailureResult("", "");
					}
				}
			} catch (Exception e) {

				json = ResultUtil.createFailureResult(e);

			}
		}
		return json;
	}

	/**
	 * 
	 * @Methods Name delettpromotionproduct
	 * @Create In 2014-5-21 By chengsj
	 * @param request
	 * @param response
	 * @param promotionSid
	 * @param shopSid
	 * @param productSids
	 * @return String 说明： 删除微闪购活动下的商品
	 */
	@ResponseBody
	@RequestMapping(value = "/delettpromotionproduct", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String delettpromotionproduct(HttpServletRequest request,
			HttpServletResponse response, String promotionSid, String shopSid,
			String supplySid, String productSids) {
		String json = "";
		MobilePromotionProduct pro = new MobilePromotionProduct();

		if (promotionSid != null && !"".equals(promotionSid)) {
			pro.setPromotionSid(Integer.valueOf(promotionSid));
		}

		if (shopSid != null && !"".equals(shopSid)) {
			pro.setShopSid(Integer.valueOf(shopSid));
		}

		if (productSids != null && !"".equals(productSids)) {
			pro.setProductSid(Integer.valueOf(productSids));
		}
		if (supplySid != null && !"".equals(supplySid)) {
			pro.setSupplySid(supplySid);
		}
		try {
			MobilePromotionProduct wsgPro = this.mobilePromotionProductService
					.queryBySelect(pro);
			// 同步拍照系统数据
			Map paramMap = new HashMap();
			paramMap.put("sid", String.valueOf(wsgPro.getSid()));
			String parajson = new GsonBuilder().create().toJson(paramMap);
			String resultJson = HttpUtil.HttpPostForLogistics(
					SystemConfig.WSG_SYN, "PromotionProductDelete", parajson);

			resultJson = resultJson.replaceAll("\\\\", "");
			resultJson = resultJson.substring(1, resultJson.length() - 1);
			JsonParser parser = new JsonParser();
			JsonObject obj = parser.parse(resultJson).getAsJsonObject();
			String success = obj.get("success").toString();
			// 撤销ssd活动位 （flg为0）
			if (success.equals("\"true\"")) {
				this.mobilePromotionProductService.deleteByInfo(pro);

				Map parmMap = new HashMap();
				parmMap.put("productSid", wsgPro.getProductSid());
				parmMap.put("activityFlg", 0);
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/photo/updateFlg.html", parmMap);
			} else {
				json = ResultUtil.createFailureResult("", "");
			}

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	/**
	 * 
	 * @Methods Name updatejson1
	 * @Create In 2014-5-21 By chengsj
	 * @param m
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 *             String 说明： 拖拽微闪购下的商品，改变顺序
	 */

	@ResponseBody
	@RequestMapping(value = { "/drag" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updatejson1(Model m, HttpServletRequest request,
			HttpServletResponse response) throws SQLException {

		String json = "";
		String promotionSid = request.getParameter("promotionSid");

		String shopSid = request.getParameter("shopSid");
		// 拖拽前的productListSid
		String selectRowPid = request.getParameter("selectRowPid");
		// 拖拽后的productListSid
		String toRowPid = request.getParameter("toRowPid");

		// 获取拖拽前的顺序号
		MobilePromotionProduct selectRow = new MobilePromotionProduct();
		selectRow.setPromotionSid(Integer.valueOf(promotionSid));
		selectRow.setShopSid(Integer.valueOf(shopSid));
		selectRow.setProductSid(Integer.valueOf(selectRowPid));
		MobilePromotionProduct selectedVo = this.mobilePromotionProductService
				.queryBySelect(selectRow);
		Integer selectRowOrderNumber = selectedVo.getSeq();
		// 获取拖拽后的顺序号
		MobilePromotionProduct toRow = new MobilePromotionProduct();
		toRow.setPromotionSid(Integer.valueOf(promotionSid));
		toRow.setShopSid(Integer.valueOf(shopSid));
		toRow.setProductSid(Integer.valueOf(toRowPid));
		MobilePromotionProduct toVo = this.mobilePromotionProductService
				.queryBySelect(toRow);
		Integer toRowOrderNumber = toVo.getSeq();
		List<MobilePromotionProduct> list = this.mobilePromotionProductService
				.selectByPromotionSid(Integer.valueOf(promotionSid));
		for (int i = 0; i < list.size(); i++) {
			Integer orderNumber = list.get(i).getSeq();
			if (selectRowOrderNumber < orderNumber
					&& orderNumber <= toRowOrderNumber) {
				list.get(i).setSeq(orderNumber - 1);
				this.mobilePromotionProductService
						.updateByPrimaryKeySelective(list.get(i));
			}
			if (toRowOrderNumber <= orderNumber
					&& orderNumber < selectRowOrderNumber) {
				list.get(i).setSeq(orderNumber + 1);
				this.mobilePromotionProductService
						.updateByPrimaryKeySelective(list.get(i));
			}
		}

		// 更新选中的数据
		selectRow.setSid(selectedVo.getSid());
		selectRow.setSeq(toRowOrderNumber);
		try {
			this.mobilePromotionProductService
					.updateByPrimaryKeySelective(selectRow);

			List<MobilePromotionProduct> proList = this.mobilePromotionProductService
					.selectByPromotionSid(Integer.valueOf(promotionSid));

			for (int i = 0; i < proList.size(); i++) {
				String resultJson = "";
				Map paramMap = new HashMap();
				paramMap.put("sid", proList.get(i).getSid());
				paramMap.put("promotion_sid",
						String.valueOf(proList.get(i).getPromotionSid()));
				paramMap.put("shop_sid", proList.get(i).getShopSid());
				paramMap.put("product_sid",
						String.valueOf(proList.get(i).getProductSid()));
				paramMap.put("seq", String.valueOf(proList.get(i).getSeq()));
				String parajson = new GsonBuilder().create().toJson(paramMap);
				resultJson = HttpUtil.HttpPostForLogistics(
						SystemConfig.WSG_SYN, "PromotionProductUpdate",
						parajson);
				resultJson = resultJson.replaceAll("\\\\", "");
				resultJson = resultJson.substring(1, resultJson.length() - 1);
				JsonParser parser = new JsonParser();
				JsonObject obj = parser.parse(resultJson).getAsJsonObject();
				String success = obj.get("success").toString();
				if (success.equals("\"true\"")) {
					json = ResultUtil.createSuccessResult();
				} else {
					json = ResultUtil.createFailureResult("", "");
				}
			}

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;

	}

	/**
	 * 说明： 活动结束后，闪购商品定时恢复为普通商品（每天23:00:00）
	 * 
	 * @Methods Name updateProductsOnTime
	 * @Create In 2013-11-26 By chengsj
	 * @throws ParseException
	 *             void
	 */
//	@Scheduled(cron = "0 0 23 * * ?")
	public void updateProductsOnTime() throws ParseException {

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		SimpleDateFormat df2 = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		MobileFlashPromotionsKey key = new MobileFlashPromotionsKey();
		key.setStartDay(df.format(new Date()));
		key.setEndDay(df2.format(new Date()));
		List<MobileFlashPromotions> pro = this.mobileFlashPromotionService
				.queryPromotionsByEndTime(key);
		if (pro == null || pro.size() == 0) {
			return;
		}

		for (int j = 0; j < pro.size(); j++) {
			List<MobilePromotionProduct> list = this.mobilePromotionProductService
					.selectByPromotionSid(Integer.valueOf(pro.get(j).getSid()));
			if (list == null || list.size() == 0) {
				return;
			}
			for (int i = 0; i < list.size(); i++) {
				Integer proSid = list.get(i).getProductSid();
				Map parmMap = new HashMap();
				parmMap.put("productSid", proSid);
				parmMap.put("activityFlg", 0);
				try {
					HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
							"/photo/updateFlg.html", parmMap);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}

		}

	}

	/**
	 * 说明： 商品售罄时，顺序下移（）
	 * 
	 * @Methods Name updateProductSeqOnTime
	 * @Create In 2014-04-15 By chengsj
	 * @throws ParseException
	 *             void
	 */

//	@Scheduled(cron = "0 15/30 00 * * ?")
	public void updateProductSeqOnTime() throws ParseException {
		List<MobileFlashPromotions> promotions = this.mobileFlashPromotionService
				.getGoingPromotions();
		for (int i = 0; i < promotions.size(); i++) {
			int promotionSid = promotions.get(i).getSid();
			List<MobilePromotionProduct> products = this.mobilePromotionProductService
					.selectByStockFlag(promotionSid);

			StringBuffer param = new StringBuffer();
			StringBuffer supplySid = new StringBuffer();
			Integer shopSid = null;
			for (int j = 0; j < products.size(); j++) {
				shopSid = products.get(j).getShopSid();
				param.append(products.get(j).getProductSid());
				param.append(",");

				supplySid.append(products.get(j).getSupplySid());
				supplySid.append(",");

			}
			String resultJson = "";
			try {
				Map paraMap = new HashMap();
				paraMap.put("param", param.substring(0, param.length() - 1));
				paraMap.put("shopSid", shopSid);
				paraMap.put("supplySid",
						supplySid.substring(0, supplySid.length() - 1));
				resultJson = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"wsg/getProductsByPids.html", paraMap);
				JSONObject obj = JSONObject.fromObject(resultJson);
				new GsonBuilder().create();
				if (obj.getString("success").equals("true")) {
					JSONArray resultArray = obj.getJSONArray("soldout");
					for (int k = 0; k < resultArray.size(); k++) {
						JSONObject t = resultArray.getJSONObject(k);
						MobilePromotionProduct mpp = new MobilePromotionProduct();
						mpp.setPromotionSid(promotionSid);
						mpp.setProductSid(Integer.valueOf(t.getString("id")));
						mpp.setShopSid(shopSid);

						MobilePromotionProduct mpp1 = new MobilePromotionProduct();
						mpp1 = this.mobilePromotionProductService
								.queryBySelect(mpp);

						mpp.setSid(mpp1.getSid());
						int maxSeq = this.mobilePromotionProductService
								.queryMaxSeqBypromotionSid(Integer
										.valueOf(promotionSid));
						mpp.setSeq(maxSeq + 1);
						mpp.setStockFlag(0);

						this.mobilePromotionProductService
								.updateByPrimaryKeySelective(mpp);
						Map paramMap = new HashMap();
						paramMap.put("sid", mpp.getSid());
						paramMap.put("promotion_sid",
								String.valueOf(mpp.getPromotionSid()));
						paramMap.put("shop_sid", mpp.getShopSid());
						paramMap.put("product_sid",
								String.valueOf(mpp.getProductSid()));
						paramMap.put("seq", String.valueOf(mpp.getSeq()));
						paramMap.put("stock_flag", mpp.getStockFlag());
						String parajson = new GsonBuilder().create().toJson(
								paramMap);
						resultJson = HttpUtil.HttpPostForLogistics(
								SystemConfig.WSG_SYN, "PromotionProductUpdate",
								parajson);
					}
				} else {
					continue;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 
	 * @Methods Name savePromotionProduct
	 * @Create In 2014-5-29 By chengsj
	 * @param request
	 * @param response
	 * @param promotionSid
	 * @param shopSid
	 * @param productSids
	 * @param promotionTypeSid
	 * @param supplySids
	 * @return String
	 *  说明： 为二维码扫码提供添加活动商品的接口
	 */
	@ResponseBody
	@RequestMapping(value = "/savepromotionproduct", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String savePromotionProduct(HttpServletRequest request,
			HttpServletResponse response, String promotionSid, String shopSid,
			String productSids, String promotionTypeSid, String supplySids) {
		String json = "";
		String[] productSidsArray = productSids.split(",");
		String[] supplySidsArray = supplySids.split(",");
		for (int i = 0; i < productSidsArray.length; i++) {
			MobilePromotionProduct pro = new MobilePromotionProduct();

			if (promotionSid != null && !"".equals(promotionSid)) {
				pro.setPromotionSid(Integer.valueOf(promotionSid));
			}

			if (shopSid != null && !"".equals(shopSid)) {
				pro.setShopSid(Integer.valueOf(shopSid));
			}

			if (productSidsArray[i] != null && !"".equals(productSidsArray[i])) {
				pro.setProductSid(Integer.valueOf(productSidsArray[i]));
			}
			if (supplySidsArray[i] != null && !"".equals(supplySidsArray[i])) {
				pro.setSupplySid(supplySidsArray[i]);
			}

			int exsit = this.mobilePromotionProductService.queryExist(pro);
			if (exsit >= 1) {
				json = ResultUtil.createSuccessResult();
				continue;
			}
			int count = this.mobilePromotionProductService
					.queryCountSeqBypromotionSid(Integer.valueOf(promotionSid));
			if (count == 0) {
				pro.setSeq(1);
			} else {
				int maxSeq = this.mobilePromotionProductService
						.queryMaxSeqBypromotionSid(Integer
								.valueOf(promotionSid));
				pro.setSeq(maxSeq + 1);
			}

			try {
				int status = this.mobilePromotionProductService
						.insertSelective(pro);
				// 同步拍照系统数据
				if (status >= 1) {
					int maxSid = this.mobilePromotionProductService
							.selectMaxSid();
					MobilePromotionProduct mPro = this.mobilePromotionProductService
							.selectByPrimaryKey(maxSid);
					Map paramMap = new HashMap();
					paramMap.put("sid", String.valueOf(maxSid));
					paramMap.put("promotion_sid",
							String.valueOf(mPro.getPromotionSid()));
					paramMap.put("shop_sid", mPro.getShopSid());
					paramMap.put("product_sid",
							String.valueOf(mPro.getProductSid()));
					paramMap.put("seq", String.valueOf(mPro.getSeq()));
					paramMap.put("stock_flag",
							String.valueOf(mPro.getStockFlag()));
					paramMap.put("supplySid",
							String.valueOf(mPro.getSupplySid()));
					String parajson = new GsonBuilder().create().toJson(
							paramMap);
					String resultJson = HttpUtil.HttpPostForLogistics(
							SystemConfig.WSG_SYN, "PromotionProductInsert",
							parajson);

					resultJson = resultJson.replaceAll("\\\\", "");
					resultJson = resultJson.substring(1,
							resultJson.length() - 1);
					JsonParser parser = new JsonParser();
					JsonObject obj = parser.parse(resultJson).getAsJsonObject();
					String success = obj.get("success").toString();
					if (success.equals("\"true\"")) {
						Map parmMap = new HashMap();
						parmMap.put("productSid", mPro.getProductSid());
						parmMap.put("activityFlg", promotionTypeSid);
						json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
								"/photo/updateFlg.html", parmMap);
						// json = ResultUtil.createSuccessResult();
					} else {
						json = ResultUtil.createFailureResult("", "");
					}
				}
			} catch (Exception e) {

				json = ResultUtil.createFailureResult(e);

			}
		}
		return json;
	}

}
