package com.wangfj.cms.floor;

import java.io.File;
import java.io.FileInputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.constants.SystemConfig;
import com.wangfj.cms.utils.FileUtil;
import com.wangfj.cms.utils.RemoteFtpProcess;
import com.wangfj.cms.utils.ZipUtil;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.ResultUtil;
import org.apache.commons.lang.StringUtils;

import common.Logger;
import net.sf.json.JSONObject;

@RequestMapping(value = "/resource")
@Controller
public class ResourceController {
    private Logger logger = Logger.getLogger(ResourceController.class);

    private String className = ResourceController.class.getName();

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

		// 根据站点id获取资源ftp信息
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("_site_id_param", siteId);
		String ftpInfo="";
		try {
			ftpInfo = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL,"/site/getResourceFtp.do",
					param);
		} catch (Exception e) {
            logger.error(className + ":" +methodName  + " " + e.getMessage()+"获取资源ftp信息失败");
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
	            ftpProcess.loginFtp(ip, Integer.valueOf(port), username,
	            		password);
	            
	            boolean flag = ftpProcess.uploadFileToFtp(targetFile.getName(), new FileInputStream(targetFile), dPath);
	            ftpProcess.closeConnections();
	            
				// 上传完成删除对应的文件
				FileUtil fileUtl = new FileUtil();
				fileUtl.deleteDir(targetFile);

				// 上传失败
				if (!flag) {
					obj.put("success", false);
					obj.put("msg", "系统异常请稍后再试");
					logger.error("上传资源到ftp服务器失败！");
					return obj.toString();
				}
				
				//上传成功刷新cdn
				Map map = new HashMap();
		        map.put("siteId", siteId);
		        String result = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/flushCDN.do", map);
		        logger.info("上传资源目录刷新CDN调用cms_admin， /site/getResFtpSitePath.do 传参  siteId:"+siteId+" 接口返回"+result);
		        
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

    // 资源目录树(读FTP)
    @ResponseBody
    @RequestMapping(value = "/resourceTree", method = RequestMethod.POST)
    public String getAllResources(String siteId, HttpServletRequest request, HttpServletResponse response) {
        String methodName = "getAllResources";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("siteId", siteId);
        String json = "";
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/resource/v_tree.do", resultMap);
        } catch (Exception e) {
            logger.info(className + ":" + methodName + " " + e.getMessage());
        }

        return json.toString();
    }

    // 目录列表
    @ResponseBody
    @RequestMapping(value = "/queryDirList", method = { RequestMethod.GET, RequestMethod.POST })
    public String queryPageLayout(HttpServletRequest request,String _site_id_param) {
        String methodName = "queryPageLayout";
        String json = "";
        String path = request.getParameter("path");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        if(StringUtils.isNotBlank(_site_id_param)){
        	resultMap.put("_site_id_param", _site_id_param);
        }

        resultMap.put("path", path);
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/resource/ftp_file_list.do", resultMap);
        } catch (Exception e) {
            logger.info(className + ":" + methodName + " " + e.getMessage());
        }

        return json;
    }
    
    /**
     * 上传资源压缩文件.zip
     * @Methods Name uploadZipFile
     * @Create In 2016-4-12 By chengsj
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

        // 根据站点id获取资源ftp信息
 		Map<String, Object> param = new HashMap<String, Object>();
 		param.put("_site_id_param", siteId);
 		String ftpInfo="";
		try {
			ftpInfo = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/getResourceFtp.do",
					param);
		} catch (Exception e) {
            logger.error(className + ":" + methodName + " " + e.getMessage()+"获取ftp信息失败");
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
		String dPath = ftp.getString("path");
		
		//上传到tomcat文件存放路径
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
				ZipUtil.unzip(targetFile.getPath(),unzipDirPath);
				targetFile.delete();	
				
				// 3.上传
				RemoteFtpProcess ftpProcess = new RemoteFtpProcess();
	            ftpProcess.loginFtp(ip, Integer.valueOf(port), username,
	            		password);
	            String[] suffix = new String[]{".html"};
	            ftpProcess.uploadDirFiles(unzipDirPath, dPath,suffix);
	            ftpProcess.closeConnections();
				
	            //4上传完，删除文件
	            File temp = new File(srcpath);
				FileUtil fileUtl = new FileUtil();
				fileUtl.deleteDir(temp);
				
				//5上传陈功刷新cdn
				Map map = new HashMap();
		        map.put("siteId", siteId);
		        String result = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/flushCDN.do", map);
		        logger.info("上传资源目录刷新CDN调用cms_admin， /site/getResFtpSitePath.do 传参  siteId:"+siteId+" 接口返回"+result);
		        
		        //删除目录缓存
		        HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/ftp/oSiteIdRemove.do", map);
				
				obj.put("success", true);
			} catch (Exception e) {
	            logger.error(className + ":" + methodName + " " + e.getMessage()+"上传失败");
	            obj.put("success", false);
	            obj.put("msg", "系统异常，请联系管理员");
			}

		} else {
			obj.put("success", false);
			obj.put("msg", "系统异常，请联系管理员");
		}
		return obj.toString();
	}

    // 修改文件名
    @ResponseBody
    @RequestMapping(value = "/modifyFileName", method = { RequestMethod.GET, RequestMethod.POST })
    public String modifyFileName(HttpServletRequest request, HttpServletResponse response) {
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
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/o_rename.do", resultMap);
        } catch (Exception e) {
            json = ResultUtil.createFailureResult(e);
            logger.info(className + ":" + methodName + " " + e.getMessage());
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
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/template/delFile.do", resultMap);
        } catch (Exception e) {
            json = ResultUtil.createFailureResult(e);
            logger.info(className + ":" + methodName + " " + e.getMessage());
        }

        return json;
    }
}
