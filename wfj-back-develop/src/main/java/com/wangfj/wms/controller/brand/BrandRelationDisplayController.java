package com.wangfj.wms.controller.brand;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileUploadException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.framework.page.Page;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.domain.entity.BrandVO;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/brandRelationDisplay")
public class BrandRelationDisplayController {

	@SuppressWarnings("unused")
	private int maxPostSize = 100 * 1024 * 1024;
	/**
	 * 分页查询集团品牌sid下的所有门店品牌
	 * @Methods Name queryShopBrandPage
	 * @Create In 2015-9-28 By chenhu
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryShopBrandPage", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryShopBrandPage(HttpServletRequest request, HttpServletResponse response,
			String sid) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currPage);
		map.put("pageSize", size);
		map.put("fromSystem", "PCM");
		if (StringUtils.isNotEmpty(sid)) {
			map.put("sid", sid);
		}
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmAdminBrand/findPageBrandByParentSid.htm", JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
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
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}
	/**
	 * 保存品牌关系维护
	 * @Methods Name addBrandRelation
	 * @Create In 2015-9-15 By chenhu
	 * @param request
	 * @param response
	 * @param parentSid
	 * @param select
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/addBrandRelation", method = { RequestMethod.GET, RequestMethod.POST })
	public String addBrandRelation(HttpServletRequest request, HttpServletResponse response,
			String parentSid, String selectR) {
		String json = "";
		try {
			String[] array = selectR.split(",");
			List<Map> listPara = new ArrayList<Map>();
			for (int i = 0; i < array.length; i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				String string = array[i];
				if (null != parentSid && !"".equals(parentSid)) {
					map.put("parentSid", parentSid);
				}
				if (null != string && !"".equals(string)) {
					map.put("sid", string);
				}
				map.put("fromSystem", "PCM");
				listPara.add(map);
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmAdminBrand/addRelationList.htm", JsonUtil.getJSONString(listPara));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 没有集团品牌的门店品牌
	 * 
	 * @Methods Name queryShopBrandNoParent
	 * @Create In 2015-9-15 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryShopBrandNoParent", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryShopBrandNoParent(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
				+ "/pcmAdminBrand/findListBrandWithoutRelation.htm", JsonUtil.getJSONString(null));
		Map<String, Object> m = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(json);
		if (jsonObject.getString("success").equals("false")) {
			m.put("success", "false");
		} else {
			@SuppressWarnings("unchecked")
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

	/**
	 * 根据集团品牌sid查询所有的门店品牌
	 * 
	 * @Methods Name queryShopBrand
	 * @Create In 2015-9-15 By chenhu
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryShopBrand", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryShopBrand(HttpServletRequest request, HttpServletResponse response,
			String sid) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if (null != sid && !"".equals(sid)) {
			map.put("sid", sid);
		}
		json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
				+ "/pcmAdminBrand/findListBrandByParentSid.htm", JsonUtil.getJSONString(map));
		Map<String, Object> m = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(json);
		if (jsonObject.getString("success").equals("false")) {
			m.put("success", "false");
		} else {
			@SuppressWarnings("unchecked")
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

	/**
	 * 查询集团品牌名称
	 * 
	 * @Methods Name queryBrandGroup
	 * @Create In 2015-8-21 By chenhu
	 * @param request
	 * @param response
	 * @param brandType
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryBrandGroup", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryBrandGroup(HttpServletRequest request, HttpServletResponse response,
			String brandType) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("brandType", 0);
		map.put("fromSystem", "PCM");
		json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmAdminBrand/findListBrand.htm",
				JsonUtil.getJSONString(map));
		Map<String, Object> m = new HashMap<String, Object>();
		JSONObject jsonObject = JSONObject.fromObject(json);
		@SuppressWarnings("unchecked")
		List<Object> list = (List<Object>) jsonObject.get("data");
		if (list != null && list.size() != 0) {
			m.put("list", list);
			m.put("success", "true");
		} else {
			m.put("success", "false");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

	/**
	 * 查询品牌关系
	 * 
	 * @Methods Name queryBrandRelation
	 * @Create In 2015-8-18 By chenhu
	 * @param request
	 * @param response
	 * @param brandName
	 * @param brandSid
	 *            2015-9-8 追加新参数门店编码
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryBrandRelation", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryBrandRelation(HttpServletRequest request, HttpServletResponse response,
			String brandName, String brandSid) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currPage);
		map.put("pageSize", size);
		map.put("fromSystem", "PCM");
		if (null != brandName && !"".equals(brandName)) {
			map.put("brandName", brandName);
		}
		if (null != brandSid && !"".equals(brandSid)) {
			map.put("brandSid", brandSid);
		}
		// 参数的问题
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmAdminBrand/findPageBrandAndBrandGroup.htm", JsonUtil.getJSONString(map));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
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
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 修改门店品牌和集团品牌的关系
	 * 
	 * @Methods Name modifyBrandRelation
	 * @Create In 2015-8-19 By chenhu
	 * @param request
	 * @param response
	 * @param parentSid
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/modifyBrandRelation", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String modifyBrandRelation(HttpServletRequest request, HttpServletResponse response,
			String parentSid, String sid) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("fromSystem", "PCM");
			if (null != sid && !"".equals(sid)) {
				map.put("sid", sid);
			}
			if (null != parentSid && !"".equals(parentSid)) {
				map.put("parentSid", parentSid);
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmAdminBrand/updateRelation.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 删除关系
	 * 
	 * @Methods Name deleteRelationBrand
	 * @Create In 2015-8-19 By chenhu
	 * @param sid
	 * @return String
	 */

	@ResponseBody
	@RequestMapping(value = "/deleteRelationBrand", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteRelationBrand(String sid) {
		String result = "";
		try {
			Map<String, String> map = new HashMap<String, String>();
			if (null != sid || !"".equals(sid)) {
				map.put("sid", sid);
			}
			result = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmAdminBrand/deleteRelation.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			result = "{success :false}";
		}
		if (null == result || "".equals(result)) {
			result = "{success: false}";
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/selectAllBrandRelation", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryAllBrandRelation(HttpServletRequest request, HttpServletResponse response,
			BrandVO brandVO) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		// Integer size = 10;
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		int start = (currPage - 1) * size;
		try {
			Map map = new HashMap();
			map.put("start", start);
			map.put("limit", size);
			if (null != brandVO.getBrandName() || "".equals(brandVO.getBrandName())) {
				map.put("brandName", brandVO.getBrandName());
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllBrandRelation.html",
					map);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/selectBrandRoot", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryBrandRoot(String brandName, Page page) {
		String json = "";
		try {
			Map map = new HashMap();
			if (null != brandName || "".equals(brandName)) {
				map.put("brandName", brandName);
			}
			map.put("Page_", page);
			map.put("start", page.getStartRecords());
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryBrandRoot.html", map);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteBrandRelation", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteBrand(String sid, String brandSid) {
		String result = "";
		String s_ = "";
		try {
			Map map = new HashMap();
			if (null != sid || !"".equals(sid)) {
				map.put("sid", sid);
			}
			if (null != brandSid || !"".equals(brandSid)) {
				map.put("brandSid", brandSid);
			}
			result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/deleteBrandRelation.html",
					map);
		} catch (Exception e) {
			result = "{success :false}";
		}
		if (null == result || "".equals(result)) {
			result = "{success: false}";
		}
		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/updataBrandRelation", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateBrand(Model model, HttpServletRequest request,
			HttpServletResponse response, String sid, String sid1) throws FileUploadException,
			UnsupportedEncodingException {
		String result = "";
		try {
			Map map = new HashMap();
			if (null != sid || !"".equals(sid)) {
				map.put("sid", sid);
			}
			if (null != sid1 || !"".equals(sid1)) {
				map.put("sid1", sid1);
			}
			result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/updateBrandRelation.html",
					map);
		} catch (Exception e) {
			result = "{success :false}";
		}
		return result;
	}
}
