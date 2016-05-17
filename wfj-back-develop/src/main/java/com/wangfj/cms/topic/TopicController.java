package com.wangfj.cms.topic;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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

import com.constants.SystemConfig;
import com.wangfj.cms.utils.CdnHelper;
import com.wangfj.cms.utils.RemoteFtpProcess;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.ResultUtil;

import common.Logger;
import net.sf.json.JSONObject;

@RequestMapping(value = "/topic")
@Controller
public class TopicController {
	private Logger logger = Logger.getLogger(TopicController.class);

	private static String[] imgServers;

	static {
		imgServers = SystemConfig.CMS_IMAGE_SERVERS.split("###");
	}

	private String className = TopicController.class.getName();

	// 查询专题活动下楼层树
	@ResponseBody
	@RequestMapping(value = "/getTopicFloorTree", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryTopicFloorTreeList(HttpServletRequest request) {
		String methodName = "queryTopicFloorTreeList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String topicId = request.getParameter("topicId");
		resultMap.put("topicId", topicId);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/t_floor_tree.do",
					resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 查询专题活动列表(分页查询)
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/getTopicList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryDirectiveList(Integer _site_id_param, HttpServletRequest request) {
		String methodName = "queryDirectiveList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		resultMap.put("pageSize", size);// 每页显示数量
		resultMap.put("currPage", currPage);
		resultMap.put("_site_id_param", _site_id_param);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/v_list.do", resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		if (json.equals("") || json == null) {
			JSONObject obj = new JSONObject();
			obj.put("success", false);
			return obj.toString();
		} else {
			Map<String, String> ftpMap = this.getFtp(String.valueOf(_site_id_param), 2);
			JSONObject j = JSONObject.fromObject(json);
			j.put("cmsImageServer", getImageServer() + ftpMap.get("siteResourcePath"));
			return j.toString();
		}
	}

	/**
	 * 
	 * @Methods Name uploadImg
	 * @Create In 2016年4月6日 By chengsj
	 * @param request
	 * @param response
	 * @return
	 * @throws FileUploadException
	 *             String
	 */
	@SuppressWarnings({ "unused", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "/uploadImg-noMulti", method = { RequestMethod.POST })
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
		if (".jpg".equalsIgnoreCase(suffix) || ".gif".equalsIgnoreCase(suffix)
				|| ".png".equalsIgnoreCase(suffix)) {
			RemoteFtpProcess ftpProcess = new RemoteFtpProcess();
			ftpProcess.loginFtp(ftpMap.get("ip"), Integer.valueOf(ftpMap.get("port")),
					ftpMap.get("username"), ftpMap.get("password"));
			String path = ftpMap.get("siteResourcePath") + SystemConfig.TOPIC_IMAGE_PATH;
			try {
				String newFileName = UUID.randomUUID() + suffix;
				ftpProcess.uploadFileToFtp(newFileName, fileItme.getInputStream(), path);
				String url = getImageServer() + "/" + path + "/" + newFileName;
				jsonResult.put("success", "true");
				jsonResult.put("url", url);
				jsonResult.put("data", (path + "/" + newFileName));
				jsonResult.put("path", path);
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

		Map<String, Object> parmMap = new HashMap<String, Object>();
		parmMap.put("_site_id_param", siteId);
		String ftpJsonResult = null;
		JSONObject ftpJson = null;
		try {
			ftpJsonResult = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
					"/site/getResourceFtp.do", parmMap);
			logger.debug(className + ":" + methodName + ",获取资源服务器地址返回结果：" + ftpJsonResult);
			ftpJson = JSONObject.fromObject(ftpJsonResult);
			// ftpJson = (JSONObject) JSON.parse(ftpJsonResult);//
			// {"port":21,"username":"test","path":"\/data","password":"123123","ip":"10.6.100.101"}
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
			JSONObject siteJson = JSONObject.fromObject(siteJsonResult);//
			resultMap.put("siteResourcePath", ftpJson.getString("path") + "/"
					+ siteJson.getJSONObject("obj").getString("domain"));
		} catch (Exception ex) {
			logger.info(className + ":" + methodName + "发生异常：" + ex.getMessage());
		}
		return resultMap;
	}

	// 修改专题活动
	@ResponseBody
	@RequestMapping(value = "/modifyTopic", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyDirectiveTpl(HttpServletRequest request) {
		String methodName = "modifyDirectiveTpl";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", request.getParameter("id"));
		resultMap.put("name", request.getParameter("name"));
		resultMap.put("keyWords", request.getParameter("keyWords"));
		resultMap.put("priority", request.getParameter("priority"));
		resultMap.put("shortName", request.getParameter("shortName"));
		resultMap.put("description", request.getParameter("description"));
		resultMap.put("path", request.getParameter("path"));
		resultMap.put("titleImg", request.getParameter("titleImg"));
		resultMap.put("tplContent", request.getParameter("tplContent"));
		resultMap.put("startTime", request.getParameter("startTime"));
		resultMap.put("endTime", request.getParameter("endTime"));
		resultMap.put("recommend", request.getParameter("recommend"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/o_update.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 添加活动时 获取从ftp获取模板列表
	@ResponseBody
	@RequestMapping(value = "/getTpl", method = { RequestMethod.GET, RequestMethod.POST })
	public String getTpl() {
		String methodName = "getTpl";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/v_add.do", resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 添加专题活动
	@ResponseBody
	@RequestMapping(value = "/addTopic", method = { RequestMethod.GET, RequestMethod.POST })
	public String addDirectiveTpl(HttpServletRequest request) {
		String methodName = "addDirectiveTpl";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("name", request.getParameter("name"));
		resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
		resultMap.put("keyWords", request.getParameter("keyWords"));
		resultMap.put("priority", request.getParameter("priority"));
		resultMap.put("shortName", request.getParameter("shortName"));
		resultMap.put("description", request.getParameter("description"));
		resultMap.put("path", request.getParameter("path"));
		resultMap.put("titleImg", request.getParameter("titleImg"));
		resultMap.put("tplContent", request.getParameter("tplContent"));
		resultMap.put("startTime", request.getParameter("startTime"));
		resultMap.put("endTime", request.getParameter("endTime"));
		resultMap.put("recommend", request.getParameter("recommend"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/o_save.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 删除专题活动
	@ResponseBody
	@RequestMapping(value = "/delTopic", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteDir(HttpServletRequest request) {
		String methodName = "deleteDir";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", request.getParameter("id"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/topic/o_delete.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}
}
