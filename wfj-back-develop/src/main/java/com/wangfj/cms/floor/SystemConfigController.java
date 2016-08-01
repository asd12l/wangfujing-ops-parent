package com.wangfj.cms.floor;

import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;
import common.Logger;

/**
 * 系统设置
 * 
 * @Class Name SystemConfigController
 * @Author chengsj
 * @Create In 2015年10月8日
 */
@RequestMapping(value = "/config")
@Controller
public class SystemConfigController {
    private Logger logger = Logger.getLogger(SystemConfigController.class);

    private String className = SystemConfigController.class.getName();

    // 加载系统设置
    @ResponseBody
    @RequestMapping(value = "/load_systemconfig", method = { RequestMethod.GET, RequestMethod.POST })
    public String getSystemConfig() {
        String methodName = "queryStylelist";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String json = "";
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/config/v_system_edit.do", resultMap);
        } catch (Exception e) {
            logger.error(className + ":" + methodName + " " + e.getMessage());
        }
        return json.toString();
    }
}
