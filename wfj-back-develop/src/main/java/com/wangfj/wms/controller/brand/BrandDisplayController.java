package com.wangfj.wms.controller.brand;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.lowagie.text.pdf.codec.Base64.OutputStream;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.domain.entity.BrandVO;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.isChineseCharAndUpperCaseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 集团品牌控制器
 *
 * @Class Name BrandDisplayController
 * @Author wangsy
 * @Create In 2015年8月11日
 */
@Controller
@RequestMapping(value = "/brandDisplay")
public class BrandDisplayController {

    private int maxPostSize = 104857600;

    /**
     * 查询品牌
     *
     * @param request
     * @param response
     * @param brandName
     * @param brandType
     * @param brandSid
     * @return String
     * @Methods Name queryBrand
     * @Create In 2015-8-24 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryBrand"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String queryBrand(HttpServletRequest request, HttpServletResponse response,
                             String brandType, String shopType, String brandName, String brandSid) {
        String json = "";
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
        if (StringUtils.isNotEmpty(brandType)) {
            map.put("brandType", brandType);
        } else {
            map.put("brandType", Integer.valueOf(0));
        }
        if (StringUtils.isNotEmpty(shopType)) {
            if ("1".equals(brandType)) {
                map.put("shopType", Integer.parseInt(shopType));
            }
        }
        if (StringUtils.isNotEmpty(brandSid)) {
            map.put("brandSid", brandSid.trim());
        }
        if (StringUtils.isNotEmpty(brandName)) {
            map.put("brandName", brandName.trim());
        }
        map.put("fromSystem", "PCM");
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminBrand/findPageBrand.htm", JsonUtil.getJSONString(map));
            map.clear();
            if (StringUtils.isNotEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject jsonPage = jsonObject.getJSONObject("data");
                if (jsonPage != null) {
                    Object list = jsonPage.get("list");
                    if (list != null && !"null".equals(list.toString())) {
                        JSONArray brands = JSONArray.fromObject(list);
                        for (int i = 0; i < brands.size(); i++) {
                            JSONObject brand = brands.getJSONObject(i); // 遍历
                            // jsonarray
                            // 数组，把每一个对象转成
                            // json
                            // 对象
                            brand.put("url", SystemConfig.IMAGE_BRAND_SERVER
                                    + SystemConfig.BRAND_IMAGE_PATH + "/");
                        }
                        map.put("list", brands);
                        map.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
                                : jsonPage.get("pages"));
                    } else {
                        map.put("list", "");
                        map.put("pageCount", Integer.valueOf(0));
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
            map.put("list", null);
            map.put("pageCount", Integer.valueOf(0));
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

    /**
     * 添加品牌
     *
     * @param request
     * @param response
     * @param parentSid
     * @param brandType
     * @param brandName
     * @param spell
     * @param shopType
     * @param brandNameSecond
     * @param brandNameEn
     * @param brandcorp
     * @param brandSpecialty
     * @param brandSuitability
     * @param brandpic1
     * @param brandpic2
     * @param isDisplay
     * @param status
     * @param brandDesc
     * @param shopSid
     * @return String
     * @Methods Name addBrandGroup
     * @Create In 2015-8-24 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/addBrandGroup"}, method = {RequestMethod.GET, RequestMethod.POST})
    public String addBrandGroup(HttpServletRequest request, HttpServletResponse response,
                                String parentSid, String brandType, String brandName, String spell, String shopType,
                                String brandNameSecond, String brandNameEn, String brandcorp, String brandSpecialty,
                                String brandSuitability, String brandpic1, String brandpic2, String isDisplay,
                                String status, String brandDesc, String shopSid) {
        String json = "";
        try {
            Map<String, String> map = new HashMap<String, String>();
            map.put("fromSystem", "PCM");
            if ((shopType != null) && (!"".equals(shopType))) {
                map.put("shopType", shopType);
            }
            if ((parentSid != null) && (!"".equals(parentSid))) {
                map.put("parentSid", parentSid);
            }
            if ((shopSid != null) && (!"".equals(shopSid))) {
                map.put("shopSid", shopSid);
            }
            if ((brandName != null) && (!"".equals(brandName))) {
                map.put("brandName", brandName);
            }
            if ((spell != null) && (!"".equals(spell))) {
                map.put("spell", spell);
            }
            if ((brandType != null) && (!"".equals(brandType))) {
                map.put("brandType", brandType);
            }
            if ((brandNameSecond != null) && (!"".equals(brandNameSecond))) {
                map.put("brandNameSecond", brandNameSecond);
            }
            if ((brandNameEn != null) && (!"".equals(brandNameEn))) {
                map.put("brandNameEn", brandNameEn);
            }
            if ((brandcorp != null) && (!"".equals(brandcorp))) {
                map.put("brandcorp", brandcorp);
            }
            if ((brandSpecialty != null) && (!"".equals(brandSpecialty))) {
                map.put("brandSpecialty", brandSpecialty);
            }
            if ((brandSuitability != null) && (!"".equals(brandSuitability))) {
                map.put("brandSuitability", brandSuitability);
            }
            if ((brandpic1 != null) && (!"".equals(brandpic1))) {
                map.put("brandpic1", brandpic1);
            }
            if ((brandpic2 != null) && (!"".equals(brandpic2))) {
                map.put("brandpic2", brandpic2);
            }
            if ((isDisplay != null) && (!"".equals(isDisplay))) {
                map.put("isDisplay", isDisplay);
            }
            if ((status != null) && (!"".equals(status))) {
                map.put("status", status);
            }
            if ((brandDesc != null) && (!"".equals(brandDesc))) {
                map.put("brandDesc", brandDesc);
            }
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminBrand/addPcmBrand.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            json = "{'success':false}";
        }
        return json;
    }

    /**
     * 修改品牌
     *
     * @param request
     * @param response
     * @param brandType
     * @param brandName
     * @param spell
     * @param brandNameSecond
     * @param brandNameEn
     * @param brandcorp
     * @param brandSpecialty
     * @param brandSuitability
     * @param brandpic1
     * @param brandpic2
     * @param isDisplay
     * @param status
     * @param brandDesc
     * @param sid
     * @param shopSidInput
     * @return String
     * @Methods Name modifyBrandGroup
     * @Create In 2015-8-24 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/modifyBrandGroup"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String modifyBrandGroup(HttpServletRequest request, HttpServletResponse response,
                                   String parentSid, String brandType, String brandName, String spell, String shopType,
                                   String brandNameSecond, String brandNameEn, String brandcorp, String brandSpecialty,
                                   String brandSuitability, String brandpic1, String brandpic2, String isDisplay,
                                   String status, String brandDesc, String sid, String shopSidInput) {
        String json = "";
        try {
            Map<String, String> map = new HashMap<String, String>();
            map.put("fromSystem", "PCM");
            if ((sid != null) && (!"".equals(sid))) {
                map.put("sid", sid);
            }
            if ((shopSidInput != null) && (!"".equals(shopSidInput))) {
                map.put("shopSid", shopSidInput);
            }
            if ((parentSid != null) && (!"".equals(parentSid))) {
                map.put("parentSid", parentSid);
            }
            if ((shopType != null) && (!"".equals(shopType))) {
                map.put("shopType", shopType);
            }
            if ((brandName != null) && (!"".equals(brandName))) {
                map.put("brandName", brandName);
            }
            if ((spell != null) && (!"".equals(spell))) {
                map.put("spell", spell);
            }
            if ((brandType != null) && (!"".equals(brandType))) {
                map.put("brandType", brandType);
            }
            if ((brandNameSecond != null) && (!"".equals(brandNameSecond))) {
                map.put("brandNameSecond", brandNameSecond);
            }
            if ((brandNameEn != null) && (!"".equals(brandNameEn))) {
                map.put("brandNameEn", brandNameEn);
            }
            if ((brandcorp != null) && (!"".equals(brandcorp))) {
                map.put("brandcorp", brandcorp);
            }
            if ((brandSpecialty != null) && (!"".equals(brandSpecialty))) {
                map.put("brandSpecialty", brandSpecialty);
            }
            if ((brandSuitability != null) && (!"".equals(brandSuitability))) {
                map.put("brandSuitability", brandSuitability);
            }
            if ((brandpic1 != null) && (!"".equals(brandpic1))) {
                map.put("brandpic1", brandpic1);
            }
            if ((brandpic2 != null) && (!"".equals(brandpic2))) {
                map.put("brandpic2", brandpic2);
            }
            if ((isDisplay != null) && (!"".equals(isDisplay))) {
                map.put("isDisplay", isDisplay);
            }
            if ((status != null) && (!"".equals(status))) {
                map.put("status", status);
            }
            if ((brandDesc != null) && (!"".equals(brandDesc))) {
                map.put("brandDesc", brandDesc);
            }
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminBrand/updateBrand.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            json = "{'success':false}";
        }
        return json;
    }

    /**
     * 从搜索查询集团品牌
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name queryBrandGroupListByName
     * @Create In 2016-03-22 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = {"/queryBrandGroupListByName"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryBrandGroupListByName(HttpServletRequest request, HttpServletResponse response,
                                            String prefix) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(prefix)) {
            map.put("prefix", prefix.trim());
        }
        try {
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/pcmAdminBrand/queryBrandGroupListByName.htm",
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
     * 查询集团品牌
     *
     * @param request
     * @param response
     * @param brandType
     * @return String
     * @Methods Name queryBrandGroupList
     * @Create In 2015-8-24 By chenhu
     */
    @ResponseBody
    @RequestMapping(value = {"/queryBrandGroupList"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryBrandGroupList(HttpServletRequest request, HttpServletResponse response,
                                      String brandType) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(brandType)) {
            map.put("brandType", brandType.trim());
        } else {
            map.put("brandType", 0);
        }
        map.put("fromSystem", "PCM");
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminBrand/findListBrand.htm", JsonUtil.getJSONString(map));
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
     * 查询集团品牌部分信息
     *
     * @param request
     * @param response
     * @param brandType
     * @return String
     * @Methods Name queryBrandGroupListPartInfo
     * @Create In 2016-02-22 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = {"/queryBrandGroupListPartInfo"}, method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryBrandGroupListPartInfo(HttpServletRequest request, HttpServletResponse response, String brandType,
                                              String brandName, String brandSid) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageSize", size);// 每页显示数量
        map.put("currentPage", currPage);// 当前第几页
        if (StringUtils.isNotEmpty(brandType)) {
            map.put("brandType", Integer.parseInt(brandType.trim()));
        } else {
            map.put("brandType", 0);
        }
        if (StringUtils.isNotEmpty(brandName)) {
            map.put("brandName", brandName.trim());
        }
        if (StringUtils.isNotEmpty(brandSid)) {
            map.put("brandSid", brandSid.trim());
        }
        map.put("fromSystem", "PCM");
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminBrand/findListBrandPartInfo.htm", JsonUtil.getJSONString(map));
            map.clear();
            if (StringUtils.isNotEmpty(json)) {
                JSONObject jsonObject = JSONObject.fromObject(json);
                JSONObject data = jsonObject.getJSONObject("data");
                JSONArray list = data.getJSONArray("list");
                if (list != null && list.size() != 0) {
                    map.put("list", list);
                    map.put("pageCount", data.get("pages") == null ? Integer.valueOf(0)
                            : data.get("pages"));
                    map.put("success", "true");
                } else {
                    map.put("list", "");
                    map.put("pageCount", Integer.valueOf(0));
                    map.put("success", "false");
                }
            } else {
                map.put("list", "");
                map.put("pageCount", Integer.valueOf(0));
                map.put("success", "false");
            }
        } catch (Exception e) {
            map.put("list", "");
            map.put("pageCount", Integer.valueOf(0));
            map.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

    /**
     * 根据skuSid和门店sid查询门店品牌
     *
     * @param shopSid
     * @param skuSid
     * @return String
     * @Methods Name getShopBrandByShopSidAndSkuSid
     * @Create In 2015-11-19 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = "/getShopBrandByShopSidAndSkuSid", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String getShopBrandByShopSidAndSkuSid(String shopSid, String skuSid) {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        if (StringUtils.isNotEmpty(shopSid)) {
            map.put("shopSid", shopSid.trim());
        }
        if (StringUtils.isNotEmpty(skuSid)) {
            map.put("skuSid", skuSid.trim());
        }
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                            + "/pcmAdminBrand/getListBrandByShopSidAndSkuSid.htm",
                    JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
            json = "";
        }
        return json;
    }

    /**
     * 校验品牌是否存在
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name validateBrandExistence
     * @Create In 2016-03-23 By wangxuan
     */
    @ResponseBody
    @RequestMapping(value = "/validateBrandExistence", method = {RequestMethod.GET, RequestMethod.POST})
    public String validateBrandExistence(HttpServletRequest request, String brandType, String shopType, String brandName) {
        Map<String, Object> map = new HashMap<String, Object>();
        if (StringUtils.isNotEmpty(brandType)) {
            map.put("brandType", Integer.parseInt(brandType.trim()));
        }
        if (StringUtils.isNotEmpty(shopType)) {
            map.put("shopType", Integer.parseInt(shopType.trim()));
        }
        if (StringUtils.isNotEmpty(brandName)) {
            map.put("brandName", brandName.trim());
        }
        String json = "";
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/brandCommon/validateBrand.htm", JsonUtil.getJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    /**
     * 查询品牌是否存在
     *
     * @param request
     * @param response
     * @return String
     * @Methods Name queryBrandExists
     * @Create In 2015-3-17 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/queryBrandExists", method = {RequestMethod.GET, RequestMethod.POST})
    public String queryBrandExists(HttpServletRequest request, HttpServletResponse response) {
        String success = "";
        // String productName = request.getParameter("productName");
        String brandName = request.getParameter("brandName");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("brandName", brandName);
        try {
            success = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryBrandExists.json",
                    map);
        } catch (Exception e) {
            e.printStackTrace();
            success = "";
        }

        return success;
    }

    /**
     * 查询所有集团品牌
     *
     * @param request
     * @param response
     * @param brandVO
     * @return String
     * @Methods Name queryAllBrandDisplay
     * @Create In 2015年8月11日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/selectAllBrand", method = {RequestMethod.GET, RequestMethod.POST})
    public String queryAllBrandDisplay(HttpServletRequest request, HttpServletResponse response,
                                       BrandVO brandVO) {
        String json = "";
        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            map.put("pageSize", size);// 每页显示数量
            map.put("currentPage", currPage);// 当前第几页
            if (null != brandVO.getBrandName() || "".equals(brandVO.getBrandName())) {
                map.put("brandName", brandVO.getBrandName());
            }
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/pcmAdminBrandGroup/findBrandGroupForPage.htm", map);
            map.clear();
            JSONObject jsonObject = JSONObject.fromObject(json);
            JSONObject jsonPage = (JSONObject) jsonObject.get("page");
            if (jsonPage != null) {
                map.put("list", jsonPage.get("list"));
                map.put("pageCount", jsonPage.get("pages") == null ? 0 : jsonPage.get("pages"));
            } else {
                map.put("list", null);
                map.put("pageCount", 0);
            }
        } catch (Exception e) {
            json = "{'success':false}";
        }
        JSONObject jsonArray = JSONObject.fromObject(map);
        return jsonArray.toString();
    }

    /**
     * 添加集团品牌
     * <p/>
     * 上传品牌图片,限制大小和类型
     *
     * @param model
     * @param request
     * @param response
     * @return
     * @throws FileUploadException
     * @throws ParseException
     * @throws UnsupportedEncodingException String
     * @Methods Name addBrand
     * @Create In 2015年8月11日 By wangsy
     */
    @ResponseBody
    @RequestMapping(value = "/addBrand", method = {RequestMethod.GET, RequestMethod.POST})
    public String addBrand(Model model, HttpServletRequest request, HttpServletResponse response)
            throws FileUploadException, ParseException, UnsupportedEncodingException {
        String result = "";
        // 请求SSDserver时封装参数
        Map<String, Object> map = new HashMap<String, Object>();
        // .jpg
        String name = "";
        // 时间
        String fileName = "";
        // fileName + name
        String uploadName = "";
        // 获取编码
        String encoding = request.getCharacterEncoding();
        // 定义输出流对象
        OutputStream outPutStream = null;
        // 创建基于文件项目的工厂对象
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

        diskFileItemFactory.setSizeThreshold(1024);
        ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
        // 允许上传文件的最大范围
        servletFileUpload.setSizeMax(maxPostSize);
        // 解析上传的请求 或许request中的请求的参数放入list
        List<FileItem> fileItem = servletFileUpload.parseRequest(request);
        // 获取当前时间戳
        fileName = FtpUtil.getImagePath();
        // 获取fileItem集合中的参数
        for (int i = 0; i < fileItem.size(); i++) {
            FileItem item = (FileItem) fileItem.get(i);
            // 判断是普通表单还是文件上传于， true是普通表单
            if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
                name = item.getName();
                int point = name.lastIndexOf(".");
                String type = name.substring(point);
                if (".jpg".equals(type) || ".gif".equals(type) || ".png".equals(type)
                        || ".JPG".equals(type) || ".GIF".equals(type) || ".PNG".equals(type)) {
                    uploadName = fileName + i + "." + name.split("\\.")[1];
                    // 上传图片到ftp服务器并向数据库插入图片属性
                    FtpUtil.saveBrandToFtp(outPutStream, uploadName, item);
                    if (item.getFieldName() == "brandLogoPic"
                            || "brandLogoPic".equals(item.getFieldName())) {
                        map.put("logoPic", "/" + SystemConfig.BRAND_IMAGE_PATH + "/" + uploadName);
                    }
                    if (item.getFieldName() == "brandBpict"
                            || "brandBpict".equals(item.getFieldName())) {
                        map.put("brandPict", "/" + SystemConfig.BRAND_IMAGE_PATH + "/" + uploadName);
                    }
                }
            } else {
                if ("brandName".equals(item.getFieldName())) {
                    map.put("brandName", item.getString(encoding));
                }
                if ("brandNameSpell".equals(item.getFieldName())) {
                    map.put("brandNameSpell", item.getString(encoding));
                }
                if ("brandNameAlias".equals(item.getFieldName())) {
                    map.put("brandNameAlias", item.getString(encoding));
                }
                if ("brandNameEn".equals(item.getFieldName())) {
                    map.put("brandNameEn", item.getString(encoding));
                }
                if ("brandDesc".equals(item.getFieldName())) {
                    map.put("brandDesc", item.getString(encoding));
                }
                if ("sid".equals(item.getFieldName())) {
                    map.put("brandDesc", item.getString(encoding));
                }
            }
        }
        try {
            result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
                    "/pcmAdminBrandGroup/savePcmBrandGroup.htm", map);
            if (result.equals("false")) {
                result = "false";
            }
        } catch (Exception e) {
            result = "{success:false}";
        }

        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteBrand", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteBrand(String sid) {
        String result = "";
        String s_ = "";
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            if (null != sid || !"".equals(sid)) {
                map.put("sid", sid);
            }
            String s = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/getBrandDisplay.html",
                    map);
            if (s != null && !"".equals(s) && !"false".equals(s)) {
                String[] pics = s.split(":");
                for (int i = 0; i < pics.length; i++) {
                    if (i % 2 != 0) {
                        s_ = pics[i].split("/")[2];
                        FtpUtil.deleteToFtp(s_, SystemConfig.BRAND_IMAGE_PATH);
                    }
                }
            }

            result = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/deleteBrand.html", map);
        } catch (Exception e) {
            result = "{success :false}";
        }
        return result;
    }

    @ResponseBody
    @RequestMapping(value = "/updataBrand", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateBrand(Model model, HttpServletRequest request,
                              HttpServletResponse response, String sid, String brandName, String brandNameSpell,
                              String brandNameAlias, String brandNameEn, String brandDesc)
            throws FileUploadException, UnsupportedEncodingException {
        Map<String, Object> map = new HashMap<String, Object>();
        String json = "";
        String dateName = "";
        String suffixName = "";
        String uploadName = "";
        String enCoding = request.getCharacterEncoding();
        OutputStream outPutStream = null;
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
        diskFileItemFactory.setSizeThreshold(1024);
        ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
        servletFileUpload.setSizeMax(maxPostSize);
        List<FileItem> fileItemList = servletFileUpload.parseRequest(request);
        dateName = FtpUtil.getImagePath();

        for (int i = 0; i < fileItemList.size(); i++) {
            FileItem fileItem = fileItemList.get(i);
            if (!fileItem.isFormField() && null != fileItem.getName()
                    && !"".equals(fileItem.getName())) {
                suffixName = fileItem.getName();
                int point = suffixName.lastIndexOf(".");
                String type = suffixName.substring(point);
                if (".jpg".equals(type) || ".gif".equals(type) || ".png".equals(type)
                        || ".JPG".equals(type) || ".GIF".equals(type) || ".PNG".equals(type)) {
                    uploadName = dateName + i + "." + suffixName.split("\\.")[1];
                    FtpUtil.saveBrandToFtp(outPutStream, uploadName, fileItem);
                    if (!"logoPic".equals(fileItem.getName()) || "logoPic" == fileItem.getName()) {
                        map.put("logoPic", "/" + SystemConfig.BRAND_IMAGE_PATH + "/" + uploadName);
                    }
                    if ("brandPict" == fileItem.getName()
                            || !"brandPict".equals(fileItem.getName())) {
                        map.put("brandPict", "/" + SystemConfig.BRAND_IMAGE_PATH + "/" + uploadName);
                    }
                }
            } else {
                if ("sid".equals(fileItem.getFieldName())
                        && !(null == fileItem.getString() && ""
                        .equals(fileItem.getString(enCoding)))) {
                    map.put("sid", fileItem.getString(enCoding));
                }
                if ("brandName".equals(fileItem.getFieldName())
                        && !(null == fileItem.getString() && ""
                        .equals(fileItem.getString(enCoding)))) {
                    map.put("brandName", fileItem.getString(enCoding));
                }
                if ("brandNameSpell".equals(fileItem.getFieldName())
                        && !(null == fileItem.getString() && ""
                        .equals(fileItem.getString(enCoding)))) {
                    map.put("brandNameSpell", fileItem.getString(enCoding));
                }
                if ("brandNameAlias".equals(fileItem.getFieldName())
                        && !(null == fileItem.getString() && ""
                        .equals(fileItem.getString(enCoding)))) {
                    map.put("brandNameAlias", fileItem.getString(enCoding));
                }
                if ("brandNameEn".equals(fileItem.getFieldName())
                        && !(null == fileItem.getString() && ""
                        .equals(fileItem.getString(enCoding)))) {
                    map.put("brandNameEn", fileItem.getString(enCoding));
                }
                if ("brandDesc".equals(fileItem.getFieldName())
                        && !(null == fileItem.getString() && ""
                        .equals(fileItem.getString(enCoding)))) {
                    map.put("brandDesc", fileItem.getString(enCoding));
                }
            }
        }

        try {
            json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/updateBrand.html", map);
        } catch (Exception e) {
            json = "{success:false}";
        }
        return json;
    }

    /**
     * 根据汉字或者拼音查询品牌
     *
     * @param cond
     * @return String
     * @Methods Name queryBrandDisplay
     * @Create In 2015-3-4 By xuxu
     */
    @ResponseBody
    @RequestMapping(value = "/queryBrandDisplay", method = {RequestMethod.POST, RequestMethod.GET})
    public String queryBrandDisplay(String cond) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();

        try {
            if (null != cond && !"".equals(cond)) {
                // 等于trur说明是汉字
                if (true == isChineseCharAndUpperCaseUtil.isChinese(cond)) {
                    map.put("brandName", cond);
                } else {
                    String str = isChineseCharAndUpperCaseUtil.upperCase(cond);
                    map.put("brandNameSpell", str);
                    map.put("brandNameEn", str);
                }
            }
            json = HttpUtil
                    .HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryBrandDisplay.html", map);
        } catch (Exception e) {
            json = "{success:false}";
        } finally {
            if ("false".equals(json)) {
                json = "{success:false}";
            }
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "/getAllBrandDisplay", method = {RequestMethod.POST, RequestMethod.GET})
    public String queryBrandDisplay() {
        String json = "";
        json = HttpUtil
                .HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllBrandDisplay.html", null);
        return json;
    }
}
