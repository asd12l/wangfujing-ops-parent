package com.wangfj.wms.controller.organization;

import java.util.HashMap;
import java.util.List;
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
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * 组织机构控制器
 * 
 * @Class Name OrganizationController
 * @Author wangsy
 * @Create In 2015年8月6日
 */
@Controller
@RequestMapping(value = "/organization")
public class OrganizationController {

	/**
	 * 查询组织机构（集团 大区 城市 门店）
	 * 
	 * @Methods Name queryOrganization
	 * @Create In 2015-8-11 By chenhu
	 * @param request
	 * @param response
	 * @param organizationType
	 * @param shopType
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryOrganizationZero", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryOrganizationZero(HttpServletRequest request, HttpServletResponse response,
			String groupSid, String organizationType, String organizationName,
			String organizationCode, String storeType) {

		Map<String, Object> map = new HashMap<String, Object>();

		Integer pageSize = request.getParameter("pageSize") == null ? 10 : Integer.parseInt(request
				.getParameter("pageSize"));

		Integer currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request
				.getParameter("page"));

		map.put("currentPage", currentPage);
		map.put("pageSize", pageSize);

		if (StringUtils.isNotEmpty(groupSid)) {
			map.put("groupSid", Long.parseLong(groupSid.trim()));
		}
		if (StringUtils.isNotEmpty(organizationType)) {
			map.put("organizationType", Integer.parseInt(organizationType.trim()));
		}
		if (StringUtils.isNotEmpty(organizationName)) {
			map.put("organizationName", organizationName);
		}
		if (StringUtils.isNotEmpty(storeType)) {
			map.put("storeType", Integer.parseInt(storeType.trim()));
		}
		if (StringUtils.isNotEmpty(organizationCode)) {
			map.put("organizationCode", organizationCode);
		}

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/organization/findPageOrganization.htm", JsonUtil.getJSONString(map));
			map.clear();
			if (StringUtils.isNotEmpty(json)) {
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
			map.put("list", null);
			map.put("pageCount", 0);
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 修改组织机构（集团 大区 城市 门店）
	 * 
	 * @Methods Name updateOrganizationZero
	 * @Create In 2015-8-21 By chenhu
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
	@RequestMapping(value = "/updateOrganizationZero", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateOrganizationZero(String groupSid, String organizationCode,
			String organizationName, String organizationType, String organizationStatus,
			String storeType, String shippingPoint, String createName, String areaCode,
			String updateName, String parentSid, String sid,
			String registeredAddress, String postCode, String legalRepresentative, 
			String agent, String taxRegistrationNumber, String bank, String bankAccount, 
			String telephoneNumber, String faxNumber) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(sid)) {
				map.put("sid", Long.parseLong(sid));
			}
			if (StringUtils.isNotEmpty(parentSid)) {
				map.put("parentSid", parentSid);
			}
			if (StringUtils.isNotEmpty(groupSid)) {
				map.put("groupSid", Long.parseLong(groupSid));
			}
			if (StringUtils.isNotEmpty(organizationCode)) {
				map.put("organizationCode", organizationCode);
			}
			if (StringUtils.isNotEmpty(organizationName)) {
				map.put("organizationName", organizationName);
			}
			if (StringUtils.isNotEmpty(organizationType)) {
				map.put("organizationType", organizationType);
			}
			if (StringUtils.isNotEmpty(organizationStatus)) {
				map.put("organizationStatus", organizationStatus);
			}
			if (StringUtils.isNotEmpty(storeType)) {
				map.put("storeType", storeType);
			}
			if (StringUtils.isNotEmpty(shippingPoint)) {
				map.put("shippingPoint", shippingPoint);
			}
			if (StringUtils.isNotEmpty(createName)) {
				map.put("createName", createName);
			}
			if (StringUtils.isNotEmpty(areaCode)) {
				map.put("areaCode", areaCode);
			}
			if (StringUtils.isNotEmpty(updateName)) {
				map.put("updateName", updateName);
			}
			
			if (StringUtils.isNotEmpty(registeredAddress)) {
				map.put("registeredAddress", registeredAddress);
			}
			if (StringUtils.isNotEmpty(postCode)) {
				map.put("postCode", postCode);
			}
			if (StringUtils.isNotEmpty(legalRepresentative)) {
				map.put("legalRepresentative", legalRepresentative);
			}
			if (StringUtils.isNotEmpty(agent)) {
				map.put("agent", agent);
			}
			if (StringUtils.isNotEmpty(taxRegistrationNumber)) {
				map.put("taxRegistrationNumber", taxRegistrationNumber);
			}
			if (StringUtils.isNotEmpty(bank)) {
				map.put("bank", bank);
			}
			if (StringUtils.isNotEmpty(bankAccount)) {
				map.put("bankAccount", bankAccount);
			}
			if (StringUtils.isNotEmpty(telephoneNumber)) {
				map.put("telephoneNumber", telephoneNumber);
			}
			if (StringUtils.isNotEmpty(faxNumber)) {
				map.put("faxNumber", faxNumber);
			}
			map.put("actionCode", "U");
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/organization/saveOrUpdateOrg.htm", JsonUtil.getJSONString(map));

		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	/**
	 * 保存组织机构（集团 大区 城市 门店）
	 * 
	 * @Methods Name saveOrganizationOne
	 * @Create In 2015-8-21 By chenghu
	 * @param organizationCode
	 * @param organizationName
	 * @param organizationType
	 * @param organizationStatus
	 * @param storeType
	 * @param shippingPoint
	 * @param areaCode
	 * @param createName
	 * @param updateName
	 * @param parentSid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveOrganizationOne", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveOrganizationOne(String groupSid, String organizationCode,
			String organizationName, String organizationType, String organizationStatus,
			String storeType, String shippingPoint, String areaCode, String createName,
			String updateName, String parentSid, 
			String registeredAddress, String postCode, String legalRepresentative, 
			String agent, String taxRegistrationNumber, String bank, String bankAccount, 
			String telephoneNumber, String faxNumber) {
		String json = "";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isNotEmpty(parentSid)) {
				map.put("parentSid", parentSid);
			}
			if (StringUtils.isNotEmpty(groupSid)) {
				map.put("groupSid", Long.parseLong(groupSid.trim()));
			}
			if (StringUtils.isNotEmpty(organizationCode)) {
				map.put("organizationCode", organizationCode);
			}
			if (StringUtils.isNotEmpty(organizationName)) {
				map.put("organizationName", organizationName);
			}
			if (StringUtils.isNotEmpty(organizationType)) {
				map.put("organizationType", organizationType);
			}
			if (StringUtils.isNotEmpty(organizationStatus)) {
				map.put("organizationStatus", organizationStatus);
			}
			if (StringUtils.isNotEmpty(storeType)) {
				map.put("storeType", storeType);
			}
			if (StringUtils.isNotEmpty(shippingPoint)) {
				map.put("shippingPoint", shippingPoint);
			}
			if (StringUtils.isNotEmpty(createName)) {
				map.put("createName", createName);
			}
			if (StringUtils.isNotEmpty(areaCode)) {
				map.put("areaCode", areaCode);
			}
			if (StringUtils.isNotEmpty(updateName)) {
				map.put("updateName", updateName);
			}
			
			if (StringUtils.isNotEmpty(registeredAddress)) {
				map.put("registeredAddress", registeredAddress);
			}
			if (StringUtils.isNotEmpty(postCode)) {
				map.put("postCode", postCode);
			}
			if (StringUtils.isNotEmpty(legalRepresentative)) {
				map.put("legalRepresentative", legalRepresentative);
			}
			if (StringUtils.isNotEmpty(agent)) {
				map.put("agent", agent);
			}
			if (StringUtils.isNotEmpty(taxRegistrationNumber)) {
				map.put("taxRegistrationNumber", taxRegistrationNumber);
			}
			if (StringUtils.isNotEmpty(bank)) {
				map.put("bank", bank);
			}
			if (StringUtils.isNotEmpty(bankAccount)) {
				map.put("bankAccount", bankAccount);
			}
			if (StringUtils.isNotEmpty(telephoneNumber)) {
				map.put("telephoneNumber", telephoneNumber);
			}
			if (StringUtils.isNotEmpty(faxNumber)) {
				map.put("faxNumber", faxNumber);
			}
			map.put("actionCode", "A");
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/organization/saveOrUpdateOrg.htm", JsonUtil.getJSONString(map));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	/**
	 * 查询集团List
	 * 
	 * @Methods Name queryListOrganization
	 * @Create In 2015-8-21 By chenghu
	 * @param request
	 * @param response
	 * @param organizationType
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryListOrganization", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryListOrganization(HttpServletRequest request, HttpServletResponse response,
			String organizationType, String parentSid, String groupSid) {

		Map<String, Object> map = new HashMap<String, Object>();

		if (StringUtils.isNotEmpty(parentSid)) {
			map.put("parentSid", parentSid);
		}

		if (StringUtils.isNotEmpty(organizationType)) {
			map.put("organizationType", Integer.parseInt(organizationType.trim()));
		}

		if (StringUtils.isNotEmpty(groupSid)) {
			map.put("groupSid", Integer.parseInt(groupSid.trim()));
		}

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/organization/findListOrgPart.htm", JsonUtil.getJSONString(map));
			map.clear();
			JSONObject jsonObject = JSONObject.fromObject(json);
			@SuppressWarnings("unchecked")
			List<Object> list = (List<Object>) jsonObject.get("data");
			if (list != null && list.size() != 0) {
				map.put("list", list);
				map.put("success", "true");
			} else {
				map.put("success", "false");
			}

		} catch (Exception e) {
			map.put("success", "false");
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	@ResponseBody
	@RequestMapping(value = "/selectAllStore", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectAllStore(String organizationType) {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		if ("".equals(organizationType)) {
			map.put("organizationType", organizationType);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/organization/findOrganizationByType.htm", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

}
