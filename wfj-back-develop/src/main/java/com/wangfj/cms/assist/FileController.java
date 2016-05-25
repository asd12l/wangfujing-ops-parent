package com.wangfj.cms.assist;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.cms.utils.CdnHelper;
import com.wangfj.cms.utils.RemoteFtpProcess;

import common.Logger;

/**
 * 基于站点的文件处理器 图片、文件等
 * 
 * @Class Name FileController
 * @Author haowenchao
 * @Create In 2016年3月15日
 */

@Controller
@RequestMapping(value = "cms/file")
public class FileController {
	private Logger logger = Logger.getLogger(FileController.class);
	private String className = FileController.class.getName();

	private static String[] imgServers;

	static {
		imgServers = SystemConfig.CMS_IMAGE_SERVERS.split("###");
	}

	/**
	 * 
	 * @Methods Name uploadImg
	 * @Create In 2016年3月15日 By haowenchao
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadImg-noMulti", method = { RequestMethod.POST })
	public String uploadImg(HttpServletRequest request, HttpServletResponse response) {

		JSONObject jsonResult = new JSONObject();
		String methodName = "uploadImg";
		String siteId = request.getParameter("siteId");
		String sizeNo = request.getParameter("sizeNo");
		// 根据站点获取站点资源服务器地址
		Map<String, String> ftpMap = null;
		// 定义输出流对象
		OutputStream outPutStream = null;
		// 创建基于文件项目的工厂对象
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		diskFileItemFactory.setSizeThreshold(1024);
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
		// 解析上传的请求 或许request中的请求的参数放入list
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
					sizeNo = item.getString();
					ftpMap = this.getFtp(siteId, 2);
				}
				if (item.getFieldName() != null && item.getFieldName().equalsIgnoreCase("sizeNo")) {
					sizeNo = item.getString();
				}
			}
		}
		if (sizeNo != null && !sizeNo.equals("")) {
			BufferedImage sourceImg;
			try {
				sourceImg = ImageIO.read(fileItme.getInputStream());
				// System.out.println(String.format("%.1f",fileItme.getSize()/1024.0));
				String[] sizeNos = sizeNo.split("_");
				if (sourceImg.getWidth() != Integer.valueOf(sizeNos[0])) {
					jsonResult.put("success", "false");
					jsonResult.put("message", "尺寸错误,请重新上传正确尺寸！");
					logger.debug(jsonResult.toString());
					return jsonResult.toString();
				}
				if (sourceImg.getHeight() != Integer.valueOf(sizeNos[1])) {
					jsonResult.put("success", "false");
					jsonResult.put("message", "尺寸错误,请重新上传正确尺寸！");
					logger.debug(jsonResult.toString());
					return jsonResult.toString();
				}
			} catch (IOException e1) {
				logger.debug(e1.getMessage());
				e1.printStackTrace();
			}
		}

		fileName = fileItme.getName();
		int pointIndex = fileName.lastIndexOf(".");
		String suffix = fileName.substring(pointIndex);
		if (".jpg".equalsIgnoreCase(suffix) || ".gif".equalsIgnoreCase(suffix)
				|| ".png".equalsIgnoreCase(suffix)) {
			RemoteFtpProcess ftpProcess = new RemoteFtpProcess();
			ftpProcess.loginFtp(ftpMap.get("ip"), Integer.valueOf(ftpMap.get("port")),
					ftpMap.get("username"), ftpMap.get("password"));
			String path = ftpMap.get("siteResourcePath") + "/" + SystemConfig.ADVERTISE_IMAGE_PATH;
			try {
				String newFileName = UUID.randomUUID() + suffix;
				ftpProcess.uploadFileToFtp(newFileName, fileItme.getInputStream(), path);
				String url = getImageServer() + "/" + path + "/" + newFileName;
				jsonResult.put("success", "true");
				jsonResult.put("url", url);
				jsonResult.put("path", path + "/" + newFileName);
				String dirPath = getImageServer() + "/" + path + "/";
				if(SystemConfig.ISCDNENABLE){
					boolean b = CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { dirPath });
					if (b) {
						jsonResult.put("success", "true");
						jsonResult.put("message", "CDN 刷新成功");
					} else {
						jsonResult.put("success", "false");
						jsonResult.put("message", "CDN刷新失败");
					}
				}
			} catch (IOException e) {
				jsonResult.put("success", "false");
				jsonResult.put("message", "服务端异常，上传失败");
			} finally {
				try {
					ftpProcess.closeConnections();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
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
			errorbUffer.append("osp请求刷新CND服务  参数   ip:").append(ip).append("  method:")
					.append(method).append(" flushPath：").append(buffer)
					.append(System.getProperty("line.separator"))
					.append(e.getStackTrace()[length].getFileName())
					.append(System.getProperty("line.separator"))
					.append(e.getStackTrace()[length].getLineNumber())
					.append(System.getProperty("line.separator"))
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

	@ResponseBody
	@RequestMapping(value = "/getImageServer")
	public String getImageServerList() {
		JSONObject jsonResult = new JSONObject();
		jsonResult.put("success", true);
		jsonResult.put("imgServer", getImageServer());
		return jsonResult.toJSONString();
	}

	/**
	 * 
	 * @Methods Name uploadFlash
	 * @Create In 2016年3月15日 By haowenchao
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadFlash-noMulti", method = { RequestMethod.POST })
	public String uploadFlash(HttpServletRequest request, HttpServletResponse response) {

		JSONObject jsonResult = new JSONObject();
		String methodName = "uploadFlash";
		String siteId = request.getParameter("siteId");
		// 根据站点获取站点资源服务器地址
		Map<String, String> ftpMap = null;
		// 定义输出流对象
		OutputStream outPutStream = null;
		// 创建基于文件项目的工厂对象
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		diskFileItemFactory.setSizeThreshold(1024);
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
		// 解析上传的请求 或许request中的请求的参数放入list
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
		if (".flv".equalsIgnoreCase(suffix)) {
			RemoteFtpProcess ftpProcess = new RemoteFtpProcess();
			ftpProcess.loginFtp(ftpMap.get("ip"), Integer.valueOf(ftpMap.get("port")),
					ftpMap.get("username"), ftpMap.get("password"));
			String path = ftpMap.get("siteResourcePath") + "/" + SystemConfig.ADVERTISE_FLASH_PATH;
			try {
				String newFileName = UUID.randomUUID() + suffix;
				ftpProcess.uploadFileToFtp(newFileName, fileItme.getInputStream(), path);
				String url = getImageServer() + "/" + path + "/" + newFileName;
				jsonResult.put("success", "true");
				jsonResult.put("url", url);
				jsonResult.put("path", path + "/" + newFileName);
				String dirPath = getImageServer() + "/" + path + "/";
				if(SystemConfig.ISCDNENABLE){
					boolean b = CdnHelper.flushCdn(SystemConfig.CDN_URL, new String[] { dirPath });
					if (b) {
						jsonResult.put("success", "true");
						jsonResult.put("message", "CDN 刷新成功");
					} else {
						jsonResult.put("success", "false");
						jsonResult.put("message", "CDN刷新失败");
					}
				}
			} catch (IOException e) {
				jsonResult.put("success", "false");
				jsonResult.put("message", "服务端异常，上传失败");
			} finally {
				try {
					ftpProcess.closeConnections();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} else {
			jsonResult.put("success", "false");
			jsonResult.put("message", "文件格式不支持！");
		}
		logger.debug(jsonResult.toString());
		return jsonResult.toString();
	}

	/**
	 * 
	 * @Methods Name getFtp
	 * @Create In 2016年3月15日 By haowencaho
	 * @param type
	 *            1模板 2资源
	 * @return Map
	 */
	private Map getFtp(String siteId, int type) {
		Map<String, String> resultMap = new HashMap();
		String methodName = "getFtp";

		Map parmMap = new HashMap();
		parmMap.put("_site_id_param", siteId);
		String ftpJsonResult = null;
		JSONObject ftpJson = null;
		try {
			ftpJsonResult = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
					"/site/getResourceFtp.do", parmMap);
			logger.debug(className + ":" + methodName + ",获取资源服务器地址返回结果：" + ftpJsonResult);
			ftpJson = (JSONObject) JSON.parse(ftpJsonResult);// {"port":21,"username":"test","path":"\/data","password":"123123","ip":"10.6.100.101"}
			resultMap.put("ip", ftpJson.getString("ip"));
			resultMap.put("port", ftpJson.getString("port"));
			resultMap.put("username", ftpJson.getString("username"));
			resultMap.put("password", ftpJson.getString("password"));
			resultMap.put("path", ftpJson.getString("path"));
		} catch (Exception ex) {
			logger.info(className + ":" + methodName + "发生异常：" + ex.getMessage());

		}
		String siteJsonResult = null;
		try {
			siteJsonResult = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/detail/"
					+ siteId + ".do", new HashMap());
			logger.debug(className + ":" + methodName + ",获取资源服务器地址返回结果：" + siteJsonResult);
			JSONObject siteJson = (JSONObject) JSON.parse(siteJsonResult);//
			resultMap.put("siteResourcePath", ftpJson.getString("path") + "/"
					+ siteJson.getJSONObject("obj").getString("domain"));
		} catch (Exception ex) {
			logger.info(className + ":" + methodName + "发生异常：" + ex.getMessage());
		}
		return resultMap;
	}

}
