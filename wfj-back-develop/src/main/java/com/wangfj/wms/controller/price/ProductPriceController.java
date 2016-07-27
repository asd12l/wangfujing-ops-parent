package com.wangfj.wms.controller.price;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wangfj.wms.service.IRoleLimitService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.wms.controller.price.support.ExcelPriceVo;
import com.wangfj.wms.controller.price.support.ProductPagePara;
import com.wangfj.wms.controller.price.support.QueryPricePara;
import com.wangfj.wms.controller.stock.support.ExcelStockVo;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;

@Controller
@RequestMapping("/productPrice")
public class ProductPriceController {

    @Autowired
    @Qualifier("roleLimitService")
    private IRoleLimitService roleLimitService;

    /**
     * 价格管理分页查询
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name selectPricePara
     * @Create In 2015-9-15 By chengsj
     */
    @RequestMapping(value = "/selectPricePara", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public String selectPricePara(HttpServletRequest request, HttpServletResponse response) {
        String json = "";
        ProductPagePara productPagePara = new ProductPagePara();
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }

        String productName = request.getParameter("productName");
        String productCode = request.getParameter("productCode");
        String supplyCode = request.getParameter("supplyCode");
        String storeCode = request.getParameter("storeCode");
        String channelSid = request.getParameter("channelSid");
        String shoppeCode = request.getParameter("shoppeCode");
        String productSku = request.getParameter("productSku");
        if (!StringUtils.isEmpty(productName)) {
            productPagePara.setProductName(productName);
        }
        if (!StringUtils.isEmpty(productCode)) {
            productPagePara.setProductCode(productCode);
        }
        if (!StringUtils.isEmpty(supplyCode)) {
            productPagePara.setSupplierCode(supplyCode);
        }
        if (!StringUtils.isEmpty(storeCode)) {
            productPagePara.setStoreCode(storeCode);
            List<String> levels = new ArrayList<String>();
            levels.add("4");
            List<String> managerCategoryCodes = roleLimitService.selectManageCateByShopSidAndLevel(storeCode, levels);
            if (managerCategoryCodes != null && managerCategoryCodes.size() > 0) {
                productPagePara.setManagerCategoryCodes(managerCategoryCodes);
            }
        }
        if (!StringUtils.isEmpty(channelSid)) {
            productPagePara.setChannelSid(channelSid);
        }
        if (!StringUtils.isEmpty(shoppeCode)) {
            productPagePara.setCounterCode(shoppeCode);
        }
        if (!StringUtils.isEmpty(productSku)) {
            productPagePara.setSkuCode(productSku);
        }
        productPagePara.setCurrentPage(currPage);
        productPagePara.setPageSize(size);
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmprice/queryProductPriceInfoFromSearch.htm", JsonUtil.getJSONString(productPagePara));
            map.clear();
            if (!StringUtils.isEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    map.put("list", jsonPage.get("list"));
                    map.put("pageCount", jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
                    Integer total = jsonPage.getInt("count");
                    map.put("total", total);
                    //搜索 ES 1W以上数据分页查不出来
                    Integer esTotal = 10000;
                    if (total > esTotal) {
                        Integer pageCount = esTotal % size == 0 ? esTotal / size : esTotal / size + 1;
                        map.put("pageCount", pageCount);
                    }
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
     * 查询价格详情
     *
     * @param request
     * @param shoppeProSid
     * @return String
     * @Methods Name queryShoppeProPriceInfo
     * @Create In 2015-9-15 By chengsj
     */
    @RequestMapping(value = "/queryShoppeProPriceInfo", method = RequestMethod.POST)
    @ResponseBody
    public String queryShoppeProPriceInfo(HttpServletRequest request, String shoppeProSid) {
        QueryPricePara queryPricePara = new QueryPricePara();
        String json = "";
        if (!StringUtils.isEmpty(shoppeProSid)) {
            queryPricePara.setShoppeProSid(shoppeProSid);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmprice/queryShoppeProPriceInfo.htm", JsonUtil.getJSONString(queryPricePara));
            map.clear();
            if (!StringUtils.isEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONArray jsonPage = (JSONArray) jsonObject.get("data");
                if (jsonPage != null) {
                    map.put("list", jsonPage);
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
     * 价格导出Excel 查总数
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name getStockToExcelCount
     * @Create In 2016-04-05 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = "/getStockToExcelCount", method = {RequestMethod.GET, RequestMethod.POST})
    public String getStockToExcelCount(HttpServletRequest request, String productCode, String supplyCode, String storeCode,
                                       String channelSid, String productSku, String shoppe) {

        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(productCode)) {
            map.put("productCode", productCode);
        }
        if (StringUtils.isNotEmpty(supplyCode)) {
            map.put("supplierCode", supplyCode);
        }
        if (StringUtils.isNotEmpty(storeCode)) {
            map.put("storeCode", storeCode);
        }
        if (StringUtils.isNotEmpty(channelSid)) {
            map.put("channelSid", channelSid);
        }
        if (StringUtils.isNotEmpty(productSku)) {
            map.put("skuCode", productSku);
        }
        if (StringUtils.isNotEmpty(shoppe)) {
            map.put("counterCode", shoppe);
        }
        String str = JsonUtil.getJSONString(map);
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmprice/queryProductPriceInfoExcelCount.htm", str);
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
     * 价格导出Excel
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name getStockToExcel
     * @Create In 2015-10-9 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = "/getPriceToExcel", method = {RequestMethod.GET, RequestMethod.POST})
    public String getStockToExcel(HttpServletRequest request, HttpServletResponse response, String productCode, String supplyCode,
                                  String storeCode, String channelSid, String productSku, String shoppe) {
        String jsons = "";
        String title = "allPrice";

        List<ExcelPriceVo> epv = new ArrayList<ExcelPriceVo>();
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(productCode)) {
            map.put("productCode", productCode);
        }
        if (StringUtils.isNotEmpty(supplyCode)) {
            map.put("supplierCode", supplyCode);
        }
        if (StringUtils.isNotEmpty(storeCode)) {
            map.put("storeCode", storeCode);
        }
        if (StringUtils.isNotEmpty(channelSid)) {
            map.put("channelSid", channelSid);
        }
        if (StringUtils.isNotEmpty(productSku)) {
            map.put("skuCode", productSku);
        }
        if (StringUtils.isNotEmpty(shoppe)) {
            map.put("counterCode", shoppe);
        }
        String str = JsonUtil.getJSONString(map);
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmprice/queryProPriceInfoExcel.htm", str);
            JSONObject js = JSONObject.fromObject(json);
            Object objs = js.get("data");
            // 得到JSONArray
            JSONArray arr = JSONArray.fromObject(objs);
            if (arr.size() > 0) {
                for (int i = 0; i < arr.size(); i++) {
                    JSONObject jOpt = arr.getJSONObject(i);
                    ExcelPriceVo vo = (ExcelPriceVo) JSONObject.toBean(jOpt, ExcelPriceVo.class);
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
    public String allProSkusToExcel(HttpServletResponse response, List<ExcelPriceVo> list, String title) {
        List<String> header = new ArrayList<String>();

        header.add("商品名称");
        header.add("专柜商品编码");
        header.add("款号");
        header.add("颜色名称");
        header.add("规格名称");
        header.add("市场价");
        header.add("零售价");
        header.add("供应商");
        header.add("渠道");
        header.add("门店");

        List<List<String>> data = new ArrayList<List<String>>();
        for (ExcelPriceVo vo : list) {
            List<String> inlist = new ArrayList<String>();

            inlist.add(vo.getProductName() == null ? "" : vo.getProductName());
            inlist.add(vo.getProductCode() == null ? "" : vo.getProductCode());
            inlist.add(vo.getModelCode() == null ? "" : vo.getModelCode());
            inlist.add(vo.getColorName() == null ? "" : vo.getColorName());
            inlist.add(vo.getStanName() == null ? "" : vo.getStanName());
            inlist.add(vo.getMarketPrice() == null ? "" : vo.getMarketPrice());
            inlist.add(vo.getSalesPrice() == null ? "" : vo.getSalesPrice());
            inlist.add(vo.getSupplierName() == null ? "" : vo.getSupplierName());
            inlist.add(vo.getChannelName() == null ? "" : vo.getChannelName());
            inlist.add(vo.getStoreName() == null ? "" : vo.getStoreName());

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
}

