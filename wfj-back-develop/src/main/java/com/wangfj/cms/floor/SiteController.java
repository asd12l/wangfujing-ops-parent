package com.wangfj.cms.floor;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.ResultUtil;

import common.Logger;

@RequestMapping(value = "/site")
@Controller
public class SiteController {
	private Logger logger = Logger.getLogger(SiteController.class);

	private String className = SiteController.class.getName();

	/**
	 * 查询站点列表modifySite
	 * 
	 * @Methods Name querySiteList
	 * @Create In 2016年3月29日 By wangsy
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getSiteList", method = { RequestMethod.GET, RequestMethod.POST })
	public String querySiteList() {
		String methodName = "querySiteList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/v_list.do", resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 修改站点
	 * 
	 * @Methods Name modifyFtp
	 * @Create In 2016-3-30 By chengsj
	 * @param id
	 * @param name
	 * @param sitePath
	 * @param domain
	 * @param resource_path
	 * @param tpl_path
	 * @param dynamicSuffix
	 * @param staticSuffix
	 * @param channelCode
	 * @param channelName
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/modifySite", method = { RequestMethod.GET, RequestMethod.POST })
	public String modifyFtp(String id, String name, String sitePath, String domain,
			String resource_path, String tpl_path, String dynamicSuffix, String staticSuffix,
			String channelCode, String channelName) {
		JSONObject messageJson = new JSONObject();
		if (!StringUtils.isNotBlank(id) || !StringUtils.isNotBlank(name)
				|| !StringUtils.isNotBlank(sitePath) || !StringUtils.isNotBlank(domain)
				|| !StringUtils.isNotBlank(resource_path) || !StringUtils.isNotBlank(tpl_path)
				|| !StringUtils.isNotBlank(dynamicSuffix) || !StringUtils.isNotBlank(staticSuffix)
				|| !StringUtils.isNotBlank(channelCode) || !StringUtils.isNotBlank(channelName)) {
			messageJson.put("success", "false");
			messageJson.put("message", "参数缺失");
			return messageJson.toString();
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("name", name);
		paramMap.put("sitePath", sitePath);
		paramMap.put("dynamicSuffix", dynamicSuffix);
		paramMap.put("domain", domain);
		paramMap.put("staticSuffix", staticSuffix);
		paramMap.put("channelCode", channelCode);
		paramMap.put("channelName", channelName);
		paramMap.put("resource_path", resource_path);
		paramMap.put("tpl_path", tpl_path);
		String resultString = null;
		try {
			resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/o_update.do",
					paramMap);
		} catch (Exception e) {
			messageJson.put("success", "false");
			messageJson.put("message", "修改失败，网络异常");
			logger.info(className + ":" + e.getMessage());
			return messageJson.toString();
		}
		if (StringUtils.isNotBlank(resultString)) {
			JSONObject resultJson = JSONObject.fromObject(resultString);
			if (StringUtils.isNotBlank(resultJson.getString("success").toString()) && "true".equals(resultJson.getString("success"))) {
				messageJson.put("success", "true");
				messageJson.put("message", "修改站点成功");
				return messageJson.toString();
			}
			messageJson.put("success", "false");
			messageJson.put("message", resultJson.getString("message"));
			return messageJson.toString();
		}
		messageJson.put("success", "false");
		messageJson.put("message", "修改站点失败，服务器网络中断");
		return messageJson.toString();
	}

	/**
	 * 保存站点
	 * 
	 * @Methods Name addFtp
	 * @Create In 2016-3-30 By chengsj
	 * @param name
	 * @param sitePath
	 * @param domain
	 * @param resource_path
	 * @param tpl_path
	 * @param dynamicSuffix
	 * @param staticSuffix
	 * @param channelCode
	 * @param channelName
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveSite", method = { RequestMethod.GET, RequestMethod.POST })
	public String addFtp(String name, String sitePath, String domain, String resource_path,
			String tpl_path, String dynamicSuffix, String staticSuffix, String channelCode,
			String channelName) {
		JSONObject messageJson = new JSONObject();
		if (!StringUtils.isNotBlank(name) || !StringUtils.isNotBlank(sitePath)
				|| !StringUtils.isNotBlank(domain) || !StringUtils.isNotBlank(resource_path)
				|| !StringUtils.isNotBlank(tpl_path) || !StringUtils.isNotBlank(dynamicSuffix)
				|| !StringUtils.isNotBlank(staticSuffix) || !StringUtils.isNotBlank(channelCode)
				|| !StringUtils.isNotBlank(channelName)) {
			messageJson.put("success", "false");
			messageJson.put("message", "参数缺失");
			return messageJson.toString();
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("name", name);
		paramMap.put("sitePath", sitePath);
		paramMap.put("dynamicSuffix", dynamicSuffix);
		paramMap.put("domain", domain);
		paramMap.put("staticSuffix", staticSuffix);
		paramMap.put("resource_path", resource_path);
		paramMap.put("tpl_path", tpl_path);
		paramMap.put("channelCode", channelCode);
		paramMap.put("channelName", channelName);
		String resultString = null;
		try {
			resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/o_save.do",
					paramMap);
		} catch (Exception e) {
			messageJson.put("success", "false");
			messageJson.put("message", "保存站点失败，网络链接异常");
			logger.info(className + ":" + e.getMessage());
			return messageJson.toString();
		}
		if (StringUtils.isNotBlank(resultString)) {
			JSONObject resultJson = JSONObject.fromObject(resultString);
			if (StringUtils.isNotBlank(resultJson.get("success").toString()) && "true".equals(resultJson.getString("success"))) {
				messageJson.put("success", "true");
				messageJson.put("message", "保存成功");
				return messageJson.toString();
			}
			messageJson.put("success", "false");
			messageJson.put("message", resultJson.getString("message"));
			return messageJson.toString();
		}
		messageJson.put("success", "false");
		messageJson.put("message", "保存失败，服务器网络链接中断");
		return messageJson.toString();
	}

	/**
	 * 删除站点信息
	 * 
	 * @Methods Name deleteFtp
	 * @Create In 2016-3-30 By chengsj
	 * @param request
	 * @param id
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/delSite", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteFtp(HttpServletRequest request, String id) {
		JSONObject messageJson = new JSONObject();
		if (!StringUtils.isNotBlank(id)) {
			messageJson.put("success", "false");
			messageJson.put("message", "站点ID缺失");
			return messageJson.toString();
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		String resultString = null;
		try {
			resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/o_delete.do",
					paramMap);
		} catch (Exception e) {
			messageJson.put("success", "false");
			messageJson.put("message", "删除失败，网络异常");
			logger.info(className + ":" + e.getMessage());
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
			messageJson.put("message", resultJson.getString("message"));
			return messageJson.toString();
		}
		messageJson.put("success", "false");
		messageJson.put("message", "删除失败,服务器网络链接中断");
		return messageJson.toString();
	}

	/**
	 * 设置站点
	 * 
	 * @Methods Name setSite
	 * @Create In 2016年3月29日 By wangsy
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/setSite", method = { RequestMethod.GET, RequestMethod.POST })
	public String setSite(HttpServletRequest request) {
		String methodName = "setSite";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String siteId = request.getParameter("siteId");
		resultMap.put("id", siteId);
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/o_set.do", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 获取对应的模板ftp路径
	 * 
	 * @Methods Name getFtpDirList
	 * @Create In 2015年11月19日 By hongfei
	 * @param request
	 * @return String
	 */
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/getFtpDirList", method = { RequestMethod.GET,
	 * RequestMethod.POST }) public String getFtpDirList( HttpServletRequest
	 * request ) { String methodName = "getFtpDirList"; String json = "";
	 * Map<String,Object> resultMap = new HashMap<String,Object>();
	 * resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
	 * try { json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
	 * "/site/getFtpDirList.do", resultMap); } catch (Exception e) {
	 * logger.info(className+":"+methodName+" "+e.getMessage()); } return json;
	 * }
	 */

	/**
	 * 获取站点下对应的模板ftp路径
	 * 
	 * @Methods Name getFtpTplDirList
	 * @Create In 2015年11月19日 By hongfei
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getFtpTplDirList", method = { RequestMethod.GET, RequestMethod.POST })
	public String getFtpTplDirList(HttpServletRequest request) {
		String methodName = "getFtpTplDirList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getFtpTplDirList.do",
					resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 获取对应的资源ftp路径
	 * 
	 * @param request
	 * @param response
	 */
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/getFtpResDirList.do", method = {
	 * RequestMethod.GET, RequestMethod.POST }) public String getFtpResDirList(
	 * HttpServletRequest request ) { String methodName = "getFtpResDirList";
	 * String json = ""; Map<String,Object> resultMap = new
	 * HashMap<String,Object>(); resultMap.put("_site_id_param",
	 * request.getParameter("_site_id_param")); try {
	 * json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,
	 * "/site/getFtpResDirList.do", resultMap); } catch (Exception e) {
	 * logger.info(className+":"+methodName+" "+e.getMessage()); } return json;
	 * }
	 */

	/**
	 * 获取站点下对应的资源ftp路径
	 * 
	 * @param request
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/getFtpSiteResDirList.do", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getFtpSiteResDirList(HttpServletRequest request) {
		String methodName = "getFtpSiteResDirList";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getFtpSiteResDirList.do",
					resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 获取资源ftp信息
	 * 
	 * @Methods Name getResourceFtp
	 * @Create In 2015年11月23日 By hongfei
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getResourceFtp", method = { RequestMethod.GET, RequestMethod.POST })
	public String getResourceFtp(HttpServletRequest request) {
		String methodName = "getResourceFtp";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getResourceFtp.do",
					resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 获取模板ftp信息
	 * 
	 * @Methods Name getTplFtp
	 * @Create In 2015年11月23日 By hongfei
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getTplFtp", method = { RequestMethod.GET, RequestMethod.POST })
	public String getTplFtp(HttpServletRequest request) {
		String methodName = "getTplFtp";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getTplFtp.do", resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 获取渠道code
	 * 
	 * @Methods Name getChannelCode
	 * @Create In 2015年12月29日 By hongfei
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getChannelCode", method = { RequestMethod.GET, RequestMethod.POST })
	public String getChannelCode(HttpServletRequest request) {
		String methodName = "getChannelCode";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("queryFlag", 0);
		try {
			json = HttpUtilPcm
					.doPost(SystemConfig.SSD_SYSTEM_INNER_URL
							+ "/cmsChannelShopShoppe/getInfoByParam.htm",
							JsonUtil.getJSONString(resultMap));
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 获取模板ftp站点路径
	 * 
	 * @Methods Name getTplFtpSitePath
	 * @Create In 2015年12月31日 By chengsj
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getTplFtpSitePath", method = { RequestMethod.GET, RequestMethod.POST })
	public String getTplFtpSitePath(HttpServletRequest request) {
		String methodName = "getTplFtpSitePath";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getTplFtpSitePath.do",
					resultMap);
		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 获取模板ftp站点路径
	 * 
	 * @Methods Name getTplFtpSitePath
	 * @Create In 2015年12月31日 By chengsj
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getResFtpSitePath", method = { RequestMethod.GET, RequestMethod.POST })
	public String getResFtpSitePath(HttpServletRequest request) {
		String methodName = "getTplFtpSitePath";
		String json = "";
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("_site_id_param", request.getParameter("_site_id_param"));
		try {
			json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getResFtpSitePath.do",
					resultMap);

		} catch (Exception e) {
			logger.info(className + ":" + methodName + " " + e.getMessage());
		}
		return json;
	}

	/**
	 * 上传资源目录刷新CDN
	 * 
	 * @Methods Name flushCDN
	 * @Create In 2016-3-26 By chengsj
	 * @param request
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/flushResource", method = { RequestMethod.GET, RequestMethod.POST })
	public String flushCDN(HttpServletRequest request, String siteId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("siteId", siteId);
		String result = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/flushCDN.do", map);
		logger.info("上传资源目录刷新CDN调用cms_admin， /site/getResFtpSitePath.do 传参  siteId:" + siteId
				+ " 接口返回" + result);
		return result;
	}
}
