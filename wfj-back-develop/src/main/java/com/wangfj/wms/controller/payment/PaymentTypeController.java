package com.wangfj.wms.controller.payment;

import java.util.ArrayList;
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
import com.wangfj.wms.controller.payment.support.PcmPaymentOrganList;
import com.wangfj.wms.controller.payment.support.PcmPaymentOrganPara;
import com.wangfj.wms.controller.payment.support.PcmPaymentTypePara;
import com.wangfj.wms.controller.payment.support.QueryPaymentType;
import com.wangfj.wms.controller.payment.support.QueryPaymentTypePara;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/payment")
public class PaymentTypeController {

	/**
	 * 门店和支付管理关联表
	 * 
	 * @Methods Name queryPaymentOrgan
	 * @Create In 2015-9-7 By huangchangwen
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPaymentOrgan", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryPaymentOrgan(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		String name = request.getParameter("name");
		String storeCode = request.getParameter("storeCode");
		if (size == null || size == 0) {
			size = 10;
		}
		QueryPaymentTypePara queryPaymentTypePara = new QueryPaymentTypePara();
		queryPaymentTypePara.setPageSize(size);
		queryPaymentTypePara.setCurrentPage(currPage);

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (!StringUtils.isEmpty(name)) {
				queryPaymentTypePara.setName(name);
			}
			if (!StringUtils.isEmpty(storeCode)) {
				queryPaymentTypePara.setStoreCode(storeCode);
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/queryStorePaymentTypePage.htm",
					JsonUtil.getJSONString(queryPaymentTypePara));
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
	 * 支付方式管理分页查询
	 * 
	 * @Methods Name queryPaymentType
	 * @Create In 2015-9-7 By hangchangwen
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPaymentType", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryPaymentType(HttpServletRequest request, HttpServletResponse response,
			String payCode, String parentCode, String name, String storeCode, String storeName) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		QueryPaymentTypePara queryPaymentType = new QueryPaymentTypePara();
		queryPaymentType.setPageSize(size);
		queryPaymentType.setCurrentPage(currPage);
		if (StringUtils.isNotEmpty(parentCode)) {
			queryPaymentType.setParentCode(parentCode.trim());
		}
		if (StringUtils.isNotEmpty(payCode)) {
			queryPaymentType.setPayCode(payCode.trim());
		}
		if (!StringUtils.isEmpty(name)) {
			queryPaymentType.setName(name.trim());
		}
		if (!StringUtils.isEmpty(storeCode)) {
			queryPaymentType.setStoreCode(storeCode.trim());
		}
		if (StringUtils.isNotEmpty(storeName)) {
			queryPaymentType.setStoreName(storeName.trim());
		}

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/queryPaymentTypeInfo.htm",
					JsonUtil.getJSONString(queryPaymentType));
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
	 * 根据门店编码查询一级支付方式（非分页）
	 * 
	 * @Methods Name queryPaymentTypeStorCode
	 * @Create In 2015-9-23 By huangchangwen
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPaymentTypeStorCode", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPaymentTypeStorCode(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = 999;
		Integer currPage = 1;
		String name = request.getParameter("name");
		String storeCode = request.getParameter("storeCode");

		String parentCode = request.getParameter("parentCode");
		QueryPaymentType queryPaymentType = new QueryPaymentType();
		queryPaymentType.setParentCode(parentCode);
		queryPaymentType.setPageSize(size);
		queryPaymentType.setCurrentPage(currPage);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (!StringUtils.isEmpty(name)) {
				queryPaymentType.setName(name);
			}
			if (!StringUtils.isEmpty(storeCode)) {
				queryPaymentType.setStoreCode(storeCode);
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/queryPaymentTypePage.htm",
					JsonUtil.getJSONString(queryPaymentType));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));

				} else {
					map.put("list", null);

				}
			} else {
				map.put("list", null);

			}

		} catch (Exception e) {
			map.put("list", null);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 根据门店编码查询门店下的一级支付方式（分页）
	 * 
	 * @Methods Name queryPageFirstPaymentTypeByShop
	 * @Create In 2015-9-29 By wangxuan
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPageFirstPaymentTypeByShop", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPageFirstPaymentTypeByShop(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";

		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 5;
		}
		if (currPage == null || currPage == 0) {
			currPage = 1;
		}

		String storeCode = request.getParameter("organizationCode");

		QueryPaymentType queryPaymentType = new QueryPaymentType();
		queryPaymentType.setPageSize(size);
		queryPaymentType.setCurrentPage(currPage);

		if (StringUtils.isNotEmpty(storeCode)) {
			queryPaymentType.setStoreCode(storeCode);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		try {

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/query1PaymentTypebyshopsid.htm",
					JsonUtil.getJSONString(queryPaymentType));
			map.clear();
			if (StringUtils.isNotEmpty(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
							: jsonPage.get("pages"));
				} else {
					map.put("list", null);
					map.put("pageCount", Integer.valueOf(0));
				}
			} else {
				map.put("list", null);
				map.put("pageCount", Integer.valueOf(0));
			}

		} catch (Exception e) {
			map.put("list", null);
			map.put("pageCount", Integer.valueOf(0));
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 根据门店查询二级支付方式（分页）
	 * 
	 * @Methods Name queryPageSecondPaymentTypeByShop
	 * @Create In 2015-9-29 By wangxuan
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPageSecondPaymentTypeByShop", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPageSecondPaymentTypeByShop(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";

		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 5;
		}
		if (currPage == null || currPage == 0) {
			currPage = 1;
		}

		String storeCode = request.getParameter("organizationCode");
		String parentCode = request.getParameter("parentCode");

		QueryPaymentType queryPaymentType = new QueryPaymentType();
		queryPaymentType.setPageSize(size);
		queryPaymentType.setCurrentPage(currPage);

		if (StringUtils.isNotEmpty(storeCode)) {
			queryPaymentType.setStoreCode(storeCode);
		}
		if (StringUtils.isNotEmpty(parentCode)) {
			queryPaymentType.setParentCode(parentCode);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/query2PaymentTypebyshopsid.htm",
					JsonUtil.getJSONString(queryPaymentType));
			map.clear();
			if (StringUtils.isNotEmpty(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
							: jsonPage.get("pages"));
				} else {
					map.put("list", null);
					map.put("pageCount", Integer.valueOf(0));
				}
			} else {
				map.put("list", null);
				map.put("pageCount", Integer.valueOf(0));
			}

		} catch (Exception e) {
			map.put("list", null);
			map.put("pageCount", Integer.valueOf(0));
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 根据上级code查询支付方式
	 * 
	 * @Methods Name queryPaymentTypeByCode
	 * @Create In 2015-9-10 By huangchangwen
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPaymentTypeByCode", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPaymentTypeByCode(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = 999;
		Integer currPage = 1;
		String parentCode = request.getParameter("parentCode");
		QueryPaymentTypePara queryPaymentType = new QueryPaymentTypePara();
		queryPaymentType.setPageSize(size);
		queryPaymentType.setCurrentPage(currPage);
		queryPaymentType.setParentCode(parentCode);

		Map<String, Object> map = new HashMap<String, Object>();
		try {

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/queryPaymentTypeInfo.htm",
					JsonUtil.getJSONString(queryPaymentType));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));

				} else {
					map.put("list", null);

				}
			} else {
				map.put("list", null);

			}

		} catch (Exception e) {
			map.put("list", null);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 查询分页二级支付方式
	 * 
	 * @Methods Name queryPaymentTypeByParentCode
	 * @Create In 2015-9-16 By huangchangwen
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPaymentTypeByParentCode", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPaymentTypeByParentCode(HttpServletRequest request,
			HttpServletResponse response, String payCode) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));

		if (size == null || size == 0) {
			size = 5;
		}

		QueryPaymentTypePara queryPaymentType = new QueryPaymentTypePara();
		queryPaymentType.setPageSize(size);
		queryPaymentType.setCurrentPage(currPage);

		String parentCode = request.getParameter("parentCode");
		if (!StringUtils.isEmpty(parentCode)) {
			queryPaymentType.setParentCode(parentCode);
		}
		if (StringUtils.isNotEmpty(payCode)) {
			queryPaymentType.setPayCode(payCode.trim());
		}
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/queryPaymentTypeInfo.htm",
					JsonUtil.getJSONString(queryPaymentType));
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
	 * 查询二级支付方式
	 * 
	 * @Methods Name queryPaymentTypeByParentCodes
	 * @Create In 2015-9-16 By huangchangwen
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryPaymentTypeByParentCodes", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPaymentTypeByParentCodes(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		Integer size = 999;
		Integer currPage = 1;
		QueryPaymentTypePara queryPaymentType = new QueryPaymentTypePara();
		String parentCode = request.getParameter("parentCode");
		queryPaymentType.setPageSize(size);
		queryPaymentType.setCurrentPage(currPage);
		if (!StringUtils.isEmpty(parentCode)) {
			queryPaymentType.setParentCode(parentCode);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/queryPaymentTypePage.htm",
					JsonUtil.getJSONString(queryPaymentType));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));

				} else {
					map.put("list", null);

				}
			} else {
				map.put("list", null);

			}

		} catch (Exception e) {
			map.put("list", null);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

	/**
	 * 支付管理信息添加
	 * 
	 * @Methods Name savePaymentType
	 * @Create In 2015-9-7 By huangchangwen
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/createPaymentType", method = RequestMethod.POST)
	@ResponseBody
	public String savePaymentType(HttpServletRequest request, HttpServletResponse response) {

		PcmPaymentTypePara pcmPaymentTypePara = new PcmPaymentTypePara();

		String name = request.getParameter("name");
		String payCode = request.getParameter("payCode");
		String parentCode = request.getParameter("parentCode");
		String dealTime = request.getParameter("dealTime");// 支付方式类型
		String isAllowInvoice = request.getParameter("isAllowInvoice");// 能否开发票
		String bankBin = request.getParameter("bankBIN");
		String remark = request.getParameter("remark");

		if (StringUtils.isNotEmpty(name)) {
			pcmPaymentTypePara.setName(name);
		}
		if (StringUtils.isNotEmpty(payCode)) {
			pcmPaymentTypePara.setPayCode(payCode);
		}
		if (StringUtils.isNotEmpty(parentCode)) {
			pcmPaymentTypePara.setParentCode(parentCode);
		}
		if (StringUtils.isNotEmpty(dealTime)) {
			pcmPaymentTypePara.setDealTime(dealTime);
		}
		if (StringUtils.isNotEmpty(isAllowInvoice)) {
			pcmPaymentTypePara.setIsAllowInvoice(isAllowInvoice);
		}
		if (StringUtils.isNotEmpty(bankBin)) {
			pcmPaymentTypePara.setBankBIN(bankBin);
		}
		if (StringUtils.isNotEmpty(remark)) {
			pcmPaymentTypePara.setRemark(remark);
		}

		String json = "";
		try {

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/createPaymentType.htm",
					JsonUtil.getJSONString(pcmPaymentTypePara));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	/**
	 * 门店添加支付方式
	 * 
	 * @Methods Name savePcmPaymentOrgan
	 * @Create In 2015年8月10日 By kongqf
	 * @param request
	 * @param pcmPaymentOrganPara
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/createPaymentOrgan", method = RequestMethod.POST)
	@ResponseBody
	public String savePcmPaymentOrgan(PcmPaymentOrganList pcmPaymentOrganList,
			HttpServletRequest request, HttpServletResponse response) {
		List<PcmPaymentOrganPara> pcmPaymentOrganParaList = new ArrayList<PcmPaymentOrganPara>();

		String shopSid = pcmPaymentOrganList.getShopSid();

		String[] split = shopSid.split(",");

		for (String str : split) {
			String[] payment = str.split(";");
			PcmPaymentOrganPara para = new PcmPaymentOrganPara();
			para.setShopSid(payment[0]);
			para.setCode(payment[1]);
			para.setBankBin(payment[2]);

			pcmPaymentOrganParaList.add(para);

		}
		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/createPaymentOrgan.htm",
					JsonUtil.getJSONString(pcmPaymentOrganParaList));

		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	/**
	 * 修改支付方式
	 * 
	 * @Methods Name updatePaymentType
	 * @Create In 2015-9-28 By wangxuan
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/updatePaymentType", method = RequestMethod.POST)
	@ResponseBody
	public String updatePaymentType(HttpServletRequest request, HttpServletResponse response,
			String sid, String name, String payCode, String isAllowInvoice, String bankBIN,
			String remark, String dealTime) {

		PcmPaymentTypePara pcmPaymentTypePara = new PcmPaymentTypePara();

		if (StringUtils.isNotEmpty(sid)) {
			pcmPaymentTypePara.setSid(sid.trim());
		}
		if (StringUtils.isNotEmpty(name)) {
			pcmPaymentTypePara.setName(name.trim());
		}
		if (StringUtils.isNotEmpty(payCode)) {
			pcmPaymentTypePara.setPayCode(payCode.trim());
		}
		if (StringUtils.isNotEmpty(isAllowInvoice)) {
			pcmPaymentTypePara.setIsAllowInvoice(isAllowInvoice.trim());
		}
		if (StringUtils.isNotEmpty(bankBIN)) {
			pcmPaymentTypePara.setBankBIN(bankBIN.trim());
		}
		if (StringUtils.isNotEmpty(remark)) {
			pcmPaymentTypePara.setRemark(remark.trim());
		}
		if (StringUtils.isNotEmpty(dealTime)) {
			pcmPaymentTypePara.setDealTime(dealTime.trim());
		}

		String json = "";
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/updatePcmPaymentType.htm",
					JsonUtil.getJSONString(pcmPaymentTypePara));
		} catch (Exception e) {
			json = "{'success':false}";
		}

		return json;
	}

	/**
	 * 删除支付方式
	 * 
	 * @Methods Name delPcmPaymentType
	 * @Create In 2015-09-8 By huangchangwen
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/delPaymentType", method = RequestMethod.POST)
	@ResponseBody
	public String delPcmPaymentType(HttpServletRequest request, HttpServletResponse response) {

		QueryPaymentTypePara queryPaymentType = new QueryPaymentTypePara();
		String sid = request.getParameter("sid");

		if (StringUtils.isNotEmpty(sid)) {
			queryPaymentType.setSid(sid);
		}

		String json = "";
		try {

			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/delPaymentType.htm", JsonUtil.getJSONString(queryPaymentType));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	/**
	 * 删除门店支付方式
	 * 
	 * @Methods Name delShopPcmPayment
	 * @Create In 2015-10-8 By wangxuan
	 * @param request
	 * @param response
	 * @return String
	 */
	@RequestMapping(value = "/delShopPcmPayment", method = RequestMethod.POST)
	@ResponseBody
	public String delShopPcmPayment(HttpServletRequest request, HttpServletResponse response) {

		String json = "";

		PcmPaymentOrganPara para = new PcmPaymentOrganPara();
		String shopSid = request.getParameter("shopSid");
		String code = request.getParameter("code");

		if (StringUtils.isNotEmpty(shopSid)) {
			para.setShopSid(shopSid);
		}
		if (StringUtils.isNotEmpty(code)) {
			para.setCode(code);
		}

		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/delPaymentOrgan.htm", JsonUtil.getJSONString(para));
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryPaymentOrganName", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPaymentOrganName(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		String name = request.getParameter("name");
		if (size == null || size == 0) {
			size = 999;
		}
		QueryPaymentTypePara queryPaymentTypePara = new QueryPaymentTypePara();
		queryPaymentTypePara.setPageSize(size);
		queryPaymentTypePara.setCurrentPage(currPage);

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (!StringUtils.isEmpty(name)) {
				queryPaymentTypePara.setName(name);
			}
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
					+ "/pcmpayment/queryStorePaymentTypePage.htm",
					JsonUtil.getJSONString(queryPaymentTypePara));
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
				} else {
					map.put("list", null);
				}
			} else {
				map.put("list", null);
			}

		} catch (Exception e) {
			map.put("list", null);
		} finally {

		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}
}
