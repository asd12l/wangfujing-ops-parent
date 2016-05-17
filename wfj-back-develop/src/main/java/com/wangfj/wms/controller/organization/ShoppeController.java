package com.wangfj.wms.controller.organization;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wangfj.back.util.HttpUtil;
import com.wangfj.back.view.UacRoleVO;

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
import com.wangfj.wms.controller.organization.support.PcmChannelSaleConfigPara;
import com.wangfj.wms.controller.organization.support.PcmShoppeAUPara;
import com.wangfj.wms.domain.entity.RolePermission;
import com.wangfj.wms.service.IRoleLimitService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

/**
 * 组织机构的专柜信息
 *
 * @Class Name ShoppeController
 * @Author chenhu
 * @Create In 2015-8-21
 */
@Controller
@RequestMapping(value = "/shoppe")
public class ShoppeController {

    @Autowired
            @Qualifier("roleLimitService")
    IRoleLimitService roleLimitService;

    /**
     * 查询专柜分页
     *
     * @param request
     * @param response
     * @param shoppeName
     * @param industryConditionSid
     * @return String
     * @Methods Name queryOrganizationZero
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryShoppe"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String queryShoppe(HttpServletRequest request, HttpServletResponse response,
                              String shoppeCode, String shoppeName, String shopSid, String industryConditionSid,
                              String supplySid, String supplyCode, String groupSid, String floorCode, String floorName) {

        Integer pageSize = request.getParameter("pageSize") == null ? null : Integer
                .valueOf(Integer.parseInt(request.getParameter("pageSize")));
        Integer currentPage = Integer.valueOf(Integer.parseInt(request.getParameter("page")));
        if ((pageSize == null) || (pageSize.intValue() == 0)) {
            pageSize = Integer.valueOf(10);
        }

        Map<String, Object> para = new HashMap<String, Object>();
        para.put("currentPage", currentPage);
        para.put("pageSize", pageSize);
        if (StringUtils.isNotEmpty(shoppeCode)) {
            para.put("shoppeCode", shoppeCode.trim());
        }
        if (StringUtils.isNotEmpty(shoppeName)) {
            para.put("shoppeName", shoppeName.trim());
        }
        if (StringUtils.isNotEmpty(floorCode)) {
            para.put("floorCode", floorCode.trim());
        }
        if (StringUtils.isNotEmpty(floorName)) {
            para.put("floorName", floorName.trim());
        }
        if (StringUtils.isNotEmpty(groupSid)) {
            para.put("groupSid", Long.parseLong(groupSid.trim()));
        }
        if (StringUtils.isNotEmpty(shopSid)) {
            para.put("shopSid", Long.parseLong(shopSid.trim()));
        }
        if (StringUtils.isNotEmpty(industryConditionSid)) {
            para.put("industryConditionSid", Integer.parseInt(industryConditionSid.trim()));
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            para.put("supplySid", supplySid.trim());
        }
        if (StringUtils.isNotEmpty(supplyCode)) {
            para.put("supplyCode", supplyCode.trim());
        }

        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/shoppe/findPageShoppe.htm", JsonUtil.getJSONString(para));
            para.clear();
            if (StringUtils.isNotEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    para.put("list", jsonPage.get("list"));
                    para.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
                            : jsonPage.get("pages"));
                } else {
                    para.put("list", null);
                    para.put("pageCount", Integer.valueOf(0));
                }
            } else {
                para.put("list", null);
                para.put("pageCount", Integer.valueOf(0));
            }
        } catch (Exception e) {
            para.put("list", null);
            para.put("pageCount", Integer.valueOf(0));
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(para);
    }

    /**
     * 查询专柜List
     *
     * @param request
     * @param response
     * @param groupSid
     * @param shopSid
     * @param supplySid
     * @param shoppeType
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"/findShoppeList"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String findShoppeList(HttpServletRequest request, HttpServletResponse response,
                                 String groupSid, String shopSid, String supplySid, String shoppeType) {

        Map<String, Object> para = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(groupSid)) {
            para.put("groupSid", Long.parseLong(groupSid));
        }
        if (StringUtils.isNotEmpty(shopSid)) {
            para.put("shopSid", Long.parseLong(shopSid));
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            para.put("supplySid", supplySid);
        }
        if (StringUtils.isNotEmpty(shoppeType)) {
            para.put("shoppeType", shoppeType.trim());
        }

        try {
            String url = SystemConfig.SSD_SYSTEM_URL + "/shoppe/findShoppeList.htm";
            String json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));
            para.clear();
            if (StringUtils.isNotEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                List<?> list = (List<?>) jsonObject.get("data");
                if ((list != null) && (list.size() != 0)) {
                    para.put("list", list);
                    para.put("success", "true");
                } else {
                    para.put("list", null);
                    para.put("success", "true");
                }
            } else {
                para.put("list", null);
                para.put("success", "true");
            }
        } catch (Exception e) {
            para.put("list", null);
            para.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(para);
    }

    /**
     * 根据门店和供应商查询专柜（页面添加专柜商品）
     *
     * @param request
     * @param response
     * @param shopSid
     * @param groupSid
     * @param supplySid
     * @return String
     * @Methods Name findListShoppeForAddShoppeProduct
     * @Create In 2015-12-21 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = {"/findListShoppeForAddShoppeProduct"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String findListShoppeForAddShoppeProduct(HttpServletRequest request,
                                                    HttpServletResponse response, String groupSid, String shopSid, String supplySid,
                                                    String shoppeType) {

        Map<String, Object> para = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(groupSid)) {
            para.put("groupSid", Long.parseLong(groupSid));
        }
        if (StringUtils.isNotEmpty(shopSid)) {
            para.put("shopSid", Long.parseLong(shopSid));
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            para.put("supplySid", supplySid);
        }
        if (StringUtils.isNotEmpty(shoppeType)) {
            para.put("shoppeType", shoppeType.trim());
        }

        try {
            String url = SystemConfig.SSD_SYSTEM_URL
                    + "/shoppe/findListShoppeForAddShoppeProduct.htm";
            String json = HttpUtilPcm.doPost(url, JsonUtil.getJSONString(para));
            para.clear();
            if (StringUtils.isNotEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                List<?> list = (List<?>) jsonObject.get("data");
                if ((list != null) && (list.size() != 0)) {
                    para.put("list", list);
                    para.put("success", "true");
                } else {
                    para.put("list", null);
                    para.put("success", "true");
                }
            } else {
                para.put("list", null);
                para.put("success", "true");
            }
        } catch (Exception e) {
            para.put("list", null);
            para.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(para);
    }

    /**
     * 修改专柜
     *
     * @param sid
     * @param shoppeShippingPoint
     * @param shoppeName
     * @param shoppeCode
     * @param shopSid
     * @param floorSid
     * @param industryConditionSid
     * @param shoppeStatus
     * @param goodsManageType
     * @param businessTypeSid
     * @param shoppeType
     * @param negativeStock
     * @param isShippingPoint
     * @return String
     * @Methods Name updateShoppe
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/updateShoppe"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String updateShoppe(String sid, String shoppeShippingPoint, String shoppeName,
                               String isShippingPoint, String shoppeCode, String optUser, String shopSid,
                               String floorSid, String industryConditionSid, String shoppeStatus,
                               String goodsManageType, String businessTypeSid, String shoppeType,
                               String negativeStock, String groupSid, String channelCode, String supplySid,
                               String brandSid) {

        PcmShoppeAUPara para = new PcmShoppeAUPara();

        if (StringUtils.isNotEmpty(sid)) {
            para.setSid(Long.parseLong(sid));
        }
        if (StringUtils.isNotEmpty(shoppeShippingPoint)) {
            para.setShoppeShippingPoint(shoppeShippingPoint);
        }
        if (StringUtils.isNotEmpty(optUser)) {
            para.setOptUser(optUser);
        }
        if (StringUtils.isNotEmpty(shoppeName)) {
            para.setShoppeName(shoppeName);
        }
        if (StringUtils.isNotEmpty(groupSid)) {
            para.setGroupSid(Long.parseLong(groupSid));
        }
        if (StringUtils.isNotEmpty(shopSid)) {
            para.setShopSid(Long.parseLong(shopSid));
        }
        if (StringUtils.isNotEmpty(floorSid)) {
            para.setFloorSid(Long.parseLong(floorSid));
        }
        if (StringUtils.isNotEmpty(industryConditionSid)) {
            para.setIndustryConditionSid(Integer.parseInt(industryConditionSid));
        }
        if (StringUtils.isNotEmpty(shoppeStatus)) {
            para.setShoppeStatus(Integer.parseInt(shoppeStatus));
        }
        if (StringUtils.isNotEmpty(goodsManageType)) {
            para.setGoodsManageType(Integer.parseInt(goodsManageType));
        }
        if (StringUtils.isNotEmpty(businessTypeSid)) {
            para.setBusinessTypeSid(Integer.parseInt(businessTypeSid));
        }
        if (StringUtils.isNotEmpty(shoppeType)) {
            para.setShoppeType(shoppeType);
        }
        if (StringUtils.isNotEmpty(negativeStock)) {
            para.setNegativeStock(Integer.parseInt(negativeStock));
        }
        if (StringUtils.isNotEmpty(isShippingPoint)) {
            para.setIsShippingPoint(Integer.parseInt(isShippingPoint));
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            para.setSupplySid(supplySid);
        }
        if (StringUtils.isNotEmpty(brandSid)) {
            para.setBrandSid(brandSid);
        }

        String[] codes = channelCode.split(",");
        List<PcmChannelSaleConfigPara> cscpList = new ArrayList<PcmChannelSaleConfigPara>();
        for (String s : codes) {
            if (s != "") {
                PcmChannelSaleConfigPara pcscp = new PcmChannelSaleConfigPara();
                pcscp.setShoppeProSid(Long.valueOf(sid));
                pcscp.setChannelSid(s);
                pcscp.setSaleStauts(0);
                cscpList.add(pcscp);
            }
        }
        para.setChannelSaleConfigParaList(cscpList);

        para.setFromSystem("PCM");
        String json = "";
        try {

            String paraJson = JsonUtil.getJSONString(para);
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/shoppe/modifyShoppe.htm",
                    paraJson);
        } catch (Exception e) {
            json = "{'success':false}";
        }

        return json;
    }

    /**
     * 保存专柜
     *
     * @param shoppeShippingPoint
     * @param shoppeName
     * @param shopSid
     * @param floorSid
     * @param industryConditionSid
     * @param shoppeStatus
     * @param goodsManageType
     * @param businessTypeSid
     * @param shoppeType
     * @param createName
     * @param negativeStock
     * @param isShippingPoint
     * @return String
     * @Methods Name saveShoppe
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/saveShoppe"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String saveShoppe(String shoppeShippingPoint, String shoppeName, String shopSid,
                             String createName, String floorSid, String industryConditionSid, String shoppeStatus,
                             String goodsManageType, String businessTypeSid, String shoppeType,
                             String negativeStock, String isShippingPoint, String groupSid, String channelCode,
                             String supplySid, String brandSid) {

        PcmShoppeAUPara para = new PcmShoppeAUPara();

        if (StringUtils.isNotEmpty(shoppeShippingPoint)) {
            para.setShoppeShippingPoint(shoppeShippingPoint);
        }
        if (StringUtils.isNotEmpty(shoppeName)) {
            para.setShoppeName(shoppeName);
        }
        if (StringUtils.isNotEmpty(shopSid)) {
            para.setShopSid(Long.parseLong(shopSid));
        }
        if (StringUtils.isNotEmpty(createName)) {
            para.setCreateName(createName);
        }
        if (StringUtils.isNotEmpty(floorSid)) {
            para.setFloorSid(Long.parseLong(floorSid));
        }
        if (StringUtils.isNotEmpty(industryConditionSid)) {
            para.setIndustryConditionSid(Integer.parseInt(industryConditionSid));
        }
        if (StringUtils.isNotEmpty(shoppeStatus)) {
            para.setShoppeStatus(Integer.parseInt(shoppeStatus));
        }
        if (StringUtils.isNotEmpty(goodsManageType)) {
            para.setGoodsManageType(Integer.parseInt(goodsManageType));
        }
        if (StringUtils.isNotEmpty(businessTypeSid)) {
            para.setBusinessTypeSid(Integer.parseInt(businessTypeSid));
        }
        if (StringUtils.isNotEmpty(shoppeType)) {
            para.setShoppeType(shoppeType);
        }
        if (StringUtils.isNotEmpty(negativeStock)) {
            para.setNegativeStock(Integer.parseInt(negativeStock));
        }
        if (StringUtils.isNotEmpty(isShippingPoint)) {
            para.setIsShippingPoint(Integer.parseInt(isShippingPoint));
        }
        if (StringUtils.isNotEmpty(groupSid)) {
            para.setGroupSid(Long.parseLong(groupSid));
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            para.setSupplySid(supplySid);
        }
        if (StringUtils.isNotEmpty(brandSid)) {
            para.setBrandSid(brandSid);
        }

        String[] codes = channelCode.split(",");
        List<PcmChannelSaleConfigPara> cscpList = new ArrayList<PcmChannelSaleConfigPara>();
        for (String s : codes) {
            if (s != "") {
                PcmChannelSaleConfigPara pcscp = new PcmChannelSaleConfigPara();
                pcscp.setChannelSid(s);
                pcscp.setSaleStauts(0);
                cscpList.add(pcscp);
            }
        }
        para.setChannelSaleConfigParaList(cscpList);

        para.setFromSystem("PCM");

        String json = "";
        try {

            String paraJson = JsonUtil.getJSONString(para);
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/shoppe/addShoppe.htm",
                    paraJson);
        } catch (Exception e) {
            json = "{'success':false}";
        }
        return json;
    }

    /**
     * 查询门店
     *
     * @param request
     * @param response
     * @param organizationType
     * @return String
     * @Methods Name queryShopList
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryShopList"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String queryShopList(HttpServletRequest request, HttpServletResponse response,
                                String organizationType, String groupSid) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(groupSid)) {
            map.put("groupSid", Long.parseLong(groupSid.trim()));
        }
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
     * 查询门店加权限
     *
     * @param request
     * @param response
     * @param organizationType
     * @return String
     * @Methods Name queryShopListAddPermission
     * @Create In 2015-8-25 By zdl
     */
    @ResponseBody
    @RequestMapping(value = {"/queryShopListAddPermission"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String queryShopListAddPermission(HttpServletRequest request, HttpServletResponse response,
                                             String organizationType, String groupSid) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(groupSid)) {
            map.put("groupSid", Long.parseLong(groupSid.trim()));
        }
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
            types.add("0");
            map.put("permissionTypes", types);
            roleLimits = roleLimitService.selectByRoleCodesOrTypes(map);

            List<JSONObject> list = new ArrayList<JSONObject>();
            for (Object o : jsonList) {
                JSONObject o1 = JSONObject.fromObject(o);
                for (RolePermission rp : roleLimits) {
                    if (rp.getPermission().equals(o1.getString("organizationCode")) && rp.getCol1().equals(o1.getString("groupSid"))) {
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
                map.put("success", "false");
            }
        } catch (Exception e) {
            map.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

    /**
     * 查询楼层
     *
     * @param request
     * @param response
     * @param shopSid
     * @return String
     * @Methods Name queryFloorList
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryFloorList"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String queryFloorList(HttpServletRequest request, HttpServletResponse response,
                                 String shopSid) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("shopSid", shopSid);
        }
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/floor/selectFloorList.htm", JsonUtil.getJSONString(map));
            map.clear();
            if (StringUtils.isNotEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                List<?> list = (List<?>) jsonObject.get("data");
                if ((list != null) && (list.size() != 0)) {
                    map.put("list", list);
                    map.put("success", "true");
                } else {
                    map.put("list", null);
                    map.put("success", "false");
                }
            }
        } catch (Exception e) {
            map.put("list", null);
            map.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

    /**
     * 查询集或地点
     *
     * @param request
     * @param response
     * @param shopSid
     * @return String
     * @Methods Name queryShoppeShippingPointList
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryShoppeShippingPointList"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryShoppeShippingPointList(HttpServletRequest request,
                                               HttpServletResponse response, String shopSid) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("sid", shopSid);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/organization/selectOrganizationByParam.htm", JsonUtil.getJSONString(map));
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
     * 调用TMS查询集或地点
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name queryShoppeShippingPoint
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryShoppeShippingPoint"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryShoppeShippingPoint(HttpServletRequest request, String storeCode,
                                           HttpServletResponse response) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            if (StringUtils.isNotEmpty(storeCode)) {
                map.put("StoreCode", storeCode.trim());
            }
            json = HttpUtil.doPost(SystemConfig.WMS_SYSTEM_URL + "/tms/getWarehouse.htm", JsonUtil.getJSONString(map));
            map.clear();
            JSONObject jsonObject = JSONObject.fromObject(json);
            Object warehouses = jsonObject.get("warehouses");
            if (warehouses != null && !"null".equals(warehouses.toString())) {
                List<?> list = (List<?>) jsonObject.get("warehouses");
                if ((list != null) && (list.size() != 0)) {
                    map.put("list", list);
                    map.put("success", "true");
                } else {
                    map.put("list", "");
                    map.put("success", "false");
                }
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
     * 查询渠道根据专柜sid
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name queryChannelListByShoppeSid
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryChannelListByShoppeSid"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryChannelListByShoppeSid(HttpServletRequest request,
                                              HttpServletResponse response, String shoppeSid) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("shoppeProSid", shoppeSid);

        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                            + "/channelSaleConfig/findListChannelSaleConfig.htm",
                    JsonUtil.getJSONString(map));
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

}
