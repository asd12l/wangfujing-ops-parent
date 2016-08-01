package com.wangfj.cms.floor;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.wangfj.cms.utils.FileUtil;
import com.wangfj.cms.utils.FtpUtil;
import com.wangfj.cms.utils.RemoteFtpProcess;
import com.wangfj.cms.utils.ZipUtil;
import com.wangfj.cms.view.WebServerDTO;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.ResultUtil;

import common.Logger;
import net.sf.json.JSONObject;

@RequestMapping(value = "/template")
@Controller
public class TemplateController {
	private Logger logger = Logger.getLogger(TemplateController.class);

	private String className = TemplateController.class.getName();

	// 模板目录树(读本FTP)
	@ResponseBody
	@RequestMapping(value = "/getTemplateTree", method = { RequestMethod.GET, RequestMethod.POST })
	public String getAllResources(HttpServletRequest request) {
		String methodName = "getAllResources";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("siteId", request.getParameter("_site_id_param"));
		String json = "";
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/v_tree.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 目录列表
	 * 
	 * @Methods Name queryPageLayout
	 * @Create In 2016年4月7日 By wangsy
	 * @param _site_id_param
	 * @param path
	 * @param request
	 * @param channelNo
	 *            区分是频道还是资源使用
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryDirList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryPageLayout(String _site_id_param, String path, HttpServletRequest request,
			String channelNo, String suffix) {
		String methodName = "queryPageLayout";
		String json = "";
		if (path == null) {
			path = "";
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (null != _site_id_param && !"".equals(_site_id_param)) {
			resultMap.put("_site_id_param", _site_id_param);
		}
		if (null != channelNo && !"".equals(channelNo)) {
			resultMap.put("channelNo", channelNo);
		}
		if (StringUtils.isNotBlank(suffix)) {
			resultMap.put("filterSuffix", suffix);
		}
		resultMap.put("path", path);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/ftp_file_list.do",
					resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	/**
	 * 模板图片上传
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
		String siteId = "";
		String name = "";
		String fileName = "";
		String uploadName = "";
		String ip = "";
		String username = "";
		String password = "";
		String port = "";
		String imgPath = "";
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
							uploadName = name;
							logger.info("uploadName=" + uploadName);
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
					if ("imgPath".equals(item.getFieldName())) {
						imgPath = item.getString(encoding);
					}
					if ("siteId".equals(item.getFieldName())) {
						siteId = item.getString(encoding);
					}
				}
			}

			// 获取站点资源ftp信息
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("_site_id_param", siteId);
			String ftpJson = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
					"/site/getResourceFtp.do", resultMap);
			if (StringUtils.isEmpty(ftpJson)) {
				json.put("success", "false");
				json.put("msg", "系统异常，请稍后再试");
				return json.toString();
			}
			JSONObject ftp = JSONObject.fromObject(ftpJson);
			ip = ftp.getString("ip");
			username = ftp.getString("username");
			password = ftp.getString("password");
			port = ftp.getString("port");

			// 上传图片到ftp服务器并向数据库插入图片属性
			FtpUtil.saveTemplateImgToFtp(outPutStream, uploadName, item1, ip, username, password,
					port, imgPath);
			String url = "ftp://" + username + ":" + password + "@" + ip + imgPath + "/"
					+ uploadName;
			json.put("success", "true");
			json.put("url", url);
			json.put("data", uploadName);
			logger.info("imgPath=" + imgPath);

			// 上传成功刷新cdn
			Map map = new HashMap();
			map.put("siteId", siteId);
			String result = HttpUtil
					.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/flushCDN.do", map);
			logger.info("上传资源目录刷新CDN调用cms_admin， /site/getResFtpSitePath.do 传参  siteId:" + siteId
					+ " 接口返回" + result);

		} catch (Exception e) {
			json.put("success", "false");
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json.toString();
	}

	// 上传文件
	@ResponseBody
	@RequestMapping(value = "/uploadfile", method = { RequestMethod.POST })
	public String uploadFile(@RequestParam(value = "file", required = true) MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) {
		String methodName = "uploadFile";
		JSONObject obj = new JSONObject();
		String siteId = request.getParameter("siteId");
		String dPath = request.getParameter("dPath");

		if (StringUtils.isEmpty(siteId)) {
			obj.put("success", false);
			obj.put("msg", "请选择站点");
			return obj.toString();
		}

		if (StringUtils.isEmpty(dPath)) {
			obj.put("success", false);
			obj.put("msg", "请选择目录进行文件上传");
			return obj.toString();
		}

		// 根据站点id获取模板ftp信息
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("_site_id_param", siteId);
		String ftpInfo = "";
		try {
			ftpInfo = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getTplFtp.do", param);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage() + "获取ftp信息失败");
		}
		if (StringUtils.isEmpty(ftpInfo)) {
			obj.put("success", false);
			obj.put("msg", "系统异常请稍后再试");
			return obj.toString();
		}

		// 返回数据异常
		JSONObject ftp = JSONObject.fromObject(ftpInfo);
		if ("false".equals(ftp.get("success"))) {
			obj.put("success", false);
			obj.put("msg", "系统异常请稍后再试");
			return obj.toString();
		}

		String ip = ftp.getString("ip");
		String username = ftp.getString("username");
		String password = ftp.getString("password");
		String port = ftp.getString("port");
		String ftpPath = dPath;

		// 将上传文件保存到upload下面
		String srcpath = request.getSession().getServletContext().getRealPath("/") + "upload/";
		String fileName = file.getOriginalFilename();
		File targetFile = new File(srcpath, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
			try {
				// 1.将文件上传到tomcat下面
				file.transferTo(targetFile);

				// 2.将tomcat下面的文件上传到ftp
				RemoteFtpProcess ftpProcess = new RemoteFtpProcess();
				ftpProcess.loginFtp(ip, Integer.valueOf(port), username, password);

				boolean flag = ftpProcess.uploadFileToFtp(targetFile.getName(),
						new FileInputStream(targetFile), dPath);
				ftpProcess.closeConnections();

				// 上传完成删除对应的文件
				FileUtil fileUtl = new FileUtil();
				fileUtl.deleteDir(targetFile);

				// 上传失败
				if (!flag) {
					obj.put("success", false);
					obj.put("msg", "系统异常请稍后再试");
					logger.error("上传模板到ftp服务器失败！");
					return obj.toString();
				}

				// 上传成功后，分发到各个动态server
				String json = "";
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put("siteId", siteId);
				resultMap.put("path", ftpPath);
				resultMap.put("fileName", fileName);
				json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/t_into.do",
						resultMap);
				if (StringUtils.isEmpty(json)) {
					obj.put("success", false);
					obj.put("msg", "上传成功，分发失败，请联系管理员！");
					return obj.toString();
				}
				JSONObject dispatchJson = JSONObject.fromObject(json);
				String info = dispatchJson.getString("success");
				if ("false".equals(info)) {
					logger.error("分发失败");
					obj.put("success", false);
					obj.put("msg", "分发失败，请稍后再试");
					return obj.toString();
				}
				obj.put("success", true);
			} catch (Exception e) {
				e.printStackTrace();
				logger.error(e.getMessage());
				obj.put("success", false);
				obj.put("msg", "系统异常，请稍后再试");
			}
		} else {
			logger.error("上传文件失败！");
			obj.put("success", false);
			obj.put("msg", "系统异常，请稍后再试");
		}
		return obj.toString();
	}

	/**
	 * 
	 * @Methods Name uploadZipFile 上传zip
	 * @Create In 2015年11月12日 By chengxp
	 * @param file
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadZip", method = { RequestMethod.POST })
	public String uploadZipFile(@RequestParam(value = "file", required = true) MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) {
		String methodName = "uploadZipFile";
		JSONObject obj = new JSONObject();
		String siteId = request.getParameter("siteId");

		if (StringUtils.isEmpty(siteId)) {
			obj.put("success", false);
			obj.put("msg", "请选择站点");
			return obj.toString();
		}

		// 根据站点id获取模板ftp信息
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("_site_id_param", siteId);
		String ftpInfo = "";
		try {
			ftpInfo = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getTplFtp.do", param);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage() + "获取ftp信息失败");
		}

		if (StringUtils.isEmpty(ftpInfo)) {
			obj.put("success", false);
			obj.put("msg", "系统异常请稍后再试");
			return obj.toString();
		}

		// 返回数据异常
		JSONObject ftp = JSONObject.fromObject(ftpInfo);
		if ("false".equals(ftp.get("success"))) {
			obj.put("success", false);
			obj.put("msg", "系统异常请稍后再试");
			return obj.toString();
		}
		String siteName = "";
		try {
			siteName = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getTplFtp.do", param);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage() + "获取站点域名信息失败");
		}
		if (StringUtils.isEmpty(siteName)) {
			obj.put("success", false);
			obj.put("msg", "系统异常请稍后再试");
			return obj.toString();
		}
		String ip = ftp.getString("ip");
		String username = ftp.getString("username");
		String password = ftp.getString("password");
		String port = ftp.getString("port");
		String dPath = ftp.getString("path");

		// 上传到tomcat文件存放路径
		String srcpath = request.getSession().getServletContext().getRealPath("/") + "upload/";
		String fileName = file.getOriginalFilename();
		File targetFile = new File(srcpath, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
			try {
				// 1.上传只tomcat
				file.transferTo(targetFile);

				// 2.解压
				String unzipDirPath = srcpath + "/"
						+ fileName.substring(0, fileName.lastIndexOf(".")) + "/";
				ZipUtil.unzip(targetFile.getPath(), unzipDirPath);
				targetFile.delete();

				// 3.上传
				RemoteFtpProcess ftpProcess = new RemoteFtpProcess();
				ftpProcess.loginFtp(ip, Integer.valueOf(port), username, password);
				String[] suffix = new String[] { ".png", ".jpg", ".css", ".js" };
				ftpProcess.uploadDirFiles(unzipDirPath, dPath, suffix);
				ftpProcess.closeConnections();

				// 4上传完，删除文件
				File temp = new File(srcpath);
				FileUtil fileUtl = new FileUtil();
				fileUtl.deleteDir(temp);

				// 5上传陈功刷新cdn
				Map map = new HashMap();
				map.put("siteId", siteId);
				String result = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/flushCDN.do",
						map);
				logger.info("上传资源目录刷新CDN调用cms_admin， /site/getResFtpSitePath.do 传参  siteId:"
						+ siteId + " 接口返回" + result);

				// 删除目录缓存
				HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/ftp/oSiteIdRemove.do", map);

				obj.put("success", true);
			} catch (Exception e) {
				logger.error(className + ":" + methodName + " " + e.getMessage() + "上传失败");
				obj.put("success", false);
				obj.put("msg", "系统异常，请联系管理员");
			}

		} else {
			obj.put("success", false);
			obj.put("msg", "系统异常，请联系管理员");
		}
		return obj.toString();
	}

	/**
	 * 预览楼层样式图片
	 * 
	 * @Methods Name viewStyleListPicture
	 * @Create In 2015年11月5日 By hongfei
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/previewImg", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewStyleListPicture(HttpServletRequest request, String _site_id_param,
			String name) {
		String methodName = "viewStyleListPicture";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("name", name);
		resultMap.put("_site_id_param", _site_id_param);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/stylelist/viewStyleList.do",
					resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/showTplView", method = { RequestMethod.GET, RequestMethod.POST })
	public String viewTplPicture(String path, String tplName, String _site_id_param,
			HttpServletRequest request) {
		String methodName = "viewTplPicture";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("path", path);
		resultMap.put("tplName", tplName);
		resultMap.put("_site_id_param", _site_id_param);
		try {
			json = HttpUtil
					.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/viewTpl.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	// 创建目录
	@ResponseBody
	@RequestMapping(value = "/createFile", method = { RequestMethod.GET, RequestMethod.POST })
	public String createTemplate(HttpServletRequest request) {
		String methodName = "createTemplate";
		String json = "";
		String path = request.getParameter("path");
		String source = request.getParameter("source");
		String fileName = request.getParameter("fileName");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("path", path);
		resultMap.put("source", source);
		resultMap.put("fileName", fileName);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/o_save.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	// 修改文件名
	@ResponseBody
	@RequestMapping(value = "/modifyFileName", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyFileName(HttpServletRequest request) {
		String methodName = "modifyFileName";
		String json = "";
		String path = request.getParameter("path");
		String oldName = request.getParameter("oldName");
		String newName = request.getParameter("newName");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("path", path);
		resultMap.put("oldName", oldName);
		resultMap.put("newName", newName);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/o_rename.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	// 批量删除文件
	@ResponseBody
	@RequestMapping(value = "/delFiles", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteFile(HttpServletRequest request) {
		String methodName = "deleteFile";
		String json = "";
		String path = request.getParameter("path");
		String name = request.getParameter("name");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("path", path);
		resultMap.put("name", name);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/delFiles.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	// 删除文件
	@ResponseBody
	@RequestMapping(value = "/delFile", method = { RequestMethod.GET, RequestMethod.POST })
	public String delFile(HttpServletRequest request) {
		String methodName = "delFile";
		String json = "";
		String path = request.getParameter("path");
		String name = request.getParameter("name");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("path", path);
		resultMap.put("name", name);
		try {
			json = HttpUtil
					.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/delFile.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}

		return json;
	}

	// 创建目录
	@ResponseBody
	@RequestMapping(value = "/createdir", method = { RequestMethod.POST })
	public String createDir(HttpServletRequest request) {
		String methodName = "createDir";
		String json = "";
		String dirName = request.getParameter("dirName");
		String path = request.getParameter("path");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("dirName", dirName);
		resultMap.put("path", path);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/o_create_dir.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	public static List getWebServers(String siteId) {
		List<WebServerDTO> list = new ArrayList<WebServerDTO>();
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("siteId", siteId);
		json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/s_list.do", resultMap);
		JSONObject jsona = JSONObject.fromObject(json);
		list = jsona.getJSONArray("list");
		return list;
	}

}
