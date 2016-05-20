package com.wangfj.cms.floor;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.constants.SystemConfig;
import com.wangfj.cms.utils.CdnHelper;
import com.wangfj.cms.utils.FileUtil;
import com.wangfj.cms.utils.FtpUtil;
import com.wangfj.order.utils.HttpUtil;

import common.Logger;

@RequestMapping(value = "/stylelist")
@Controller
public class StylelistController {
	private Logger logger = Logger.getLogger(StylelistController.class);

	private String className = StylelistController.class.getName();

	private static String[] imgServers;

	static {
		imgServers = SystemConfig.CMS_IMAGE_SERVERS.split("###");
	}

	/**
	 * 查询楼层样式列表
	 * 
	 * @Methods Name queryStylelist
	 * @Create In 2015年11月9日 By chengsj
	 * @param request
	 * 
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryStyleList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryStylelist(String type, String _site_id_param, HttpServletRequest request) {
		String methodName = "queryStylelist";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("siteId", request.getParameter("_site_id_param"));
		if (type != null) {
			resultMap.put("type", type);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/style/list.do", resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		JSONObject  resultJson = new JSONObject().fromObject(json);
		resultJson.put("siteResultUrl", getImageServer()+"/");
		return resultJson.toString();
	}

	/**
	 * 查询FTP上楼层样式所在的路径
	 * 
	 * @Methods Name queryStylelistPath
	 * @Create In 2016-4-5 By chengsj
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryStyleListPath", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryStylelistPath(HttpServletRequest request) {
		JSONObject messageJson = new JSONObject();
		String methodName = "queryStylelistPath";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("siteId", request.getParameter("siteId"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/style/ftp_style_list_path.do",
					resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
			messageJson.put("success", "false");
			messageJson.put("message", "查询FTP路径失败，网络异常");
			return messageJson.toString();
		}
		if (!StringUtils.isNotBlank(json)) {
			messageJson.put("success", "false");
			messageJson.put("message", "查询FTP路径失败，网络异常");
			return messageJson.toString();
		}
		return json;
	}

	/**
	 * 楼层样式图片上传
	 * 
	 * @Methods Name uploadImg
	 * @Create In 2015年12月2日 By hongfei
	 * @param request
	 * @param response
	 * @return String
	 * @throws FileUploadException
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadImg-noMulti", method = { RequestMethod.POST, RequestMethod.GET })
	public String uploadImg(HttpServletRequest request, HttpServletResponse response)
			throws FileUploadException {
		String methodName = "uploadImg";
		JSONObject json = new JSONObject();
		String name = "";
		String fileName = "";
		String uploadName = "";
		String ip = "";
		String username = "";
		String password = "";
		String port = "";
		String path = "";
		String siteName = "";
		FileItem item1 = null;
		// 获取编码
		String encoding = request.getCharacterEncoding();
		// 定义输出流对象
		OutputStream outPutStream = null;
		// 创建基于文件项目的工厂对象
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		diskFileItemFactory.setSizeThreshold(1024);
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
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
							uploadName = fileName + i + "." + name.substring(name.lastIndexOf(".")+1);
							item1 = item;
						} else {
							json.put("success", "false");
							json.put("data", "只能上传jpg、gif、png类型的图片！");
							return json.toString();
						}
					} else {
						json.put("success", "false");
						json.put("data", "只能上传jpg、gif、png类型的图片！");
						return json.toString();
					}
				} else {
					if ("ip".equals(item.getFieldName())) {
						ip = item.getString(encoding);
					}
					if ("username".equals(item.getFieldName())) {
						username = item.getString(encoding);
					}
					if ("password".equals(item.getFieldName())) {
						password = item.getString(encoding);
					}
					if ("port".equals(item.getFieldName())) {
						port = item.getString(encoding);
					}
					if ("path".equals(item.getFieldName())) {
						path = item.getString(encoding);
					}
					if ("siteName".equals(item.getFieldName())) {
						siteName = item.getString(encoding);
					}
				}
			}
			// 上传图片到ftp服务器并向数据库插入图片属性
			FtpUtil f = new FtpUtil();
			f.saveStylelistImgToFtp(outPutStream, uploadName, item1, ip, username, password,
					port, path, siteName);

			String cdnUrl = SystemConfig.CDN_URL;
			String flushPath = getImageServer() + path + "/" + siteName
					+ SystemConfig.STYLELIST_IMAGE_PATH;
			logger.debug("======== starting flush cdn,cdn url :" + cdnUrl + "flushPath:"
					+ flushPath);
			CdnHelper.flushCdn(cdnUrl, new String[] { flushPath });
/*			String imgServer = getImageServer() + path + "/" + siteName;
			String url = imgServer + SystemConfig.STYLELIST_IMAGE_PATH + "/" + uploadName;*/
			String siteResourcePath = getImageServer()+"/";
			json.put("success", "true");
			json.put("url", siteResourcePath);
			json.put("data", uploadName);
			json.put("path", path + "/" + siteName + SystemConfig.STYLELIST_IMAGE_PATH + "/" + uploadName);

		} catch (Exception e) {
			json.put("success", "false");
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json.toString();
	}

	/**
	 * 楼层样式上传
	 * 
	 * @Methods Name uploadZipFile
	 * @Create In 2016-4-5 By chengsj
	 * @param file
	 * @param desc
	 * @param type
	 * @param attr_image_name
	 * @param attr_image_url
	 * @param ip
	 * @param username
	 * @param password
	 * @param siteId
	 * @param localPath
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/upload", method = { RequestMethod.POST })
	public String uploadZipFile(@RequestParam(value = "file", required = true) MultipartFile file,
			String desc, Integer type, String attr_image_name, String attr_image_url, String ip,
			String username, String password, String siteId, String localPath,
			HttpServletRequest request, HttpServletResponse response) {
		String contextPath = request.getSession().getServletContext().getRealPath("/") + "upload/";
		String name = file.getOriginalFilename();
		JSONObject messageJson = new JSONObject();
/*		if (null == type || !StringUtils.isNotBlank(attr_image_name)
				|| !StringUtils.isNotBlank(attr_image_url) || !StringUtils.isNotBlank(ip)
				|| !StringUtils.isNotBlank(username) || !StringUtils.isNotBlank(password)
				|| !StringUtils.isNotBlank(siteId) || !StringUtils.isNotBlank(localPath)) {
			messageJson.put("success", "false");
			messageJson.put("message", "参数缺失");
			return messageJson.toString();
		}*/

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("name", name);
		paramMap.put("desc", desc);
		paramMap.put("username", "admin");
		paramMap.put("siteId", siteId);
		paramMap.put("type", type); 
		paramMap.put("imgName", attr_image_name);
		
		paramMap.put("imgDir", SystemConfig.STYLELIST_IMAGE_PATH);  //+(name.substring(name.lastIndexOf(".")+1))
		File targetFile = new File(contextPath, name);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
			try {
				file.transferTo(targetFile);
			} catch (Exception e) {
				logger.info(className + ": " + e.getMessage());
				messageJson.put("success", "false");
				messageJson.put("message", "上传文件失败，内部方法异常， 请联系管理员");
				return messageJson.toString();
			}
			FtpUtil ftpUtil = new FtpUtil();
			boolean flag = ftpUtil.uploadFileToFtp(contextPath, localPath, ip, username, password);
			if (flag) {
				logger.info("上传成功,上传至FTP" + contextPath);
			}
			FileUtil fileUtl = new FileUtil();
			fileUtl.deleteDir(targetFile);
		} else {
			targetFile.delete();

			try {
				file.transferTo(targetFile);
			} catch (IOException e) {
				logger.info(className + ": " + e.getMessage());
				messageJson.put("success", "false");
				messageJson.put("message", "上传文件失败，内部方法异常， 请联系管理员");
				return messageJson.toString();
			}
		}
		try {
			HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/style/save.do", paramMap);
		} catch (Exception e) {
			logger.info(className + ": " + e.getMessage());
		}
		messageJson.put("success", "true");
		messageJson.put("message", "上传成功");
		return messageJson.toString();
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
}
