package com.wangfj.wms.controller.brand;

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
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/shopBrand")
public class ShopBrandController {

	/**
	 * 根据门店查询门店品牌
	 * 
	 * @Methods Name queryShopBrandPage
	 * @Create In 2015-12-16 By chengsj
	 * @param request
	 * @param response
	 * @param shopSid
	 * @param shopCode
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPageShopBrand", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryShopBrandPage(HttpServletRequest request, HttpServletResponse response,
			String shopSid, String shopCode) {

		String pageSize = request.getParameter("pageSize");
		if (StringUtils.isEmpty(pageSize)) {
			pageSize = 10 + "";
		}
		String currentPage = request.getParameter("page");
		if (StringUtils.isEmpty(currentPage)) {
			currentPage = 1 + "";
		}

		Map<String, Object> para = new HashMap<String, Object>();
		para.put("currentPage", Integer.parseInt(currentPage));
		para.put("pageSize", Integer.parseInt(pageSize));
		if (StringUtils.isNotEmpty(shopSid)) {
			para.put("shopSid", shopSid);
		}
		if (StringUtils.isNotEmpty(shopCode)) {
			para.put("shopCode", shopCode);
		}

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmAdminBrand/getPageBrandFromShopBrandRelation.htm",
					JsonUtil.getJSONString(para));
			para.clear();

			if (StringUtils.isNotEmpty(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					para.put("list", jsonPage.get("list"));
					para.put("pageCount", jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
				} else {
					para.put("list", null);
					para.put("pageCount", 0);
				}
			} else {
				para.put("list", null);
				para.put("pageCount", 0);
			}

		} catch (Exception e) {
			para.put("pageCount", 0);
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(para);
	}

}
