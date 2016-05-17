package com.wangfj.cms.floor;

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
import com.wangfj.order.utils.HttpUtil;

import common.Logger;

@RequestMapping(value = "/ftp")
@Controller
public class FtpController {
    private Logger logger = Logger.getLogger(FtpController.class);

    private String className = FtpController.class.getName();

    // 查询所有ftp
    @ResponseBody
    @RequestMapping(value = "/getList", method = { RequestMethod.GET, RequestMethod.POST })
    public String queryList(HttpServletRequest request, HttpServletResponse response) {
        String methodName = "queryList";
        String json = "";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/ftp/o_list.do", resultMap);
        } catch (Exception e) {
            logger.info(className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }

    // 查询ftp列表
    @ResponseBody
    @RequestMapping(value = "/getftpList", method = { RequestMethod.GET, RequestMethod.POST })
    public String queryFtpList(HttpServletRequest request, HttpServletResponse response) {
        String methodName = "queryFtpList";
        String json = "";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/ftp/v_list.do", resultMap);
        } catch (Exception e) {
            logger.info(className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }

    /**
     * 修改FTP
     * 
     * @Methods Name modifyFtp
     * @Create In 2016-3-29 By chengsj
     * @param id
     * @param name
     * @param ip
     * @param path
     * @param port
     * @param timeout
     * @param username
     * @param password
     * @param encoding
     * @param type
     * @param request
     * @param response
     * @return String
     */
    @ResponseBody
    @RequestMapping(value = "/modifyFtp", method = { RequestMethod.GET, RequestMethod.POST })
    public String modifyFtp(String id, String name, String ip, String path, String port, String timeout,
            String username, String password, String encoding, String type, HttpServletRequest request,
            HttpServletResponse response) {
        JSONObject messageJson = new JSONObject();
        if (!StringUtils.isNotBlank(id) || !StringUtils.isNotBlank(name) || !StringUtils.isNotBlank(ip)
                || !StringUtils.isNotBlank(path) || !StringUtils.isNotBlank(port) || !StringUtils.isNotBlank(username)
                || !StringUtils.isNotBlank(password) || !StringUtils.isNotBlank(encoding)
                || !StringUtils.isNotBlank(type)) {
            messageJson.put("success", "false");
            messageJson.put("message", "参数缺失");
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("id", id);
        resultMap.put("name", name);
        resultMap.put("ip", ip);
        resultMap.put("path", path);
        resultMap.put("port", port);
        if (StringUtils.isNotBlank(timeout)) {
            resultMap.put("timeout", timeout);
        }
        resultMap.put("username", username);
        resultMap.put("password", password);
        resultMap.put("encoding", encoding);
        resultMap.put("type", type);
        String resultString = null;
        try {
            resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/ftp/o_update.do", resultMap);
        } catch (Exception e) {
            messageJson.put("success", "true");
            messageJson.put("message", "修改失败，网络异常，请联系管理员");
            logger.info(className + ":" + e.getMessage());
            return messageJson.toString();
        }
        if (StringUtils.isNotBlank(resultString)) {
            JSONObject resultJSON = JSONObject.fromObject(resultString);
            if (StringUtils.isNotBlank(resultJSON.get("success").toString()) && "true".equals(resultJSON.getString("success"))) {
                messageJson.put("success", "true");
                messageJson.put("message", "修改成功");
                return messageJson.toString();
            }
            messageJson.put("success", "false");
            messageJson.put("message", resultJSON.get("message"));
            return messageJson.toString();
        }
        messageJson.put("success", "false");
        messageJson.put("message", "修改失败");
        return messageJson.toString();
    }

    /**
     * 保存新的FTP
     * 
     * @Methods Name addFtp
     * @Create In 2016-3-29 By chengsj
     * @param request
     * @param name
     * @param ip
     * @param path
     * @param port
     * @param timeout
     * @param username
     * @param password
     * @param encoding
     * @param type
     * @param response
     * @return String
     */
    @ResponseBody
    @RequestMapping(value = "/saveFtp", method = { RequestMethod.GET, RequestMethod.POST })
    public String addFtp(HttpServletRequest request, String name, String ip, String path, String port, String timeout,
            String username, String password, String encoding, String type, HttpServletResponse response) {

        JSONObject messageJson = new JSONObject();
        if (!StringUtils.isNotBlank(name) || !StringUtils.isNotBlank(ip) || !StringUtils.isNotBlank(path)
                || !StringUtils.isNotBlank(port) || !StringUtils.isNotBlank(username)
                || !StringUtils.isNotBlank(password) || !StringUtils.isNotBlank(encoding)
                || !StringUtils.isNotBlank(type)) {
            messageJson.put("success", "false");
            messageJson.put("message", "属性缺失");
            return messageJson.toString();
        }
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("name", name);
        paramMap.put("ip", ip);
        paramMap.put("path", path);
        paramMap.put("port", "21");
        paramMap.put("timeout", timeout);
        paramMap.put("username", username);
        paramMap.put("password", password);
        paramMap.put("encoding", encoding);
        paramMap.put("type", type);
        String resultString = null;
        try {
            resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/ftp/o_save.do", paramMap);
        } catch (Exception e) {
            messageJson.put("success", "false");
            messageJson.put("message", "保存FTP网络异常，请联系管理员");
            logger.info(className + ":" + e.getMessage());
            return messageJson.toString();
        }
        if (StringUtils.isNotBlank(resultString)) {
            JSONObject resultJSON = JSONObject.fromObject(resultString);
            if (StringUtils.isNotBlank(resultJSON.get("success").toString())  && "true".equals(resultJSON.getString("success"))) {
                messageJson.put("success", "true");
                messageJson.put("message", "保存成功");
                return messageJson.toString();
            }
            messageJson.put("success", "false");
            messageJson.put("message", resultJSON.get("message"));
            return messageJson.toString();
        }
        messageJson.put("success", "false");
        messageJson.put("message", "FTP保存 失败");
        return messageJson.toString();
    }

    /**
     * 删除FTP
     * 
     * @Methods Name deleteFtp
     * @Create In 2016-3-29 By chengsj
     * @param request
     * @param id
     * @param response
     * @return String
     */
    @ResponseBody
    @RequestMapping(value = "/delFtp", method = { RequestMethod.GET, RequestMethod.POST })
    public String deleteFtp(HttpServletRequest request, String id, HttpServletResponse response) {
        JSONObject messageJson = new JSONObject();
        if (!StringUtils.isNotBlank(id)) {
            messageJson.put("success", "false");
            messageJson.put("message", "请选择要删除的FTP");
            return messageJson.toString();
        }
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("ids", id);
        String resultString = null;
        try {
            resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/ftp/o_delete.do", paramMap);
        } catch (Exception e) {
            messageJson.put("success", "false");
            messageJson.put("message", "删除失败，网络异常");
            logger.info(className + ":" + e.getMessage());
            return messageJson.toString();
        }
        if (StringUtils.isNotBlank(resultString)) {
            JSONObject resultJSON = JSONObject.fromObject(resultString);
            if (StringUtils.isNotBlank(resultJSON.get("success").toString())  && "true".equals(resultJSON.getString("success"))) {
                messageJson.put("success", "true");
                messageJson.put("message", "删除成功");
                return messageJson.toString();
            }
            messageJson.put("success", "false");
            messageJson.put("message", resultJSON.get(resultJSON));
            return messageJson.toString();
        }
        messageJson.put("success", "false");
        messageJson.put("message", "删除失败");
        return messageJson.toString();
    }

    /**
     * 校验FTP
     * 
     * @Methods Name ftpTest
     * @Create In 2016-3-29 By chengsj
     * @param request
     * @param response
     * @param ip
     * @param username
     * @param password
     * @param port
     * @return String
     */
    @ResponseBody
    @RequestMapping(value = "/testFtp", method = { RequestMethod.GET, RequestMethod.POST })
    public String ftpTest(HttpServletRequest request, HttpServletResponse response, String ip, String username,
            String password, String port) {
        JSONObject messageJson = new JSONObject();
        if (!StringUtils.isNotBlank(ip) || !StringUtils.isNotBlank(username) || !StringUtils.isNotBlank(password)
                || !StringUtils.isNotBlank(port)) {
            messageJson.put("success", "false");
            messageJson.put("message", "属性缺失");
            return messageJson.toString();
        }
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("ip", ip);
        paramMap.put("username", username);
        paramMap.put("password", password);
        paramMap.put("port", port);
        String resultString = null;
        try {
            logger.info("osp,FTP测试调用" + SystemConfig.CMS_SYSTEM_URL + "/ftp/testFtp.do");
            resultString = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/ftp/testFtp.do", paramMap);
        } catch (Exception e) {
            messageJson.put("success", "false");
            messageJson.put("message", "网络异常，请联系管理员");
            logger.info(className + "测试Ftp链接" + e);
            return messageJson.toString();
        }
        if (StringUtils.isNotBlank(resultString)) {
            return resultString;
        } else {
            messageJson.put("success", "false");
            messageJson.put("message", "网络异常，请联系管理员");
            return messageJson.toString();
        }
    }
}
