package com.wangfj.cms.floor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.cms.utils.CdnHelper;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.domain.entity.SsdProduct;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;

import common.Logger;

@RequestMapping(value = "/web")
@Controller
public class FloorWeb {
	private Logger logger = Logger.getLogger(FloorWeb.class);

	private String className = FloorWeb.class.getName();
	
	private static String[] imgServers;

	static {
		imgServers = SystemConfig.CMS_IMAGE_SERVERS.split("###");
	}
	
	private String getImageServer() {
		if (imgServers.length < 1) {
			return "http://img.wangfujing.com/";
		}
		int length = imgServers.length;
		// 生成0到length-1的随机数
		int random = (int) Math.floor(Math.random() * length);
		return imgServers[random];
	}
	
	/**
	 * 频道树
	 * 
	 * @Methods Name getAllResources
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllLimitResources", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllResources(HttpServletRequest request, HttpServletResponse response,String id) {
		String methodName = "getAllResources";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
		if("0".equals(id)){
			resultMap.put("id", id);
		}else{
			resultMap.put("id", -1);
		}
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
					"/floor/getAllLimitResourcesNew.do", resultMap);
			JSONObject obj = JSONObject.fromObject(json);
			if (obj.get("success").equals("true")) {
				if(obj.getString("list").equals("[]")){
					//StringBuffer sb = new StringBuffer();
					//sb.append("[{'id':0,'name':'右键创建频道','siteId':").append(request.getParameter("_site_id_param")).append(",'isShow':1,'type':0,'hasContent':0,'open':true,'iconSkin': 'house'}]");
					//json = sb.toString();
					JSONArray ja = new JSONArray();
					JSONObject jo = new JSONObject();
					jo.put("id", 0);
					jo.put("name", "右键创建频道");
					jo.put("siteId", request.getParameter("_site_id_param"));
					jo.put("isShow", 1);
					jo.put("type", 0);
					jo.put("hasContent", 0);
					jo.put("open", true);
					jo.put("iconSkin", "house");
					ja.add(jo);
					return ja.toString();
				}else{
					json = obj.getString("list");
				}
			} else {
				JSONArray ja = new JSONArray();
				JSONObject jo = new JSONObject();
				jo.put("id", 0);
				jo.put("name", "右键创建频道");
				jo.put("siteId", request.getParameter("_site_id_param"));
				jo.put("isShow", 1);
				jo.put("type", 0);
				jo.put("hasContent", 0);
				jo.put("open", true);
				jo.put("iconSkin", "house");
				ja.add(jo);
				return ja.toString();
				
			}
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json.toString();
	}

	/**
	 * 商品模块-商品信息管理-商品管理-查询所有商品(已暂停使用,改从admin调接口)
	 * 
	 * @Methods Name selectAllProduct
	 * @Create In 2015-4-17 By wangsy
	 * @param request
	 * @param response
	 * @param ssdProduct
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectAllProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryProducts(HttpServletRequest request, SsdProduct ssdProduct, String proSids,
			HttpServletResponse response) {
		String methodName = "queryProducts";
		String json = "";
		ssdProduct.setSkuSale("1");

		String channelCode = request.getParameter("channelCode");
		String shopCode = request.getParameter("shopCode");
		String shoppeCode = request.getParameter("shoppeCode");
		String cateZSCode = request.getParameter("cateZSCode");
		String cateZSName = request.getParameter("cateZSName");
		Map<String, Object> proMap = new HashMap<String, Object>();

		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}

		proMap.put("pageSize", size);// 每页显示数量
		proMap.put("page", currPage);// 当前第几页
		if (null != channelCode && !"".equals(channelCode)) {
			proMap.put("channelSid", channelCode);
		}
		if (null != shopCode && !"".equals(shopCode)) {
			proMap.put("storeCode", shopCode);
		}
		if (null != shoppeCode && !"".equals(shoppeCode)) {
			proMap.put("counterName", shoppeCode);
		}
		if (null != cateZSCode && !"".equals(cateZSCode)) {
			proMap.put("cateZSCode", cateZSCode);
		}
		if (null != cateZSName && !"".equals(cateZSName)) {
			proMap.put("cateZSName", cateZSName);
		}
		if (null != ssdProduct.getProSelling() && !"".equals(ssdProduct.getProSelling())) {
			proMap.put("proSelling", ssdProduct.getProSelling());
		}
		if (null != ssdProduct.getSkuName() && !"".equals(ssdProduct.getSkuName())) {
			proMap.put("skuName", ssdProduct.getSkuName());
		}
		if (null != ssdProduct.getSpuName() && !"".equals(ssdProduct.getSpuName())) {
			proMap.put("spuName", ssdProduct.getSpuName());
		}
		if (null != ssdProduct.getSkuCode() && !"".equals(ssdProduct.getSkuCode())) {
			proMap.put("skuCode", ssdProduct.getSkuCode());
		}
		if (null != ssdProduct.getSpuCode() && !"".equals(ssdProduct.getSpuCode())) {
			proMap.put("spuCode", ssdProduct.getSpuCode());
		}
		if (null != ssdProduct.getSpuSid() && !"".equals(ssdProduct.getSpuSid())) {
			proMap.put("spuSid", ssdProduct.getSpuSid());
		}
		if (null != ssdProduct.getProType() && !"".equals(ssdProduct.getProType())) {
			proMap.put("proType", ssdProduct.getProType());
		}
		if (null != ssdProduct.getBrandGroupCode() && !"".equals(ssdProduct.getBrandGroupCode())) {
			proMap.put("brandGroupCode", ssdProduct.getBrandGroupCode());
		}
		if (null != ssdProduct.getModelCode() && !"".equals(ssdProduct.getModelCode())) {
			proMap.put("modelCode", ssdProduct.getModelCode());
		}
		if (null != ssdProduct.getColorSid() && !"".equals(ssdProduct.getColorSid())) {
			proMap.put("colorSid", ssdProduct.getColorSid());
		}
		if (null != ssdProduct.getPhotoStatus() && !"".equals(ssdProduct.getPhotoStatus())) {
			proMap.put("photoStatus", ssdProduct.getPhotoStatus());
		}
		if (null != ssdProduct.getSkuSale() && !"".equals(ssdProduct.getSkuSale())) {
			proMap.put("skuSale", ssdProduct.getSkuSale());
		}
		if (null != ssdProduct.getProActiveBit() && !"".equals(ssdProduct.getProActiveBit())) {
			proMap.put("proActiveBit", ssdProduct.getProActiveBit());
		}
		proMap.put("proSids", proSids);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floorPro/selectAllProduct.do",
					proMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 频道下模板列表
	 * 
	 * @Methods Name queryTemplate
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryTemplate", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryTemplate(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "queryDirectiveList";
		String json = "";
		String channelSid = request.getParameter("channelSid");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("channelSid", channelSid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/channel/load_template.do",
					resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 楼层列表(停止使用)
	 * 
	 * @Methods Name queryPageLayout
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPageLayout", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryPageLayout(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "queryPageLayout";
		String json = "";
		String channelSid = request.getParameter("channelSid");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("channelSid", channelSid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/f_list.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 加载楼层信息
	 * 
	 * @Methods Name queryFloorDiv
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryFloorDiv", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryFloorDiv(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "queryFloorDiv";
		String json = "";
		String sid = request.getParameter("sid");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("channelSid", sid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/f_load.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 修改模板生效状态(停止使用)
	 * 
	 * @Methods Name modifyType
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/modifyType", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyType(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "modifyType";
		String json = "";
		String channelSid = request.getParameter("channelSid");
		String tplName = request.getParameter("tplName");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("channelSid", channelSid);
		resultMap.put("tplName", tplName);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/f_modifyType.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 楼层树
	 * 
	 * @Methods Name getAllFloorResources
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllFloorResources", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllFloorResources(HttpServletRequest request, HttpServletResponse response,
			String id) {
		String methodName = "getAllFloorResources";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String sid = request.getParameter("sid");
		resultMap.put("sid", sid);
		if (!StringUtils.isEmpty(id)) {
			resultMap.put("id", id);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/getFloorTreeNew.do",
					resultMap);
			JSONObject obj = JSONObject.fromObject(json);
			if (obj.get("success").equals("true")) {
				json = obj.getString("list");
			} else {
				json = "[{'id':0,'name':'根节点','pId':-1,'isShow':1,'type':0,'floorContent':1}]";
			}
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json.toString();
	}

	/**
	 * 楼层列表
	 * 
	 * @Methods Name queryFloor
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryFloorList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryFloor(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "queryFloor";
		String json = "";
		String id = request.getParameter("channelSid");
		String rootId = request.getParameter("rootId");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", id);
		resultMap.put("rootId", rootId);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/floorList.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 修改块/楼层
	 * 
	 * @Methods Name modifyDiv
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @param divSid
	 * @param seq
	 * @param channelLink
	 * @param title
	 * @param enTitle
	 * @param styleList
	 * @param type
	 * @param flag
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/modifyFloorDiv", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyDiv(HttpServletRequest request, HttpServletResponse response,
			String divSid, String seq, String channelLink, String title, String enTitle,
			String styleList, String type, String flag) {
		String methodName = "modifyDiv";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("sid", divSid);
		resultMap.put("title", title);
		if (enTitle != null && !enTitle.equals("")) {
			resultMap.put("enTitle", enTitle);
		}
		if (channelLink != null && !channelLink.equals("")) {
			resultMap.put("channelLink", channelLink);
		}
		if (styleList != null && !styleList.equals("")) {
			resultMap.put("styleList", styleList);
		}
		if (type != null && !type.equals("")) {
			resultMap.put("type", type);
		}
		if (seq != null && !seq.equals("")) {
			resultMap.put("seq", seq);
		}
		if (flag != null && !flag.equals("")) {
			resultMap.put("flag", flag);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/f_modifyfloor.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 新建楼层读取style_list列表
	 * 
	 * @Methods Name queryStyleList
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryFloorStyleList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryStyleList(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "queryStyleList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("path", "/style_list/");
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/ftp_style_list.do",
					resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 添加块/块组
	 * 
	 * @Methods Name addDiv
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @param enTitle
	 * @param pageLayoutSid
	 * @param type
	 * @param seq
	 * @param styleList
	 * @param flag
	 * @param channelLink
	 * @param divtype
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addFloorDiv", method = { RequestMethod.GET, RequestMethod.POST })
	public String addDiv(
			HttpServletRequest request,
			HttpServletResponse response, // String
											// channelSid,
			String enTitle, String pageLayoutSid, String type, String seq, String styleList,
			String flag, String channelLink, String divtype) {
		String methodName = "addDiv";
		String json = "";
		String channelSid = request.getParameter("channelSid");
		String title = request.getParameter("title");
		if (pageLayoutSid == "" || pageLayoutSid == null) {
			pageLayoutSid = "0";
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("channelSid", channelSid);
		if (styleList != null) {
			resultMap.put("styleList", styleList);
		}
		if (channelLink != null && !channelLink.equals("")) {
			resultMap.put("channelLink", channelLink);
		}
		if (enTitle != null && !enTitle.equals("")) {
			resultMap.put("enTitle", enTitle);
		}
		if (divtype != null && "0".equals(divtype)) {
			type = "0";
		}
		if (type != null) {
			resultMap.put("type", type);
		}
		resultMap.put("pageLayoutSid", pageLayoutSid);
		resultMap.put("title", title);
		if (seq != null) {
			resultMap.put("seq", seq);
		}
		if (flag != null) {
			resultMap.put("flag", flag);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/f_save.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 删除块/块组
	 * 
	 * @Methods Name delDiv
	 * @Create In 2016年3月29日 By wangsy
	 * @param sid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/delDiv", method = { RequestMethod.GET, RequestMethod.POST })
	public String delDiv(String sid, HttpServletRequest request, HttpServletResponse response) {
		String methodName = "delDiv";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("pageLayoutSid", sid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/f_del.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 块下商品列表
	 * 
	 * @Methods Name productList
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @param pageLayoutSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/productList", method = { RequestMethod.GET, RequestMethod.POST })
	public String productList(HttpServletRequest request, HttpServletResponse response,
			String pageLayoutSid) {
		String methodName = "productList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", pageLayoutSid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floor/f_divlist.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 查询商品列表(停止使用)
	 * 
	 * @Methods Name queryProductList
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addProductList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryProductList(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "queryProductList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floorPro/fp_search.do",
					resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 条件查询商品列表
	 * 
	 * @Methods Name findProductByPrame
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryProductByPrame", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findProductByPrame(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "methodName";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("proSku", request.getParameter("proSku"));
		resultMap.put("brandName", request.getParameter("brandName"));
		resultMap.put("product_name", request.getParameter("product_name"));
		resultMap.put("offMin", request.getParameter("offMin"));
		resultMap.put("offMax", request.getParameter("offMax"));
		resultMap.put("stockMin", request.getParameter("stockMin"));
		resultMap.put("stockMax", request.getParameter("stockMax"));
		resultMap.put("priceMin", request.getParameter("priceMin"));
		resultMap.put("priceMax", request.getParameter("priceMax"));
		resultMap.put("productClassSid", request.getParameter("productClassSid"));
		resultMap.put("shopName", request.getParameter("shopName"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floorPro/fp_search.do",
					resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 添加块下商品列表(把商品信息存至我们自己的数据库中)
	 * 
	 * @Methods Name addProductList
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public String addProductList(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "addProductList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("ids", request.getParameter("ids"));
		resultMap.put("name", request.getParameter("name"));
		resultMap.put("prices", request.getParameter("prices"));
		resultMap.put("picts", request.getParameter("picts"));
		resultMap.put("id", request.getParameter("pageLayoutSid"));

		resultMap.put("brandNames", request.getParameter("brandNames"));
		// resultMap.put("smallPicts", request.getParameter("smallPicts"));
		// resultMap.put("oldPrices", request.getParameter("oldPrices"));
		try {
			json = HttpUtil
					.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floorPro/fp_save.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 删除块下商品
	 * 
	 * @Methods Name delProduct
	 * @Create In 2016年3月29日 By wangsy
	 * @param sid
	 * @param pageLayoutSid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/delProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public String delProduct(String sid, String pageLayoutSid, HttpServletRequest request,
			HttpServletResponse response) {
		String methodName = "delProduct";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("sid", sid);
		resultMap.put("pageLayoutSid", pageLayoutSid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/floorPro/fp_delete.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 查询块下品牌列表
	 * 
	 * @Methods Name brandList
	 * @Create In 2016年3月29日 By wangsy
	 * @param pageLayoutSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/brandList", method = { RequestMethod.GET, RequestMethod.POST })
	public String brandList(String pageLayoutSid) {
		String json = "";
		String methodName = "brandList";
		if (pageLayoutSid == null) {
			json = "{'success':'false','msg':'参数传递为空'}";
			return json;
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", pageLayoutSid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/fbrand/fb_list.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 品牌列表(可条件分页查询)
	 * 
	 * @Methods Name addBrandList
	 * @Create In 2016年3月29日 By wangsy
	 * @param brandName
	 * @param brandSid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addBrandList", method = { RequestMethod.GET, RequestMethod.POST })
	public String addBrandList(String brandName, String brandSid, HttpServletRequest request,
			HttpServletResponse response, String brandSids) {
		String methodName = "addBrandList";
		String json = "";
		if (brandName == null) {
			brandName = "";
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		if (brandName != null && !brandName.equals("")) {
			resultMap.put("brandName", brandName);
		}
		if (brandSid != null && !brandSid.equals("")) {
			resultMap.put("brandSid", brandSid);
		}
		resultMap.put("brandSids", brandSids);
		resultMap.put("pageSize", size);// 每页显示数量
		resultMap.put("currPage", currPage);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/fbrand/fb_query.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 添加块下品牌
	 * 
	 * @Methods Name addBrandList
	 * @Create In 2016年3月29日 By wangsy
	 * @param ids
	 * @param pageLayoutSid
	 * @param brandLinks
	 * @param picts
	 * @param names
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addBrand", method = { RequestMethod.GET, RequestMethod.POST })
	public String addBrandList(String ids, String pageLayoutSid, String brandLinks, String picts,
			String names, HttpServletRequest request, HttpServletResponse response) {
		String methodName = "addBrandList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("ids", ids);
		resultMap.put("id", pageLayoutSid);
		resultMap.put("picts", picts);
		resultMap.put("names", names);
		resultMap.put("brandLinks", brandLinks);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/fbrand/fb_save.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 删除块下品牌
	 * 
	 * @Methods Name delBrand
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/delBrand", method = { RequestMethod.GET, RequestMethod.POST })
	public String delBrand(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "delBrand";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("sid", request.getParameter("sid"));
		resultMap.put("pageLayoutSid", request.getParameter("pageLayoutSid"));
		try {
			json = HttpUtil
					.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/fbrand/fb_delete.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 查询块下引导链接列表
	 * 
	 * @Methods Name queryLinkList
	 * @Create In 2016年3月29日 By wangsy
	 * @param pageLayoutSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/linkList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryLinkList(String pageLayoutSid) {
		String json = "";
		String methodName = "queryLinkList";
		if (pageLayoutSid == null) {
			json = "{'success':'false','msg':'参数传递为空'}";
			return json;
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("pageLayoutSid", pageLayoutSid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/fnav/fn_qlist.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		JSONObject result = JSONObject.fromObject(json);
		JSONArray listJson = (JSONArray) result.get("list");
		for(int i=0; i<listJson.size(); i++){
			JSONObject object = (JSONObject) listJson.get(i);
			if(object.containsKey("pict")){
				String pict = object.getString("pict");
				if(StringUtils.isNotEmpty(pict)) {
					object.put("pict",  getImageServer() + pict);
				}
			}
			if(object.containsKey("subTitle")){
				String subTitle = object.getString("subTitle");
				if(StringUtils.isNotEmpty(subTitle)) {
					object.put("subTitle", getImageServer() + subTitle);
				}
			}
		}
		return result.toString();
	}

	/**
	 * 添加引导链接
	 * 
	 * @Methods Name addLink
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @param seq
	 * @param pageLayoutSid
	 * @param mainTitle
	 * @param subTitle
	 * @param pict
	 * @param flag
	 * @param link
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addLink", method = { RequestMethod.GET, RequestMethod.POST })
	public String addLink(HttpServletRequest request, HttpServletResponse response, String seq,
			String pageLayoutSid, String mainTitle, String subTitle, String pict, String flag,
			String link) {
		String methodName = "addLink";
		String json = "";

		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("pageLayoutSid", pageLayoutSid);
		resultMap.put("mainTitle", mainTitle);
		resultMap.put("subTitle", subTitle);
		resultMap.put("pict", pict);
		resultMap.put("link", link);
		if (seq != null) {
			resultMap.put("seq", seq);
		}
		if (flag != null) {
			resultMap.put("flag", flag);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/fnav/fn_save.do", resultMap);
			JSONObject js = JSONObject.fromObject(json);
			if (js.get("success").equals("true")) {
				boolean b = false;
				if (StringUtils.isNotBlank(pict)) {
					String pictPath = pict.substring(0, pict.lastIndexOf("/") + 1);
					b = CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { pictPath });
					if (!b) {
						logger.error("CDN刷新引导链接图片失败: " + pict);
					}
				}
				if (StringUtils.isNotBlank(link)) {
					String linktPath = pict.substring(0, pict.lastIndexOf("/") + 1);
					b = CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { linktPath });
					if (!b) {
						logger.error("CDN刷新引导链接地址失败: " + link);
					}
				}
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 修改引导链接
	 * 
	 * @Methods Name modifyLink
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @param seq
	 * @param pageLayoutSid
	 * @param sid
	 * @param mainTitle
	 * @param subTitle
	 * @param flag
	 * @param pict
	 * @param link
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/modifyLink", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyLink(HttpServletRequest request, HttpServletResponse response, String seq,
			String pageLayoutSid, String sid, String mainTitle, String subTitle, String flag,
			String pict, String link) {
		String methodName = "modifyLink";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("sid", sid);
		resultMap.put("mainTitle", mainTitle);
		resultMap.put("subTitle", subTitle);
		resultMap.put("pict", pict);
		resultMap.put("link", link);
		if (seq != null) {
			resultMap.put("seq", seq);
		}
		if (flag != null) {
			resultMap.put("flag", flag);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/fnav/fn_update.do", resultMap);
			JSONObject js = JSONObject.fromObject(json);
			if (js.get("success").equals("true")) {
				boolean b = false;
				if (StringUtils.isNotBlank(pict)) {
					String pictPath = pict.substring(0, pict.lastIndexOf("/") + 1);
					b = CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { pictPath });
					if (!b) {
						logger.error("CDN刷新引导链接图片失败: " + pict);
					}
				}
				if (StringUtils.isNotBlank(link)) {
					String linktPath = pict.substring(0, pict.lastIndexOf("/") + 1);
					b = CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { linktPath });
					if (!b) {
						logger.error("CDN刷新引导链接地址失败: " + link);
					}
				}
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 删除楼层下引导链接
	 * 
	 * @Methods Name delLink
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/delLink", method = { RequestMethod.GET, RequestMethod.POST })
	public String delLink(HttpServletRequest request, HttpServletResponse response, String sid) {
		String methodName = "delLink";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("ids", sid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/fnav/fn_delete.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 获取渠道下所有门店
	 * 
	 * @Methods Name getShopCode
	 * @Create In 2015年12月30日 By chengsj
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getShopCode", method = { RequestMethod.GET, RequestMethod.POST })
	public String getShopCode(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "getShopCode";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("queryFlag", 1);
		resultMap.put("channelCode", request.getParameter("channelCode"));
		try {
			json = HttpUtilPcm
					.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
							+ "/cmsChannelShopShoppe/getInfoByParam.htm",
							JsonUtil.getJSONString(resultMap));
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 获取门店下所有专柜
	 * 
	 * @Methods Name getShopCode
	 * @Create In 2015年12月30日 By chengsj
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getShoppeCode", method = { RequestMethod.GET, RequestMethod.POST })
	public String getShoppeCode(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "getShoppeCode";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("queryFlag", 2);
		resultMap.put("shopCode", request.getParameter("shopCode"));
		try {
			json = HttpUtilPcm
					.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
							+ "/cmsChannelShopShoppe/getInfoByParam.htm",
							JsonUtil.getJSONString(resultMap));
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}
}
