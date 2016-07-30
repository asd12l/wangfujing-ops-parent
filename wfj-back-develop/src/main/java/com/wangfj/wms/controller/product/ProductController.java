package com.wangfj.wms.controller.product;

import com.alibaba.fastjson.JSON;
import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.back.controller.SecutityController;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.controller.product.support.ExcelShoppeProductVo;
import com.wangfj.wms.domain.entity.*;
import com.wangfj.wms.domain.view.*;
import com.wangfj.wms.service.IRoleLimitService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/product")
public class ProductController {

    protected final Log logger = LogFactory.getLog(SecutityController.class);

    @Autowired
    @Qualifier("roleLimitService")
    private IRoleLimitService roleLimitService;


    /**
     * 根据专柜商品编码查询统计分类信息
     *
     * @param productCode
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"/findShoppeProductAndCategoryByPara"})
    public String findShoppeProductAndCategoryByPara(String productCode) {
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        Map<String, Object> para = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(productCode)) {
            para.put("productCode", productCode.trim());
            try {
                String url = SystemConfig.SSD_SYSTEM_URL + "/product/findShoppeProductAndCategoryByPara.htm";
                String doPost = HttpUtil.doPost(url, JsonUtil.getJSONString(para));
                if (StringUtils.isNotEmpty(doPost)) {
                    JSONObject jsonObject = JSONObject.fromObject(doPost);
                    Object obj = jsonObject.get("data");
                    if (obj != null && !"null".equals(obj)) {
                        JSONArray data = jsonObject.getJSONArray("data");
                        para.clear();
                        para.put("list", data.get(0));
                        para.put("success", "true");
                        return gson.toJson(para);
                    }
                }
            } catch (Exception e) {
                para.clear();
                para.put("success", "false");
                return gson.toJson(para);
            }
        }
        para.clear();
        para.put("success", "false");
        return gson.toJson(para);
    }

    /**
     * 根据专柜商品编码查询专柜商品信息
     *
     * @param productCode
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"/selectListByParam"})
    public String selectListByParam(String productCode) {
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        Map<String, Object> para = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(productCode)) {
            para.put("shoppeProSid", productCode.trim());
            try {
                String url = SystemConfig.SSD_SYSTEM_URL + "/product/selectListByParam.htm";
                String doPost = HttpUtil.doPost(url, JsonUtil.getJSONString(para));
                if (StringUtils.isNotEmpty(doPost)) {
                    JSONObject jsonObject = JSONObject.fromObject(doPost);
                    Object obj = jsonObject.get("data");
                    if (obj != null && !"null".equals(obj)) {
                        JSONArray data = jsonObject.getJSONArray("data");
                        para.clear();
                        para.put("list", data.get(0));
                        para.put("success", "true");
                        return gson.toJson(para);
                    }
                }
            } catch (Exception e) {
                para.clear();
                para.put("success", "false");
                return gson.toJson(para);
            }
        }
        para.clear();
        para.put("success", "false");
        return gson.toJson(para);
    }

    /**
     * 添加商品,保存基本信息
     *
     * @return String
     * @Methods Name saveProductBaseMessage
     * @Create In 2015年8月21日 By wangsy
     */
    public String saveProductBaseMessage() {
        return "";
    }

    /**
     * 导出所有商品skus信息到excel
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name getProductSkusToExcel
     * @Create In 2015-3-27 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/getProductSkusToExcel", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String getProductSkusToExcel(HttpServletRequest request, HttpServletResponse response) {
        String jsons = "";
        String title = "allSkus_dgw";
        List<ExcelProductVo> epv = new ArrayList<ExcelProductVo>();
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            String json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/bw/getProductSkusToExcel.json", map);
            JSONObject js = JSONObject.fromObject(json);
            Object objs = js.get("list");
            // 得到JSONArray
            JSONArray arr = JSONArray.fromObject(objs);
            if (arr.size() > 0) {
                for (int i = 0; i < arr.size(); i++) {
                    JSONObject jOpt = arr.getJSONObject(i);
                    ExcelProductVo vo = (ExcelProductVo) JSONObject.toBean(jOpt,
                            ExcelProductVo.class);
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

    public String allProSkusToExcel(HttpServletResponse response, List<ExcelProductVo> list,
                                    String title) {
        List<String> header = new ArrayList<String>();

        header.add("商品UPC码");
        header.add("外部SKU（非必填）");
        header.add("商品名称");
        header.add("京东价");
        header.add("市场价");

        List<List<String>> data = new ArrayList<List<String>>();
        for (ExcelProductVo vo : list) {
            List<String> inlist = new ArrayList<String>();

            inlist.add(vo.getProSPU() == null ? "" : vo.getProSPU());
            inlist.add((vo.getProSKU() == null ? "" : vo.getProSKU()));
            inlist.add(vo.getProductName() == null ? "" : vo.getProductName());
            inlist.add((vo.getChannelPrice() == null ? "" : vo.getChannelPrice()));
            inlist.add((vo.getMarketPrice() == null ? "" : vo.getMarketPrice()));

            data.add(inlist);
        }
        ExcelFile ef = new ExcelFile(title, header, data);
        try {
            OutputStream file = response.getOutputStream();
            response.reset();
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-disposition", "attachment; filename=/" + title + ".xls");

            ef.save(file);
            return "成功";
        } catch (Exception e) {
            return e.toString();
        }

    }

    /**
     * 获取供应链商品列表
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name getProdetailStockPriceBySid
     * @Create In 2015-3-20 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/getProdetailStockPriceBySid", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String getProdetailStockPriceBySid(HttpServletRequest request,
                                              HttpServletResponse response) {
        String json = "";
        String productSid = request.getParameter("productSid");
        String supplySid = request.getParameter("supplySid");
        String shopSid = request.getParameter("shopSid");

        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(productSid)) {
            map.put("productSid", productSid);
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            map.put("supplySid", supplySid);
        }
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("shopSid", shopSid);
        }

        try {
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/bw/getProdetailStockPriceBySid.json", map);
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }

        return json;
    }

    /**
     * 根据sku供应商ID门店Id 判断此记录供应链商品是否存在
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name queryProSkuShopSupplyExists
     * @Create In 2015-3-19 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/queryProSkuShopSupplyExists", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryProSkuShopSupplyExists(HttpServletRequest request,
                                              HttpServletResponse response) {
        String json = "";
        String productSid = request.getParameter("productSid");
        String supplySid = request.getParameter("supplySid");
        String shopSid = request.getParameter("shopSid");
        String proColorSid = request.getParameter("proColorSid");
        String proStanName = request.getParameter("proStanName");

        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(productSid)) {
            map.put("productSid", productSid);
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            map.put("supplySid", supplySid);
        }
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("shopSid", shopSid);
        }
        if (StringUtils.isNotEmpty(proColorSid)) {
            map.put("proColorSid", proColorSid);
        }
        if (StringUtils.isNotEmpty(proStanName)) {
            map.put("proStanName", proStanName);
        }

        try {
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/bw/queryProSkuShopSupplyExists.json", map);
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }

        return json;
    }

    /**
     * 查询详情
     *
     * @param id
     * @param m
     * @param request
     * @return String
     * @Methods Name getProductDetail
     * @Create In 2015年9月16日 By wangsy
     */
    @RequestMapping(value = "/getProductDetail/{id}", method = {RequestMethod.POST,
            RequestMethod.GET})
    public String getProductDetail(@PathVariable("id") String id, Model m, String tabMark1,
                                   String backUrl, HttpServletRequest request) {
        tabMark1 = (tabMark1 == "" || tabMark1 == null) ? "base" : tabMark1;
        m.addAttribute("backUrl", backUrl);
        // SKU请求
        String jsonSku = "";
        JSONObject jsonsSku = new JSONObject();
        String jsonShoppro = "";
        JSONObject jsons = new JSONObject();
        String json_2 = "";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("skuCode", id);
        try {
            String sku = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/getBaseSkuByPara.htm", JsonUtil.getJSONString(map));

            id = JSONObject.fromObject(JSONObject.fromObject(sku).get("data")).getString("sid");
            map.clear();
            map.put("skuSid", id);

            jsonShoppro = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectProPageBySku.htm", JsonUtil.getJSONString(map));
            jsons = JSONObject.fromObject(jsonShoppro);
            map.clear();
            map.put("sid", id);
            jsonSku = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectBaseSkuPageByPara.htm", JsonUtil.getJSONString(map));
            jsonsSku = JSONObject.fromObject(jsonSku);
            JSONObject oSku = (JSONObject) jsonsSku.get("data");
            JSONArray aSku = oSku.getJSONArray("list");
            JSONObject o2 = (JSONObject) aSku.get(0);
            String spuSid = (String) o2.get("spuSid");
            String spuCode = (String) o2.get("spuCode");

            map.clear();
            map.put("spuSid", spuSid);
            json_2 = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/bwCategoryController/bw/getGYCatePropValueBySpuSid.htm", map);
            map.clear();
            map.put("spuCode", spuCode);
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/productPrcture/queryColorBySpu.htm", JsonUtil.getJSONString(map));
            if (!"".equals(json) && json != null) {
                JSONObject colorJson = JSONObject.fromObject(json);
                if ("true".equals(colorJson.get("success"))) {
                    m.addAttribute("", "");
                    m.addAttribute("colors", colorJson.get("data"));
                    m.addAttribute("productCode", spuSid);
                } else {
                    m.addAttribute("error", "系统异常，请联系管理员！");
                    return "forward:/404.jsp";
                }
            } else {
                m.addAttribute("error", "系统异常，请联系管理员！");
                return "forward:/404.jsp";
            }

            JSONObject a2 = JSONObject.fromObject(json_2);
            /* JSONObject oo1 = (JSONObject) a2.get(0); */
            JSONArray a3 = (JSONArray) a2.get("data");

            if ("true".equals(jsons.get("success"))) {
                m.addAttribute("json", jsons);
            }
            m.addAttribute("tabMark1", tabMark1);
            m.addAttribute("json_2", a3);
            m.addAttribute("jsonsSku", aSku);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "forward:/jsp/product/getProductDetail.jsp";
    }

    @RequestMapping(value = "/getProductDetails/{id}", method = RequestMethod.GET)
    public String getProductDetails(@PathVariable("id") String id, Model m,
                                    HttpServletRequest request) {
        String jsonSku = "";
        JSONObject jsonsSku = new JSONObject();
        String jsonShoppro = "";
        JSONObject jsons = new JSONObject();
        String json_2 = "";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("skuSid", id);
        try {
            jsonShoppro = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectProPageBySku.htm", JsonUtil.getJSONString(map));
            jsons = JSONObject.fromObject(jsonShoppro);
            map.clear();
            map.put("sid", id);
            jsonSku = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectBaseSkuPageByPara.htm", JsonUtil.getJSONString(map));
            jsonsSku = JSONObject.fromObject(jsonSku);
            JSONObject oSku = (JSONObject) jsonsSku.get("data");
            JSONArray aSku = oSku.getJSONArray("list");
            JSONObject o2 = (JSONObject) aSku.get(0);
            String spuSid = (String) o2.get("spuSid");

            map.clear();
            map.put("productSid", spuSid);
            json_2 = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/bwCategoryController/bw/selectPropValueBySid.htm", map);
            JSONArray a2 = JSONArray.fromObject(json_2);
            JSONObject oo1 = (JSONObject) a2.get(0);
            JSONArray a3 = (JSONArray) oo1.get("cp");

            if ("true".equals(jsons.get("success"))) {
                m.addAttribute("json", jsons);
            }
            m.addAttribute("json_2", a3);
            m.addAttribute("jsonsSku", aSku);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "forward:/jsp/product/ProductMaintenance.jsp";
    }

    /**
     * 查看商品详情json
     *
     * @param id
     * @param request
     * @param response
     * @return String
     * @Methods Name getProdetail
     * @Create In 2015年8月18日 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/getProdetail/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String getProdetail(@PathVariable("id") String id, HttpServletRequest request,
                               HttpServletResponse response) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sid", id);
        try {
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/getProductDetail.html", map);
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }

        return json;
    }

    /**
     * 查询商品是否存在
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name queryProductInfoExists
     * @Create In 2015-3-13 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/queryProductInfoExists", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryProductInfoExists(HttpServletRequest request, HttpServletResponse response) {
        String json = "";
        // String productName = request.getParameter("productName");
        String productSku = request.getParameter("productSku");
        String brandSid = request.getParameter("brandSid");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("brandSid", brandSid);
        // map.put("productName", productName);
        map.put("productSku", productSku);

        try {
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/bw/queryProductInfoExists.json", map);
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }

        return json;
    }

    /**
     * 补充商品信息
     *
     * @Methods Name addProductOthers
     * @Create In 2015-3-13 By chengsj
     * @param productAddVO
     * @param mode
     * @param request
     * @param response
     * @return String
     */
    /*
     * @ResponseBody
	 * 
	 * @RequestMapping(value = "/addProductOthers", method = {
	 * RequestMethod.GET, RequestMethod.POST }) public String
	 * addProductOthers(@ModelAttribute("productAddVO") ProductAddVO
	 * productAddVO, Model mode, HttpServletRequest request, HttpServletResponse
	 * response) { System.out.println("HOUTAI:" + productAddVO.toString());
	 * String json = ""; Map<String, Object> map = new HashMap<String,
	 * Object>(); if (productAddVO != null) { if
	 * (StringUtils.isNotEmpty(productAddVO.getSid())) { map.put("sid",
	 * productAddVO.getSid()); } if
	 * (StringUtils.isNotEmpty(productAddVO.getOriginalPrice())) {
	 * map.put("originalPrice", productAddVO.getOriginalPrice()); } if
	 * (StringUtils.isNotEmpty(productAddVO.getSupplySid())) {
	 * map.put("supplySid", productAddVO.getSupplySid()); } if
	 * (StringUtils.isNotEmpty(productAddVO.getShopSid())) { map.put("shopSid",
	 * productAddVO.getShopSid()); } if
	 * (StringUtils.isNotEmpty(productAddVO.getStockTypeSid())) {
	 * map.put("stockTypeSid", productAddVO.getStockTypeSid()); }
	 * 
	 * if (StringUtils.isNotEmpty(productAddVO.getProductColorStanSunStocks()))
	 * { map.put("productColorStanSunStocks",
	 * productAddVO.getProductColorStanSunStocks()); }
	 * 
	 * try { json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
	 * "/bw/addProductOthers.json", map); } catch (Exception e) {
	 * e.printStackTrace(); json = ""; } } else { json = "参数为空"; }
	 * 
	 * return json; }
	 */

    /**
     * 跳转补充商品信息页面
     *
     * @Methods Name getProductBySid
     * @Create In 2015-3-12 By chengsj
     * @param id
     * @param m
     * @param request
     * @return String
     */
    /*
     * @RequestMapping(value = "/toproduct/{id}", method = RequestMethod.GET)
	 * public String getProductBySid(@PathVariable("id") String id, Model m,
	 * HttpServletRequest request) { String json = ""; JSONObject jsons = new
	 * JSONObject(); Map<String, Object> map = new HashMap<String, Object>();
	 * map.put("sid", id); try { json =
	 * HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/getProduct.json",
	 * map); jsons = JSONObject.fromObject(json); } catch (Exception e) {
	 * e.printStackTrace(); json = ""; } m.addAttribute("productSid", id);
	 * m.addAttribute("json", jsons);
	 * 
	 * return "forward:/jsp/product/addProductViewNext.jsp"; }
	 */

    /**
     * 商品模块-商品信息管理-商品管理-查询所有商品
     *
     * @param request
     * @param response
     * @param ssdProduct
     * @return String
     * @Methods Name selectAllProduct
     * @Create In 2015-4-17 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectAllProduct", method = {RequestMethod.POST, RequestMethod.GET})
    public String selectAllProduct(HttpServletRequest request, HttpServletResponse response,
                                   SsdProduct ssdProduct) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        try {
            proMap.put("pageSize", size);// 每页显示数量
            proMap.put("currentPage", currPage);// 当前第几页
            if (!"1".equals(ssdProduct.getCache())) {
                if (null != ssdProduct.getSkuName() && !"".equals(ssdProduct.getSkuName())) {
                    proMap.put("skuName", ssdProduct.getSkuName());
                }
                if (null != ssdProduct.getSpuName() && !"".equals(ssdProduct.getSpuName())) {
                    proMap.put("spuName", ssdProduct.getSpuName());
                }
                if (null != ssdProduct.getSkuCode() && !"".equals(ssdProduct.getSkuCode())) {
                    proMap.put("skuCode", ssdProduct.getSkuCode());
                }
                String minSkuCode = ssdProduct.getMinSkuCode();
                if (StringUtils.isNotEmpty(minSkuCode)) {
                    proMap.put("minSkuCode", minSkuCode);
                }
                String maxSkuCode = ssdProduct.getMaxSkuCode();
                if (StringUtils.isNotEmpty(maxSkuCode)) {
                    proMap.put("maxSkuCode", maxSkuCode);
                }
                if (null != ssdProduct.getSpuCode() && !"".equals(ssdProduct.getSpuCode())) {
                    proMap.put("spuCode", ssdProduct.getSpuCode());
                }
                if (null != ssdProduct.getSpuSid() && !"".equals(ssdProduct.getSpuSid())) {
                    proMap.put("spuSid", ssdProduct.getSpuSid());
                }
                if (null != ssdProduct.getProType() && !"".equals(ssdProduct.getProType())) {
                    proMap.put("proType", ssdProduct.getProType());
                }
                if (null != ssdProduct.getBrandGroupCode()
                        && !"".equals(ssdProduct.getBrandGroupCode())) {
                    proMap.put("brandGroupCode", ssdProduct.getBrandGroupCode());
                }
                if (null != ssdProduct.getModelCode() && !"".equals(ssdProduct.getModelCode())) {
                    proMap.put("modelCode", ssdProduct.getModelCode());
                }
                if (null != ssdProduct.getColorSid() && !"".equals(ssdProduct.getColorSid())) {
                    proMap.put("colorSid", ssdProduct.getColorSid());
                }
                if (null != ssdProduct.getPhotoStatus() && !"".equals(ssdProduct.getPhotoStatus())) {
                    proMap.put("photoStatus", ssdProduct.getPhotoStatus());
                }
                if (null != ssdProduct.getSkuSale() && !"".equals(ssdProduct.getSkuSale())) {
                    proMap.put("skuSale", ssdProduct.getSkuSale());
                }
                if (null != ssdProduct.getProActiveBit()
                        && !"".equals(ssdProduct.getProActiveBit())) {
                    proMap.put("proActiveBit", ssdProduct.getProActiveBit());
                }
                json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                        + "/product/selectBaseSkuPageByPara.htm", JsonUtil.getJSONString(proMap));
            } else {
                json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                        // + "/product/selectBaseSkuPageByPara.htm",
                        // JsonUtil.getJSONString(proMap));
                        + "/product/selectSkuPageCache.htm", JsonUtil.getJSONString(proMap));
            }
            proMap.clear();
            if (!"".equals(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    proMap.put("list", jsonPage.get("list"));
                    proMap.put("pageCount",
                            jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
                } else {
                    proMap.put("list", null);
                    proMap.put("pageCount", 0);
                }
            } else {
                proMap.put("list", null);
                proMap.put("pageCount", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        JSONObject jsonArray = JSONObject.fromObject(proMap);
        return jsonArray.toString();

    }

    /**
     * 商品模块-商品信息管理-商品管理-查询所有商品
     *
     * @param request
     * @param response
     * @param ssdProduct
     * @return String
     * @Methods Name selectAllProduct
     * @Create In 2015-4-17 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectSkuProductBySpuAndColor", method = {RequestMethod.POST, RequestMethod.GET})
    public String selectSkuProductBySpuAndColor(HttpServletRequest request, HttpServletResponse response,
                                                SsdProduct ssdProduct) {
        String json = "";

        Map<String, Object> proMap = new HashMap<String, Object>();
        try {
            if (null != ssdProduct.getSpuCode() && !"".equals(ssdProduct.getSpuCode())) {
                proMap.put("spuCode", ssdProduct.getSpuCode());
            }
            if (null != ssdProduct.getColorSid() && !"".equals(ssdProduct.getColorSid())) {
                proMap.put("colorSid", ssdProduct.getColorSid());
            }

            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectBaseSkuPageByPara.htm", JsonUtil.getJSONString(proMap));
            proMap.clear();
            if (!"".equals(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    proMap.put("list", jsonPage.get("list"));
                    proMap.put("packimgUrl", SystemConfig.PACKIMG_URL);
                    proMap.put("pageCount",
                            jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
                } else {
                    proMap.put("list", null);
                    proMap.put("pageCount", 0);
                }
            } else {
                proMap.put("list", null);
                proMap.put("pageCount", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        JSONObject jsonArray = JSONObject.fromObject(proMap);
        return jsonArray.toString();

    }

    /**
     * 商品模块-商品信息管理-商品管理-查询所有商品
     *
     * @param request
     * @param response
     * @param ssdProduct
     * @return String
     * @Methods Name selectAllProduct
     * @Create In 2015-4-17 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectAllSpu", method = {RequestMethod.POST, RequestMethod.GET})
    public String selectAllSpu(HttpServletRequest request, HttpServletResponse response,
                               SpuPageVO ssdProduct) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        try {
            proMap.put("pageSize", size);// 每页显示数量
            proMap.put("currentPage", currPage);// 当前第几页
            if (null != ssdProduct.getSid()) {
                proMap.put("sid", ssdProduct.getSid());
            }
            if (StringUtils.isNotBlank(ssdProduct.getSpuCode())) {
                proMap.put("spuCode", ssdProduct.getSpuCode().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getProductAbbr())) {
                proMap.put("productAbbr", ssdProduct.getProductAbbr().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getModelCode())) {
                proMap.put("modelCode", ssdProduct.getModelCode().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getPrimaryAttr())) {
                proMap.put("primaryAttr", ssdProduct.getPrimaryAttr().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getProductName())) {
                proMap.put("productName", ssdProduct.getProductName().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getBrandGroupName())) {
                proMap.put("brandGroupName", ssdProduct.getBrandGroupName().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getSpuSale())) {
                proMap.put("spuSale", ssdProduct.getSpuSale().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getSexSid())) {
                proMap.put("sexSid", ssdProduct.getSexSid().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getSeason())) {
                proMap.put("season", ssdProduct.getSeason().trim());
            }
            if (StringUtils.isNotBlank(ssdProduct.getIndustryCondition())) {
                proMap.put("industryCondition", ssdProduct.getIndustryCondition().trim());
            }
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectBaseSpuPageByPara.htm", JsonUtil.getJSONString(proMap));
            proMap.clear();
            if (!"".equals(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    proMap.put("list", jsonPage.get("list"));
                    proMap.put("pageCount",
                            jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
                } else {
                    proMap.put("list", null);
                    proMap.put("pageCount", 0);
                }
            } else {
                proMap.put("list", null);
                proMap.put("pageCount", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        JSONObject jsonArray = JSONObject.fromObject(proMap);
        return jsonArray.toString();

    }

    /**
     * 查询所有商品缓存SQL
     *
     * @param request
     * @param response
     * @param ssdProduct
     * @return String
     * @Methods Name selectProPageCache
     * @Create In 2015年10月12日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectProPageCache", method = {RequestMethod.POST, RequestMethod.GET})
    public String selectProPageCache(HttpServletRequest request, HttpServletResponse response,
                                     SsdProduct ssdProduct) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        try {
            proMap.put("pageSize", size);// 每页显示数量
            proMap.put("currentPage", currPage);// 当前第几页
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectProPageCache.htm", JsonUtil.getJSONString(proMap));
            proMap.clear();
            if (!"".equals(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    proMap.put("list", jsonPage.get("list"));
                    proMap.put("pageCount",
                            jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
                } else {
                    proMap.put("list", null);
                    proMap.put("pageCount", 0);
                }
            } else {
                proMap.put("list", null);
                proMap.put("pageCount", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        JSONObject jsonArray = JSONObject.fromObject(proMap);
        return jsonArray.toString();

    }

    /**
     * 跳转到专柜商品列表页
     *
     * @param id
     * @param m
     * @param request
     * @return String
     * @Methods Name getProductDetail
     * @Create In 2015-9-8 By chengsj
     */
    @RequestMapping(value = "/toShoppeProduct/{sid}", method = RequestMethod.GET)
    public String toShoppeProduct(@PathVariable("sid") String skuSid, Model m,
                                  HttpServletRequest request) {
        Map<String, Object> proMap = new HashMap<String, Object>();
        proMap.put("sid", skuSid);
        m.addAttribute("skuSid", skuSid);
        String forwardUrl = "";
        String json = "";
        json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/product/getBaseSkuByPara.htm",
                JsonUtil.getJSONString(proMap));
        proMap.clear();

        try {
            JSONObject jsonObject = JSONObject.fromObject(json);

            if (jsonObject != null) {
                if ("true".equals(jsonObject.get("success"))) {
                    JSONObject skuDto = (JSONObject) jsonObject.get("data");
                    if (skuDto != null) {
                        m.addAttribute("sku", skuDto);
                        forwardUrl = "forward:/jsp/product/shoppeProductView_1.jsp";
                    } else {
                        m.addAttribute("error", "系统异常，找不到对应的商品！");
                        forwardUrl = "forward:/404.jsp";
                    }
                } else {
                    m.addAttribute("error", "系统异常，请联系管理员！");
                    forwardUrl = "forward:/404.jsp";
                }
            } else {
                m.addAttribute("error", "系统异常，请联系管理员！");
                forwardUrl = "forward:/404.jsp";
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return forwardUrl;
    }

    /**
     * 查询专柜商品列表
     *
     * @param request
     * @param response
     * @param shoppeProduct
     * @return String
     * @Methods Name selectShoppeProductBySku
     * @Create In 2015-9-8 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/selectShoppeProductBySku", method = {RequestMethod.POST,
            RequestMethod.GET})
    public String selectShoppeProductBySku(HttpServletRequest request,
                                           HttpServletResponse response, PcmShoppeProductVo shoppeProduct) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        try {
            proMap.put("pageSize", size);// 每页显示数量
            proMap.put("currentPage", currPage);// 当前第几页

            // 商品sid
            if (null != shoppeProduct.getProductDetailSid()
                    && !"".equals(shoppeProduct.getProductDetailSid())) {
                proMap.put("skuSid", shoppeProduct.getProductDetailSid());
            }

            // 专柜商品名称
            if (null != shoppeProduct.getShoppeProName()
                    && !"".equals(shoppeProduct.getShoppeProName())) {
                proMap.put("productName", shoppeProduct.getShoppeProName());
            }
            // 销售状态
            if (null != shoppeProduct.getSaleStatus() && !"".equals(shoppeProduct.getSaleStatus())) {
                proMap.put("isSale", shoppeProduct.getSaleStatus());
            }
            // if (null != shoppeProduct.getBrandName() &&
            // !"".equals(ssdProduct.getBrandName())) {
            // proMap.put("brandName", ssdProduct.getBrandName());
            // }
            // if (null != ssdProduct.getSkuCode() &&
            // !"".equals(ssdProduct.getSkuCode())) {
            // proMap.put("skuCode", ssdProduct.getSkuCode());
            // }
            // if (null != ssdProduct.getSpuCode() &&
            // !"".equals(ssdProduct.getSpuCode())) {
            // proMap.put("spuCode", ssdProduct.getSpuCode());
            // }
            // if (null != ssdProduct.getProActiveBit() &&
            // !"".equals(ssdProduct.getProActiveBit())) {
            // proMap.put("proActiveBit", ssdProduct.getProActiveBit());
            // }
            // if (null != ssdProduct.getProSelling() &&
            // !"".equals(ssdProduct.getProSelling())) {
            // proMap.put("proSelling", ssdProduct.getProSelling());
            // }
            // if (null != ssdProduct.getProType() &&
            // !"".equals(ssdProduct.getProType())) {
            //
            // proMap.put("proType", ssdProduct.getProType());
            // }
            // if (null != ssdProduct.getBetweenCreateTime()
            // && !"".equals(ssdProduct.getBetweenCreateTime())) {
            // proMap.put("betweenCreateTime",
            // ssdProduct.getBetweenCreateTime());
            // }
            // if (null != ssdProduct.getEndCreateTime() &&
            // !"".equals(ssdProduct.getEndCreateTime())) {
            // proMap.put("endCreateTime", ssdProduct.getEndCreateTime());
            // }
            // if (null != ssdProduct.getBetweenCurrentPrice()
            // && !"".equals(ssdProduct.getBetweenCurrentPrice())) {
            // proMap.put("betweenCurrentPrice",
            // ssdProduct.getBetweenCurrentPrice());
            // }
            // if (null != ssdProduct.getEndnCurrentPrice()
            // && !"".equals(ssdProduct.getEndnCurrentPrice())) {
            // proMap.put("endCurrentPrice", ssdProduct.getEndnCurrentPrice());
            // }
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectProPageBySku.htm", JsonUtil.getJSONString(proMap));
            proMap.clear();
            if (json != null) {
                if (!"".equals(json)) {
                    JSONObject jsonObject = JSONObject.fromObject(json);
                    JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                    if (jsonPage != null) {
                        proMap.put("list", jsonPage.get("list"));
                        proMap.put("pageCount",
                                jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
                    } else {
                        proMap.put("list", null);
                        proMap.put("pageCount", 0);
                    }
                } else {
                    proMap.put("list", null);
                    proMap.put("pageCount", 0);
                }
            } else {
                proMap.put("list", null);
                proMap.put("pageCount", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        JSONObject jsonArray = JSONObject.fromObject(proMap);
        return jsonArray.toString();

    }

    @ResponseBody
    @RequestMapping(value = "/selectErpProduct", method = {RequestMethod.POST, RequestMethod.GET})
    public String selectErpProduct(HttpServletRequest request, HttpServletResponse response,
                                   ErpProductVo erpProduct) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        try {
            proMap.put("pageSize", size);// 每页显示数量
            proMap.put("currentPage", currPage);// 当前第几页

            // ERP商品编码
            if (null != erpProduct.getProductCode() && !"".equals(erpProduct.getProductCode())) {
                proMap.put("productCode", erpProduct.getProductCode());
            }
            if (null != erpProduct.getProductName() && !"".equals(erpProduct.getProductName())) {
                proMap.put("productName", erpProduct.getProductName());
            }

            // 专柜名称
            if (null != erpProduct.getShoppeCode() && !"".equals(erpProduct.getShoppeCode())) {
                proMap.put("counterCode", erpProduct.getShoppeCode());
            }
            // 门店编码
            if (null != erpProduct.getStoreCode() && !"".equals(erpProduct.getStoreCode())) {
                proMap.put("storeCode", erpProduct.getStoreCode());
                List<String> levelList = new ArrayList<String>();
                levelList.add("4");
                List<String> manageCateCodeList = roleLimitService.selectManageCateByShopSidAndLevel(erpProduct.getStoreCode(), levelList);
                if (manageCateCodeList != null && manageCateCodeList.size() != 0) {
                    proMap.put("cateList", manageCateCodeList);
                } else {
                    proMap.put("cateList", null);
                }
            }
            // 供应商编码
            if (null != erpProduct.getSupplyCode() && !"".equals(erpProduct.getSupplyCode())) {
                proMap.put("supplierCode", erpProduct.getSupplyCode());
            }

            // // 商品sid
            // if (null != shoppeProduct.getProductDetailSid()
            // && !"".equals(shoppeProduct.getProductDetailSid())) {
            // proMap.put("skuSid", shoppeProduct.getProductDetailSid());
            // }
            //
            // // 专柜商品名称
            // if (null != shoppeProduct.getShoppeProName()
            // && !"".equals(shoppeProduct.getShoppeProName())) {
            // proMap.put("productName", shoppeProduct.getShoppeProName());
            // }
            // // 销售状态
            // if (null != shoppeProduct.getSaleStatus() &&
            // !"".equals(shoppeProduct.getSaleStatus())) {
            // proMap.put("isSale", shoppeProduct.getSaleStatus());
            // }
            // if (null != shoppeProduct.getBrandName() &&
            // !"".equals(ssdProduct.getBrandName())) {
            // proMap.put("brandName", ssdProduct.getBrandName());
            // }
            // if (null != ssdProduct.getSkuCode() &&
            // !"".equals(ssdProduct.getSkuCode())) {
            // proMap.put("skuCode", ssdProduct.getSkuCode());
            // }
            // if (null != ssdProduct.getSpuCode() &&
            // !"".equals(ssdProduct.getSpuCode())) {
            // proMap.put("spuCode", ssdProduct.getSpuCode());
            // }
            // if (null != ssdProduct.getProActiveBit() &&
            // !"".equals(ssdProduct.getProActiveBit())) {
            // proMap.put("proActiveBit", ssdProduct.getProActiveBit());
            // }
            // if (null != ssdProduct.getProSelling() &&
            // !"".equals(ssdProduct.getProSelling())) {
            // proMap.put("proSelling", ssdProduct.getProSelling());
            // }
            // if (null != ssdProduct.getProType() &&
            // !"".equals(ssdProduct.getProType())) {
            //
            // proMap.put("proType", ssdProduct.getProType());
            // }
            // if (null != ssdProduct.getBetweenCreateTime()
            // && !"".equals(ssdProduct.getBetweenCreateTime())) {
            // proMap.put("betweenCreateTime",
            // ssdProduct.getBetweenCreateTime());
            // }
            // if (null != ssdProduct.getEndCreateTime() &&
            // !"".equals(ssdProduct.getEndCreateTime())) {
            // proMap.put("endCreateTime", ssdProduct.getEndCreateTime());
            // }
            // if (null != ssdProduct.getBetweenCurrentPrice()
            // && !"".equals(ssdProduct.getBetweenCurrentPrice())) {
            // proMap.put("betweenCurrentPrice",
            // ssdProduct.getBetweenCurrentPrice());
            // }
            // if (null != ssdProduct.getEndnCurrentPrice()
            // && !"".equals(ssdProduct.getEndnCurrentPrice())) {
            // proMap.put("endCurrentPrice", ssdProduct.getEndnCurrentPrice());
            // }
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                            + "/erpProductPIS/findErpProductFromPcmPage.htm",
                    JsonUtil.getJSONString(proMap));
            System.out.println(json);
            proMap.clear();
            if (json != null) {
                if (!"".equals(json)) {
                    JSONObject jsonObject = JSONObject.fromObject(json);
                    JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                    if (jsonPage != null) {
                        proMap.put("list", jsonPage.get("list"));
                        proMap.put("pageCount",
                                jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
                    } else {
                        proMap.put("list", null);
                        proMap.put("pageCount", 0);
                    }
                } else {
                    proMap.put("list", null);
                    proMap.put("pageCount", 0);
                }
            } else {
                proMap.put("list", null);
                proMap.put("pageCount", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        JSONObject jsonArray = JSONObject.fromObject(proMap);
        return jsonArray.toString();

    }

    /**
     * 查询专柜商品列表(用于专柜商品列表加载)
     *
     * @param request
     * @param response
     * @param shoppeProduct
     * @return String
     * @Methods Name selectShoppeProduct
     * @Create In 2015-9-8 By duanzhaole
     */
    @ResponseBody
    @RequestMapping(value = "/selectShoppeProduct", method = {RequestMethod.POST,
            RequestMethod.GET})
    public String selectShoppeProduct(HttpServletRequest request, HttpServletResponse response,
                                      PcmShoppeProductVo shoppeProduct) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        try {
            proMap.put("pageSize", size);// 每页显示数量
            proMap.put("currentPage", currPage);// 当前第几页

            // 商品编码
            String shoppeProSid = shoppeProduct.getShoppeProSid();
            if (StringUtils.isNotEmpty(shoppeProSid)) {
                proMap.put("productCode", shoppeProSid.trim());
            }
            // 专柜商品编码(分段查询的最小值)
            String minShoppeProSid = shoppeProduct.getMinShoppeProSid();
            if (StringUtils.isNotEmpty(minShoppeProSid)) {
                proMap.put("minProductCode", minShoppeProSid.trim());
            }
            // 专柜商品编码(分段查询的最大值)
            String maxShoppeProSid = shoppeProduct.getMaxShoppeProSid();
            if (StringUtils.isNotEmpty(maxShoppeProSid)) {
                proMap.put("maxProductCode", maxShoppeProSid.trim());
            }
            // 专柜商品名称
            String shoppeProName = shoppeProduct.getShoppeProName();
            if (StringUtils.isNotEmpty(shoppeProName)) {
                proMap.put("productName", shoppeProName.trim());
            }
            // sku编码
            String productDetailSid = shoppeProduct.getProductDetailSid();
            if (StringUtils.isNotEmpty(productDetailSid)) {
                proMap.put("skuCode", productDetailSid.trim());
            }
            // 商品表SKU 编码(分段查询的最小值)
            String minProductDetailSid = shoppeProduct.getMinProductDetailSid();
            if (StringUtils.isNotEmpty(minProductDetailSid)) {
                proMap.put("minSkuCode", minProductDetailSid.trim());
            }
            // 商品表SKU 编码(分段查询的最大值)
            String maxProductDetailSid = shoppeProduct.getMaxProductDetailSid();
            if (StringUtils.isNotEmpty(maxProductDetailSid)) {
                proMap.put("maxSkuCode", maxProductDetailSid.trim());
            }
            // 销售状态
            String saleStatus = shoppeProduct.getSaleStatus();
            if (StringUtils.isNotEmpty(saleStatus)) {
                if ("Y".equals(saleStatus)) {
                    proMap.put("isSale", "0");
                }
                if ("N".equals(saleStatus)) {
                    proMap.put("isSale", "1");
                }
            }
            // 专柜名称
            String shoppeSid = shoppeProduct.getShoppeSid();
            if (StringUtils.isNotEmpty(shoppeSid)) {
                proMap.put("counterCode", shoppeSid);
            }
            // 门店编码
            String field5 = shoppeProduct.getField5();
            if (StringUtils.isNotEmpty(field5)) {
                proMap.put("storeCode", field5);
            }
            // 供应商编码
            String supplySid = shoppeProduct.getSupplySid();
            if (StringUtils.isNotEmpty(supplySid)) {
                proMap.put("supplierCode", supplySid);
            }

            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectBaseProPageByPara.htm", JsonUtil.getJSONString(proMap));
            proMap.clear();
            if (!"".equals(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = (JSONObject) jsonObject.get("data");
                if (jsonPage != null) {
                    proMap.put("list", jsonPage.get("list"));
                    proMap.put("pageCount",
                            jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
                } else {
                    proMap.put("list", null);
                    proMap.put("pageCount", 0);
                }
            } else {
                proMap.put("list", null);
                proMap.put("pageCount", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        JSONObject jsonArray = JSONObject.fromObject(proMap);
        return jsonArray.toString();

    }

    /**
     * 从搜索查询专柜商品列表
     *
     * @Methods Name selectShoppeProductFromSearch
     * @Create In 2016-04-12 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = "/selectShoppeProductFromSearch", method = {RequestMethod.POST,
            RequestMethod.GET})
    public String selectShoppeProductFromSearch(HttpServletRequest request, HttpServletResponse response,
                                                PcmShoppeProductVo shoppeProduct) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        try {
            proMap.put("pageSize", size);// 每页显示数量
            proMap.put("currentPage", currPage);// 当前第几页

            // 商品编码
            String shoppeProSid = shoppeProduct.getShoppeProSid();
            if (StringUtils.isNotEmpty(shoppeProSid)) {
                proMap.put("productCodeStart", shoppeProSid.trim());
            }
            // 专柜商品编码(分段查询的最小值)
            String minShoppeProSid = shoppeProduct.getMinShoppeProSid();
            if (StringUtils.isNotEmpty(minShoppeProSid)) {
                proMap.put("productCodeStart", minShoppeProSid.trim());
            }
            // 专柜商品编码(分段查询的最大值)
            String maxShoppeProSid = shoppeProduct.getMaxShoppeProSid();
            if (StringUtils.isNotEmpty(maxShoppeProSid)) {
                proMap.put("productCodeEnd", maxShoppeProSid.trim());
            }
            // 专柜商品名称
            String shoppeProName = shoppeProduct.getShoppeProName();
            if (StringUtils.isNotEmpty(shoppeProName)) {
                proMap.put("productName", shoppeProName.trim());
            }
            // sku编码
            String productDetailSid = shoppeProduct.getProductDetailSid();
            if (StringUtils.isNotEmpty(productDetailSid)) {
                proMap.put("skuCodeStart", productDetailSid.trim());
            }
            // 商品表SKU 编码(分段查询的最小值)
            String minProductDetailSid = shoppeProduct.getMinProductDetailSid();
            if (StringUtils.isNotEmpty(minProductDetailSid)) {
                proMap.put("skuCodeStart", minProductDetailSid.trim());
            }
            // 商品表SKU 编码(分段查询的最大值)
            String maxProductDetailSid = shoppeProduct.getMaxProductDetailSid();
            if (StringUtils.isNotEmpty(maxProductDetailSid)) {
                proMap.put("skuCodeEnd", maxProductDetailSid.trim());
            }
            // 销售状态
            String saleStatus = shoppeProduct.getSaleStatus();
            if (StringUtils.isNotEmpty(saleStatus)) {
                if ("Y".equals(saleStatus)) {
                    proMap.put("isSale", "0");
                }
                if ("N".equals(saleStatus)) {
                    proMap.put("isSale", "1");
                }
            }
            // 专柜名称
            String shoppeSid = shoppeProduct.getShoppeSid();
            if (StringUtils.isNotEmpty(shoppeSid)) {
                proMap.put("counterCode", shoppeSid);
            }
            // 物料号
            String field4 = shoppeProduct.getField4();
            if (StringUtils.isNotEmpty(field4)) {
                proMap.put("field4", field4);
            }
            // 门店编码
            String field5 = shoppeProduct.getField5();
            if (StringUtils.isNotEmpty(field5)) {
                proMap.put("storeCode", field5);
                List<String> levels = new ArrayList<String>();
                levels.add("4");
                List<String> managerCategoryCodes = roleLimitService.selectManageCateByShopSidAndLevel(field5, levels);
                if (managerCategoryCodes != null && managerCategoryCodes.size() > 0) {
                    proMap.put("managerCategoryCodes", managerCategoryCodes);
                }
            }
            // 供应商编码
            String supplySid = shoppeProduct.getSupplySid();
            if (StringUtils.isNotEmpty(supplySid)) {
                proMap.put("supplierCode", supplySid);
            }

            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectShoppeProductPageByParaFromSearch.htm", JsonUtil.getJSONString(proMap));
            proMap.clear();
            if (StringUtils.isNotEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = jsonObject.getJSONObject("page");
                if (jsonPage != null) {
                    Object list = jsonPage.get("list");
                    if (list != null && !"null".equals(list)) {
                        proMap.put("list", jsonPage.get("list"));
                        Integer total = jsonPage.getInt("total");
                        Integer pageSize = jsonPage.getInt("pageSize");
                        Integer pageCount = total % pageSize == 0 ? total / pageSize : total / pageSize + 1;
                        //搜索 ES 1W以上数据分页查不出来
                        Integer esTotal = 10000;
                        if (total > esTotal) {
//                            pageCount = esTotal % pageSize == 0 ? esTotal / pageSize : esTotal / pageSize + 1;
                            pageCount = esTotal / pageSize;
                        }
                        proMap.put("total", total);
                        proMap.put("pageCount", pageCount);
                    } else {
                        proMap.put("list", null);
                        proMap.put("pageCount", 0);
                    }
                } else {
                    proMap.put("list", null);
                    proMap.put("pageCount", 0);
                }
            } else {
                proMap.put("list", null);
                proMap.put("pageCount", 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
            proMap.put("list", null);
            proMap.put("pageCount", 0);
        }
        JSONObject jsonArray = JSONObject.fromObject(proMap);
        return jsonArray.toString();

    }

    /**
     * 专柜商品导出Excel时查询总数量
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name getShoppeProductToExcelCount
     * @Create 2016-04-05 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = "/getShoppeProductToExcelCount", method = {RequestMethod.GET, RequestMethod.POST})
    public String getShoppeProductToExcelCount(HttpServletRequest request, String shoppeProSid, String shoppeProName,
                                               String productDetailSid, String saleStatus, String shoppeSid, String field5,
                                               String supplySid, String minShoppeProSid, String maxShoppeProSid,
                                               String minProductDetailSid, String maxProductDetailSid, String field4) {

        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(shoppeProSid)) {
            map.put("productCode", shoppeProSid.trim());
        }
        // 专柜商品编码(分段查询的最小值)
        if (StringUtils.isNotEmpty(minShoppeProSid)) {
            map.put("minProductCode", minShoppeProSid.trim());
        }
        // 专柜商品编码(分段查询的最大值)
        if (StringUtils.isNotEmpty(maxShoppeProSid)) {
            map.put("maxProductCode", maxShoppeProSid.trim());
        }
        if (StringUtils.isNotEmpty(shoppeProName)) {
            map.put("productName", shoppeProName.trim());
        }
        if (StringUtils.isNotEmpty(productDetailSid)) {
            map.put("skuCode", productDetailSid.trim());
        }
        // 商品表SKU 编码(分段查询的最小值)
        if (StringUtils.isNotEmpty(minProductDetailSid)) {
            map.put("minSkuCode", minProductDetailSid.trim());
        }
        // 商品表SKU 编码(分段查询的最大值)
        if (StringUtils.isNotEmpty(maxProductDetailSid)) {
            map.put("maxSkuCode", maxProductDetailSid.trim());
        }
        //物料号
        if (StringUtils.isNotEmpty(field4)) {
            map.put("field4", field4.trim());
        }
        if (StringUtils.isNotEmpty(saleStatus)) {
            if ("Y".equals(saleStatus)) {
                map.put("isSale", "0");
            }
            if ("N".equals(saleStatus)) {
                map.put("isSale", "1");
            }
        }
        if (StringUtils.isNotEmpty(shoppeSid)) {
            map.put("counterCode", shoppeSid);
        }
        if (StringUtils.isNotEmpty(field5)) {
            map.put("storeCode", field5);
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            map.put("supplierCode", supplySid);
        }
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/product/getShoppeProductToExcelCount.htm",
                    JsonUtil.getJSONString(map));
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
     * 专柜商品导出Excel
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name getShoppeProductToExcel
     * @Create 2016-03-31 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = "/getShoppeProductToExcel", method = {RequestMethod.GET, RequestMethod.POST})
    public String getShoppeProductToExcel(HttpServletRequest request, HttpServletResponse response, String shoppeProSid,
                                          String shoppeProName, String productDetailSid, String saleStatus, String field4,
                                          String shoppeSid, String field5, String supplySid, String minShoppeProSid,
                                          String maxShoppeProSid, String minProductDetailSid, String maxProductDetailSid) {

        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(shoppeProSid)) {
            map.put("productCode", shoppeProSid.trim());
        }
        // 专柜商品编码(分段查询的最小值)
        if (StringUtils.isNotEmpty(minShoppeProSid)) {
            map.put("minProductCode", minShoppeProSid.trim());
        }
        // 专柜商品编码(分段查询的最大值)
        if (StringUtils.isNotEmpty(maxShoppeProSid)) {
            map.put("maxProductCode", maxShoppeProSid.trim());
        }
        if (StringUtils.isNotEmpty(shoppeProName)) {
            map.put("productName", shoppeProName.trim());
        }
        if (StringUtils.isNotEmpty(productDetailSid)) {
            map.put("skuCode", productDetailSid.trim());
        }
        // 商品表SKU 编码(分段查询的最小值)
        if (StringUtils.isNotEmpty(minProductDetailSid)) {
            map.put("minSkuCode", minProductDetailSid.trim());
        }
        // 商品表SKU 编码(分段查询的最大值)
        if (StringUtils.isNotEmpty(maxProductDetailSid)) {
            map.put("maxSkuCode", maxProductDetailSid.trim());
        }
        if (StringUtils.isNotEmpty(saleStatus)) {
            if ("Y".equals(saleStatus)) {
                map.put("isSale", "0");
            }
            if ("N".equals(saleStatus)) {
                map.put("isSale", "1");
            }
        }
        if (StringUtils.isNotEmpty(shoppeSid)) {
            map.put("counterCode", shoppeSid);
        }
        if (StringUtils.isNotEmpty(field5)) {
            map.put("storeCode", field5);
        }
        if (StringUtils.isNotEmpty(field4)) {
            map.put("field4", field4);
        }
        if (StringUtils.isNotEmpty(supplySid)) {
            map.put("supplierCode", supplySid);
        }
        String jsons = "";
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/product/getShoppeProductToExcel.htm",
                    JsonUtil.getJSONString(map));
            JSONObject jsonObject = JSONObject.fromObject(json);
            String success = jsonObject.get("success") + "";
            if ("true".equalsIgnoreCase(success)) {
                JSONObject data = jsonObject.getJSONObject("data");
                // 得到JSONArray
                JSONArray list = data.getJSONArray("list");
                List<ExcelShoppeProductVo> shoppeProductVoList = new ArrayList<ExcelShoppeProductVo>();
                if (list != null && list.size() > 0) {
                    for (int i = 0; i < list.size(); i++) {
                        JSONObject object = list.getJSONObject(i);
//                        ExcelShoppeProductVo vo = (ExcelShoppeProductVo) JSONObject.toBean(object, ExcelShoppeProductVo.class);
                        ExcelShoppeProductVo vo = new ExcelShoppeProductVo();
                        vo.setProductCode(object.get("productCode") + "");
                        vo.setSkuCode(object.get("skuCode") + "");
                        vo.setProductName(object.get("productName") + "");
                        vo.setStoreName(object.get("storeName") + "");
                        vo.setCounterName(object.get("counterName") + "");
                        vo.setSupplierName(object.get("supplierName") + "");
                        vo.setBrandName(object.get("brandName") + "");
                        vo.setIsSale(object.get("isSale") + "");
                        shoppeProductVoList.add(vo);
                    }
                }

                String title = "shoppeProduct_dgw";
                String result = allShoppeProductToExcel(response, shoppeProductVoList, title);
                jsons = ResultUtil.createSuccessResult(result);
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsons = "";
        }

        return jsons;
    }

    /**
     * 专柜商品导出Excel
     *
     * @param response
     * @param list
     * @param title
     * @return String
     * @Methods Name allShoppeProductToExcel
     * @Create In 2016-03-31 By wangxuan
     */
    public String allShoppeProductToExcel(HttpServletResponse response, List<ExcelShoppeProductVo> list, String title) {
        List<String> header = new ArrayList<String>();

        header.add("专柜商品编码");
        header.add("商品名称");
        header.add("SKU编码");
        header.add("门店");
        header.add("专柜");
        header.add("供应商");
        header.add("门店品牌");
        header.add("状态");

        List<List<String>> data = new ArrayList<List<String>>();
        for (ExcelShoppeProductVo vo : list) {
            List<String> inlist = new ArrayList<String>();
            inlist.add(vo.getProductCode() == null ? "" : vo.getProductCode());
            inlist.add(vo.getProductName() == null ? "" : vo.getProductName());
            inlist.add(vo.getSkuCode() == null ? "" : vo.getSkuCode());
            inlist.add(vo.getStoreName() == null ? "" : vo.getStoreName());
            inlist.add(vo.getCounterName() == null ? "" : vo.getCounterName());
            inlist.add(vo.getSupplierName() == null ? "" : vo.getSupplierName());
            inlist.add(vo.getBrandName() == null ? "" : vo.getBrandName());
            String isSale = vo.getIsSale();
            if (StringUtils.isNotEmpty(isSale)) {
                if ("Y".equals(isSale)) {
                    isSale = "可售";
                }
                if ("N".equals(isSale)) {
                    isSale = "不可售";
                }
            } else {
                isSale = "";
            }
            inlist.add(isSale == null ? "" : isSale);
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
     * 查询专柜商品列表(用于专柜商品列表加载)
     *
     * @param request
     * @return String
     * @Methods Name selectShoppeProductBySku
     * @Create In 2015-9-8 By duanzhaole
     */
//    @RequestMapping(value = "/selectShoppeProductByCode/{id}", method = {RequestMethod.POST,
//            RequestMethod.GET})
    public String selectShoppeProductByCode(@PathVariable("id") String id, Model m,
                                            String backUrl, HttpServletRequest request) {
        String json = "";
        JSONObject jsons = new JSONObject();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sid", id);
        m.addAttribute("backUrl", backUrl);
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectShoppeProductByCode.htm", JsonUtil.getJSONString(map));
            jsons = JSONObject.fromObject(json);
            JSONObject oSku = (JSONObject) jsons.get("data");
            JSONArray aSku = oSku.getJSONArray("list");

            m.addAttribute("jsons", aSku);

            JSONObject shoppeProduct = aSku.getJSONObject(0);
            String storeCode = shoppeProduct.getString("storeCode");// 门店编码
            String manageCategory = shoppeProduct.getString("manageCategory");// 管理分类编码
            String statCategoryCode = shoppeProduct.getString("statCategoryCode");// 统计分类编码
            String categoryQueryUrl = SystemConfig.SSD_SYSTEM_URL
                    + "/bwCategoryController/bw/findAllParentCategoryByParam.htm";
            if (StringUtils.isNotEmpty(storeCode) && StringUtils.isNotEmpty(manageCategory)) {
                map.clear();
                map.put("categoryType", "1");
                map.put("shopCode", storeCode);
                map.put("categoryCode", manageCategory);
                String manageCategoryInfo = HttpUtilPcm.doPost(categoryQueryUrl,
                        JsonUtil.getJSONString(map));//查询管理分类的所有上级
                if (StringUtils.isNotEmpty(manageCategoryInfo)) {
                    JSONObject manageCategoryJson = JSONObject.fromObject(manageCategoryInfo);
                    JSONArray manageCategoryList = manageCategoryJson.getJSONArray("data");
                    StringBuffer sb = new StringBuffer();
                    for (int i = manageCategoryList.size() - 1; i >= 0; i--) {
                        if (i == 0) {
                            sb.append(manageCategoryList.getJSONObject(i).getString("name"));
                        } else {
                            sb.append(manageCategoryList.getJSONObject(i).getString("name") + ">");
                        }
                        m.addAttribute("manageCategoryNames", sb.toString());
                    }
                }
            }
            if (StringUtils.isNotEmpty(statCategoryCode)) {
                map.clear();
                map.put("categoryType", "2");
                map.put("categoryCode", statCategoryCode);
                String statCategoryInfo = HttpUtilPcm.doPost(categoryQueryUrl, JsonUtil.getJSONString(map));//查询统计分类的所有上级
                if (StringUtils.isNotEmpty(statCategoryInfo)) {
                    JSONObject statCategoryJson = JSONObject.fromObject(statCategoryInfo);
                    JSONArray statCategoryList = statCategoryJson.getJSONArray("data");
                    StringBuffer sb = new StringBuffer();
                    for (int i = statCategoryList.size() - 1; i >= 0; i--) {
                        if (i == 0) {
                            sb.append(statCategoryList.getJSONObject(i).getString("name"));
                        } else {
                            sb.append(statCategoryList.getJSONObject(i).getString("name") + ">");
                        }
                        m.addAttribute("statCategoryNames", sb.toString());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "forward:/jsp/product/getShoppeProduct.jsp";
    }

    /**
     * 查询专柜商品列表(用于专柜商品列表加载)(优化)
     *
     * @param request
     * @return String
     * @Methods Name selectShoppeProductByCode1
     * @Create In 2015-9-8 By zdl
     */
    @RequestMapping(value = "/selectShoppeProductByCode1/{id}", method = {RequestMethod.POST,
            RequestMethod.GET})
    public String selectShoppeProductByCodeCopy(@PathVariable("id") String id, Model m,
                                                String backUrl, HttpServletRequest request) {
        String json = "";
        JSONObject jsons = new JSONObject();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("productCode", id);
        m.addAttribute("backUrl", backUrl);
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectShoppeProductByPara.htm", JsonUtil.getJSONString(map));
            jsons = JSONObject.fromObject(json);
            JSONObject oSku = (JSONObject) jsons.get("data");
            JSONArray aSku = new JSONArray();
            aSku.add(oSku);
            m.addAttribute("jsons", aSku);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "forward:/jsp/product/getShoppeProduct.jsp";
    }

    /**
     * 查询专柜商品管理分类和统计分类 (用于专柜商品列表加载)(优化)
     *
     * @param request
     * @return String
     * @Methods Name selectCate
     * @Create In 2015-9-8 By zdl
     */
    @ResponseBody
    @RequestMapping(value = "/selectCate", method = {RequestMethod.POST,
            RequestMethod.GET})
    public String selectCate(String storeCode, String manageCategory, String statCategory,
                             HttpServletRequest request) {
        JSONObject jsons = new JSONObject();
        boolean isHaveData = false;
        Map<String, Object> map = new HashMap<String, Object>();
        String categoryQueryUrl = SystemConfig.SSD_SYSTEM_URL
                + "/bwCategoryController/bw/findAllParentCategoryByParam.htm";
        if (StringUtils.isNotEmpty(storeCode) && StringUtils.isNotEmpty(manageCategory)) {
            map.clear();
            map.put("categoryType", "1");
            map.put("shopCode", storeCode);
            map.put("categoryCode", manageCategory);
            String manageCategoryInfo = HttpUtilPcm.doPost(categoryQueryUrl,
                    JsonUtil.getJSONString(map));//查询管理分类的所有上级
            if (StringUtils.isNotEmpty(manageCategoryInfo)) {
                JSONObject manageCategoryJson = JSONObject.fromObject(manageCategoryInfo);
                JSONArray manageCategoryList = manageCategoryJson.getJSONArray("data");
                StringBuffer sb = new StringBuffer();
                for (int i = manageCategoryList.size() - 1; i >= 0; i--) {
                    if (i == 0) {
                        sb.append(manageCategoryList.getJSONObject(i).getString("name"));
                    } else {
                        sb.append(manageCategoryList.getJSONObject(i).getString("name") + ">");
                    }
                    jsons.put("manageCategoryNames", sb.toString());
                    isHaveData = true;
                }
            }
        }
        if (StringUtils.isNotEmpty(statCategory)) {
            map.clear();
            map.put("categoryType", "2");
            map.put("categorySid", statCategory);
            String statCategoryInfo = HttpUtilPcm.doPost(categoryQueryUrl, JsonUtil.getJSONString(map));//查询统计分类的所有上级
            if (StringUtils.isNotEmpty(statCategoryInfo)) {
                JSONObject statCategoryJson = JSONObject.fromObject(statCategoryInfo);
                JSONArray statCategoryList = statCategoryJson.getJSONArray("data");
                StringBuffer sb = new StringBuffer();
                for (int i = statCategoryList.size() - 1; i >= 0; i--) {
                    if (i == 0) {
                        sb.append(statCategoryList.getJSONObject(i).getString("name"));
                    } else {
                        sb.append(statCategoryList.getJSONObject(i).getString("name") + ">");
                    }
                    jsons.put("statCategoryNames", sb.toString());
                    isHaveData = true;
                }
            }
        }
        if (isHaveData) {
            jsons.put("success", "true");
        } else {
            jsons.put("success", "false");
        }
        return jsons.toString();
    }

    /**
     * 获取品牌类型
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name selectAllBrandSid
     * @Create In 2015年8月18日 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/selectAllBrandSid", method = {RequestMethod.POST})
    public String selectAllBrandSid(HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> map = new HashMap<String, Object>();
        String json = HttpUtil
                .HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/selectAllBrand.html", map);

        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/skuUpdateAttr", method = {RequestMethod.GET, RequestMethod.POST})
    public String skuUpdateAttr(ProductDto dto, Model mode, HttpServletRequest request,
                                HttpServletResponse response) {
        String json = "";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("productDetailSid", dto.getSkuCode());
        if (dto.getProColorName() != null) {
            paramMap.put("proColorName", dto.getProColorName());
        }
        if (dto.getProStanSid() != null) {
            paramMap.put("proStanSid", dto.getProStanSid());
        }
        if (dto.getFeatures() != null) {
            paramMap.put("features", dto.getFeatures());
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/updateSkuColorStan.htm", JsonUtil.getJSONString(paramMap));
            /*
             * json = HttpUtilPcm.doPost(
			 * "http://127.0.0.1:8083/pcm-admin/product/updateSkuColorStan.htm",
			 * JsonUtil.getJSONString(paramMap));
			 */
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/skuUpdateAttrOrSku", method = {RequestMethod.GET, RequestMethod.POST})
    public String skuUpdateAttrOrSku(ProductDto dto, Model mode, HttpServletRequest request,
                                     HttpServletResponse response) {
        String json = "";
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("productDetailSid", dto.getSkuCode());
        if (dto.getPrimaryAttr() != null && dto.getPrimaryAttr() != "") {
            paramMap.put("primaryAttr", dto.getPrimaryAttr());
        }
        if (dto.getProductSku() != null && dto.getProductSku() != "") {
            paramMap.put("productSku", dto.getProductSku());
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/changeProductSkuBySKU.htm", JsonUtil.getJSONString(paramMap));
            /*
             * json = HttpUtilPcm.doPost(
			 * "http://127.0.0.1:8083/pcm-admin/product/changeProductSkuBySKU.htm"
			 * , JsonUtil.getJSONString(paramMap)); System.out.println(json);
			 */
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 添加商品基本信息
     *
     * @param productAddVO
     * @param mode
     * @param request
     * @param response
     * @return String
     * @Methods Name addProduct
     * @Create In 2015年8月24日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/addProduct", method = {RequestMethod.GET, RequestMethod.POST})
    public String addProduct(SaveSkuVO saveSku, Model mode, HttpServletRequest request,
                             HttpServletResponse response) {
        System.out.println("HOUTAI:" + saveSku.toString());
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (saveSku != null) {
            if (StringUtils.isNotEmpty(saveSku.getBrandSid())) {
                map.put("brandSid", saveSku.getBrandSid());
            }
            if (StringUtils.isNotEmpty(saveSku.getCategoryName())) {
                map.put("categoryName", saveSku.getCategoryName());
            }
            if (StringUtils.isNotEmpty(saveSku.getCrowdUser())) {
                map.put("crowdUser", saveSku.getCrowdUser());
            }
            if (StringUtils.isNotEmpty(saveSku.getFinalClassiFicationCode())) {
                map.put("finalClassiFicationCode", saveSku.getFinalClassiFicationCode());
            }
            if (StringUtils.isNotEmpty(saveSku.getMainAttribute())) {
                map.put("mainAttribute", saveSku.getMainAttribute());
            }
            if (StringUtils.isNotEmpty(saveSku.getParameters())) {
                List<ParametersDto> listInsert = JSON.parseArray(saveSku.getParameters(),
                        ParametersDto.class);
                map.put("parameters", listInsert);
            }
            if (StringUtils.isNotEmpty(saveSku.getSkuProps())) {
                List<SkuListVO> listInsert = JSON
                        .parseArray(saveSku.getSkuProps(), SkuListVO.class);
                map.put("skuProps", listInsert);
            }
            if (StringUtils.isNotEmpty(saveSku.getProdCategoryCode())) {
                map.put("prodCategoryCode", saveSku.getProdCategoryCode());
            }
            if (StringUtils.isNotEmpty(saveSku.getProductNum())) {
                map.put("productNum", saveSku.getProductNum());
            }
            if (StringUtils.isNotEmpty(saveSku.getSeasonCode())) {
                map.put("seasonCode", saveSku.getSeasonCode());
            }
            if (StringUtils.isNotEmpty(saveSku.getType())) {
                map.put("type", saveSku.getType());
            }
            if (StringUtils.isNotEmpty(saveSku.getYearToMarket())) {
                map.put("yearToMarket", saveSku.getYearToMarket());
            }
            if (StringUtils.isNotEmpty(saveSku.getProTypeSid())) {
                map.put("proTypeSid", saveSku.getProTypeSid());
            }
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/saveProduct/saveProductSku.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 添加单品信息
     *
     * @param SaveShoppeProductVO
     * @param mode
     * @param request
     * @param response
     * @return String
     * @Methods Name saveShoppeProduct
     * @Create In 2015年8月24日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/saveShoppeProduct", method = {RequestMethod.GET, RequestMethod.POST})
    public String saveShoppeProduct(SaveShoppeProductVO saveShoppeProductVO, Model mode,
                                    HttpServletRequest request, HttpServletResponse response) {
        System.out.println("HOUTAI:" + saveShoppeProductVO.toString());
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (saveShoppeProductVO != null) {
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getConsumptionTax())) {
                map.put("consumptionTax", saveShoppeProductVO.getConsumptionTax());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getCounterCode())) {
                map.put("counterCode", saveShoppeProductVO.getCounterCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getDiscountLimit())) {
                map.put("discountLimit", saveShoppeProductVO.getDiscountLimit());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getEntryNumber())) {
                map.put("entryNumber", saveShoppeProductVO.getEntryNumber());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getErpProductCode())) {
                map.put("erpProductCode", saveShoppeProductVO.getErpProductCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getInputTax())) {
                map.put("inputTax", saveShoppeProductVO.getInputTax());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsAdjustPrice())) {
                map.put("isAdjustPrice", saveShoppeProductVO.getIsAdjustPrice());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsPromotion())) {
                map.put("isPromotion", saveShoppeProductVO.getIsPromotion());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getManageCateGory())) {
                map.put("manageCateGory", saveShoppeProductVO.getManageCateGory());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getFinalClassiFicationCode())) {
                map.put("finalClassiFicationCode", saveShoppeProductVO.getFinalClassiFicationCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getMarketPrice())) {
                map.put("marketPrice", saveShoppeProductVO.getMarketPrice());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getOfferNumber())) {
                map.put("offerNumber", saveShoppeProductVO.getOfferNumber());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getOutputTax())) {
                map.put("outputTax", saveShoppeProductVO.getOutputTax());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getProcessingType())) {
                map.put("processingType", saveShoppeProductVO.getProcessingType());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getProcurementPersonnelNumber())) {
                map.put("procurementPersonnelNumber",
                        saveShoppeProductVO.getProcurementPersonnelNumber());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getProductAbbr())) {
                map.put("productAbbr", saveShoppeProductVO.getProductAbbr());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getProductName())) {
                map.put("productName", saveShoppeProductVO.getProductName());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getRate())) {
                map.put("rate", saveShoppeProductVO.getRate());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getShopBrandSid())) {
                map.put("brandSid", saveShoppeProductVO.getShopBrandSid());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getShopCode())) {
                map.put("shopCode", saveShoppeProductVO.getShopCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSkuSid())) {
                map.put("skuSid", saveShoppeProductVO.getSkuSid());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSkuName())) {
                map.put("skuName", saveShoppeProductVO.getSkuName());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getBarcodes())) {
                List<BarcodeDto> listInsert = JSON.parseArray(saveShoppeProductVO.getBarcodes(),
                        BarcodeDto.class);
                map.put("barcodes", listInsert);
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSupplierCode())) {
                map.put("supplierCode", saveShoppeProductVO.getSupplierCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getType())) {
                map.put("type", saveShoppeProductVO.getType());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getUnitCode())) {
                map.put("unitCode", saveShoppeProductVO.getUnitCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSalePrice())) {
                map.put("salePrice", saveShoppeProductVO.getSalePrice());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getInventory())) {
                map.put("inventory", saveShoppeProductVO.getInventory());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getPurchasePrice())) {
                map.put("rate_price", saveShoppeProductVO.getPurchasePrice());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getBuyingPrice())) {
                map.put("purchasePrice_taxRebate", saveShoppeProductVO.getBuyingPrice());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getModelNum())) {
                map.put("modelNum", saveShoppeProductVO.getModelNum());
            }
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/saveProduct/saveShoppeProduct.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 添加单品信息
     *
     * @param SaveShoppeProductVO
     * @param mode
     * @param request
     * @param response
     * @return String
     * @Methods Name saveShoppeProduct
     * @Create In 2015年8月24日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/saveShoppeProductDs", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String saveShoppeProductDs(SaveShoppeProductDsVO saveShoppeProductVO, Model mode,
                                      HttpServletRequest request, HttpServletResponse response) {
        System.out.println("HOUTAI:" + saveShoppeProductVO.toString());
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (saveShoppeProductVO != null) {
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getConsumptionTax())) {
                map.put("consumptionTax", saveShoppeProductVO.getConsumptionTax());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getCounterCode())) {
                map.put("counterCode", saveShoppeProductVO.getCounterCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getDiscountLimit())) {
                map.put("discountLimit", saveShoppeProductVO.getDiscountLimit());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getEntryNumber())) {
                map.put("entryNumber", saveShoppeProductVO.getEntryNumber());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getErpProductCode())) {
                map.put("erpProductCode", saveShoppeProductVO.getErpProductCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getInputTax())) {
                map.put("inputTax", saveShoppeProductVO.getInputTax());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsAdjustPrice())) {
                map.put("isAdjustPrice", saveShoppeProductVO.getIsAdjustPrice());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsPromotion())) {
                map.put("isPromotion", saveShoppeProductVO.getIsPromotion());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getManageCateGory())) {
                map.put("manageCateGory", saveShoppeProductVO.getManageCateGory());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getFinalClassiFicationCode())) {
                map.put("finalClassiFicationCode", saveShoppeProductVO.getFinalClassiFicationCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getMarketPrice())) {
                map.put("marketPrice", saveShoppeProductVO.getMarketPrice());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getOfferNumber())) {
                map.put("offerNumber", saveShoppeProductVO.getOfferNumber());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getOutputTax())) {
                map.put("outputTax", saveShoppeProductVO.getOutputTax());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getProcessingType())) {
                map.put("processingType", saveShoppeProductVO.getProcessingType());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getProcurementPersonnelNumber())) {
                map.put("procurementPersonnelNumber",
                        saveShoppeProductVO.getProcurementPersonnelNumber());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getProductAbbr())) {
                map.put("productAbbr", saveShoppeProductVO.getProductAbbr());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getProductName())) {
                map.put("productName", saveShoppeProductVO.getProductName());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getRate())) {
                map.put("rate", saveShoppeProductVO.getRate());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getShopBrandSid())) {
                map.put("brandSid", saveShoppeProductVO.getShopBrandSid());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getShopCode())) {
                map.put("shopCode", saveShoppeProductVO.getShopCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSkuSid())) {
                map.put("skuSid", saveShoppeProductVO.getSkuSid());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSkuName())) {
                map.put("skuName", saveShoppeProductVO.getSkuName());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getBarcodes())) {
                List<BarcodeDto> listInsert = JSON.parseArray(saveShoppeProductVO.getBarcodes(),
                        BarcodeDto.class);
                map.put("barcodes", listInsert);
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSupplierCode())) {
                map.put("supplierCode", saveShoppeProductVO.getSupplierCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getType())) {
                map.put("type", saveShoppeProductVO.getType());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getUnitCode())) {
                map.put("unitCode", saveShoppeProductVO.getUnitCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSalePrice())) {
                map.put("salePrice", saveShoppeProductVO.getSalePrice());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getInventory())) {
                map.put("inventory", saveShoppeProductVO.getInventory());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getRate_price())) {
                map.put("rate_price", saveShoppeProductVO.getRate_price());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getPurchasePrice_taxRebate())) {
                map.put("purchasePrice_taxRebate", saveShoppeProductVO.getPurchasePrice_taxRebate());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getPlaceOfOrigin())) {
                map.put("placeOfOrigin", saveShoppeProductVO.getPlaceOfOrigin());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getCountryOfOrigin())) {
                map.put("countryOfOrigin", saveShoppeProductVO.getCountryOfOrigin());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getRemarks())) {
                map.put("remarks", saveShoppeProductVO.getRemarks());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getModelNum())) {
                map.put("modelNum", saveShoppeProductVO.getModelNum());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSupplyProductCode())) {
                map.put("supplyProductCode", saveShoppeProductVO.getSupplyProductCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getTmsParam())) {
                map.put("tmsParam", saveShoppeProductVO.getTmsParam());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsCod())) {
                map.put("isCod", saveShoppeProductVO.getIsCod());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsPacking())) {
                map.put("isPacking", saveShoppeProductVO.getIsPacking());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsCard())) {
                map.put("isCard", saveShoppeProductVO.getIsCard());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getOriginCountry())) {
                map.put("originCountry", saveShoppeProductVO.getOriginCountry());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getStockMode())) {
                map.put("stockMode", saveShoppeProductVO.getStockMode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsOriginPackage())) {
                map.put("isOriginPackage", saveShoppeProductVO.getIsOriginPackage());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getIsGift())) {
                map.put("isGift", saveShoppeProductVO.getIsGift());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getXxhcFlag())) {
                map.put("xxhcFlag", saveShoppeProductVO.getXxhcFlag());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getBaseUnitCode())) {
                map.put("baseUnitCode", saveShoppeProductVO.getBaseUnitCode());
            }

            if (StringUtils.isNotEmpty(saveShoppeProductVO.getZzColorCode())) {
                map.put("zzColorCode", saveShoppeProductVO.getZzColorCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getZzSizeCode())) {
                map.put("zzSizeCode", saveShoppeProductVO.getZzSizeCode());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSupplyOriginLand())) {
                map.put("supplyOriginLand", saveShoppeProductVO.getSupplyOriginLand());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getShelfLife())) {
                map.put("shelfLife", saveShoppeProductVO.getShelfLife());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getRemainShelLife())) {
                map.put("remainShelLife", saveShoppeProductVO.getRemainShelLife());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getLaunchDate())) {
                map.put("launchDate", saveShoppeProductVO.getLaunchDate());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getSeason())) {
                map.put("season", saveShoppeProductVO.getSeason());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getApplicablePeople())) {
                map.put("applicablePeople", saveShoppeProductVO.getApplicablePeople());
            }
            if (StringUtils.isNotEmpty(saveShoppeProductVO.getShoppeProType())) {
                map.put("shoppeProType", saveShoppeProductVO.getShoppeProType());
            }
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/saveProduct/saveShoppeProductDs.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 根据门店编码、供应商编码、经营方式查询要约信息
     *
     * @param storeCode
     * @param supplyCode
     * @param manageType
     * @return String
     * @Methods Name selectContractByParams
     * @Create In 2015年9月9日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectContractByParams", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String selectContractByParams(String storeCode, String supplyCode, String manageType,
                                         String shoppeCode) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(storeCode)) {
            map.put("storeCode", storeCode);
        }
        if (StringUtils.isNotEmpty(supplyCode)) {
            map.put("supplyCode", supplyCode);
        }
        if (StringUtils.isNotEmpty(manageType)) {
            map.put("manageType", manageType);
        }
        if (StringUtils.isNotEmpty(shoppeCode)) {
            map.put("shoppeCode", shoppeCode);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/contractLog/selectContractLogByParam.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 查询商品类型
     *
     * @return String
     * @Methods Name selectProductType
     * @Create In 2015年9月15日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectProductType", method = {RequestMethod.GET, RequestMethod.POST})
    public String selectProductType() {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                + "/product/selectProductType.htm", JsonUtil.getJSONString(map));
        return json;
    }

	/*
     * colourComboArray:colourId, sizeComboArray:sizeId,
	 * colourComboValue:colourComboValue, sizeComboValue:sizeComboValue
	 */

    @SuppressWarnings("unused")
    @ResponseBody
    @RequestMapping(value = "/toJsonStore", method = {RequestMethod.GET, RequestMethod.POST})
    public String toJsonStore(String colourComboArray, String sizeComboArray,
                              String colourComboValue, String sizeComboValue) {
        System.out.println(colourComboArray + "            " + colourComboValue + "            "
                + sizeComboArray + "          " + sizeComboValue);
        String[] colourComboIdArray = colourComboArray.split(",");
        String[] colourComboValueArray = colourComboValue.split(",");
        String[] sizeComboIdArray = sizeComboArray.split(",");
        String[] sizeComboValueAray = sizeComboValue.split(",");

        ProSizeColourEntity ProSizeColourEntity = new ProSizeColourEntity();
        List<ProSizeColourEntity> list = new ArrayList<ProSizeColourEntity>();
        List<ProSizeEntity> sizeList = new ArrayList<ProSizeEntity>();
        ProSizeEntity sizeEntity = new ProSizeEntity();
        // 颜色 对应多个尺码
        for (int i = 0; i < colourComboValueArray.length; i++) {

            ProSizeColourEntity.setColourId(colourComboIdArray[i]);
            ProSizeColourEntity.setColourValue(colourComboValueArray[i]);

            for (int j = 0; j < sizeComboIdArray.length; j++) {
                sizeEntity.setSizeId(sizeComboIdArray[j]);
                sizeEntity.setSizeValue(sizeComboValueAray[j]);
                sizeList.add(sizeEntity);
            }
            ProSizeColourEntity.setList(sizeList);
        }

        Gson gson = new Gson();
        String json = "[" + gson.toJson(ProSizeColourEntity) + "]";
        System.out.println(json);
        /**
         * 黄色 100/52 100/53 白色 100/52 100/53
         *
         * Z1,Z2 白色, 黄色 108 100/52 Z1 白色 108,109 100/52, 110/56
         */

        return null;
    }

    /**
     * 专柜商品换扣率码
     *
     * @return String
     * @Methods Name updateShopProduct
     * @Create In 2015年9月23日 By duanzhaole
     */
    @ResponseBody
    @RequestMapping(value = "/updateRateCode", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateShopProduct(String rateCode, String shoppeProSid) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(rateCode)) {
            map.put("rateCode", rateCode);
        }
        if (StringUtils.isNotEmpty(shoppeProSid)) {
            map.put("shoppeProSid", shoppeProSid);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/updateProductRateCode.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 查询所有专柜，用于商品换专柜
     *
     * @return String
     * @Methods Name selectAllShoppe
     * @Create In 2015年9月23日 By duanzhaole
     */
    @Deprecated
    @ResponseBody
    @RequestMapping(value = "/selectAllShoppe", method = {RequestMethod.GET, RequestMethod.POST})
    public String selectAllShoppe() {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        try {
            json = HttpUtilPcm.doPost(
                    SystemConfig.SSD_SYSTEM_URL + "/shoppe/findShoppeFromPCM.htm",
                    JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 根据门店sid和经营方式查询专柜
     *
     * @param shopSid
     * @param businessTypeSid
     * @return String
     * @Methods Name findListShoppe
     * @Create In 2015年10月16日 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/findListShoppe", method = {RequestMethod.GET, RequestMethod.POST})
    public String findListShoppe(String shopSid) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("shopSid", shopSid);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/shoppe/findListShoppe.htm",
                    JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 专柜商品换专柜
     *
     * @param shoppeCode
     * @param shoppeProSid
     * @return String
     * @Methods Name updateShoppe
     * @Create In 2015年9月24日 By duanzhaole
     */
    @ResponseBody
    @RequestMapping(value = "/updateShoppe", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateShoppe(String shoppeCode, String shoppeProSid, String activeTime) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(shoppeCode)) {
            map.put("shoppeSid", shoppeCode);
        }
        if (StringUtils.isNotEmpty(shoppeProSid)) {
            map.put("shoppeProSid", shoppeProSid);
        }
        if (StringUtils.isNotEmpty(activeTime)) {
            map.put("activeTime", activeTime);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/propertyChange/changeGroupShoppe.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 换色码(特性)规格
     *
     * @param shoppeCode
     * @param shoppeProSid
     * @return String
     * @Methods Name updateShoppe
     * @Create In 2015年9月24日 By duanzhaole
     */
    @ResponseBody
    @RequestMapping(value = "/updateSMGG", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateSMGG(String sizeCode, String features, String colorCode,
                             String shoppeProSid, String proColorSid) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(shoppeProSid)) {
            map.put("shoppeProSid", shoppeProSid);
        }
        if (StringUtils.isNotEmpty(sizeCode)) {
            map.put("proStanSid", sizeCode);
        }
        if (StringUtils.isNotEmpty(features)) {
            map.put("features", features);
        }
        if (StringUtils.isNotEmpty(colorCode)) {
            map.put("proColorName", colorCode);
        }
        if (StringUtils.isNotEmpty(proColorSid)) {
            map.put("proColorSid", proColorSid);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/updateProColorStan.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 换一般属性
     *
     * @param shoppeCode
     * @param shoppeProSid
     * @return String
     * @Methods Name updateShoppe
     * @Create In 2015年9月24日 By duanzhaole
     */
    @ResponseBody
    @RequestMapping(value = "/updateYBSX", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateYBSX(String productCode, String productName, String unit,
                             String originLand, String remark, String articleNum) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(productCode)) {
            map.put("productCode", productCode);
        }
        if (StringUtils.isNotEmpty(productName)) {
            map.put("productName", productName);
        }
        if (StringUtils.isNotEmpty(unit)) {
            map.put("unit", unit);
        }
        if (StringUtils.isNotEmpty(articleNum)) {
            map.put("articleNum", articleNum);
        }
        map.put("originLand", originLand);
        map.put("remark", remark);
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/UpdateProductInfo.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 停/启用SKU
     *
     * @param shoppeCode
     * @param shoppeProSid
     * @return String
     * @Methods Name deleteProduct
     * @Create In 2015年9月24日 By zhangxueyi
     */
    @ResponseBody
    @RequestMapping(value = "/deleteProduct", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteProduct(String sids, Integer status) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        // List<Object> listInsert = JSON.parseArray(sids);
        map.put("sids", sids);
        map.put("proActiveBit", status);
        try {
            json = HttpUtilPcm.doPost(
                    SystemConfig.SSD_SYSTEM_URL + "/product/proDetailDisable.htm",
                    JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 上/下架SKU
     *
     * @param shoppeCode
     * @param shoppeProSid
     * @return String
     * @Methods Name sellProduct
     * @Create In 2015年9月24日 By zhangxueyi
     */
    @ResponseBody
    @RequestMapping(value = "/sellProduct", method = {RequestMethod.GET, RequestMethod.POST})
    public String sellProduct(String sids, Integer status) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        // List<Object> listInsert = JSON.parseArray(sids);
        map.put("sids", sids);
        map.put("sellStatus", status);
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/product/proDetailSell.htm",
                    JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 查询所有门店
     *
     * @return String
     * @Methods Name selectAllBrand
     * @Create In 2015年9月24日 By duanzhaole
     */
    @ResponseBody
    @RequestMapping(value = "/selectAllBrand", method = {RequestMethod.GET, RequestMethod.POST})
    public String selectAllBrand(String shopSid, String shopCode, String parentSid) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("shopSid", shopSid);
        }
        if (StringUtils.isNotEmpty(shopCode)) {
            map.put("shopCode", shopCode);
        }
        if (StringUtils.isNotEmpty(parentSid)) {
            map.put("parentSid", parentSid);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                            + "/pcmAdminBrand/getListBrandByShopSidAndParentSid.htm",
                    JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 换品牌
     *
     * @return String
     * @Methods Name updateBrand
     * @Create In 2015年9月25日 By duanzhaole
     */
    @ResponseBody
    @RequestMapping(value = "/updateBrand", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateBrand(String sid, String brandCode, String activeTime) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(sid)) {
            map.put("sid", sid);
        }
        if (StringUtils.isNotEmpty(brandCode)) {
            map.put("brandSid", brandCode);
        }
        if (StringUtils.isNotEmpty(activeTime)) {
            map.put("activeTime", activeTime);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/propertyChange/changeGroupBrands.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 换款号
     *
     * @return String
     * @Methods Name updateBrand
     * @Create In 2015年9月25日 By duanzhaole
     */
    @ResponseBody
    @RequestMapping(value = "/updateModelCode", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateModelCode(String shoppeProSid, String modelCode) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(shoppeProSid)) {
            map.put("shoppeProSid", shoppeProSid);
        }
        if (StringUtils.isNotEmpty(modelCode)) {
            map.put("productSku", modelCode);
        }
        try {
            json = HttpUtilPcm.doPost(
                    SystemConfig.SSD_SYSTEM_URL + "/product/changeProductSku.htm",
                    JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    //
    @ResponseBody
    @RequestMapping(value = "/changeProductSkuBySKU", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String changeProductSkuBySKU(String productSku, String primaryAttr, String skuCode) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        map.put("productDetailSid", skuCode);
        if (StringUtils.isNotEmpty(productSku)) {
            map.put("productSku", productSku);
        }
        if (StringUtils.isNotEmpty(primaryAttr)) {
            map.put("primaryAttr", primaryAttr);
        }

        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/validChangeProductSkuBySKU.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    //
    @ResponseBody
    @RequestMapping(value = "/addProByEdit", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateSkuColorStan(String spuList) {

        String json = "";
        List<PcmProDetailDto> proList = JsonUtil.getListDTO(spuList, PcmProDetailDto.class);
        List<Map<String, Object>> proList1 = new ArrayList<Map<String, Object>>();
        for (PcmProDetailDto pro : proList) {
            Map<String, Object> map = new HashMap<String, Object>();

            if (StringUtils.isNotEmpty(pro.getProStanSid())) {
                map.put("proStanSid", pro.getProStanSid());
            }
            if (StringUtils.isNotEmpty(pro.getProductSid())) {
                map.put("productSid", pro.getProductSid());
            }
            if (StringUtils.isNotEmpty(pro.getProColorName())) {
                map.put("proColorSid", pro.getProColorSid());
            }
            if (StringUtils.isNotEmpty(pro.getProColorName())) {
                map.put("proColorName", pro.getProColorName());
            }
            if (StringUtils.isNotEmpty(pro.getFeatures())) {
                map.put("features", pro.getFeatures());
            }
            proList1.add(map);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/proDetail/insertSkuInfo.htm",
                    JsonUtil.getJSONString(proList1));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    //
    @RequestMapping(value = "/getShoppeBySkuSid", method = {RequestMethod.GET, RequestMethod.POST})
    public String getShoppeBySkuSid(HttpServletRequest request, Model m) {
        String jsonShoppro = "";
        // String jsonSpuList = "";
        JSONObject jsons = new JSONObject();
        // JSONObject jsonSpu = new JSONObject();
        String skuSid = request.getParameter("skuSid");
        // String skuCode = request.getParameter("skuCode");

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("skuSid", skuSid);

        try {
            jsonShoppro = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/selectProPageBySku.htm", JsonUtil.getJSONString(map));
            jsons = JSONObject.fromObject(jsonShoppro);
            if ("true".equals(jsons.get("success"))) {
                m.addAttribute("json", jsons);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        /*
         * map.clear(); map.put("skuCode", skuCode); try { jsonSpuList =
		 * HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL +
		 * "/proDetail/selectSkuItemByCode.htm", JsonUtil.getJSONString(map));
		 * jsonSpu = JSONObject.fromObject(jsonSpuList); if
		 * ("true".equals(jsonSpu.get("success"))) { m.addAttribute("jsonSpu",
		 * jsonSpu); } } catch (Exception e) { e.printStackTrace(); }
		 */
        return "forward:/jsp/product/editProduct.jsp";
    }

    //
    @ResponseBody
    @RequestMapping(value = "/UpdateProductStatusInfo", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String UpdateProductStatusInfo(String productCode, String status) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        map.put("productCode", productCode);
        if (StringUtils.isNotEmpty(status)) {
            map.put("status", status);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/UpdateProductInfo.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    // 专柜商品启用状态多项修改
    @ResponseBody
    @RequestMapping(value = "/UpdateProductsStatusInfo", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String UpdateProductsStatusInfo(String productCodes, String status) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";

        if (StringUtils.isNotEmpty(productCodes)) {
            map.put("proShoppeCodes", productCodes);
        }
        if (StringUtils.isNotEmpty(status)) {
            map.put("status", status);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/UpdateProductStatusInfo.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/updateSkuInfoBySid", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateSkuInfoBySid(String skuSid, String searchKey, String keyWord) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        map.put("sid", skuSid);
        if (StringUtils.isNotEmpty(searchKey)) {
            map.put("searchKey", searchKey);
        }
        if (StringUtils.isNotEmpty(keyWord)) {
            map.put("keyWord", keyWord);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/proDetail/updateSkuInfoBySid.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/getBrandCateInfo", method = {RequestMethod.GET, RequestMethod.POST})
    public String getBrandCateInfo(String brandCode, String categoryCode) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";

        if (StringUtils.isNotEmpty(brandCode)) {
            map.put("brandCode", brandCode);
        }
        if (StringUtils.isNotEmpty(categoryCode)) {
            map.put("cateCode", categoryCode);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmInnerBrandData/getBrandCateInfo.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/addBrandCateInfo", method = {RequestMethod.GET, RequestMethod.POST})
    public String addBrandCateInfo(String brandCode, String categoryCode, String sizeCodeUrl,
                                   String status, String optUser) {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";

        if (StringUtils.isNotEmpty(brandCode)) {
            map.put("brandCode", brandCode);
        }
        if (StringUtils.isNotEmpty(categoryCode)) {
            map.put("cateCode", categoryCode);
        }
        if (StringUtils.isNotEmpty(sizeCodeUrl)) {
            map.put("sizePictureUrl", sizeCodeUrl);
        }
        if (StringUtils.isNotEmpty(status)) {
            map.put("status", status);
        }
        if (StringUtils.isNotEmpty(optUser)) {
            map.put("optUser", optUser);
        }
        list.add(map);
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmInnerBrandData/addBrandCateInfo.htm", JsonUtil.getJSONString(list));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/getProBySpuCode", method = {RequestMethod.GET, RequestMethod.POST})
    public String getProBySpuCode(String spuCode) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";

        if (StringUtils.isNotEmpty(spuCode)) {
            map.put("productSid", spuCode);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/getSpuproBySpu.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/editProDescBySpuCode", method = {RequestMethod.GET, RequestMethod.POST})
    public String editProDescBySpuCode(String spuCode, String longDesc, String shortDesc) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";

        if (StringUtils.isNotEmpty(spuCode)) {
            map.put("productSid", spuCode);
        }
        if (StringUtils.isNotEmpty(longDesc)) {
            map.put("longDesc", longDesc);
        }
        if (StringUtils.isNotEmpty(shortDesc)) {
            map.put("shortDesc", shortDesc);
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/product/editSpuproBySpu.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 根据产品编码和色系加载缩略图
     *
     * @param proSid
     * @param request
     * @return String
     * @Methods Name loadProSuolvImg
     * @Create In 2015-10-15 By zdl
     */
    @ResponseBody
    @RequestMapping(value = "/loadProSuolvImg", method = {RequestMethod.GET, RequestMethod.POST})
    public String loadProSuolvImg(String spuCode, String colorSid, HttpServletRequest request) {
        Map<String, Object> proMap = new HashMap<String, Object>();
        proMap.put("spuCode", spuCode);
        proMap.put("ifDelete", 0);
        proMap.put("isThumbnail", 0);
        proMap.put("color", colorSid);

        // 查询图片列表
        String result = "";
        JSONObject json = new JSONObject();
        try {
            result = HttpUtilPcm.doPost(
                    SystemConfig.SSD_SYSTEM_URL + "/productPrcture/queryPrctureInfoByPara.htm",
                    JsonUtil.getJSONString(proMap));
            if (StringUtils.isNotEmpty(result)) {
                JSONObject ret = JSONObject.fromObject(result);
                if ("true".equals(ret.get("success"))) {
                    JSONArray list = JSONArray.fromObject(ret.get("data"));
                    if (list != null && list.size() != 0) {
                        JSONObject o = JSONObject.fromObject(list.get(0));
                        json.put("success", "true");
                        json.put("spuCode", o.get("skuSid"));
                        json.put("pictureUrl", SystemConfig.IMAGE_SERVER + o.get("pictureUrl"));
                        json.put("colorCode", o.get("colorCode"));
                    } else {
                        json.put("success", "false");
                    }
                } else {
                    json.put("success", "false");
                }
            } else {
                json.put("success", "false");
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            json.put("success", "false");
            e.printStackTrace();
        }
        return json.toString();
    }
}
