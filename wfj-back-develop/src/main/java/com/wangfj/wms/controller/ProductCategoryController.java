package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.wangfj.order.utils.HttpUtil;

/**
 * 商品品类控制器
 * 
 * @Class Name ProductCategoryController
 * @Author wangsy
 * @Create In 2015年8月7日
 */
@Controller
@RequestMapping(value = "/productCategory")
public class ProductCategoryController {

	/**
	 * 查询所有
	 * 
	 * @Methods Name queryAllProductCategory
	 * @Create In 2015年8月7日 By wangsy
	 * @param request
	 * @param response
	 * @param productSku
	 * @param productName
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectAllProductCategory", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryAllProductCategory(HttpServletRequest request, HttpServletResponse response,
			String productSku, String productName) {
		String json = null;
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		int start = (currPage - 1) * size;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("limit", size);
		if (null != productSku && !"".equals(productSku)) {
			map.put("productSku", productSku);
		}
		if (null != productName && !"".equals(productName)) {
			map.put("productName", productName);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/productcategorycontroller/bw/queryAllProductCategory.htm", map);
			if ("".equals(json)) {
				map.clear();
				map.put("list", "");
				map.put("pageCount", 0);
				Gson gson = new Gson();
				json = gson.toJson(map);
			}
		} catch (Exception e) {
			json = "{'success':false}";
		} finally {
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveProductCategory(String productSid, String categorySid) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (null != productSid || "".equals(productSid)) {
				map.put("productSid", productSid);
			}
			if (null != categorySid || "".equals(categorySid)) {
				map.put("categorySid", categorySid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/productcategorycontroller/bw/saveProductCategory.htm",
					map);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/edit", method = { RequestMethod.GET, RequestMethod.POST })
	public String hide(String pid) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (null != pid || "".equals(pid)) {
				map.put("pid", pid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/productcategorycontroller/bw/ProductCategoryEdit.htm", map);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 
	 * @Methods Name liste
	 * @Create In 2015年8月7日 By wangsy
	 * @param productSid
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/liste", method = { RequestMethod.GET, RequestMethod.POST })
	public String liste(String productSid, String id) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (null != productSid || "".equals(productSid)) {
				map.put("productSid", productSid);
			}
			if (null != id || "".equals(id)) {
				map.put("id", id);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/productcategorycontroller/bw/ProductCategoryListe.htm", map);
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

}
