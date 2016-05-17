package com.wangfj.wms.controller.supplierInfomationNode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
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

@Controller
@RequestMapping(value = "/supplierDisplay")
public class SupplierInfomationController {

    /**
     * 根据SID获取信息
     *
     * @return String
     * @Methods Name getChannelByChannelById
     * @Create In 2015-4-20 By wangsy
     */
    @RequestMapping(value = "/getSupplierInfoById/{id}", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String getSupplierInfoById(@PathVariable("id") String id, Model m,
                                      HttpServletRequest request) {
        JSONObject jsons = new JSONObject();
        String json = "";
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (null != id || "".equals(id)) {
                map.put("sid", id);
            }
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/getSupplierInfoById.html",
                    map);
            jsons = JSONObject.fromObject(json);
            m.addAttribute("sid", id);
            m.addAttribute("json", jsons);
        } catch (Exception e) {
            json = "{'success':false}";
        }
        return "forward:/jsp/supplierInfomationNode/editSupplierInfomationNode.jsp";
    }

    /**
     * 验证供应商名称与税号是否重复
     *
     * @param supplyName ,taxNumber
     * @return String
     * @Methods Name getSupplyBySupplyNameAndTaxNumber
     * @Create In 2015-3-20 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/getSupplyBySupplyNameAndTaxNumber", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String getSupplyBySupplyNameAndTaxNumber(String supplyName) {
        String json = "";
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (!(null == supplyName || "".equals(supplyName))) {
                map.put("supplyName", supplyName);
            }
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/bw/getSupplyBySupplyNameAndTaxNumber.html", map);
        } catch (Exception e) {
            json = "{'success':false}";
        }
        return json;
    }

    /**
     * 添加商品时获取所有的供应商信息
     *
     * @return String
     * @Methods Name getAllSuppliers
     * @Create In 2015-3-6 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/getAllSuppliers", method = {RequestMethod.GET, RequestMethod.POST})
    public String getAllSuppliers(HttpServletRequest request, HttpServletResponse response) {
        String json = "";
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/getAllSuppliers.html", map);

        } catch (Exception e) {
            json = "{'success':false}";
        }
        return json;
    }

    /**
     * 供应商管理-查询所有供应商
     *
     * @param request
     * @param response
     * @param supplyName
     * @return String
     * @Methods Name querySupplier
     * @Create In 2015-4-17 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectSupplier", method = {RequestMethod.GET, RequestMethod.POST})
    public String selectSupplier(HttpServletRequest request, HttpServletResponse response,
                                 String supplyName, String supplyCode, String shopSid, String businessPattern,
                                 String apartOrder) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        int start = (currPage - 1) * size;
        Map<String, Object> m = new HashMap<String, Object>();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (StringUtils.isNotEmpty(supplyName)) {
                map.put("supplyName", supplyName.trim());
            }
            if (StringUtils.isNotEmpty(supplyCode)) {
                map.put("supplyCode", supplyCode.trim());
            }
            if (StringUtils.isNotEmpty(shopSid)) {
                map.put("shopSid", shopSid.trim());
            }
            if (StringUtils.isNotEmpty(businessPattern)) {
                map.put("businessPattern", businessPattern.trim());
            }
            if (StringUtils.isNotEmpty(apartOrder)) {
                map.put("apartOrder", apartOrder.trim());
            }
            map.put("currentPage", currPage);
            map.put("pageSize", size);
            map.put("fromSystem", "PCM");
            String jsonStr = JsonUtil.getJSONString(map);
            String pageSupplyInfo = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminSupplyInfo/findPageSullyInfoFuzzy.htm", jsonStr);
            json = pageSupplyInfo;
            JSONObject jsonObject = JSONObject.fromObject(json);
            String page = jsonObject.getString("data");
            JSONObject jsonObject2 = JSONObject.fromObject(page);
            @SuppressWarnings("unchecked")
            List<Object> list = (List<Object>) jsonObject2.get("list");
            Integer count = jsonObject2.getInt("count");
            int pageCount = count % size == 0 ? count / size : (count / size + 1);
            if (list != null && list.size() != 0) {
                m.put("list", list);
                m.put("pageCount", pageCount);
                m.put("success", "true");
            } else {
                m.put("success", "false");
                m.put("pageCount", 0);
            }
        } catch (Exception e) {
            m.put("pageCount", 0);
        }
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(m);
    }

    /**
     * 供应商管理-查询供应商详情
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name toSupplierDetail
     * @Create In 2016-04-05 By wangxuan
     */
    @RequestMapping(value = "/toSupplierDetail", method = {RequestMethod.GET, RequestMethod.POST})
    public String toSupplierDetail(HttpServletRequest request, HttpServletResponse response,
                                   String sid, Model model) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (StringUtils.isNotEmpty(sid)) {
                map.put("sid", sid);
            }
            map.put("fromSystem", "PCM");
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminSupplyInfo/findPageSullyInfoFuzzy.htm", JsonUtil.getJSONString(map));
            JSONObject jsonObject = JSONObject.fromObject(json);
            String success = jsonObject.get("success") + "";
            if ("true".equalsIgnoreCase(success)) {
                JSONObject data = jsonObject.getJSONObject("data");
                Object obj = data.get("list");
                if (obj != null && !"null".equals(obj)) {
                    JSONArray list = data.getJSONArray("list");
                    if (list.size() == 1) {
                        model.addAttribute("json", list.get(0));
                    }
                }
            }
        } catch (Exception e) {
            model.addAttribute("json", "");
        }
        return "forward:/jsp/supplierInfomationNode/toSupplierDetail.jsp";
    }

    /**
     * 添加或修改供应商
     *
     * @param supplyName
     * @param phone
     * @param fax
     * @param address
     * @return String
     * @Methods Name updateOrInsert
     * @Create In 2015-4-21 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/updateOrInsertSupplier", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String updateOrInsert(String supplyName, String postcode, String city, String country,
                                 String zone, String shopRegion, String address, String phone, String fax, String email,
                                 String lastOptUser, String shopSid, String supplyCode, Integer supplyType,
                                 String status, String shortName, Integer businessPattern, String street,
                                 String orgCode, String industry, String bizCertificateNo, String taxType,
                                 String taxNumbe, String bank, String bankNo, String registeredCapital,
                                 String enterpriseProperty, String businessCategory, String legalPerson,
                                 String legalPersonIcCode, String legalPersonContact, String agent, String agentIcCode,
                                 String agentContact, String contact, String contactTitle, String contactIcCode,
                                 String contactWay, String businessScope, Integer keySupplier, String taxRates,
                                 String inOutCity, String admissionDate, Integer returnSupply, String joinSite,
                                 Integer apartOrder, Integer dropship, String erpSupplierCode) {
        String json = "";
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("fromSystem", "PCM");
            map.put("supplyName", supplyName);
            map.put("postcode", postcode);
            map.put("city", city);
            map.put("country", country);
            map.put("zone", zone);
            map.put("shopRegion", shopRegion);
            map.put("address", address);
            map.put("phone", phone);
            map.put("fax", fax);
            map.put("email", email);
            map.put("lastOptUser", lastOptUser);
            map.put("shopSid", shopSid);
            map.put("supplyCode", supplyCode);
            map.put("supplyType", supplyType);
            map.put("status", status);
            map.put("shortName", shortName);
            map.put("businessPattern", businessPattern);
            map.put("street", street);
            map.put("orgCode", orgCode);
            map.put("industry", industry);
            map.put("bizCertificateNo", bizCertificateNo);
            map.put("taxType", taxType);
            map.put("taxNumbe", taxNumbe);
            map.put("bank", bank);
            map.put("bankNo", bankNo);
            map.put("registeredCapital", registeredCapital);
            map.put("enterpriseProperty", enterpriseProperty);
            map.put("businessCategory", businessCategory);
            map.put("legalPerson", legalPerson);
            map.put("legalPersonIcCode", legalPersonIcCode);
            map.put("legalPersonContact", legalPersonContact);
            map.put("agent", agent);
            map.put("agentIcCode", agentIcCode);
            map.put("agentContact", agentContact);
            map.put("contact", contact);
            map.put("contactTitle", contactTitle);
            map.put("contactIcCode", contactIcCode);
            map.put("contactWay", contactWay);
            map.put("businessScope", businessScope);
            map.put("keySupplier", keySupplier);
            map.put("taxRates", taxRates);
            map.put("inOutCity", inOutCity);
            map.put("admissionDate", admissionDate);
            map.put("returnSupply", returnSupply);
            map.put("joinSite", joinSite);
            map.put("apartOrder", apartOrder);
            map.put("dropship", dropship);
            // map.put("erpSupplierCode", erpSupplierCode);
            /*
             * json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
			 * "/bw/insertOrUpdateSupplier.html", map);
			 */
            String jsonStr = JsonUtil.getJSONString(map);
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminSupplyInfo/addSupplyInfo.htm", jsonStr);

        } catch (Exception e) {
            json = "{'success':false}";
        }

        return json;
    }

    /**
     * 修改供应商信息
     *
     * @param supplyName
     * @param sid
     * @param postcode
     * @param city
     * @param country
     * @param zone
     * @param shopRegion
     * @param address
     * @param phone
     * @param fax
     * @param email
     * @param lastOptUser
     * @param shopSid
     * @param supplyCode
     * @param supplyType
     * @param status
     * @param shortName
     * @param businessPattern
     * @param street
     * @param orgCode
     * @param industry
     * @param bizCertificateNo
     * @param taxType
     * @param taxNumbe
     * @param bank
     * @param bankNo
     * @param registeredCapital
     * @param enterpriseProperty
     * @param businessCategory
     * @param legalPerson
     * @param legalPersonIcCode
     * @param legalPersonContact
     * @param agent
     * @param agentIcCode
     * @param agentContact
     * @param contact
     * @param contactTitle
     * @param contactIcCode
     * @param contactWay
     * @param businessScope
     * @param keySupplier
     * @param taxRates
     * @param inOutCity
     * @param admissionDate
     * @param returnSupply
     * @param joinSite
     * @param apartOrder
     * @param dropship
     * @param erpSupplierCode
     * @return String
     * @Methods Name update
     * @Create In 2015-8-14 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/updateSupplier", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateSupplier(String supplyName, Long sid, String postcode, String city,
                                 String country, String zone, String shopRegion, String address, String phone,
                                 String fax, String email, String lastOptUser, String shopSid, String supplyCode,
                                 Integer supplyType, String status, String shortName, Integer businessPattern,
                                 String street, String orgCode, String industry, String bizCertificateNo,
                                 String taxType, String taxNumbe, String bank, String bankNo, String registeredCapital,
                                 String enterpriseProperty, String businessCategory, String legalPerson,
                                 String legalPersonIcCode, String legalPersonContact, String agent, String agentIcCode,
                                 String agentContact, String contact, String contactTitle, String contactIcCode,
                                 String contactWay, String businessScope, Integer keySupplier, String taxRates,
                                 String inOutCity, String admissionDate, Integer returnSupply, String joinSite,
                                 Integer apartOrder, Integer dropship, String erpSupplierCode) {
        String json = "";
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (sid != null || "".equals(sid)) {
                map.put("sid", sid);
            }
            map.put("supplyName", supplyName);
            map.put("postcode", postcode);
            map.put("city", city);
            map.put("country", country);
            map.put("zone", zone);
            map.put("shopRegion", shopRegion);
            map.put("address", address);
            map.put("phone", phone);
            map.put("fax", fax);
            map.put("email", email);
            map.put("lastOptUser", lastOptUser);
            map.put("shopSid", shopSid);
            map.put("supplyCode", supplyCode);
            map.put("supplyType", supplyType);
            map.put("status", status);
            map.put("shortName", shortName);
            map.put("businessPattern", businessPattern);
            map.put("street", street);
            map.put("orgCode", orgCode);
            map.put("industry", industry);
            map.put("bizCertificateNo", bizCertificateNo);
            map.put("taxType", taxType);
            map.put("taxNumbe", taxNumbe);
            map.put("bank", bank);
            map.put("bankNo", bankNo);
            map.put("registeredCapital", registeredCapital);
            map.put("enterpriseProperty", enterpriseProperty);
            map.put("businessCategory", businessCategory);
            map.put("legalPerson", legalPerson);
            map.put("legalPersonIcCode", legalPersonIcCode);
            map.put("legalPersonContact", legalPersonContact);
            map.put("agent", agent);
            map.put("agentIcCode", agentIcCode);
            map.put("agentContact", agentContact);
            map.put("contact", contact);
            map.put("contactTitle", contactTitle);
            map.put("contactIcCode", contactIcCode);
            map.put("contactWay", contactWay);
            map.put("businessScope", businessScope);
            map.put("keySupplier", keySupplier);
            map.put("taxRates", taxRates);
            map.put("inOutCity", inOutCity);
            map.put("admissionDate", admissionDate);
            map.put("returnSupply", returnSupply);
            map.put("joinSite", joinSite);
            map.put("apartOrder", apartOrder);
            map.put("dropship", dropship);
            map.put("fromSystem", "PCM");
            // map.put("erpSupplierCode", erpSupplierCode);
            /*
             * json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
			 * "/bw/insertOrUpdateSupplier.html", map);
			 */
            String jsonStr = JsonUtil.getJSONString(map);
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminSupplyInfo/updateSupplyInfo.htm", jsonStr);

        } catch (Exception e) {
            json = "{'success':false}";
        }

        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteSupplier", method = {RequestMethod.GET, RequestMethod.POST})
    public String delete(String sid) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            map.put("sid", sid);
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/deleteSupplier.html", map);

        } catch (Exception e) {
            json = "{'success:false'}";
        }
        return json;
    }

    /**
     * 根据门店sid和供应商名称 查询供应商列表
     *
     * @param pageSize
     * @param page
     * @param shopSid
     * @param supplyName
     * @return String
     * @Methods Name selectSupplyByShopSidAndSupplyName
     * @Create In 2015年8月24日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectSupplyByShopSidAndSupplyName", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String selectSupplyByShopSidAndSupplyName(String pageSize, String page, String shopSid,
                                                     String supplyName) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            if (!"-1".equals(shopSid)) {
                map.put("pageSize", pageSize);// 每页显示数量
                map.put("currentPage", page);// 当前第几页
                // 门店Code
                map.put("shopCode", shopSid);
                // 供应商名称
                map.put("supplyName", supplyName);
                // map.put("fromSystem", "PCM");
                json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                        + "/pcmAdminSupplyInfo/findListSupplier.htm", JsonUtil.getJSONString(map));
            } else {
                map.clear();
                map.put("success", false);
                map.put("msg", "未选择门店,无信息");
                json = JsonUtil.getJSONString(map);
            }

        } catch (Exception e) {
            json = "{'success:false'}";
        }
        return json;
    }

    /**
     * 查询供应商(与组织机构连表)
     *
     * @param sid
     * @param shopSid
     * @param supplyName
     * @param shopCode
     * @param supplyCode
     * @param supplyType
     * @param status
     * @return String
     * @Methods Name findListSupplier
     * @Create In 2015-12-8 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/findListSupplier", method = {RequestMethod.GET, RequestMethod.POST})
    public String findListSupplier(String sid, String shopSid, String supplyName, String shopCode,
                                   String supplyCode, String supplyType, String status, String apartOrder) {

        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(sid)) {
            map.put("sid", sid.trim());
        }
        // 门店sid
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("shopSid", shopSid.trim());
        }
        if (StringUtils.isNotEmpty(supplyName)) {
            map.put("supplyName", supplyName.trim());
        }
        // 门店编码
        if (StringUtils.isNotEmpty(shopCode)) {
            map.put("shopCode", shopCode.trim());
        }
        if (StringUtils.isNotEmpty(supplyCode)) {
            map.put("supplyCode", supplyCode.trim());
        }
        if (StringUtils.isNotEmpty(supplyType)) {
            map.put("supplyType", supplyType.trim());
        }
        if (StringUtils.isNotEmpty(status)) {
            map.put("status", status.trim());
        }
        if (StringUtils.isNotEmpty(apartOrder)) {
            map.put("apartOrder", apartOrder.trim());
        }

        try {
            String url = SystemConfig.SSD_SYSTEM_URL + "/pcmAdminSupplyInfo/findListSupplier.htm";
            String json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(map));
            JSONObject jsonObject = JSONObject.fromObject(json);
            List<?> list = (List<?>) jsonObject.get("data");
            map.clear();
            if (list != null && list.size() > 0) {
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
     * 从搜索查询供应商
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name findListSupplierBySearch
     * @Create In 2016-04-01 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = {"/findListSupplierBySearch"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String findListSupplierBySearch(HttpServletRequest request, HttpServletResponse response,
                                           String storeCode, String prefix) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(storeCode)) {
            map.put("storeCode", storeCode.trim());
        }
        if (StringUtils.isNotEmpty(prefix)) {
            map.put("prefix", prefix.trim());
        }
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmAdminSupplyInfo/findListSupplierBySearch.htm",
                    JsonUtil.getJSONString(map));
            map.clear();
            JSONObject jsonObject = JSONObject.fromObject(json);
            Object obj = jsonObject.get("list");
            if (obj != null && !"null".equals(obj.toString())) {
                List<?> list = (List<?>) jsonObject.get("list");
                map.put("list", list);
                map.put("success", "true");
            } else {
                map.put("list", "");
                map.put("success", "false");
            }
        } catch (Exception e) {
            map.put("list", "");
            map.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

    /**
     * 从搜索查询供应商
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name findListSupplierBySearchForSelect2
     * @Create In 2016-04-01 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = {"/findListSupplierBySearchForSelect2"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String findListSupplierBySearchForSelect2(HttpServletRequest request, HttpServletResponse response,
                                                     String storeCode, String prefix) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(storeCode)) {
            map.put("storeCode", storeCode.trim());
        }
        if (StringUtils.isNotEmpty(prefix)) {
            map.put("prefix", prefix.trim());
        }
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmAdminSupplyInfo/findListSupplierBySearch.htm",
                    JsonUtil.getJSONString(map));
            map.clear();
            JSONObject jsonObject = JSONObject.fromObject(json);
            Object obj = jsonObject.get("list");
            if (obj != null && !"null".equals(obj.toString())) {
                List<Map<String, Object>> items = new ArrayList<Map<String, Object>>();
                JSONArray list = jsonObject.getJSONArray("list");
                map.put("total_count", list.size());
                map.put("incomplete_results", false);
                for (int i = 0; i < list.size(); i++) {
                    JSONObject supplier = list.getJSONObject(i);
                    String sid = supplier.get("sid") + "";
                    String supplierCode = supplier.get("supplierCode") + "";
                    String supplierName = supplier.get("supplierName") + "";
                    String businessPattern = supplier.get("businessPattern") + "";
                    String shopCode = supplier.get("shopCode") + "";
                    Map<String, Object> item = new HashMap<String, Object>();
                    item.put("id", sid);
                    item.put("name", prefix);
                    item.put("full_name", supplierName);
                    items.add(item);
                }
                map.put("items", items);
//                map.put("success", "true");
            } else {
                map.put("items", "");
//                map.put("success", "false");
            }
        } catch (Exception e) {
            map.put("items", "");
//            map.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

    /**
     * 查询专柜的供应商信息
     *
     * @param sid
     * @param shopSid
     * @param supplyName
     * @param shopCode
     * @param supplyCode
     * @param supplyType
     * @param status
     * @param shoppeSid
     * @param shoppeCode
     * @return String
     * @Methods Name findListSupplierByShoppeParam
     * @Create In 2015-12-11 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/findListSupplierByShoppeParam", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String findListSupplierByShoppeParam(String sid, String shopSid, String supplyName,
                                                String shopCode, String supplyCode, String supplyType, String status, String shoppeSid,
                                                String shoppeCode) {

        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(sid)) {
            map.put("sid", sid.trim());
        }
        // 门店sid
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("shopSid", shopSid.trim());
        }
        // 门店编码
        if (StringUtils.isNotEmpty(supplyName)) {
            map.put("supplyName", supplyName.trim());
        }
        if (StringUtils.isNotEmpty(shopCode)) {
            map.put("shopCode", shopCode.trim());
        }
        if (StringUtils.isNotEmpty(supplyCode)) {
            map.put("supplyCode", supplyCode.trim());
        }
        if (StringUtils.isNotEmpty(supplyType)) {
            map.put("supplyType", supplyType.trim());
        }
        if (StringUtils.isNotEmpty(status)) {
            map.put("status", status.trim());
        }
        if (StringUtils.isNotEmpty(shoppeSid)) {
            map.put("shoppeSid", shoppeSid.trim());
        }
        if (StringUtils.isNotEmpty(shoppeCode)) {
            map.put("shoppeCode", shoppeCode.trim());
        }

        try {
            String url = SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminSupplyInfo/findListSupplierByShoppeParam.htm";
            String json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(map));
            JSONObject jsonObject = JSONObject.fromObject(json);
            List<?> list = (List<?>) jsonObject.get("data");
            map.clear();
            if (list != null && list.size() > 0) {
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

    @RequestMapping(value = "/getSupplyDetail/{id}", method = RequestMethod.GET)
    public String getSupplyDetail(@PathVariable("id") String id, Model m, HttpServletRequest request) {
        String json = "";
        JSONObject jsons = new JSONObject();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sid", id);
        map.put("fromSystem", "PCM");
        List<Object> list = new ArrayList<Object>();
        try {
            String supplyInfoDtoList = HttpUtilPcm
                    .doPost(SystemConfig.SSD_SYSTEM_URL
                                    + "/pcmAdminSupplyInfo/findListSullyInfoFuzzy.htm",
                            JsonUtil.getJSONString(map));
            json = supplyInfoDtoList;
            jsons = JSONObject.fromObject(json);
            /*
             * String page = jsonObject.getString("data"); JSONObject
			 * jsonObject2 = JSONObject.fromObject(page); list= (List<Object>)
			 * jsonObject2.get("list");
			 */
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        m.addAttribute("json", jsons);

        return "forward:/jsp/supplierInfomationNode/getSupplierDetail.jsp";
    }
}
