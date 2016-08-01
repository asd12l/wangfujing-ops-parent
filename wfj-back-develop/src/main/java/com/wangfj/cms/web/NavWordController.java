package com.wangfj.cms.web;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.wms.util.ResultUtil;
import common.Logger;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "navword")
public class NavWordController {
    private Logger logger = Logger.getLogger(NavWordController.class);

    private String className = NavWordController.class.getName();

    // 导航关键词列表
    @ResponseBody
    @RequestMapping(value = "navwordList")
    public String getList(HttpServletRequest request, HttpServletResponse response) {
        String methodName = "getList";
        String sid = request.getParameter("sid");
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("nav_sid", sid);
        String json = "";
        JSONObject jsonobj = new JSONObject();
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/navword/a_list.do", map);
            jsonobj.put("list", json);
        } catch (Exception e) {
            logger.error(className + ":" + methodName + " " + e.getMessage());
        }
        return jsonobj.toString();
    }

    // 删除导航关键词
    @ResponseBody
    @RequestMapping(value = "delNav")
    public String delPro(HttpServletRequest request, HttpServletResponse response, String sid) {
        String methodName = "delNav";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("sid", sid);
        String json = "";
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/navword/a_delete.do", map);
        } catch (Exception e) {
            json = ResultUtil.createFailureResult(e);
            logger.error(className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }

    // 添加导航关键词
    @ResponseBody
    @RequestMapping(value = "saveNav")
    public String savePro(HttpServletRequest request, HttpServletResponse response, String navSid, String name,
            String link, String seq, String isShow,String username) {
        String methodName = "saveNav";
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("navSid", navSid);
        map.put("name", name);
        map.put("link", link);
        map.put("seq", seq);
        map.put("isShow", isShow);
        map.put("username", username);
        String json = "";
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/navword/a_save.do", map);
        } catch (Exception e) {
            json = ResultUtil.createFailureResult(e);
            logger.error(className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }

   
}
