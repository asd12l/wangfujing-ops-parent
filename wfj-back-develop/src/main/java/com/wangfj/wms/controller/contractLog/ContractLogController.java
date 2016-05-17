package com.wangfj.wms.controller.contractLog;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/contractLog")
public class ContractLogController {

	/**
	 * 查询要约的部分信息
	 * 
	 * @Methods Name findContractLogList
	 * @Create In 2015-12-8 By wangxuan
	 * @param request
	 * @param response
	 * @param storeCode
	 * @param supplyCode
	 * @param manageType
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = { "/findContractLogList" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryBrandGroupList(HttpServletRequest request, HttpServletResponse response,
			String storeCode, String supplyCode, String manageType) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isNotEmpty(storeCode)) {
			map.put("storeCode", storeCode.trim());
		}
		if (StringUtils.isNotEmpty(supplyCode)) {
			map.put("supplyCode", supplyCode.trim());
		}
		if (StringUtils.isNotEmpty(manageType)) {
			map.put("manageType", manageType.trim());
		}
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/contractLog/findContractLogList.htm", JsonUtil.getJSONString(map));
			map.clear();
			JSONObject jsonObject = JSONObject.fromObject(json);

			List<?> list = (List<?>) jsonObject.get("data");
			if ((list != null) && (list.size() != 0)) {
				map.put("list", list);
				map.put("success", "true");
			} else {
				map.put("success", "false");
			}
		} catch (Exception e) {
			map.put("success", "false");
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 分页查询要约信息
	 * 
	 * @param request
	 * @param sid
	 * @param contractCode
	 * @param storeCode
	 * @param supplyCode
	 * @param manageType
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = { "/findPageContract" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findPageContract(HttpServletRequest request, String sid, String contractCode,
			String storeCode, String supplyCode, String manageType) {
		Integer size = request.getParameter("pageSize") == null ? null : Integer.valueOf(Integer
				.parseInt(request.getParameter("pageSize")));
		Integer currPage = request.getParameter("page") == null ? null : Integer.valueOf(Integer
				.parseInt(request.getParameter("page")));
		Map<String, Object> map = new HashMap<String, Object>();
		if ((size == null) || (size.intValue() == 0)) {
			size = Integer.valueOf(10);
		}
		if (currPage != null) {
			map.put("currentPage", currPage);
			map.put("pageSize", size);
		}
		if (StringUtils.isNotEmpty(sid)) {
			map.put("sid", Long.parseLong(sid.trim()));
		}
		if (StringUtils.isNotEmpty(contractCode)) {
			map.put("contractCode", contractCode.trim());
		}
		if (StringUtils.isNotEmpty(storeCode)) {
			map.put("storeCode", storeCode.trim());
		}
		if (StringUtils.isNotEmpty(supplyCode)) {
			map.put("supplyCode", supplyCode.trim());
		}
		if (StringUtils.isNotEmpty(manageType)) {
			map.put("manageType", manageType.trim());
		}

		try {
			String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/contractLog/findPageContract.htm", JsonUtil.getJSONString(map));
			map.clear();
			if (StringUtils.isNotEmpty(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
				} else {
					map.put("list", null);
					map.put("pageCount", Integer.valueOf(0));
				}
			} else {
				map.put("list", null);
				map.put("pageCount", Integer.valueOf(0));
			}
		} catch (Exception e) {
			map.put("pageCount", Integer.valueOf(0));
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

}
