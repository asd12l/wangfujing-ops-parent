package com.wangfj.order.controller;

import com.constants.SystemConfig;
import com.wangfj.back.controller.SecutityController;
import com.wangfj.wms.util.*;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Controller;
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
@RequestMapping(value = "/orderUpImg")
public class PictureUploadController {

    protected final Log logger = LogFactory.getLog(SecutityController.class);

    @Autowired
    private ThreadPoolTaskExecutor taskExecutor;

    /**
     * 退货图片上传
     * @Methods Name uploadBrandImg
     * @Create In 2016-4-8 By chenHu
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws FileUploadException String
     */
    @ResponseBody
    @RequestMapping(value = "/uploadOms-noMulti", method = {RequestMethod.GET,
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
                            int requiredWidthMax = 0;
                            int requiredHeightMax = 0;
                            long requiredSize = 0;
                            String imgName = "";
                            if ("brandimg1".equals(fieldName)) {
                                requiredWidth = Constants.BRAND_LOGO_PIC_WIDTH;
                                requiredHeight = Constants.BRAND_LOGO_PIC_HEIGHT;
                                imgName = "Logo";
                            }
                            if ("brandimg2".equals(fieldName)) {
                                requiredWidth = Constants.REFUND_BANNER_PIC_WIDTH;
                                requiredHeight = Constants.REFUND_BANNER_PIC_HEIGHT;
                                requiredWidthMax = Constants.REFUND_BANNER_PIC_WIDTH_MAX;
                                requiredHeightMax = Constants.REFUND_BANNER_PIC_HEIGHT_MAX;
                                requiredSize = Constants.REFUND_BANNER_PIC_SIZE_MAX;
                                imgName = "Refund";
                            }
                            // 获取图片的尺寸
                            BufferedImage bi = ImageIO.read(item.getInputStream());
                            int width = bi.getWidth();
                            int height = bi.getHeight();
                            long filesize = item.getSize();//获取图片大小
                            if (requiredSize >= filesize) {
                                uploadName = fileName + i + "." + name.split("\\.")[1];
//                                if (width >= requiredWidth && width <= requiredWidthMax && height >= requiredHeight && height <= requiredHeightMax) {
//                                	uploadName = fileName + i + "." + name.split("\\.")[1];
                                // 上传图片到ftp服务器并向数据库插入图片属性
                                FtpUtil.saveRefundToFtp(outPutStream, uploadName, item);
                                json.put("success", "true");
                                json.put("url", SystemConfig.IMAGE_REFUND_SERVER + SystemConfig.REFUND_IMAGE_PATH + "/" + uploadName);
                                json.put("data", uploadName);
                                //刷新CDN
                                Map<String, Object> para = new HashMap<String, Object>();
                                para.put("flushPath", SystemConfig.IMAGE_REFUND_SERVER + SystemConfig.REFUND_IMAGE_PATH + "/");
                                HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/common/flushCdn.htm", JsonUtil.getJSONString(para));
                            } else {
                                json.put("success", "false");
//                                json.put("data", imgName + "图片尺寸必须是" + requiredWidth + "*" + requiredHeight + "！");
                                json.put("data", imgName + "图片必须小于1M ！");
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

}
