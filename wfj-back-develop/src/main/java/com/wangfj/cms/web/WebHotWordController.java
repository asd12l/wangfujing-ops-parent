package com.wangfj.cms.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.wms.util.ResultUtil;
import common.Logger;

@Controller
@RequestMapping(value = "hotword")
public class WebHotWordController {
    private Logger logger = Logger.getLogger(WebHotWordController.class);

    private String className = WebHotWordController.class.getName();

    @ResponseBody
    @RequestMapping(value = "getWordsPageList")
    public String getWordsPageList(HttpServletRequest request, HttpServletResponse response) {
        String methodName = "getWordsPageList";
        String results = "";

        Map<String, Object> mapPara = new HashMap<String, Object>();
        //null != request.getParameter("siteId")
        if (StringUtils.isNotBlank(request.getParameter("siteId"))) {
            mapPara.put("siteId", Integer.parseInt(request.getParameter("siteId")));
        }
        //null != request.getParameter("channelId") 
        if (StringUtils.isNotBlank(request.getParameter("channelId"))) {
            mapPara.put("channelId", request.getParameter("channelId"));
        }
        //        /null != request.getParameter("hotword") && !request.getParameter("hotword").isEmpty()
        if (StringUtils.isNotBlank(request.getParameter("hotword"))) {
            mapPara.put("hotword", request.getParameter("hotword"));
        }
//        /null == request.getParameter("page")
        if (!StringUtils.isNotBlank(request.getParameter("page"))) {
            mapPara.put("pageNo", "1");
        } else {
            mapPara.put("pageNo", request.getParameter("page"));
        }

        mapPara.put("pageSize", request.getParameter("pageSize") == null ? "10" : request.getParameter("pageSize"));

        try {
            results = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/hotword/getWordsPageList.do", mapPara);

            return results;
        } catch (Exception e) {
            logger.error("获取关键词列表错误" + methodName + e);
            return "{success:false}";
        }
    }

    @ResponseBody
    @RequestMapping(value = "getHotwordList")
    public String getHotwordList(HttpServletRequest request, HttpServletResponse response, String hotword) {
        String methodName = "getHotwordList";
        String results = "";

        Map<String, Object> mapPara = new HashMap<String, Object>();

        mapPara.put("channelId", 1);
        if (null != hotword && hotword.isEmpty()) {
            mapPara.put("hotword", hotword.isEmpty());
        }

        if (null == request.getParameter("page")) {
            mapPara.put("pageNo", "1");
        } else {
            mapPara.put("pageNo", request.getParameter("page"));
        }

        mapPara.put("pageSize", request.getParameter("pageSize") == null ? "10" : request.getParameter("pageSize"));

        try {
            results = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/hotword/getWordsList.do", mapPara);

            return results;
        } catch (Exception e) {
            logger.error("获取关键词列表错误" + methodName + e);
            return "{success:false}";
        }
    }

    // 添加关键词列表
    @ResponseBody
    @RequestMapping(value = "/addHotword", method = { RequestMethod.GET, RequestMethod.POST })
    public String addProductList(HttpServletRequest request, HttpServletResponse response, String hotwords) {
        String methodName = "addHotword";
        String json = "";
        Map<String, Object> mapPara = new HashMap<String, Object>();
        mapPara.put("hotwords", hotwords);
//        /null != request.getParameter("siteId")
        if (StringUtils.isNotBlank(request.getParameter("siteId"))) {
            mapPara.put("siteId", Integer.parseInt(request.getParameter("siteId")));
        }
        //null != request.getParameter("channelId")
        if (StringUtils.isNotBlank(request.getParameter("channelId"))) {
            mapPara.put("channelId", request.getParameter("channelId"));
        }
//        /null != request.getParameter("navid")
        if (StringUtils.isNotBlank(request.getParameter("navid"))) {
            mapPara.put("navid", request.getParameter("navid"));
        }

        try {
            HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/hotword/addHotword.do", mapPara);
            json = ResultUtil.createSuccessResult();
        } catch (Exception e) {
            json = ResultUtil.createFailureResult(e);
            logger.info("添加关键词错误" + className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }

    // 删除关键词列表
    @ResponseBody
    @RequestMapping(value = "/delHotword", method = { RequestMethod.GET, RequestMethod.POST })
    public String delProduct(String sids, HttpServletRequest request, HttpServletResponse response) {
        String methodName = "delHotword";
        String json = "";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("sid", request.getParameter("sid"));

        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/hotword/delHotword.do", resultMap);
        } catch (Exception e) {
            json = ResultUtil.createFailureResult(e);
            logger.info("删除关键词错误" + className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }

    @ResponseBody
    @RequestMapping(value = "getHotwordListFromDB")
    public String getHotwordListFromDB(HttpServletRequest request, HttpServletResponse response) {
        String methodName = "getHotwordListFromDB";
        String results = "";

        Map<String, Object> mapPara = new HashMap<String, Object>();
        //null != request.getParameter("siteId")
        if (StringUtils.isNotBlank(request.getParameter("siteId"))) {
            mapPara.put("siteId", Integer.parseInt(request.getParameter("siteId")));
        }
//        /null != request.getParameter("channelId")
        if (StringUtils.isNotBlank(request.getParameter("channelId"))) {
            mapPara.put("channelId", request.getParameter("channelId"));
        }
//        null != request.getParameter("navid")
        if (StringUtils.isNotBlank(request.getParameter("navid"))) {
            mapPara.put("navid", request.getParameter("navid"));
        }
        //null == request.getParameter("page")
        if (!StringUtils.isNotBlank(request.getParameter("page"))) {
            mapPara.put("pageNo", "1");
        } else {
            mapPara.put("pageNo", request.getParameter("page"));
        }
        mapPara.put("pageSize", request.getParameter("pageSize") == null ? "10" : request.getParameter("pageSize"));

        try {
            results = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/hotword/getWordsListFromDB.do", mapPara);
            return results;
        } catch (Exception e) {
            logger.error("获取关键词列表错误" + methodName + e);
            return ResultUtil.createFailureResult(e);
        }
    }
}
