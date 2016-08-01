package com.wangfj.cms.floor;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.elong.common.StringUtil;
import com.wangfj.cms.utils.Constants;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.wms.util.ResultUtil;

import common.Logger;

@RequestMapping(value = "/webserver")
@Controller
public class WebServerController {
	private Logger logger = Logger.getLogger(WebServerController.class);

	private String className = WebServerController.class.getName();

	// 查询所有webserver
	@ResponseBody
	@RequestMapping(value = "/getList", method = {  RequestMethod.GET, RequestMethod.POST })
	public String queryList(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "queryList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			json = HttpUtil
					.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/o_list.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 预览页面时 查询一个前台server地址(暂停使用)
	@ResponseBody
	@RequestMapping(value = "/get_front_server", method = { RequestMethod.GET, RequestMethod.POST })
	public String getFront(HttpServletRequest request, String _site_id_param,
			HttpServletResponse response) {
		String methodName = "getFront";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (_site_id_param != null && !_site_id_param.equals("")) {
			resultMap.put("_site_id_param", _site_id_param);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/get_front.do",
					resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 动态服务器初始化
	 * 
	 * @Methods Name initTplRes
	 * @Create In 2016-4-1 By chengsj
	 * @param request
	 * @param serverId
	 * @param ip
	 * @param port
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/initResource", method = { RequestMethod.GET, RequestMethod.POST })
	public String initTplRes(HttpServletRequest request, String serverId, String ip, String port, String contextPath, 
			HttpServletResponse response) {
		JSONObject messageJson = new JSONObject();
		if (!StringUtils.isNotBlank(serverId) || !StringUtils.isNotBlank(ip)
				|| !StringUtils.isNotBlank(port)) {
			messageJson.put("success", "false");
			messageJson.put("message", "参数缺失");
			return messageJson.toString();
		}
		String userName = CookieUtil.getUserName(request);
		logger.info(className + ": 参数: serverId " + serverId + " ip " + ip + " port " + port);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("serverId", serverId);
		paramMap.put("ip", ip);
		paramMap.put("port", port);
		paramMap.put("userName",userName);
		paramMap.put("contextPath", StringUtils.isNotEmpty(contextPath) ? contextPath : "/");
		String resultString = null;
		try {
			resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/o_init.do",
					paramMap);
		} catch (Exception e) {
			logger.error(className + ": + " + e.getMessage());
			messageJson.put("success", "false");
			messageJson.put("message", "初始化失败，服务器网络异常");
			return messageJson.toString();
		}
		if (StringUtils.isNotBlank(resultString)) {
			JSONObject resultJson = JSONObject.fromObject(resultString);
			if (StringUtils.isNotBlank(resultJson.getString("success"))) {
				messageJson.put("success", "true");
				messageJson.put("message", "初始化成功");
				return messageJson.toString();
			}
			return resultString;
		}
		messageJson.put("success", "false");
		messageJson.put("message", "初始化失败，服务器网络中断");
		return messageJson.toString();
	}

	// 初始化静态webserver(把静态化页面复制到该静态server)
	@ResponseBody
	@RequestMapping(value = "/initStaticServer", method = { RequestMethod.GET, RequestMethod.POST })
	public String initStaticServer(HttpServletRequest request, String serverId,
			HttpServletResponse response) {
		String methodName = "initStaticServer";
		logger.info(className + ":" + methodName + " 参数: serverId " + serverId);
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (serverId != null && !serverId.equals(Constants.EMPTY)) {
			resultMap.put("serverId", serverId);
			resultMap.put("msDate",new SimpleDateFormat("yyyy-MM-dd-HH:mm:ss.SSS").format(new Date()));
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.STATIC_SYSTEM_URL, "/static/o_copyScriptForNginx.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 获取初始化操作记录
	@ResponseBody
	@RequestMapping(value = "/getRecordList", method = { RequestMethod.GET, RequestMethod.POST })
	public String getRecordList(HttpServletRequest request, String serverId,
			HttpServletResponse response) {
		String methodName = "getRecordList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (serverId != null && !serverId.equals(Constants.EMPTY)) {
			resultMap.put("serverId", serverId);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/o_record.do",
					resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	// 查询webserver列表
	@ResponseBody
	@RequestMapping(value = "/getWebServerList", method = { RequestMethod.GET, RequestMethod.POST })
	public String queryFtpList(HttpServletRequest request, HttpServletResponse response) {
		String methodName = "queryFtpList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			json = HttpUtil
					.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/v_list.do", resultMap);
		} catch (Exception e) {
			logger.error(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 修改webServer
	 * 
	 * @Methods Name modifyFtp
	 * @Create In 2016-3-31 By chengsj
	 * @param id
	 * @param siteId
	 * @param name
	 * @param ip
	 * @param path
	 * @param port
	 * @param username
	 * @param password
	 * @param encoding
	 * @param type
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/modifyWebServer", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyFtp(String id, String siteId, String name, String ip, String path,
			String port, String username, String password, String encoding, String type,
			HttpServletRequest request, HttpServletResponse response) {
		JSONObject messageJson = new JSONObject();
		if (StringUtils.isNotBlank(type) && "0".equals(type)) {
			if (!StringUtils.isNotBlank(siteId) || !StringUtils.isNotBlank(name)
					|| !StringUtils.isNotBlank(ip) || !StringUtils.isNotBlank(path)
					|| !StringUtils.isNotBlank(port) || !StringUtils.isNotBlank(username)
					|| !StringUtils.isNotBlank(password) || !StringUtils.isNotBlank(encoding)
					|| !StringUtils.isNotBlank(type)) {
				messageJson.put("success", "false");
				messageJson.put("message", "参数缺失");
				return messageJson.toString();
			}
		}
		if (StringUtils.isNotBlank(type) && "1".equals(type)) {
			if (!StringUtils.isNotBlank(siteId) || !StringUtils.isNotBlank(name)
					|| !StringUtils.isNotBlank(ip) || !StringUtils.isNotBlank(port)
					|| !StringUtils.isNotBlank(encoding) || !StringUtils.isNotBlank(type)) {
				messageJson.put("success", "false");
				messageJson.put("message", "参数缺失");
				return messageJson.toString();
			}
			username = null;
			password = null;
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("siteId", siteId);
		paramMap.put("name", name);
		paramMap.put("ip", ip);
		paramMap.put("path", path);
		paramMap.put("port", port);
		paramMap.put("username", username);
		paramMap.put("password", password);
		paramMap.put("encoding", encoding);
		paramMap.put("type", type);
		if ("0".equals(type)) {
			String valijson = null;
			try {
				valijson = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
						"/webserver/valiWebServer.do", paramMap);
			} catch (Exception e) {
				logger.error(className + ":" + e.getMessage());
				JSONObject errorJson = new JSONObject();
				errorJson.put("success", "false");
				errorJson.put("message", "用户认证失败，网络中断。");
				return errorJson.toString();
			}
			if (!StringUtils.isNotBlank(valijson)) {
				JSONObject errorJson = new JSONObject();
				errorJson.put("success", "false");
				errorJson.put("data", "用户认证失败，网络中断。");
				return errorJson.toString();
			}
			JSONObject resultJson = JSONObject.fromObject(valijson);
			if (resultJson.get("success").toString().equals("false")) {
				return resultJson.toString();
			}
		}
		String resultString = null;
		try {
			resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/o_update.do",
					paramMap);
		} catch (Exception e) {
			logger.error(className + ":" + e.getMessage());
			messageJson.put("success", "false");
			messageJson.put("message", "更新失败，服务器网路异常");
			return messageJson.toString();
		}
		if (StringUtils.isNotBlank(resultString)) {
			JSONObject resultJson = JSONObject.fromObject(resultString);
			if (StringUtils.isNotBlank(resultJson.get("success").toString()) && "true".equals(resultJson.getString("success"))) {
				messageJson.put("success", "true");
				messageJson.put("message", "更新成功");
				return messageJson.toString();
			}
			return resultJson.toString();
		}
		messageJson.put("success", "false");
		messageJson.put("message", "更新失败，服务器网路中断");
		return messageJson.toString();
	}

	/**
	 * 添加webServer
	 * 
	 * @Methods Name addFtp
	 * @Create In 2016-3-30 By chengsj
	 * @param request
	 * @param siteId
	 * @param name
	 * @param ip
	 * @param path
	 * @param port
	 * @param username
	 * @param password
	 * @param encoding
	 * @param type
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveWebServer", method = { RequestMethod.GET, RequestMethod.POST })
	public String addFtp(HttpServletRequest request, String siteId, String name, String ip,
			String path, String port, String username, String password, String encoding,
			String type, HttpServletResponse response) {
		JSONObject messageJson = new JSONObject();
		if (StringUtils.isNotBlank(type) && "0".equals(type)) {
			if (!StringUtils.isNotBlank(siteId) || !StringUtils.isNotBlank(name)
					|| !StringUtils.isNotBlank(ip) || !StringUtils.isNotBlank(path)
					|| !StringUtils.isNotBlank(port) || !StringUtils.isNotBlank(username)
					|| !StringUtils.isNotBlank(password) || !StringUtils.isNotBlank(encoding)
					|| !StringUtils.isNotBlank(type)) {
				messageJson.put("success", "false");
				messageJson.put("message", "参数缺失");
				return messageJson.toString();
			}
		}
		if (StringUtils.isNotBlank(type) && "1".equals(type)) {
			if (!StringUtils.isNotBlank(siteId) || !StringUtils.isNotBlank(name)
					|| !StringUtils.isNotBlank(ip) || !StringUtils.isNotBlank(port)
					|| !StringUtils.isNotBlank(encoding) || !StringUtils.isNotBlank(type)) {
				messageJson.put("success", "false");
				messageJson.put("message", "参数缺失");
				return messageJson.toString();
			}
			username = null;
			password = null;
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("siteId", siteId);
		paramMap.put("name", name);
		paramMap.put("ip", ip);
		paramMap.put("path", path);
		paramMap.put("port", port);
		paramMap.put("username", username);
		paramMap.put("password", password);
		paramMap.put("encoding", encoding);
		paramMap.put("type", type);
		String resultString = null;
		if ("0".equals(type)) {
			try {
				resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
						"/webserver/valiWebServer.do", paramMap);
				if (!StringUtils.isNotBlank(resultString)) {
					JSONObject errorJson = new JSONObject();
					errorJson.put("success", "false");
					errorJson.put("message", "用户认证失败，网络中断。");
					return errorJson.toString();
				}
				JSONObject resultJson = JSONObject.fromObject(resultString);
				if (resultJson.get("success").toString().equals("false")) {
					return resultJson.toString();
				}
			} catch (Exception e) {
				messageJson.put("success", "false");
				messageJson.put("data", "添加啊server失败，网络异常。");
				logger.error(className + ":" + e.getMessage());
				return messageJson.toString();

			}
		}
		String saveString = null;
		saveString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/o_save.do",
				paramMap);
		if (StringUtils.isNotBlank(saveString)) {
			JSONObject saveJson = JSONObject.fromObject(saveString);
			if (StringUtils.isNotBlank(saveJson.get("success").toString())) {
				messageJson.put("success", "true");
				messageJson.put("message", "保存成功");
				return messageJson.toString();
			}
			messageJson.put("success", "false");
			messageJson.put("message", saveJson.get("message"));
			return messageJson.toString();
		}
		messageJson.put("success", "false");
		messageJson.put("message", "保存失败，请检查server参数或网络链接");
		return messageJson.toString();
	}

	/**
	 * 删除Server
	 * 
	 * @Methods Name deleteFtp
	 * @Create In 2016-3-30 By chengsj
	 * @param request
	 * @param id
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/delWebServer", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteFtp(HttpServletRequest request, String id, HttpServletResponse response) {
		JSONObject messageJson = new JSONObject();
		if (!StringUtils.isNotBlank(id)) {
			messageJson.put("success", "false");
			messageJson.put("message", "请选择要删除的列");
			return messageJson.toString();
		}
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("id", id);
		String resultString = null;
		try {
			resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/webserver/o_delete.do",
					resultMap);
		} catch (Exception e) {
			messageJson.put("success", "false");
			messageJson.put("message", "删除失败，网络异常");
			logger.error(className + e.getMessage());
			return messageJson.toString();
		}
		if (StringUtils.isNotBlank(resultString)) {
			JSONObject resultJson = JSONObject.fromObject(resultString);
			if (StringUtils.isNotBlank(resultJson.get("success").toString()) && "true".equals(resultJson.getString("success"))) {
				messageJson.put("success", "true");
				messageJson.put("message", "删除成功");
				return messageJson.toString();
			}
			messageJson.put("success", "false");
			messageJson.put("message", resultJson.get("message"));
			return messageJson.toString();
		}
		messageJson.put("success", "false");
		messageJson.put("message", "删除失败，服务器网络中断");
		return messageJson.toString();
	}
}
