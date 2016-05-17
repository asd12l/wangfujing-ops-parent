package com.wangfj.wms.controller.photo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.domain.entity.FtpConfig;
import com.wangfj.wms.domain.entity.Photoguige;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * 上线计划管理
 * 
 * @Class Name OnlinPlanController
 * @Author Henry
 * @Create In 2015年11月26日
 */
@Controller
@RequestMapping(value = "/photo")
public class OnlinPlanController {

	/**
	 * 查询上线计划列表
	 * 
	 * @Methods Name queryOnlinPlanList
	 * @param request
	 * @param response
	 * @param organizationName
	 * @param organizationCode
	 * @param groupSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOnlinPlanList", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryOrganizationZero(HttpServletRequest request,
			HttpServletResponse response, String organizationName,
			String organizationCode, String groupSid) {
		// 操作人用户名
		String username = (String) request.getSession()
				.getAttribute("username");

		Map<String, Object> map = new HashMap<String, Object>();

		String pageSize = request.getParameter("pageSize") == null ? "10"
				: ("" + request.getParameter("pageSize"));

		String currentPage = request.getParameter("page") == null ? "1"
				: ("" + request.getParameter("page"));

		// 当前页码
		map.put("currentPage", Integer.parseInt(currentPage));
		// 每页数目
		map.put("pageSize", Integer.parseInt(pageSize));

		// 上线计划的状态,0--全部，1--未发布，2--已发布
		if (StringUtils.isNotEmpty(groupSid)) {
			map.put("on_line_state", groupSid);
		} else {
			map.put("on_line_state", "0");
		}
		// 上线计划名称
		if (StringUtils.isNotEmpty(organizationName)) {
			map.put("on_line_name", organizationName);
		} else {
			map.put("on_line_name", "");
		}
		// 上线计划编码
		if (StringUtils.isNotEmpty(organizationCode)) {
			map.put("on_line_id", organizationCode);
		} else {
			map.put("on_line_id", "");
		}
		// 操作人用户名
		if (StringUtils.isNotEmpty(username)) {
			map.put("username", username);
		} else {
			map.put("username", "");
		}

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/queryOnlinePlanPage.htm",
					JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					map.put("list", jsonObject.get("data"));
					if (jsonObject.get("count") == null) {
						map.put("pageCount", 0);
					} else {
						int countInteger = Integer.parseInt(jsonObject.get(
								"count").toString());
						int pageSizeInteger = Integer.parseInt(jsonObject.get(
								"pageSize").toString());
						double c = ((double) countInteger) / pageSizeInteger;
						int d = (int) Math.ceil(c);
						map.put("pageCount", d);
					}
				} else {
					map.put("list", null);
					map.put("pageCount", 0);
				}
			} else {
				map.put("list", null);
				map.put("pageCount", 0);
			}

		} catch (Exception e) {
			map.put("pageCount", 0);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
//		System.out.println(gson.toJson(map));
		return gson.toJson(map);
	}

	/**
	 * 查询可加入上线计划的商品列表
	 * 
	 * @Methods Name queryProductList
	 * @param request
	 * @param response
	 * @param colorCode
	 *            色系编码
	 * @param colorName
	 *            色系名称
	 * @param modelCode
	 *            款号
	 * @param photoStatus
	 *            商品拍照上线计划的状态,0未加入上线计划;1已加入上线计划;2发布上线计划
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryProductList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryProductList(HttpServletRequest request,
			HttpServletResponse response, String colorCode, String colorName,
			String modelCode, String productName, String productCode, String brandName, String photoStatus) {

		Map<String, Object> map = new HashMap<String, Object>();

		String pageSize = request.getParameter("pageSize") == null ? "10"
				: ("" + request.getParameter("pageSize"));

		String currentPage = request.getParameter("page") == null ? "1"
				: ("" + request.getParameter("page"));

		// 当前页码
		map.put("currentPage", Integer.parseInt(currentPage));
		// 每页数目
		map.put("pageSize", Integer.parseInt(pageSize));

		// 商品上线计划的状态,0未加入上线计划;1已加入上线计划;2发布上线计划
		if (StringUtils.isNotEmpty(photoStatus)) {
			map.put("planStatus", photoStatus);
		} else {
			map.put("planStatus", "0");
		}

//		// 色系编码
//		if (StringUtils.isNotEmpty(colorCode)) {
//			map.put("colorCode", colorCode);
//		}
		// 色系名称
		if (StringUtils.isNotEmpty(colorName)) {
			if (!colorName.equals("全部")) {
				map.put("colorName", colorName);
			}
		}
		// 款号
		if (StringUtils.isNotEmpty(modelCode)) {
			map.put("modelCode", modelCode);
		}
		// 商品名称
		if (StringUtils.isNotEmpty(productName)) {
			map.put("productName", productName);
		}
		// 商品编号
		if (StringUtils.isNotEmpty(productCode)) {
			map.put("productSid", productCode);
		}
		// 品牌名称
		if (StringUtils.isNotEmpty(brandName)) {
			map.put("brandName", brandName);
		}
		System.out.println(JsonUtil.getJSONString(map));
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
					+ "/productPhoto/getProPlanInfoByPara.htm",
					JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					JSONObject jason = JSONObject.fromObject(jsonObject
							.get("data"));

					map.put("list", jason.get("list"));
					if (jason.get("count") == null) {
						map.put("pageCount", 0);
					} else {
						int countInteger = Integer.parseInt(jason.get("count")
								.toString());
						int pageSizeInteger = Integer.parseInt(jason.get(
								"pageSize").toString());
						double c = ((double) countInteger) / pageSizeInteger;
						int d = (int) Math.ceil(c);
						map.put("pageCount", d);
					}

				} else {
					map.put("list", null);
					map.put("pageCount", 0);
				}
			} else {
				map.put("list", null);
				map.put("pageCount", 0);
			}

		} catch (Exception e) {
			map.put("pageCount", 0);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		return gson.toJson(map);
	}

	/**
	 * 根据上线计划ID查询上线计划中的商品列表
	 * 
	 * @Methods Name queryOnlinePlanByIDPage
	 * @param request
	 * @param response
	 * @param on_line_id
	 *            上线计划ID
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOnlinePlanByIDPage", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryOnlinePlanByIDPage(HttpServletRequest request,
			HttpServletResponse response, String on_line_id) {

		Map<String, Object> map = new HashMap<String, Object>();

		String pageSize = request.getParameter("pageSize") == null ? "10"
				: ("" + request.getParameter("pageSize"));

		String currentPage = request.getParameter("page") == null ? "1"
				: ("" + request.getParameter("page"));

		// 当前页码
		map.put("currentPage", Integer.parseInt(currentPage));
		// 每页数目
		map.put("pageSize", Integer.parseInt(pageSize));

		// 上线计划ID
		if (StringUtils.isNotEmpty(on_line_id)) {
			map.put("on_line_id", on_line_id);
		} else {
			map.put("on_line_id", "");
		}

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/queryOnlinePlanByIDPage.htm",
					JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					map.put("list", jsonObject.get("data"));
					if (jsonObject.get("count") == null) {
						map.put("pageCount", 0);
					} else {
						int countInteger = Integer.parseInt(jsonObject.get(
								"count").toString());
						int pageSizeInteger = Integer.parseInt(jsonObject.get(
								"pageSize").toString());
						double c = ((double) countInteger) / pageSizeInteger;
						int d = (int) Math.ceil(c);
						map.put("pageCount", d);
					}
				} else {
					map.put("list", null);
					map.put("pageCount", 0);
				}
			} else {
				map.put("list", null);
				map.put("pageCount", 0);
			}

		} catch (Exception e) {
			map.put("pageCount", 0);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		return gson.toJson(map);
	}

	/**
	 * 保存上线计划名称
	 * 
	 * @Methods Name saveOrganizationOne
	 * @param organizationName
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveOnlineName", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveOnlineName(HttpServletRequest request,
			HttpServletResponse response, String organizationName) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(organizationName)) {
				request.getSession().setAttribute("on_line_name",
						organizationName);
				Map map0 = new HashMap();
				map0.put("success", true);
				JSONObject json0 = JSONObject.fromObject(map0);
				return json0.toString();
			} else {
				Map map0 = new HashMap();
				map0.put("success", false);
				JSONObject json0 = JSONObject.fromObject(map0);
				return json0.toString();
			}
		} catch (Exception e) {
			Map map0 = new HashMap();
			map0.put("success", false);
			JSONObject json0 = JSONObject.fromObject(map0);
			return json0.toString();
		}
	}

	/**
	 * 创建上线计划
	 * 
	 * @Methods Name createOnlinePlan
	 * @param shoppeCode
	 * @param shoppeProSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/createOnlinePlan", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String createOnlinePlan(HttpServletRequest request,
			HttpServletResponse response, String sids, String on_line_name,
			String product_names, String modelcodes, String colorcodes,
			String colorcodenames, String brandcodes, String brandnames,
			String categotyscodes, String categotyss, String sexsids) {

		// 操作人用户名
		String username3 = (String) request.getSession().getAttribute(
				"username");

		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";

		String[] sidsArr = (sids.substring(1, sids.length() - 1).replace("\"",
				"")).split(",");
		String[] product_namesArr = (product_names.substring(1,
				product_names.length() - 1).replace("\"", "")).split(",");
		String[] modesArr = (modelcodes.substring(1, modelcodes.length() - 1)
				.replace("\"", "")).split(",");
		String[] colorcodesArr = (colorcodes.substring(1,
				colorcodes.length() - 1).replace("\"", "")).split(",");
		String[] colorcodenamesArr = (colorcodenames.substring(1,
				colorcodenames.length() - 1).replace("\"", "")).split(",");
		String[] brandcodesArr = (brandcodes.substring(1,
				brandcodes.length() - 1).replace("\"", "")).split(",");
		String[] brandnamesArr = (brandnames.substring(1,
				brandnames.length() - 1).replace("\"", "")).split(",");
		String[] categotyscodesArr = (categotyscodes.substring(1,
				categotyscodes.length() - 1).replace("\"", "")).split(",");
		String[] categotyssArr = (categotyss.substring(1,
				categotyss.length() - 1).replace("\"", "")).split(",");
		String[] sexsidsArr = (sexsids.substring(1, sexsids.length() - 1)
				.replace("\"", "")).split(",");
		// String[] storeNamesArr = (storeNames.substring(1,
		// storeNames.length() - 1).replace("\"", "")).split(",");
		// String[] storeCodesArr = (storeCodes.substring(1, storeCodes.length()
		// - 1)
		// .replace("\"", "")).split(",");

		List list = new ArrayList();
		for (int i = 0; i < sidsArr.length; i++) {
			Map map1 = new HashMap();
			map1.put("skucode", sidsArr[i]);
			map1.put("skuname", product_namesArr[i]);
			map1.put("modelcode", modesArr[i]);
			map1.put("colorcode", colorcodesArr[i]);
			map1.put("colorcodename", colorcodenamesArr[i]);
			map1.put("brandcode", brandcodesArr[i]);
			map1.put("brandname", brandnamesArr[i]);
			map1.put("categotyscode", categotyscodesArr[i]);
			map1.put("categotys", categotyssArr[i]);
			map1.put("sexsid", sexsidsArr[i]);
			map1.put("createmen", username3);
			// map1.put("storeName", storeNamesArr[i]);
			// map1.put("storeCode", storeCodesArr[i]);
			list.add(map1);
		}
		map.put("dataPcmOnlineGoods", list);
		map.put("on_line_name", on_line_name);
		map.put("createmen", username3);
		map.put("opt_name", username3);
		try {
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/insertPcmOnlinePlan.htm",
					JsonUtil.getJSONString(map));
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}

		if (StringUtils.isNotEmpty(json)) {

			JSONObject jsonObject = JSONObject.fromObject(json);
			if ("true".equals(jsonObject.getString("success"))) {
				List list2 = new ArrayList();
				for (int i = 0; i < sidsArr.length; i++) {
					Map map2 = new HashMap();
					map2.put("productCode", sidsArr[i]);
					map2.put("color", colorcodesArr[i]);
					map2.put("photoPlanSid", "1");
					list2.add(map2);
				}

				String json2 = "";

				while (true) { // 循环条件中直接为TRUE
					try {
						json2 = HttpUtilPcm
								.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
										+ "/productpicture/updatePhotoPlanSid.htm",
										JsonUtil.getJSONString(list2));
					} catch (Exception e) {
						e.printStackTrace();
						json2 = "";
					}
					// 直到符合条件后跳出本循环 否则一直循环下去
					if (StringUtils.isNotEmpty(json2)) {
						JSONObject jsonObject2 = JSONObject.fromObject(json2);
						if ("true".equals(jsonObject2.getString("success"))) {
							Map map0 = new HashMap();
							map0.put("success", true);
							JSONObject json0 = JSONObject.fromObject(map0);
							return json0.toString();
						}
					}
				}
			}
		}
		return json;
	}

	/**
	 * 往上线计划中添加商品
	 * 
	 * @Methods Name editAddProduct
	 * @param shoppeCode
	 * @param shoppeProSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/editAddProduct", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String editAddProduct(HttpServletRequest request,
			HttpServletResponse response, String sids, String on_line_id,
			String on_line_name, String product_names, String modelcodes,
			String colorcodes, String colorcodenames, String brandcodes,
			String brandnames, String categotyscodes, String categotyss,
			String sexsids) {

		// 操作人用户名
		String username = (String) request.getSession()
				.getAttribute("username");

		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";

		String[] sidsArr = (sids.substring(1, sids.length() - 1).replace("\"",
				"")).split(",");
		String[] product_namesArr = (product_names.substring(1,
				product_names.length() - 1).replace("\"", "")).split(",");
		String[] modelcodesArr = (modelcodes.substring(1,
				modelcodes.length() - 1).replace("\"", "")).split(",");
		String[] colorcodesArr = (colorcodes.substring(1,
				colorcodes.length() - 1).replace("\"", "")).split(",");
		String[] colorcodenamesArr = (colorcodenames.substring(1,
				colorcodenames.length() - 1).replace("\"", "")).split(",");
		String[] brandcodesArr = (brandcodes.substring(1,
				brandcodes.length() - 1).replace("\"", "")).split(",");
		String[] brandnamesArr = (brandnames.substring(1,
				brandnames.length() - 1).replace("\"", "")).split(",");
		String[] categotyscodesArr = (categotyscodes.substring(1,
				categotyscodes.length() - 1).replace("\"", "")).split(",");
		String[] categotyssArr = (categotyss.substring(1,
				categotyss.length() - 1).replace("\"", "")).split(",");
		String[] sexsidsArr = (sexsids.substring(1, sexsids.length() - 1)
				.replace("\"", "")).split(",");
		// String[] storeNamesArr = (storeNames.substring(1,
		// storeNames.length() - 1).replace("\"", "")).split(",");
		// String[] storeCodesArr = (storeCodes.substring(1, storeCodes.length()
		// - 1)
		// .replace("\"", "")).split(",");

		List list = new ArrayList();
		for (int i = 0; i < sidsArr.length; i++) {
			Map map1 = new HashMap();
			map1.put("on_line_id", on_line_id);
			map1.put("skucode", sidsArr[i]);
			map1.put("skuname", product_namesArr[i]);
			map1.put("modelcode", modelcodesArr[i]);
			map1.put("colorcode", colorcodesArr[i]);
			map1.put("colorcodename", colorcodenamesArr[i]);
			map1.put("brandcode", brandcodesArr[i]);
			map1.put("brandname", brandnamesArr[i]);
			map1.put("categotyscode", categotyscodesArr[i]);
			map1.put("categotys", categotyssArr[i]);
			map1.put("sexsid", sexsidsArr[i]);// (有脏数据)
			// map1.put("storeName", storeNamesArr[i]);
			// map1.put("storeCode", storeCodesArr[i]);
			map1.put("createmen", username);
			list.add(map1);
		}

		try {
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/insertOnlineGoods.htm",
					JsonUtil.getJSONString(list));
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}

		if (StringUtils.isNotEmpty(json)) {

			JSONObject jsonObject = JSONObject.fromObject(json);
			if ("true".equals(jsonObject.getString("success"))) {
				List list2 = new ArrayList();
				for (int i = 0; i < sidsArr.length; i++) {
					Map map2 = new HashMap();
					map2.put("productCode", sidsArr[i]);
					map2.put("color", colorcodesArr[i]);
					map2.put("photoPlanSid", "1");
					list2.add(map2);
				}

				String json2 = "";
				while (true) { // 循环条件中直接为TRUE
					try {
						json2 = HttpUtilPcm
								.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
										+ "/productpicture/updatePhotoPlanSid.htm",
										JsonUtil.getJSONString(list2));
					} catch (Exception e) {
						e.printStackTrace();
						json2 = "";
					}
					// 直到符合条件后跳出本循环 否则一直循环下去
					if (StringUtils.isNotEmpty(json2)) {
						JSONObject jsonObject2 = JSONObject.fromObject(json2);
						if ("true".equals(jsonObject2.getString("success"))) {
							Map map0 = new HashMap();
							map0.put("success", true);
							JSONObject json0 = JSONObject.fromObject(map0);
							return json0.toString();
						}
					}
				}
			}
		}
		return json;
	}

	/**
	 * 从上线计划中删除商品
	 * 
	 * @Methods Name editDelProduct
	 * @param shoppeCode
	 * @param shoppeProSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/editDelProduct", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String editDelProduct(HttpServletRequest request,
			HttpServletResponse response, String sids, String on_line_id,
			String on_line_name, String product_names, String modelcodes,
			String colorcodes, String colorcodenames, String brandcodes,
			String brandnames, String categotyscodes, String categotyss,
			String sexsids, String goods_ids) {

		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";

		String[] sidsArr = (sids.substring(1, sids.length() - 1).replace("\"",
				"")).split(",");
		String[] product_namesArr = (product_names.substring(1,
				product_names.length() - 1).replace("\"", "")).split(",");
		String[] modelcodesArr = (modelcodes.substring(1,
				modelcodes.length() - 1).replace("\"", "")).split(",");
		String[] colorcodesArr = (colorcodes.substring(1,
				colorcodes.length() - 1).replace("\"", "")).split(",");
		String[] colorcodenamesArr = (colorcodenames.substring(1,
				colorcodenames.length() - 1).replace("\"", "")).split(",");
		String[] brandcodesArr = (brandcodes.substring(1,
				brandcodes.length() - 1).replace("\"", "")).split(",");
		String[] brandnamesArr = (brandnames.substring(1,
				brandnames.length() - 1).replace("\"", "")).split(",");
		String[] categotyscodesArr = (categotyscodes.substring(1,
				categotyscodes.length() - 1).replace("\"", "")).split(",");
		String[] categotyssArr = (categotyss.substring(1,
				categotyss.length() - 1).replace("\"", "")).split(",");
		String[] sexsidsArr = (sexsids.substring(1, sexsids.length() - 1)
				.replace("\"", "")).split(",");
		// String[] storeNamesArr = (storeNames.substring(1,
		// storeNames.length() - 1).replace("\"", "")).split(",");
		// String[] storeCodesArr = (storeCodes.substring(1, storeCodes.length()
		// - 1)
		// .replace("\"", "")).split(",");
		String[] goods_idsArr = (goods_ids.substring(1, goods_ids.length() - 1)
				.replace("\"", "")).split(",");

		List list = new ArrayList();
		for (int i = 0; i < sidsArr.length; i++) {
			Map map1 = new HashMap();
			map1.put("goods_id", goods_idsArr[i]);
			list.add(map1);
		}

		try {
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/deleteOnlineGoods.htm",
					JsonUtil.getJSONString(list));
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}

		if (StringUtils.isNotEmpty(json)) {

			JSONObject jsonObject = JSONObject.fromObject(json);
			if ("true".equals(jsonObject.getString("success"))) {
				List list2 = new ArrayList();
				for (int i = 0; i < sidsArr.length; i++) {
					Map map2 = new HashMap();
					map2.put("productCode", sidsArr[i]);
					map2.put("color", colorcodesArr[i]);
					map2.put("photoPlanSid", "0");
					list2.add(map2);
				}

				String json2 = "";
				while (true) { // 循环条件中直接为TRUE
					try {
						json2 = HttpUtilPcm
								.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
										+ "/productpicture/updatePhotoPlanSid.htm",
										JsonUtil.getJSONString(list2));
					} catch (Exception e) {
						e.printStackTrace();
						json2 = "";
					}
					// 直到符合条件后跳出本循环 否则一直循环下去
					if (StringUtils.isNotEmpty(json2)) {
						JSONObject jsonObject2 = JSONObject.fromObject(json2);
						if ("true".equals(jsonObject2.getString("success"))) {
							Map map0 = new HashMap();
							map0.put("success", true);
							JSONObject json0 = JSONObject.fromObject(map0);
							return json0.toString();
						}
					}
				}
			}
		}
		return json;
	}

	/**
	 * 发布上线计划
	 * 
	 * @Methods Name updateOrganizationZero
	 * @param organizationCode
	 * @param organizationName
	 * @param organizationType
	 * @param organizationStatus
	 * @param storeType
	 * @param shippingPoint
	 * @param createName
	 * @param areaCode
	 * @param updateName
	 * @param parentSid
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/releaseOnlinePlan", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String releaseOnlinePlan(HttpServletRequest request,
			HttpServletResponse response, String on_line_id,
			String photoCenterCode, String photoCenterName) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(on_line_id)) {
				map.put("on_line_id", on_line_id);
			}
			// 操作人用户名
			String username = (String) request.getSession().getAttribute(
					"username");
			if (StringUtils.isNotEmpty(username)) {
				map.put("opt_name", username);
			}
			if (StringUtils.isNotEmpty(photoCenterCode)) {
				map.put("photocenter", photoCenterCode);
			}
			if (StringUtils.isNotEmpty(photoCenterName)) {
				map.put("photocentername", photoCenterName);
			}
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/ReleaseLian.htm", JsonUtil.getJSONString(map));

		} catch (Exception e) {
			e.printStackTrace();
			Map map0 = new HashMap();
			map0.put("success", false);
			JSONObject json0 = JSONObject.fromObject(map0);
			return json0.toString();
		}

		if (StringUtils.isNotEmpty(json)) {

			JSONObject jsonObject = JSONObject.fromObject(json);
			if ("true".equals(jsonObject.getString("success"))) {

				Map map2 = new HashMap();

				// 当前页码
				map2.put("currentPage", 1);
				// 每页数目
				map2.put("pageSize", 10000);
				// 上线计划ID
				map2.put("on_line_id", on_line_id);

				String json2 = "";
				try {
					json2 = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
							+ "/photo/queryOnlinePlanByIDPage.htm",
							JsonUtil.getJSONString(map2));
					map2.clear();
					if (!"".equals(json2)) {
						JSONObject jsonObject2 = JSONObject.fromObject(json2);

						List list2 = new ArrayList();
						List list00 = (List) jsonObject2.get("data");
						for (int i = 0; i < list00.size(); i++) {
							JSONObject jason = JSONObject.fromObject(list00
									.get(i));
							Map map3 = new HashMap();
							map3.put("productCode", jason.get("skucode"));
							map3.put("color", jason.get("colorcode"));
							map3.put("photoPlanSid", "2");
							list2.add(map3);
						}

						String json3 = "";
						while (true) { // 循环条件中直接为TRUE
							try {
								json3 = HttpUtilPcm
										.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
												+ "/productpicture/updatePhotoPlanSid.htm",
												JsonUtil.getJSONString(list2));
							} catch (Exception e) {
								e.printStackTrace();
								json3 = "";
							}
							// 直到符合条件后跳出本循环 否则一直循环下去
							if (StringUtils.isNotEmpty(json3)) {
								JSONObject jsonObject3 = JSONObject
										.fromObject(json3);
								if ("true".equals(jsonObject3
										.getString("success"))) {
									Map map0 = new HashMap();
									map0.put("success", true);
									JSONObject json0 = JSONObject
											.fromObject(map0);
									return json0.toString();
								}
							}
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
					Map map0 = new HashMap();
					map0.put("success", false);
					JSONObject json0 = JSONObject.fromObject(map0);
					return json0.toString();
				}
			}
		}
		return json;

	}

	/**
	 * 删除上线计划
	 * 
	 * @Methods Name updateOrganizationZero
	 * @param organizationCode
	 * @param organizationName
	 * @param organizationType
	 * @param organizationStatus
	 * @param storeType
	 * @param shippingPoint
	 * @param createName
	 * @param areaCode
	 * @param updateName
	 * @param parentSid
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/delOnlinePlan", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String delOnlinePlan(HttpServletRequest request,
			HttpServletResponse response, String on_line_id) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(on_line_id)) {
				map.put("on_line_id", on_line_id);
			}
			// 操作人用户名
			String username = (String) request.getSession().getAttribute(
					"username");
			if (StringUtils.isNotEmpty(username)) {
				map.put("opt_name", username);
			}
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/delectOnlinePlanGoods.htm",
					JsonUtil.getJSONString(map));

		} catch (Exception e) {
			e.printStackTrace();
			Map map0 = new HashMap();
			map0.put("success", false);
			JSONObject json0 = JSONObject.fromObject(map0);
			return json0.toString();
		}

		if (StringUtils.isNotEmpty(json)) {

			JSONObject jsonObject = JSONObject.fromObject(json);
			if ("true".equals(jsonObject.getString("success"))) {

				Map map2 = new HashMap();

				// 当前页码
				map2.put("currentPage", 1);
				// 每页数目
				map2.put("pageSize", 10000);
				// 上线计划ID
				map2.put("on_line_id", on_line_id);

				String json2 = "";
				try {
					json2 = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
							+ "/photo/queryOnlinePlanByIDPage.htm",
							JsonUtil.getJSONString(map2));
					map2.clear();
					if (!"".equals(json2)) {
						JSONObject jsonObject2 = JSONObject.fromObject(json2);

						List list2 = new ArrayList();
						List list00 = (List) jsonObject2.get("data");
						for (int i = 0; i < list00.size(); i++) {
							JSONObject jason = JSONObject.fromObject(list00
									.get(i));
							Map map3 = new HashMap();
							map3.put("productCode", jason.get("skucode"));
							map3.put("color", jason.get("colorcode"));
							map3.put("photoPlanSid", "0");
							list2.add(map3);
						}

						String json3 = "";
						while (true) { // 循环条件中直接为TRUE
							try {
								json3 = HttpUtilPcm
										.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
												+ "/productpicture/updatePhotoPlanSid.htm",
												JsonUtil.getJSONString(list2));
							} catch (Exception e) {
								e.printStackTrace();
								json3 = "";
							}
							// 直到符合条件后跳出本循环 否则一直循环下去
							if (StringUtils.isNotEmpty(json3)) {
								JSONObject jsonObject3 = JSONObject
										.fromObject(json3);
								if ("true".equals(jsonObject3
										.getString("success"))) {
									Map map0 = new HashMap();
									map0.put("success", true);
									JSONObject json0 = JSONObject
											.fromObject(map0);
									return json0.toString();
								}
							}
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
					Map map0 = new HashMap();
					map0.put("success", false);
					JSONObject json0 = JSONObject.fromObject(map0);
					return json0.toString();
				}
			}
		}
		return json;

	}

	/**
	 * 修改上线计划名字
	 * 
	 * @Methods Name updateOrganizationZero
	 * @param organizationCode
	 * @param organizationName
	 * @param organizationType
	 * @param organizationStatus
	 * @param storeType
	 * @param shippingPoint
	 * @param createName
	 * @param areaCode
	 * @param updateName
	 * @param parentSid
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/editOnlinePlanName", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String editOnlinePlanName(HttpServletRequest request,
			HttpServletResponse response, String sid, String organizationName) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(sid)) {
				map.put("on_line_id", sid);
			}
			if (StringUtils.isNotEmpty(organizationName)) {
				map.put("on_line_name", organizationName);
			}
			// 操作人用户名
			String username = (String) request.getSession().getAttribute(
					"username");
			if (StringUtils.isNotEmpty(username)) {
				map.put("opt_name", username);
			}
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/updateOnlinePlan.htm",
					JsonUtil.getJSONString(map));

		} catch (Exception e) {
			e.printStackTrace();
			Map map0 = new HashMap();
			map0.put("success", false);
			JSONObject json0 = JSONObject.fromObject(map0);
			return json0.toString();
		}
		return json;

	}

	/**
	 * 查询拍照中心
	 * 
	 * @Methods Name selectPhotoCenter
	 * @param organizationCode
	 * @param organizationName
	 * @param organizationType
	 * @param organizationStatus
	 * @param storeType
	 * @param shippingPoint
	 * @param createName
	 * @param areaCode
	 * @param updateName
	 * @param parentSid
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectPhotoCenter", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectPhotoCenter(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/getPhotoStore.htm", JsonUtil.getJSONString(map));

		} catch (Exception e) {
			e.printStackTrace();
			Map map0 = new HashMap();
			map0.put("success", false);
			JSONObject json0 = JSONObject.fromObject(map0);
			return json0.toString();
		}
		return json;

	}

	/*
	 * 查询ftp
	 */
	@ResponseBody
	@RequestMapping(value = "/queryFtp", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryFtp(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/queryFtp.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}
		if (StringUtils.isNotEmpty(json)) {
			JSONArray jsonArray = new JSONArray();
			jsonArray = JSONArray.fromObject(json);
			List<FtpConfig> list = JSONArray.toList(jsonArray, FtpConfig.class);
			FtpConfig ftpConfig = list.get(0);
			Map map2 = new HashMap();
			map2.put("success", true);
			map2.put("id", ftpConfig.getId());
			map2.put("ftp_pwd", ftpConfig.getFtp_pwd());
			map2.put("ftp_port", ftpConfig.getFtp_port());
			map2.put("ftp_name", ftpConfig.getFtp_name());
			map2.put("ftp_address", ftpConfig.getFtp_address());
			JSONObject json0 = JSONObject.fromObject(map2);
			return json0.toString();
		} else {
			Map map0 = new HashMap();
			map0.put("success", false);
			JSONObject json0 = JSONObject.fromObject(map0);
			return json0.toString();
		}
	}

	/*
	 * 保存ftp
	 */
	@ResponseBody
	@RequestMapping(value = "/saveFtp", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveFtp(String ftp_name, String ftp_pwd, String ftp_address,
			HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";
		// String[] name = (ftp_name.substring(1, ftp_name.length() -
		// 1).replace("\"",
		// "")).split(",");
		// String[] pwd = (ftp_pwd.substring(1,
		// ftp_pwd.length() - 1).replace("\"", "")).split(",");
		// String[] address = (ftp_address.substring(1,
		// ftp_address.length() - 1).replace("\"", "")).split(",");
		map.put("ftp_name", ftp_name);
		map.put("ftp_pwd", ftp_pwd);
		map.put("ftp_address", ftp_address);
		try {
			//
			System.out.println(JsonUtil.getJSONString(map));
			System.out.println(SystemConfig.PHOTO_SYSTEM_URL);
			json = HttpUtilPcm
					.doPost(SystemConfig.PHOTO_SYSTEM_URL
							+ "/photo/updateandinsert.htm",
							JsonUtil.getJSONString(map));
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}
		return json;
	}

	/*
	 * 查询图片
	 */

	@ResponseBody
	@RequestMapping(value = "/queryPhotoguige", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPhotoguige(HttpServletRequest request,
			HttpServletResponse response, String photoname, String groupSid) {
		Map<String, Object> map = new HashMap<String, Object>();

		
		String pageSize = request.getParameter("pageSize") == null ? "10"
				: ("" + request.getParameter("pageSize"));

		String currentPage = request.getParameter("page") == null ? "1"
				: ("" + request.getParameter("page"));

		// 当前页码
		map.put("currentPage", Integer.parseInt(currentPage));
		// 每页数目
		map.put("pageSize", Integer.parseInt(pageSize));
		
		
		
		if (StringUtils.isNotEmpty(groupSid)) {

			String[] s = groupSid.split("\\*");
			String width = s[0];
			String height = s[1];

			if (StringUtils.isNotEmpty(width)) {
				map.put("width", width);
			}
			if (StringUtils.isNotEmpty(height)) {
				map.put("height", height);
			}

		}
		if (StringUtils.isNotEmpty(photoname)) {
			map.put("photoname", photoname);
		}
		String json = "";
		try {
			json = HttpUtilPcm
					.doPost(SystemConfig.PHOTO_SYSTEM_URL
							+ "/photo/queryPhotoguigePage.htm",
							JsonUtil.getJSONString(map));
			map.clear();

			if (StringUtils.isNotEmpty(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				if (jsonObject != null) {
					map.put("list", jsonObject.get("data"));
					
					if (jsonObject.get("count") == null) {
						map.put("pageCount", 0);
					} else {
						int countInteger = Integer.parseInt(jsonObject.get(
								"count").toString());
						int pageSizeInteger = Integer.parseInt(jsonObject.get(
								"pageSize").toString());
						double c = ((double) countInteger) / pageSizeInteger;
						int d = (int) Math.ceil(c);
						map.put("pageCount", d);
					}
				} else {
					map.put("list", null);
					map.put("pageCount", 0);
				}
			} else {
				map.put("list", null);
				map.put("pageCount", 0);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("pageCount", 0);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		return gson.toJson(map);

	}

	/*
	 * 查询图片规格
	 */

	@ResponseBody
	@RequestMapping(value = "/queryListguige", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryListguige(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/queryListguige.htm", JsonUtil.getJSONString(map));
			JSONObject jsonObject = JSONObject.fromObject(json);
			@SuppressWarnings("unchecked")
			List<Photoguige> list = (List<Photoguige>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				map.put("list", list);
				map.put("success", "true");
			} else {
				map.put("success", "false");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss")
				.create();
		System.out.println(gson.toJson(map));
		return gson.toJson(map);
	}

	/*
	 * 删除图片规格
	 */

	@ResponseBody
	@RequestMapping(value = "/deletePhotoguige", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deletePhotoguige(HttpServletRequest request,
			HttpServletResponse response, String photo_id) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(photo_id)) {
				map.put("photo_id", photo_id);
			}
			String jsonpram = JsonUtil.getJSONString(map);
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/delectPhotoguige.htm", jsonpram);

		} catch (Exception e) {
			e.printStackTrace();
			Map map0 = new HashMap();
			map0.put("success", false);
			JSONObject json0 = JSONObject.fromObject(map0);
			return json0.toString();
		}
		return json;
	}

	/*
	 * 添加图片规格
	 */

	@ResponseBody
	@RequestMapping(value = "/insertPhotoguige", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String insertPhotoguige(int width, int height, String photoname,
			String remark, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";

		map.put("width", width);
		map.put("height", height);
		map.put("photoname", photoname);
		map.put("remark", remark);
		try {
			System.err
					.println("----------------------------------------------");
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/insertPhotoguige.htm",
					JsonUtil.getJSONString(map));
			System.out.println(json);
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}
		return json;
	}

	/*
	 * 修改图片规格
	 */

	@ResponseBody
	@RequestMapping(value = "/updatePhotoguige", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updatePhotoguige(int width, int height, String photoname,
			String remark, String photo_id, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String json = "";
		if (StringUtils.isNotEmpty(photo_id)) {
			map.put("photo_id", photo_id);
		}
		map.put("width", width);
		map.put("height", height);
		map.put("photoname", photoname);
		map.put("remark", remark);
		try {
			System.out.println(SystemConfig.PHOTO_SYSTEM_URL);
			json = HttpUtilPcm.doPost(SystemConfig.PHOTO_SYSTEM_URL
					+ "/photo/updatePhotoguige.htm",
					JsonUtil.getJSONString(map));
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}

		return json;
	}
}
