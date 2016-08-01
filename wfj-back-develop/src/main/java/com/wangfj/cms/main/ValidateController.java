package com.wangfj.cms.main;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;

/**
 * 校验
 * 
 * @Class Name ValidateController
 * @Author
 * @Create In 2015年12月23日
 */
@Controller
@RequestMapping(value = "/validate")
public class ValidateController {
    private static final Logger logger = LoggerFactory.getLogger(ValidateController.class);

    private String className = ValidateController.class.getName();

    // 校验站点 域名,站点名
    @ResponseBody
    @RequestMapping(value = "/validate_site_name", method = { RequestMethod.GET, RequestMethod.POST })
    public String validateSiteName(String domain, String siteName, HttpServletRequest request,
            HttpServletResponse response) {
        String methodName = "queryList";
        String json = "";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        if (domain != null && domain != "") {
            resultMap.put("domain", domain);
        }
        if (siteName != null && siteName != "") {
            resultMap.put("siteName", siteName);
        }
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/site/validate_site.do", resultMap);
        } catch (Exception e) {
            logger.error(className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }
}
