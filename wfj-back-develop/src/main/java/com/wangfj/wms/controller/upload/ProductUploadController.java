package com.wangfj.wms.controller.upload;

import com.constants.SystemConfig;
import com.utils.StringUtils;
import com.wangfj.back.controller.SecutityController;
import com.wangfj.wms.util.*;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.tools.ant.types.resources.comparators.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;

@Controller
@RequestMapping(value = "/upImg")
public class ProductUploadController {

    protected final Log logger = LogFactory.getLog(SecutityController.class);

    @Autowired
    private ThreadPoolTaskExecutor taskExecutor;

    /**
     * 上传品牌图片到ftp
     *
     * @param request
     * @param response
     * @return String
     * @throws IOException
     * @throws FileUploadException
     * @Methods Name getProductSkusToExcel
     * @Create In 2015-3-27 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/uploadBrand-noMulti", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String uploadBrandImg(HttpServletRequest request, HttpServletResponse response)
            throws IOException, FileUploadException {
        JSONObject json = new JSONObject();
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
        // servletFileUpload.setSizeMax(maxPostSize);
        // 解析上传的请求 或许request中的请求的参数放入list
        List<FileItem> fileItem = servletFileUpload.parseRequest(request);
        // 获取当前时间戳
        fileName = FtpUtil.getImagePath();
        // 获取fileItem集合中的参数
        try {
            for (int i = 0; i < fileItem.size(); i++) {
                FileItem item = (FileItem) fileItem.get(i);
                // 判断是普通表单还是文件上传于， true是普通表单
                if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
                    name = item.getName();
                    int point = name.lastIndexOf(".");
                    if (point > -1) {
                        String type = name.substring(point);
                        if (".jpg".equalsIgnoreCase(type) || ".gif".equalsIgnoreCase(type)
                                || ".png".equalsIgnoreCase(type)) {
                            //根据fieldName判断是Logo图、Banner图
                            String fieldName = item.getFieldName();
                            int requiredWidth = 0;
                            int requiredHeight = 0;
                            String imgName = "";
                            if ("brandimg1".equals(fieldName)) {
                                requiredWidth = Constants.BRAND_LOGO_PIC_WIDTH;
                                requiredHeight = Constants.BRAND_LOGO_PIC_HEIGHT;
                                imgName = "Logo";
                            }
                            if ("brandimg2".equals(fieldName)) {
                                requiredWidth = Constants.BRAND_BANNER_PIC_WIDTH;
                                requiredHeight = Constants.BRAND_BANNER_PIC_HEIGHT;
                                imgName = "Banner";
                            }
                            // 获取图片的尺寸
                            BufferedImage bi = ImageIO.read(item.getInputStream());
                            int width = bi.getWidth();
                            int height = bi.getHeight();
                            if (width == requiredWidth && height == requiredHeight) {
                                uploadName = fileName + i + "." + name.split("\\.")[1];
                                // 上传图片到ftp服务器并向数据库插入图片属性
                                FtpUtil.saveBrandToFtp(outPutStream, uploadName, item);
                                json.put("success", "true");
                                json.put("url", SystemConfig.IMAGE_BRAND_SERVER + SystemConfig.BRAND_IMAGE_PATH + "/" + uploadName);
                                json.put("data", uploadName);
                                //刷新CDN
                                Map<String, Object> para = new HashMap<String, Object>();
                                para.put("flushPath", SystemConfig.IMAGE_BRAND_SERVER + SystemConfig.BRAND_IMAGE_PATH + "/");
                                HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/common/flushCdn.htm", JsonUtil.getJSONString(para));
                            } else {
                                json.put("success", "false");
                                json.put("data", imgName + "图片尺寸必须是" + requiredWidth + "*" + requiredHeight + "！");
                            }
                        } else {
                            json.put("success", "false");
                            json.put("data", "只能上传jpg、gif、png类型的图片！");
                        }
                    } else {
                        json.put("success", "false");
                        json.put("data", "只能上传jpg、gif、png类型的图片！");
                    }
                } else {
                    // 非图片参数的处理
                    /*
                     * if ("brandName".equals(item.getFieldName())) {
					 * map.put("brandName", item.getString(encoding)); }
					 */
                }
            }
        } catch (Exception e) {
            json.put("success", "false");
            e.printStackTrace();
        }
        return json.toString();
    }

    /**
     * 上传尺码对照表图片到ftp
     *
     * @param request
     * @param response
     * @return String
     * @throws IOException
     * @throws FileUploadException
     * @Methods Name uploadSizeCodeTableImg
     * @Create In 2015-3-27 By zdl
     */
    @ResponseBody
    @RequestMapping(value = "/uploadSizeCodeTable-noMulti", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String uploadSizeCodeTableImg(HttpServletRequest request, HttpServletResponse response)
            throws IOException, FileUploadException {

        Map<String, String> textMap = new HashMap<String, String>();

//        textMap.put("uploaduser", request.getSession().getAttribute("username").toString());
        textMap.put("uploaduser", CookiesUtil.getCookies(request, "username"));

        Map<String, byte[]> fileMap = new HashMap<String, byte[]>();

        JSONObject json = new JSONObject();
        // 请求SSDserver时封装参数
        Map<String, Object> map = new HashMap<String, Object>();
        // .jpg
        String name = "";
        // 时间
        String fileName = "";
        // fileName + name
        String uploadName = "";
        int imgWidth = 0;
        // 获取编码
        String encoding = request.getCharacterEncoding();
        // 定义输出流对象
        OutputStream outPutStream = null;
        // 创建基于文件项目的工厂对象
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

        diskFileItemFactory.setSizeThreshold(1024);
        ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
        // 允许上传文件的最大范围
        // servletFileUpload.setSizeMax(maxPostSize);
        // 解析上传的请求 或许request中的请求的参数放入list
        List<FileItem> fileItem = servletFileUpload.parseRequest(request);
        // 获取当前时间戳
        fileName = FtpUtil.getImagePath();
        // 获取fileItem集合中的参数
        try {
            String brandCode = "";
            String cateCode = "";
            for (int i = 0; i < fileItem.size(); i++) {
                FileItem item = (FileItem) fileItem.get(i);
                // 判断是普通表单还是文件上传于， true是普通表单
                if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {

                } else {
                    // 非图片参数的处理
                    String fieldName = item.getFieldName();
                    if (fieldName.equals("brandCode")) {
                        brandCode = item.getString(encoding);
                    } else {
                        cateCode = item.getString(encoding);
                    }
                }
            }
            for (int i = 0; i < fileItem.size(); i++) {
                FileItem item = (FileItem) fileItem.get(i);
                // 判断是普通表单还是文件上传于， true是普通表单
                if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
                    name = item.getName();
                    int point = name.lastIndexOf(".");
                    if (point > -1) {
                        String type = name.substring(point);
                        if (".jpg".equalsIgnoreCase(type) || ".gif".equalsIgnoreCase(type)
                                || ".png".equalsIgnoreCase(type)) {
                            uploadName = brandCode + "_" + cateCode + "_" + fileName + "."
                                    + name.split("\\.")[1];

                            fileMap.put(uploadName, item.get());
                            // 获取图片的尺寸
                            BufferedImage bi = ImageIO.read(item.getInputStream());
                            int width = bi.getWidth();
                            int height = bi.getHeight();
                            textMap.put("width", width + "");
                            textMap.put("height", height + "");
                            textMap.put("size", item.getSize() + "");
                            imgWidth = width;
                        } else {
                            json.put("success", "false");
                            json.put("data", "只能上传jpg、gif、png类型的图片！");
                        }
                    } else {
                        json.put("success", "false");
                        json.put("data", "只能上传jpg、gif、png类型的图片！");
                    }
                } else {
                    // 非图片参数的处理
                    if ("brandCode".equals(item.getFieldName())) {
                        textMap.put("brandCode", item.getString(encoding));
                    }
                    if ("cateCode".equals(item.getFieldName())) {
                        textMap.put("categoryCode", item.getString(encoding));
                    }
                }
            }//{"brandCode":"c123","status":"true","categoryCode":"d9123","url":"brand/c123_d9123.jpg"}
//            if (imgWidth < Constants.SIZECODE_PIC_WIDTH) {
                String ret = UploadUtil.formUpload(
                        SystemConfig.PHOTO_SERVER + "photo/uploadSizeTablePic.htm", textMap, fileMap);
                if (StringUtils.isNotEmpty(ret)) {
                    JSONObject result = JSONObject.fromObject(ret);
                    if ("true".equals(result.get("status"))) {
                        json.put("success", "true");
                        String url = SystemConfig.IMAGE_SERVER + result.get("url");
                        json.put("url", url);
                    } else {
                        json.put("success", "false");
                    }
                } else {
                    json.put("success", "false");
                }
//            } else {
//                json.put("success", "false");
//                json.put("data", uploadName + "图片宽必须小于" + Constants.SIZECODE_PIC_WIDTH + "！");
//            }
        } catch (Exception e) {
            json.put("success", "false");
            e.printStackTrace();
        }
        return json.toString();
    }

    /**
     * 跳转到添加图片选项卡，根据产品编码加载色系
     *
     * @param proSid
     * @param m
     * @param request
     * @return String
     * @Methods Name loadProImgs
     * @Create In 2015-10-15 By chengsj
     */
    @RequestMapping(value = "/loadColors", method = {RequestMethod.GET, RequestMethod.POST})
    public String loadColors(String proSid, Model m, String mark, HttpServletRequest request) {
        Map<String, Object> proMap = new HashMap<String, Object>();
        proMap.put("spuCode", proSid);
        String forwardUrl = "";
        String json = "";
        json = HttpUtilPcm.doPost(
                SystemConfig.SSD_SYSTEM_URL + "/productPrcture/queryColorBySpu.htm",
                JsonUtil.getJSONString(proMap));
        proMap.clear();

        try {
            if (!"".equals(json) && json != null) {
                JSONObject colorJson = JSONObject.fromObject(json);
                if ("true".equals(colorJson.get("success"))) {
                    m.addAttribute("mark", mark);
                    m.addAttribute("", "");
                    m.addAttribute("colors", colorJson.get("data"));
                    m.addAttribute("productCode", proSid);
                    forwardUrl = "/product/uploadProduct";
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
            m.addAttribute("error", "系统异常，请联系管理员！");
            forwardUrl = "forward:/404.jsp";
        }
        return forwardUrl;

    }

    /**
     * 跳转到添加图片选项卡，根据产品编码加载色系
     *
     * @param proSid
     * @param m
     * @param request
     * @return String
     * @Methods Name loadProImgs
     * @Create In 2015-10-15 By chengsj
     */
    @RequestMapping(value = "/loadProImgs", method = {RequestMethod.GET, RequestMethod.POST})
    public String loadProImgs(String proSid, String colorSid, Model m, String mark,
                              HttpServletRequest request) {
        Map<String, Object> proMap = new HashMap<String, Object>();
        proMap.put("spuCode", proSid);
        proMap.put("ifDelete", 0);
        proMap.put("isThumbnail", 1);
        proMap.put("isModel", 0);
        proMap.put("color", colorSid);
        m.addAttribute("img_server", SystemConfig.IMAGE_SERVER);
        m.addAttribute("uid", System.currentTimeMillis());

        String forwardUrl = "";
        // 查询图片列表
        String json = "";
        json = HttpUtilPcm.doPost(
                SystemConfig.SSD_SYSTEM_URL + "/productPrcture/queryPrctureInfoByPara.htm",
                JsonUtil.getJSONString(proMap));

        // 查询最大排序号
        String json1 = "";
        json1 = HttpUtilPcm.doPost(
                SystemConfig.SSD_SYSTEM_URL + "/productPrcture/getSortByOara.htm",
                JsonUtil.getJSONString(proMap));

        proMap.clear();

        try {
            if (!"".equals(json) && json != null) {
                JSONObject imgJson = JSONObject.fromObject(json);
                if ("true".equals(imgJson.get("success"))) {
                    m.addAttribute("imgs", imgJson.get("data"));
                } else {
                    m.addAttribute("error", "系统异常，请联系管理员！");
                    forwardUrl = "forward:/404.jsp";
                }
            } else {
                m.addAttribute("error", "系统异常，请联系管理员！");
                forwardUrl = "forward:/404.jsp";
            }

            if (!"".equals(json1) && json != null) {
                JSONObject maxSortJson = JSONObject.fromObject(json1);
                if ("true".equals(maxSortJson.get("success"))) {
                    m.addAttribute("mark", mark);
                    m.addAttribute("maxSort", maxSortJson.get("data"));
                    forwardUrl = "/product/imgShow";
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
            forwardUrl = "forward:/404.jsp";
        }
        return forwardUrl;

    }

    @ResponseBody
    @RequestMapping(value = "/loadProImgs1", method = {RequestMethod.GET, RequestMethod.POST})
    public String loadProImgs1(String proSid, HttpServletRequest request) {
        JSONObject jsonO = new JSONObject();
        Map<String, Object> proMap = new HashMap<String, Object>();
        proMap.put("spuCode", proSid);
        proMap.put("ifDelete", 0);
        proMap.put("isThumbnail", 1);
        proMap.put("isModel", 0);
        // 查询图片列表
        String json = "";
        json = HttpUtilPcm.doPost(
                SystemConfig.SSD_SYSTEM_URL + "/productPrcture/queryPrctureInfoByPara1.htm",
                JsonUtil.getJSONString(proMap));
        proMap.clear();
        try {
            if (!"".equals(json) && json != null) {
                JSONObject imgJson = JSONObject.fromObject(json);
                if ("true".equals(imgJson.get("success"))) {
                    jsonO.put("success", "true");
                    jsonO.put("data", imgJson.get("data"));
                } else {
                    jsonO.put("error", "系统异常，请联系管理员！");
                }
            } else {
                jsonO.put("error", "系统异常，请联系管理员！");
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            jsonO.put("error", "系统异常，请联系管理员！");
        }
        return jsonO.toString();
    }

    /**
     * 上传产品图片到服务器
     *
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws FileUploadException String
     * @Methods Name uploadProductImg
     * @Create In 2015-10-12 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/uploadProduct-noMulti", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String uploadProductImg(HttpServletRequest request, HttpServletResponse response)
            throws IOException, FileUploadException {

        Map<String, String> textMap = new HashMap<String, String>();

//        textMap.put("uploaduser", request.getSession().getAttribute("username").toString());
        textMap.put("uploaduser", CookiesUtil.getCookies(request, "username"));

        Map<String, byte[]> fileMap = new HashMap<String, byte[]>();

        JSONObject json = new JSONObject();
        // 请求SSDserver时封装参数
        Map<String, Object> map = new HashMap<String, Object>();
        // .jpg
        String name = "";
        // 时间
        String fileName = "";
        // fileName + name
        String uploadName = "";
        int imgWidth = 0;
        int imgHeight = 0;
        // 获取编码
        String encoding = request.getCharacterEncoding();
        // 定义输出流对象
        OutputStream outPutStream = null;
        // 创建基于文件项目的工厂对象
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

        diskFileItemFactory.setSizeThreshold(1024);
        ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
        // 允许上传文件的最大范围
        // servletFileUpload.setSizeMax(maxPostSize);
        // 解析上传的请求 或许request中的请求的参数放入list
        List<FileItem> fileItem = servletFileUpload.parseRequest(request);
        // 获取当前时间戳
        fileName = FtpUtil.getImagePath();
        // 获取fileItem集合中的参数
        try {
            for (int i = 0; i < fileItem.size(); i++) {
                FileItem item = (FileItem) fileItem.get(i);
                // 判断是普通表单还是文件上传于， true是普通表单
                if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
                    name = item.getName();
                    int point = name.lastIndexOf(".");
                    if (point > -1) {
                        String type = name.substring(point);
                        if (".jpg".equalsIgnoreCase(type) || ".gif".equalsIgnoreCase(type)
                                || ".png".equalsIgnoreCase(type)) {
                            uploadName = fileName + i + "." + name.split("\\.")[1];

                            fileMap.put(uploadName, item.get());
                            // 获取图片的尺寸
                            BufferedImage bi = ImageIO.read(item.getInputStream());
                            int width = bi.getWidth();
                            int height = bi.getHeight();
                            textMap.put("width", width + "");
                            textMap.put("height", height + "");
                            imgWidth = width;
                            imgHeight = height;
                        } else {
                            json.put("success", "false");
                            json.put("data", "图片类型错误！");
                        }
                    } else {
                        json.put("success", "false");
                        json.put("data", "图片类型错误！");
                    }
                } else {
                    // 非图片参数的处理
                    if ("sort".equals(item.getFieldName())) {
                        textMap.put("number", item.getString(encoding));
                    }

                    if ("productCode".equals(item.getFieldName())) {
                        textMap.put("productId", item.getString(encoding));
                    }

                    if ("colorSid".equals(item.getFieldName())) {
                        textMap.put("color_sid", item.getString(encoding));
                    }
                    if ("isPrintMark".equals(item.getFieldName())) {
                        textMap.put("isPrintMark", item.getString(encoding));
                    }
                }
            }
            if (imgWidth == Constants.PRO_PIC_WIDTH && imgHeight == Constants.PRO_PIC_HEIGHT) {
                String ret = UploadUtil.formUpload(
                        SystemConfig.PHOTO_SERVER + "photo/uploadProductPic.htm", textMap, fileMap);
                if (StringUtils.isNotEmpty(ret)) {
                    JSONObject result = JSONObject.fromObject(ret);
                    if ("true".equals(result.get("success"))) {
                        json.put("success", "true");
                    } else {
                        json.put("success", "false");
                        json.put("data", JSONObject.fromObject(result.get("data")).get("errorMsg"));
                    }
                } else {
                    json.put("success", "false");
                    json.put("data", "上传失败！");
                }
            } else {
                json.put("success", "false");
                json.put("data", "图片尺寸不符合！");
            }
        } catch (Exception e) {
            json.put("success", "false");
            json.put("data", "系统错误！");
            e.printStackTrace();
        }
        return json.toString();
    }

    /**
     * 修改图片
     *
     * @param imgIds
     * @param type
     * @param imgUrl
     * @param imgName
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws FileUploadException String
     * @Methods Name modifyImg
     * @Create In 2015-10-20 By chengsj
     */
    @ResponseBody
    @RequestMapping(value = "/modifyImg", method = {RequestMethod.GET, RequestMethod.POST})
    public String modifyImg(String imgIds, String type, String imgUrl, String imgName,
                            HttpServletRequest request, HttpServletResponse response)
            throws IOException, FileUploadException {
        Map<String, Object> imgMap = new HashMap<String, Object>();
        JSONObject json = new JSONObject();

        if (!StringUtils.isNotEmpty(imgIds)) {
            json.put("success", false);
            json.put("data", "没有选择图片");
            return json.toString();
        }
        String[] ids = imgIds.split(",");

        if (!StringUtils.isNotEmpty(type)) {
            json.put("success", false);
            json.put("data", "修改出错");
            return json.toString();
        }

        List<Map<String, Object>> params = new ArrayList<Map<String, Object>>();

        // 设置主图
        if ("2".equals(type)) {
            if (ids.length > 1) {
                json.put("success", false);
                json.put("data", "只能选择一张主图");
            }
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("sid", ids[0]);
            map.put("picName", imgName);
            map.put("url", imgUrl);
            params.add(map);
        }

        // 设置模特图,删除图片
        if ("1".equals(type) || "4".equals(type)) {
            for (int i = 0; i < ids.length; i++) {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("sid", ids[i]);
                params.add(map);
            }
        }

        // 排序
        if ("3".equals(type)) {
            for (int i = 0; i < ids.length; i++) {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("sid", ids[i]);
                map.put("number", i);
                params.add(map);
            }
        }
        imgMap.put("type", type);
        imgMap.put("data", params);

        try {
            String result = HttpUtilPcm.doPost(
                    SystemConfig.PHOTO_SERVER + "photo/configProductInfo.htm",
                    JsonUtil.getJSONString(imgMap));
            if (StringUtils.isNotEmpty(result)) {
                JSONObject ret = JSONObject.fromObject(result);
                if ("true".equals(ret.get("success"))) {
                    json.put("success", "true");
                } else {
                    JSONObject error = JSONObject.fromObject(ret.get("data"));
                    json.put("success", "false");
                    json.put("data", error.get("errorMsg"));
                }
            } else {
                json.put("success", "false");
                json.put("data", "修改失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            json.put("success", "false");
            json.put("data", "修改失败");
        }

        return json.toString();
    }

}
