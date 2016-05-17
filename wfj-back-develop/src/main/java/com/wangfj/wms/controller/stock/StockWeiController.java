package com.wangfj.wms.controller.stock;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.wms.controller.stock.support.ExcelStockVo;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;

@Controller
@RequestMapping(value = "/stockWei")
public class StockWeiController {
    /**
     * 根据专柜商品编码和渠道查询库位信息
     *
     * @param request
     * @param response
     * @param supplyProductId
     * @param channelSid
     * @return String
     * @Methods Name selectStockWei
     * @Create In 2015-9-16 By chenhu
     */

    @ResponseBody
    @RequestMapping(value = "/selectStockWei", method = {RequestMethod.GET, RequestMethod.POST})
    public String selectStockWei(HttpServletRequest request, HttpServletResponse response,
                                 String supplyProductId, String channelSid) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(supplyProductId)) {
            map.put("supplyProductId", supplyProductId);
        }
        if (StringUtils.isNotEmpty(channelSid)) {
            map.put("channelSid", channelSid);
        }
        String str = JsonUtil.getJSONString(map);
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/stockAdmin/ShoppeProStockInfo.htm", str);
//			map.clear();
//			if (!"".equals(json)) {
//				JSONObject jsonObject = JSONObject.fromObject(json);
//				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
//				if (jsonPage != null) {
//					map.put("list", jsonPage.get("list"));
//					map.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
//							: jsonPage.get("pages"));
//				} else {
//					map.put("list", null);
//					map.put("pageCount", Integer.valueOf(0));
//				}
//			} else {
//				map.put("list", null);
//				map.put("pageCount", Integer.valueOf(0));
//			}
        } catch (Exception e) {
//			map.put("pageCount", Integer.valueOf(0));
        }

//		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
//		return gson.toJson(map);
        return json;
    }

    /**
     * 同渠道转移
     *
     * @param request
     * @param response
     * @param stockName
     * @param sid
     * @param channelSid
     * @param stockInfo
     * @return String
     * @Methods Name saveStockWei
     * @Create In 2015-9-22 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/saveStockWei"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String saveStockWei(HttpServletRequest request, HttpServletResponse response, String stockName,
                               String sid, String channelSid, String stockInfo) {
        String json = "";
        Map<String, Object> map = null;
        try {

            //串
            List<Map<String, Object>> li = new ArrayList<Map<String, Object>>();
            if (StringUtils.isNotEmpty(stockInfo)) {
                List<Map<String, Object>> stockInfoList = JSONArray.toList(JSONArray.fromObject(stockInfo), HashMap.class);
                for (int i = 0; i < stockInfoList.size(); i++) {
                    map = new HashMap<String, Object>();
                    if (StringUtils.isNotEmpty(stockName)) {
                        map.put("stockTypeSid", stockName);
                    }
                    if (StringUtils.isNotEmpty(sid)) {
                        map.put("shoppeProSid", sid);
                    }
                    if (StringUtils.isNotEmpty(channelSid)) {
                        map.put("channelSid", channelSid);
                    }
                    map.put("fromSystem", "OMSADMIN");
                    map.put("newStockType", stockInfoList.get(i).get("stockTypeSid"));
                    map.put("proSum", stockInfoList.get(i).get("proSum"));
                    li.add(map);
                }
            }


            String str = JsonUtil.getJSONString(li);
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_INNER_URL + "/stockInner/findStockTypeUpdateFromPcm.htm", str);
        } catch (Exception e) {
            json = "{'success':false}";
        }
        return json;
    }

    /**
     * 跨渠道转移库存
     *
     * @param request
     * @param response1
     * @param stockName1
     * @param sid1
     * @param channelSid1
     * @param stockInfo1
     * @return String
     * @Methods Name saveStockWei1
     * @Create In 2015-9-22 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/saveStockWei1"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String saveStockWei1(HttpServletRequest request, HttpServletResponse response1, String stockName1,
                                String sid1, String channelSid1, String stockInfo1) {
        String json = "";
        Map<String, Object> map = null;
        Map<String, Object> map2 = null;
        Map<String, Object> map3 = new HashMap<String, Object>();
        try {

            //串
            List<Map<String, Object>> li = new ArrayList<Map<String, Object>>();
            if (StringUtils.isNotEmpty(stockInfo1)) {
                List<Map<String, Object>> stockInfoList = JSONArray.toList(JSONArray.fromObject(stockInfo1), HashMap.class);
                map3.put("isOfferLine", "0");
                map3.put("saleNo", "");
                map3.put("fromSystem", "OMSADMIN");

                for (int i = 0; i < stockInfoList.size(); i++) {
                    map = new HashMap<String, Object>();
                    map2 = new HashMap<String, Object>();
                    map.put("stockType", "1012");
                    map.put("supplyProductNo", sid1);
                    map.put("channelSid", channelSid1);
                    map.put("saleSum", stockInfoList.get(i).get("proSum"));
                    map.put("salesItemNo", "");

                    map2.put("stockType", "1013");
                    map2.put("supplyProductNo", sid1);
                    map2.put("channelSid", stockInfoList.get(i).get("channelSid"));
                    map2.put("saleSum", stockInfoList.get(i).get("proSum"));
                    map2.put("salesItemNo", "");
                    li.add(map);
                    li.add(map2);
                }
                map3.put("products", li);
            }


            String str = JsonUtil.getJSONString(map3);
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_INNER_URL + "/stockInner/findStockTransferFromPcm.htm", str);
        } catch (Exception e) {
            json = "{'success':false}";
        }
        return json;
    }

    /**
     * 库存导出Excel 查询总数量
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name getStockToExcelCount
     * @Create In 2016-04-05 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = "/getStockToExcelCount", method = {RequestMethod.GET, RequestMethod.POST})
    public String getStockToExcelCount(HttpServletRequest request, String skuCode, String productCode, String supplierCode,
                                       String storeCode, String channelSid, String shoppe) {

        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(skuCode)) {
            map.put("skuCode", skuCode);
        }
        if (StringUtils.isNotEmpty(productCode)) {
            map.put("productCode", productCode);
        }
        if (StringUtils.isNotEmpty(supplierCode)) {
            map.put("supplierCode", supplierCode);
        }
        if (StringUtils.isNotEmpty(storeCode)) {
            map.put("storeCode", storeCode);
        }
        if (StringUtils.isNotEmpty(channelSid)) {
            map.put("channelSid", channelSid);
        }
        if (StringUtils.isNotEmpty(shoppe)) {
            map.put("counterCode", shoppe);
        }
        String str = JsonUtil.getJSONString(map);
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/stockAdmin/queryProductPriceInfoExcelCount.htm", str);
            JSONObject jsonObject = JSONObject.fromObject(json);
            JSONObject data = jsonObject.getJSONObject("data");
            map.clear();
            map.put("success", "true");
            map.put("count", data.get("count"));
        } catch (Exception e) {
            e.printStackTrace();
            map.clear();
            map.put("success", "false");
            map.put("count", 0);
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

    /**
     * 库存导出Excel
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name getStockToExcel
     * @Create In 2015-10-9 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = "/getStockToExcel", method = {RequestMethod.GET, RequestMethod.POST})
    public String getStockToExcel(HttpServletRequest request, HttpServletResponse response) {
        String jsons = "";
        String title = "allSkus_dgw";
        List<ExcelStockVo> epv = new ArrayList<ExcelStockVo>();
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(request.getParameter("skuCode"))) {
            map.put("skuCode", request.getParameter("skuCode"));
        }
        if (StringUtils.isNotEmpty(request.getParameter("productCode"))) {
            map.put("productCode", request.getParameter("productCode"));
        }
        if (StringUtils.isNotEmpty(request.getParameter("supplierCode"))) {
            map.put("supplierCode", request.getParameter("supplierCode"));
        }
        if (StringUtils.isNotEmpty(request.getParameter("storeCode"))) {
            map.put("storeCode", request.getParameter("storeCode"));
        }
        if (StringUtils.isNotEmpty(request.getParameter("channelSid"))) {
            map.put("channelSid", request.getParameter("channelSid"));
        }
        if (StringUtils.isNotEmpty(request.getParameter("shoppe"))) {
            map.put("counterCode", request.getParameter("shoppe"));
        }
        String str = JsonUtil.getJSONString(map);
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/stockAdmin/queryProductInfoExcel.htm", str);
            JSONObject js = JSONObject.fromObject(json);
            Object objs = js.get("data");
            // 得到JSONArray
            JSONArray arr = JSONArray.fromObject(objs);
            if (arr.size() > 0) {
                for (int i = 0; i < arr.size(); i++) {
                    JSONObject jOpt = arr.getJSONObject(i);
                    ExcelStockVo vo = (ExcelStockVo) JSONObject.toBean(jOpt, ExcelStockVo.class);
                    epv.add(vo);
                }
            }

            String result = allProSkusToExcel(response, epv, title);
            jsons = ResultUtil.createSuccessResult(result);

        } catch (Exception e) {
            e.printStackTrace();
            jsons = "";
        }

        return jsons;
    }

    /**
     * @param response
     * @param list
     * @param title
     * @return String
     * @Methods Name allProSkusToExcel
     * @Create In 2015-10-10 By chenhu
     */
    public String allProSkusToExcel(HttpServletResponse response, List<ExcelStockVo> list, String title) {
        List<String> header = new ArrayList<String>();

        header.add("商品SKU");
        header.add("专柜商品编码");
        header.add("销售单位");
        header.add("可售库");
        header.add("残次品库");
        header.add("退货库");
        header.add("锁定库");
        header.add("品牌");
        header.add("供应商");
        header.add("渠道");
        header.add("门店");

        List<List<String>> data = new ArrayList<List<String>>();
        for (ExcelStockVo vo : list) {
            List<String> inlist = new ArrayList<String>();

            inlist.add(vo.getSkuCode() == null ? "" : vo.getSkuCode());
            inlist.add(vo.getProductCode() == null ? "" : vo.getProductCode());
            inlist.add(vo.getUnitName() == null ? "" : vo.getUnitName());
            inlist.add(vo.getSaleStock() == null ? "" : vo.getSaleStock());
            inlist.add(vo.getEdefectiveStock() == null ? "" : vo.getEdefectiveStock());
            inlist.add(vo.getReturnStock() == null ? "" : vo.getReturnStock());
            inlist.add(vo.getLockedStock() == null ? "" : vo.getLockedStock());
            inlist.add(vo.getBrandName() == null ? "" : vo.getBrandName());
            inlist.add(vo.getSupplierName() == null ? "" : vo.getSupplierName());
            inlist.add(vo.getChannelName() == null ? "" : vo.getChannelName());
            inlist.add(vo.getStoreName() == null ? "" : vo.getStoreName());
//			inlist.add(vo.getSupplierCode()==null?"":vo.getSupplierCode());
//			inlist.add(vo.getChannelSid()==null?"":vo.getChannelSid());
//			inlist.add(vo.getStoreCode()==null?"":vo.getStoreCode());

            data.add(inlist);
        }
        ExcelFile ef = new ExcelFile(title, header, data);
        try {
            OutputStream file = response.getOutputStream();
            response.reset();
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-disposition",
                    "attachment; filename=/" + title + ".xls");

            ef.save(file);
            return "成功";
        } catch (Exception e) {
            return e.toString();
        }

    }

    /**
     * 查询渠道根据专柜商品sid
     *
     * @param request
     * @param response
     * @param shopSid
     * @return String
     * @Methods Name queryChannelListByShoppeSid
     * @Create In 2015-8-25 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryChannelListByShoppeProCode"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryChannelListByShoppeProSid(HttpServletRequest request,
                                                 HttpServletResponse response, String shoppeProCode) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("shoppeProCode", shoppeProCode);

        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/channelSaleConfig/findListChannelSaleByShoppeProSid.htm", JsonUtil.getJSONString(map));
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
