package com.wangfj.cms.topic;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.cms.utils.CdnHelper;
import com.wangfj.cms.utils.RemoteFtpProcess;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.wms.util.ResultUtil;

import common.Logger;

@RequestMapping(value = "/topic_floor")
@Controller
public class TopicFloorController {
	private Logger logger = Logger.getLogger(TopicFloorController.class);

	private static String[] imgServers;

    static {
        imgServers = SystemConfig.CMS_IMAGE_SERVERS.split("###");
    }
	
	private String className = TopicFloorController.class.getName();

	/**
	 * 专题楼层引导链接上传图片
	 * 
	 * @Methods Name uploadImg
	 * @Create In 2016年4月7日 By wangsy
	 * @param request
	 * @param response
	 * @return
	 * @throws FileUploadException
	 *             String
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "/uploadImg-noMulti", method = { RequestMethod.POST, RequestMethod.GET })
	public String uploadImg(HttpServletRequest request, HttpServletResponse response) {

        JSONObject jsonResult = new JSONObject();
        String methodName = "uploadImg";
        String siteId = request.getParameter("siteId");
        // 根据站点获取站点资源服务器地址
        Map<String, String> ftpMap = null;
        // 定义输出流对象
        OutputStream outPutStream = null;
        // 创建基于文件项目的工厂对象
        DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

        diskFileItemFactory.setSizeThreshold(1024);
        ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
        // 解析上传的请求  获取request中的请求的参数放入list
        List<FileItem> fileItems = null;
        FileItem fileItme = null;
        String fileName = null;
        try {
            fileItems = servletFileUpload.parseRequest(request);
        } catch (FileUploadException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        for (int i = 0; i < fileItems.size(); i++) {
            FileItem item = (FileItem) fileItems.get(i);
            if (!item.isFormField()) {// 判断是否为图片
                fileItme = item;
            } else {
                if (item.getFieldName() != null && item.getFieldName().equalsIgnoreCase("siteId")) {
                    siteId = item.getString();
                    ftpMap = this.getFtp(siteId, 2);
                }
            }
        }

        fileName = fileItme.getName();
        int pointIndex = fileName.lastIndexOf(".");
        String suffix = fileName.substring(pointIndex);
        if (".jpg".equalsIgnoreCase(suffix) || ".gif".equalsIgnoreCase(suffix) || ".png".equalsIgnoreCase(suffix)) {
            RemoteFtpProcess ftpProcess = new RemoteFtpProcess();
            ftpProcess.loginFtp(ftpMap.get("ip"), Integer.valueOf(ftpMap.get("port")), ftpMap.get("username"),
                    ftpMap.get("password"));
            String path = ftpMap.get("siteResourcePath") + SystemConfig.TOPIC_IMAGE_PATH;
            try {
                String newFileName = UUID.randomUUID() + suffix;
                ftpProcess.uploadFileToFtp(newFileName, fileItme.getInputStream(), path);
                String url = getImageServer() + "/" + path + "/" + newFileName;
                jsonResult.put("success", "true");
                jsonResult.put("url", url);
                jsonResult.put("data", ftpMap.get("siteResourcePath") + SystemConfig.TOPIC_IMAGE_PATH + "/" + newFileName);
				jsonResult.put("path", path);
                String dirPath = getImageServer() + "/" + path + "/";
                boolean b = CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { dirPath });
                if (b) {
                    jsonResult.put("success", "true");
                    jsonResult.put("message", "CDN 刷新成功");
                } else {
                    jsonResult.put("success", "false");
                    jsonResult.put("message", "CDN刷新失败");
                }
            } catch (IOException e) {
                jsonResult.put("success", "false");
                jsonResult.put("message", "服务端异常，上传失败");
            }
        } else {
            jsonResult.put("success", "false");
            jsonResult.put("message", "文件格式不支持！");
        }
        logger.debug(jsonResult.toString());
        return jsonResult.toString();
    }

    /**
     * 刷新CDN
     * 
     * @Methods Name flushCDN
     * @Create In 2016-3-25 By chengsj
     * @param ip
     * @param port
     * @param flushPath
     * @return String
     */
    @SuppressWarnings("unused")
	private boolean flushCDN(String ip, String method, String[] flushPath) {
        if (flushPath == null || flushPath.equals("") || flushPath.length < 1) {
            return false;
        }
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < flushPath.length; i++) {
            if (i == flushPath.length - 1) {
                buffer.append(flushPath[i]);
            } else {
                buffer.append(flushPath[i]).append(" ");
            }
        }
        JSONObject json = new JSONObject();
        json.put("flushPath", buffer.toString());
        String url = "http://" + ip;
        String result = "";
        try {
            String cdnUrl = url + "/pcm-admin-sdc/common/flushCdn.htm";
            result = HttpUtil.doPost(cdnUrl, json.toString());
        } catch (Exception e) {
            int length = e.getStackTrace().length - 1;
            StringBuffer errorbUffer = new StringBuffer();
            errorbUffer.append("osp请求刷新CND服务  参数   ip:").append(ip).append("  method:").append(method)
                    .append(" flushPath：").append(buffer).append(System.getProperty("line.separator"))
                    .append(e.getStackTrace()[length].getFileName()).append(System.getProperty("line.separator"))
                    .append(e.getStackTrace()[length].getLineNumber()).append(System.getProperty("line.separator"))
                    .append(e.getStackTrace()[length].getMethodName());
            logger.debug(errorbUffer);
            return false;
        }
        return Boolean.getBoolean(result);
    }

    private String getImageServer() {
        if (imgServers.length < 1) {
            return "http://img.wfjimg.com/";
        }
        int length = imgServers.length;
        // 生成0到length-1的随机数
        int random = (int) Math.floor(Math.random() * length);
        return imgServers[random];
    }
    
    /**
     * 
     * @Methods Name getFtp
     * @Create In 2016年3月15日 By haowencaho
     * @param type
     *            1模板 2资源
     * @return Map
     */
    @SuppressWarnings("rawtypes")
    private Map getFtp(String siteId, int type) {
        Map<String, String> resultMap = new HashMap<String, String>();
        String methodName = "getFtp";

        Map<String,Object> parmMap = new HashMap<String,Object>();
        parmMap.put("_site_id_param", siteId);
        String ftpJsonResult = null;
        JSONObject ftpJson = null;
        try {
            ftpJsonResult = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getResourceFtp.do", parmMap);
            logger.debug(className + ":" + methodName + ",获取资源服务器地址返回结果：" + ftpJsonResult);
            ftpJson = JSONObject.fromObject(ftpJsonResult);
            // ftpJson = (JSONObject) JSON.parse(ftpJsonResult);// {"port":21,"username":"test","path":"\/data","password":"123123","ip":"10.6.100.101"}
            resultMap.put("ip", ftpJson.getString("ip"));
            resultMap.put("port", ftpJson.getString("port"));
            resultMap.put("username", ftpJson.getString("username"));
            resultMap.put("password", ftpJson.getString("password"));
            resultMap.put("path", ftpJson.getString("path"));
        } catch (Exception ex) {
            logger.error(className + ":" + methodName + "发生异常：" + ex.getMessage());

        }
        String siteJsonResult = null;
        try {
            siteJsonResult = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/detail/" + siteId + ".do", new HashMap());
            logger.debug(className + ":" + methodName + ",获取资源服务器地址返回结果：" + siteJsonResult);
            JSONObject siteJson = JSONObject.fromObject(siteJsonResult);//
            resultMap.put("siteResourcePath", ftpJson.getString("path") + "/" +  siteJson.getJSONObject("obj").getString("domain"));
        } catch (Exception ex) {
            logger.error(className + ":" + methodName + "发生异常：" + ex.getMessage());
        }
        return resultMap;
    }

	// 添加专题活动楼层
	@ResponseBody
	@RequestMapping(value = "/addFloor", method = { RequestMethod.GET, RequestMethod.POST })
	public String addDirectiveTpl(String title, String styleList, String flag,
			String divtype, String enTitle, String topicId, String floorId, String type,
			String seq,HttpServletRequest request) {
		String methodName = "addDirectiveTpl";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (divtype != null && divtype.equals("0")) {
			type = "0";
		}
		if (type != null && !type.equals("")) {
			resultMap.put("type", type);
		}
		if (floorId != null && !floorId.equals("")) {
			resultMap.put("floorId", floorId);
		}
		if (topicId != null && !topicId.equals("")) {
			resultMap.put("topicId", topicId);
		}
		if (styleList != null && !styleList.equals("")) {
			resultMap.put("styleList", styleList);
		}
		resultMap.put("seq", 1);
		if (title != null && !title.equals("")) {
			resultMap.put("title", title);
		}
		if (enTitle != null && !enTitle.equals("")) {
			resultMap.put("enTitle", enTitle);
		}
		if (flag != null && !flag.equals("")) {
			resultMap.put("flag", flag);
		}
		if (seq != null && !seq.equals("")) {
			resultMap.put("seq", seq);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic_floor/f_save.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 楼层块里添加品牌
	@ResponseBody
	@RequestMapping(value = "/addBrand", method = { RequestMethod.GET, RequestMethod.POST })
	public String addBrand(String ids, String names, String brandLinks, String picts,
			String floorId, HttpServletRequest request) {
		String methodName = "addBrand";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", ids);
		resultMap.put("floorId", floorId);
		resultMap.put("names", names);
		resultMap.put("brandLinks", brandLinks);
		resultMap.put("picts", picts);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic_floor/t_add_brand.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 楼层块里添加链接
	@ResponseBody
	@RequestMapping(value = "/addLink", method = { RequestMethod.GET, RequestMethod.POST })
	public String addLink(String floorId, String mainTitle, String subTitle, String pict,
			String link, String seq, String flag, HttpServletRequest request) {
		String methodName = "addLink";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (floorId != null && floorId != "") {
			resultMap.put("floorId", floorId);
		}
		if (mainTitle != null && mainTitle != "") {
			resultMap.put("mainTitle", mainTitle);
		}
		if (subTitle != null && subTitle != "") {
			resultMap.put("subTitle", subTitle);
		}
		if (link != null && link != "") {
			resultMap.put("link", link);
		}
		if (pict != null && pict != "") {
			resultMap.put("pict", pict);
		}
		if (seq != null && seq != "") {
			resultMap.put("seq", seq);
		}
		if (flag != null && flag != "") {
			resultMap.put("flag", flag);
		}
		try {
			json = HttpUtil
					.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/t_add_link.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 楼层块里删除商品
	@ResponseBody
	@RequestMapping(value = "/delLink", method = { RequestMethod.GET, RequestMethod.POST })
	public String delLink(String sid, HttpServletRequest request) {
		String methodName = "delLink";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("idsStr", sid);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic_floor/f_del_link.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 楼层块里修改链接
	@ResponseBody
	@RequestMapping(value = "/editLink", method = { RequestMethod.GET, RequestMethod.POST })
	public String editLink(String sid, String mainTitle, String subTitle, String pict, String link,
			String seq, String flag, HttpServletRequest request) {
		String methodName = "editLink";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (sid != null && sid != "") {
			resultMap.put("id", sid);
		}
		if (mainTitle != null && mainTitle != "") {
			resultMap.put("mainTitle", mainTitle);
		}
		if (subTitle != null && subTitle != "") {
			resultMap.put("subTitle", subTitle);
		}
		if (link != null && link != "") {
			resultMap.put("link", link);
		}
		if (pict != null && pict != "") {
			resultMap.put("pict", pict);
		}
		if (seq != null && seq != "") {
			resultMap.put("seq", seq);
		}
		if (flag != null && flag != "") {
			resultMap.put("flag", flag);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/t_edit_link.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 楼层块里添加商品
	@ResponseBody
	@RequestMapping(value = "/addProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public String addProduct(String ids, String floorId, String prices, String picts, 
			String brandNames,  String name,HttpServletRequest request) {
		String methodName = "addProduct";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", ids);
		resultMap.put("name", name);
		resultMap.put("prices", prices);
		resultMap.put("picts", picts);
		resultMap.put("floorId", floorId);

		resultMap.put("brandNames", brandNames);
		// resultMap.put("smallpicts", smallpicts);
		// resultMap.put("oldPrices", oldPrices);

		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/t_add_product.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 楼层块里删除商品
	@ResponseBody
	@RequestMapping(value = "/delProduct", method = { RequestMethod.GET, RequestMethod.POST })
	public String delProduct(String sid, String floorId, HttpServletRequest request) {
		String methodName = "delProduct";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("sid", sid);
		resultMap.put("floorId", floorId);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic_floor/f_del_product.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 楼层块里添加商品
	@ResponseBody
	@RequestMapping(value = "/delBrand", method = { RequestMethod.GET, RequestMethod.POST })
	public String delBrand(String sid, String floorId, HttpServletRequest request) {
		String methodName = "delBrand";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("sid", sid);
		resultMap.put("floorId", floorId);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic_floor/f_del_brand.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 查询块下的品牌列表
	@ResponseBody
	@RequestMapping(value = "/brandList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryBrandList(String floorId, HttpServletRequest request) {
		String methodName = "queryBrandList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (floorId != null && floorId != "") {
			resultMap.put("floorId", floorId);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
					"/topic_floor/f_query_brandlist.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 查询块下的链接列表
	@ResponseBody
	@RequestMapping(value = "/linkList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryLinkList(String floorId, HttpServletRequest request) {
		String methodName = "queryLinkList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (floorId != null && floorId != "") {
			resultMap.put("floorId", floorId);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
					"/topic_floor/f_query_linklist.do", resultMap);
			
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		JSONObject result = JSONObject.fromObject(json);
		JSONArray listJson = (JSONArray) result.get("list");
		for(int i=0; i<listJson.size(); i++){
			JSONObject object = (JSONObject) listJson.get(i);
			if(object.containsKey("pict")){
				String pict = object.getString("pict");
				if(StringUtils.isNotEmpty(pict)) {
					object.put("pictPath",  getImageServer() + pict);
				}
			}
		}
		return result.toString();
	}

	// 查询块下的商品列表
	@ResponseBody
	@RequestMapping(value = "/productList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryProductList(String floorId, HttpServletRequest request) {
		String methodName = "queryProductList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (floorId != null && floorId != "") {
			resultMap.put("floorId", floorId);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
					"/topic_floor/f_query_prolist.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 修改楼层/块
	@ResponseBody
	@RequestMapping(value = "/editFloor", method = { RequestMethod.GET, RequestMethod.POST })
	public String editdiv(String id, String title, String type, String flag,
			String enTitle, String styleList,String seq, HttpServletRequest request) {
		String methodName = "editdiv";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (id != null && id != "") {
			resultMap.put("id", id);
		}
		if (title != null && title != "") {
			resultMap.put("title", title);
		}
		if (enTitle != null && !enTitle.equals("")) {
			resultMap.put("enTitle", enTitle);
		}
		if (styleList != null && styleList != "") {
			resultMap.put("styleList", styleList);
		}
		if(seq != null && !seq.equals("")){
			resultMap.put("seq", seq);
		}
		if (type != null && type != "") {
			resultMap.put("type", type);
		}
		if (flag != null && flag != "") {
			resultMap.put("flag", flag);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic_floor/f_edit_floor.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 删除楼层/块
	@ResponseBody
	@RequestMapping(value = "/delDiv", method = { RequestMethod.GET, RequestMethod.POST })
	public String delDiv(String floorId, HttpServletRequest request) {
		String methodName = "delDiv";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("floorId", floorId);

		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic_floor/f_del.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 查询楼层下的块列表
	@ResponseBody
	@RequestMapping(value = "/queryDivList", method = { RequestMethod.GET, RequestMethod.POST })
	public String findDivList(String floorId, String topicId, HttpServletRequest request) {
		String methodName = "findDivList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("topicId", topicId);
		resultMap.put("floorId", floorId);

		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic_floor/f_div_list.do",
					resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

}
