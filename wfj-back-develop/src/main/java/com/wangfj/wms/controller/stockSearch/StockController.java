package com.wangfj.wms.controller.stockSearch;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.back.view.UacRoleVO;
import com.wangfj.wms.controller.stockSearch.support.ProductPagePara;
import com.wangfj.wms.domain.entity.RolePermission;
import com.wangfj.wms.service.IRoleLimitService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/stock")
public class StockController {

    @Autowired
    @Qualifier("roleLimitService")
    IRoleLimitService roleLimitService;

    /**
     * 分页查询库存管理
     *
     * @param request
     * @param response
     * @param skuCode
     * @param supplierSid
     * @param productCode
     * @param channelSid
     * @param storeCode
     * @return String
     * @Methods Name queryStockType
     * @Create In 2015-9-7 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = "/selectStockSearch", method = {RequestMethod.GET, RequestMethod.POST})
    public String queryStockType(HttpServletRequest request, HttpServletResponse response,
                                 String skuCode, String supplierSid, String productCode, String channelSid,
                                 String storeCode, String shoppeCode) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.valueOf(Integer
                .parseInt(request.getParameter("pageSize")));
        Integer currPage = request.getParameter("page") == null ? null : Integer.valueOf(Integer
                .parseInt(request.getParameter("page")));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        ProductPagePara para = new ProductPagePara();
        para.setCurrentPage(currPage);
        para.setPageSize(size);
        if (StringUtils.isNotEmpty(storeCode)) {
            para.setStoreCode(storeCode);
            List<String> levels = new ArrayList<String>();
            levels.add("4");
            List<String> managerCategoryCodes = roleLimitService.selectManageCateByShopSidAndLevel(storeCode, levels);
            if (managerCategoryCodes != null && managerCategoryCodes.size() > 0) {
                para.setManagerCategoryCodes(managerCategoryCodes);
            }
        }
        if (StringUtils.isNotEmpty(skuCode)) {
            para.setSkuCode(skuCode);
        }
        if (StringUtils.isNotEmpty(productCode)) {
            para.setProductCode(productCode);
        }
        if (StringUtils.isNotEmpty(supplierSid)) {
            para.setSupplierCode(supplierSid);
        }
        if (StringUtils.isNotEmpty(channelSid)) {
            para.setChannelSid(channelSid);
        }
        if (StringUtils.isNotEmpty(shoppeCode)) {
            para.setCounterCode(shoppeCode);
        }
        String str = JsonUtil.getJSONString(para);
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/stockAdmin/queryProductStockInfoFromSearch.htm", str);
            map.clear();
            if (!"".equals(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    map.put("list", jsonPage.get("list"));
                    map.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
                            : jsonPage.get("pages"));
                    Integer total = jsonPage.getInt("count");
                    map.put("total", total);
                    //搜索 ES 1W以上数据分页查不出来
                    Integer esTotal = 10000;
                    if (total > esTotal) {
//                        Integer pageCount = esTotal % size == 0 ? esTotal / size : esTotal / size + 1;
                        Integer pageCount = esTotal / size;
                        map.put("pageCount", pageCount);
                    }
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

    @ResponseBody
    @RequestMapping(value = "/queryStockChangeHis", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryStockChangeHis(HttpServletRequest request, HttpServletResponse response,
                                      String shoppeProSid, String channelSid, String changeTypeSid) {

        Integer pageSize = request.getParameter("pageSize") == null ? null : Integer
                .valueOf(Integer.parseInt(request.getParameter("pageSize")));
        Integer currentPage = request.getParameter("page") == null ? null : Integer.valueOf(Integer
                .parseInt(request.getParameter("page")));
        if (pageSize == null || pageSize == 0) {
            pageSize = 10;
        }

        Map<String, Object> para = new HashMap<String, Object>();
        para.put("currentPage", currentPage);
        para.put("pageSize", pageSize);

        if (StringUtils.isNotEmpty(shoppeProSid)) {
            para.put("shoppeProSid", shoppeProSid);
        }
        if (StringUtils.isNotEmpty(channelSid)) {
            para.put("channelSid", channelSid);
        }
        if (StringUtils.isNotEmpty(changeTypeSid)) {
            para.put("changeTypeSid", Long.parseLong(changeTypeSid));
        }

        Map<String, Object> returnMap = new HashMap<String, Object>();
        String json = "";
        try {
            String url = SystemConfig.SSD_SYSTEM_URL + "/stockAdmin/queryStockChangeHis.htm";
            String jsonPara = JsonUtil.getJSONString(para);
            json = HttpUtilPcm.doPost(url, jsonPara);
            returnMap.clear();
            if (!"".equals(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    returnMap.put("list", jsonPage.get("list"));
                    returnMap.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
                            : jsonPage.get("pages"));
                } else {
                    returnMap.put("list", null);
                    returnMap.put("pageCount", Integer.valueOf(0));
                }
            } else {
                returnMap.put("list", null);
                returnMap.put("pageCount", Integer.valueOf(0));
            }
        } catch (Exception e) {
            returnMap.put("pageCount", Integer.valueOf(0));
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(returnMap);
    }

    /**
     * 查询门店
     *
     * @param request
     * @param response
     * @param organizationType
     * @return String
     * @Methods Name queryShopList
     * @Create In 2015-9-7 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = {"/queryShopList"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String queryShopList(HttpServletRequest request, HttpServletResponse response,
                                String organizationType) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(organizationType)) {
            map.put("organizationType", Integer.parseInt(organizationType.trim()));
        } else {
            map.put("organizationType", "3");
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/organization/findListOrgPart.htm", JsonUtil.getJSONString(map));
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
     * 供应商查询
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name querySupplyInfoList
     * @Create In 2015-9-8 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/querySupplyInfoList"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String querySupplyInfoList(HttpServletRequest request, HttpServletResponse response) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("fromSystem", "PCM");
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminSupplyInfo/findListSupplyInfo.htm", JsonUtil.getJSONString(map));
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
     * 查询渠道
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name queryChannelList
     * @Create In 2015-9-8 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryChannelList"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryChannelList(HttpServletRequest request, HttpServletResponse response) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminChannel/findListChannel.htm", JsonUtil.getJSONString(map));
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
     * 查询渠道加权限
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name queryChannelListAddPermission
     * @Create In 2015-9-8 By zdl
     */
    @ResponseBody
    @RequestMapping(value = {"/queryChannelListAddPermission"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryChannelListAddPermission(HttpServletRequest request, HttpServletResponse response) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminChannel/findListChannel.htm", JsonUtil.getJSONString(map));
            map.clear();
            JSONObject jsonObject = JSONObject.fromObject(json);
            JSONArray jsonList = JSONArray.fromObject(jsonObject.get("data"));

            List<RolePermission> roleLimits = new ArrayList<RolePermission>();
            String username = CookiesUtil.getCookies(request, "username");
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("userId", username);
            String RolesJson = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/api/findRolesByUserId.do", paramMap);
            JSONObject json2 = JSONObject.fromObject(RolesJson);
            JSONArray Roles = JSONArray.fromObject(json2.get("result"));
            List<UacRoleVO> rolesList = JsonUtil.getListDTO(Roles.toString(), UacRoleVO.class);
            List<String> paramList = new ArrayList<String>();
            for (UacRoleVO jo : rolesList) {
                paramList.add(jo.getCn());
            }
            map.put("roleCodes", paramList);
            List<String> types = new ArrayList<String>();
            types.add("1");
            map.put("permissionTypes", types);
            roleLimits = roleLimitService.selectByRoleCodesOrTypes(map);

            List<JSONObject> list = new ArrayList<JSONObject>();
            for (Object o : jsonList) {
                JSONObject o1 = JSONObject.fromObject(o);
                for (RolePermission rp : roleLimits) {
                    if (rp.getPermission().equals(o1.getString("channelCode"))) {
                        list.add(o1);
                        break;
                    }
                }
            }
            map.clear();
            if ((list != null) && (list.size() != 0)) {
                map.put("list", list);
                map.put("success", "true");
            } else {
                map.put("list", jsonList);
                map.put("success", "true");
            }
        } catch (Exception e) {
            map.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

}
