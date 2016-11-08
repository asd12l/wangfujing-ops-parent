package com.wangfj.cms.staticpage;

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
import com.wangfj.cms.dto.MessageDto;
import com.wangfj.cms.dto.MsgHeaderDto;
import com.wangfj.search.utils.CookieUtil;

import common.Logger;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value = "statics")
public class StaticController {
    private Logger logger = Logger.getLogger(StaticController.class);

    private String className = StaticController.class.getName();

    // 频道静态化(判断是否首页,如果是首页,调另一接口)
    @ResponseBody
    @RequestMapping(value = "index", method = { RequestMethod.GET, RequestMethod.POST })
    public String indexSubmit(HttpServletRequest request, HttpServletResponse response, String channelId,
            String indexFlag, String _site_id_param) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        String userName = CookieUtil.getUserName(request);
        map.put("_site_id_param", _site_id_param);
        if (!Boolean.valueOf(indexFlag)) {
            map.put("channelId", channelId);
        }
        map.put("userName", userName);
        MessageDto dto = new MessageDto();
        MsgHeaderDto header = new MsgHeaderDto();
        header.setBizType("15");
        header.setServiceID("P133_03");
        header.setCount("1");
        if (Boolean.valueOf(indexFlag)) {
            header.setDestUrl(SystemConfig.STATIC_SYSTEM_URL + "/static/o_index.do");
            logger.info(className + ":url:" + SystemConfig.STATIC_SYSTEM_URL + "/static/o_index.do");
        } else {
            header.setDestUrl(SystemConfig.STATIC_SYSTEM_URL + "/static/o_newChannelStatic.do");
            logger.info(className + ":url:" + SystemConfig.STATIC_SYSTEM_URL + "/static/o_newChannelStatic.do");
        }
        header.setCallbackUrl(SystemConfig.LOCAL_URL + "/statics/index");
        header.setDestCallType(0);
        header.setRouteKey("P201_03");
        header.setVersion("1");
        header.setSourceSysID("P133");
        header.setPriority("2");
        header.setToken("");
        header.setDestCallType(0);
        JSONArray arr = new JSONArray();
        arr.add(map);
        dto.setData(arr);
        dto.setHeader(header);
        JSONObject jsono = new JSONObject();
        String jsonString = jsono.fromObject(dto).toString();
        try {
            json = HttpUtil.doPost(SystemConfig.MQ_POST_URL, jsonString);
        } catch (Exception e) {
            JSONObject errorJson = new JSONObject();
            errorJson.put("success", "false");
            errorJson.put("message", "网络链接失败，请联系管理员");
            return errorJson.toString();
        }
        if(!StringUtils.isNotBlank(json)){
            JSONObject errorJson = new JSONObject();
            errorJson.put("success", "false");
            errorJson.put("message", "调用MQ失败,请联系管理员");
            return errorJson.toString();
        }
        
        JSONObject MQresultJson =   JSONObject.fromObject(json);
        String respStatus = MQresultJson.get("respStatus").toString();
        if("".equals(respStatus) || "null".equals(respStatus) || "0".equals(respStatus)){
            JSONObject errorJson = new JSONObject();
            errorJson.put("success", "false");
            errorJson.put("message", "调用MQ失败,请联系管理员");
            return errorJson.toString();
        }
        JSONObject result = new JSONObject();
        result.put("success", "true");
        result.put("message", "创建成功");
        if (Boolean.valueOf(indexFlag)) {
            logger.info(className + ":首页静态化   MQ.dto:" + jsonString);
        } else {
            logger.info(className + ":频道静态化   MQ.dto:" + jsonString);
        }
        return result.toString();
    }

    // 频道静态化
    @ResponseBody
    @RequestMapping(value = "channel", method = { RequestMethod.GET, RequestMethod.POST })
    public String channlSubmit(HttpServletRequest request, HttpServletResponse response, String channelId,
            String _site_id_param) {
        String json = "";
        String userName = CookieUtil.getUserName(request);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("_site_id_param", _site_id_param);
        map.put("channelId", channelId);
        map.put("userName",userName);
        try {

            MessageDto dto = new MessageDto();
            MsgHeaderDto header = new MsgHeaderDto();
            header.setBizType("15");
            header.setServiceID("P133_03");
            header.setCount("1");
            header.setDestUrl(SystemConfig.STATIC_SYSTEM_URL + "/static/o_channl.do");
            header.setCallbackUrl(SystemConfig.LOCAL_URL + "/statics/index");
            header.setDestCallType(0);
            header.setRouteKey("P201_03");
            header.setVersion("1");
            header.setSourceSysID("P133");
            header.setPriority("2");
            header.setToken("");
            header.setDestCallType(0);
            JSONArray arr = new JSONArray();
            arr.add(map);
            dto.setData(arr);
            dto.setHeader(header);
            JSONObject jsono = new JSONObject();
            String jsonString = jsono.fromObject(dto).toString();
            json = HttpUtil.doPost(SystemConfig.MQ_POST_URL, jsonString);
            logger.info(className + ":频道静态化   MQ.dto:" + jsonString);
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        return json;
    }

    // 专题活动静态化
    @ResponseBody
    @RequestMapping(value = "topic", method = { RequestMethod.GET, RequestMethod.POST })
    public String indexTopic(HttpServletRequest request, HttpServletResponse response, String topicId,
            String _site_id_param) {
        String res = "";
        if (topicId == null || topicId == "") {
            topicId = "2";
        }
        String userName = CookieUtil.getUserName(request);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("topicId", topicId);
        map.put("_site_id_param", _site_id_param);
        map.put("userName",userName);
        try {

            MessageDto dto = new MessageDto();
            MsgHeaderDto header = new MsgHeaderDto();
            header.setBizType("15");
            header.setServiceID("P133_03");
            header.setCount("1");
            header.setDestUrl(SystemConfig.STATIC_SYSTEM_URL + "/static/o_topric.do");
            header.setCallbackUrl(SystemConfig.LOCAL_URL + "/statics/topic");
            header.setDestCallType(0);
            header.setRouteKey("P201_03");
            header.setVersion("1");
            header.setSourceSysID("P133");
            header.setPriority("2");
            header.setToken("");
            header.setDestCallType(0);
            JSONArray arr = new JSONArray();
            arr.add(map);
            dto.setData(arr);
            dto.setHeader(header);
            JSONObject jsono = new JSONObject();
            String jsonString = jsono.fromObject(dto).toString();
            res = HttpUtil.doPost(SystemConfig.MQ_POST_URL, jsonString);
            logger.info(className + ":专题活动静态化  MQ.dto:" + jsonString);
        } catch (Exception e) {
            e.printStackTrace();
            res = "{'success':false}";
            return res;
        }
        return res;
    }

    // 删除静态化首页(暂停使用)
    @ResponseBody
    @RequestMapping(value = "indexRemove")
    public String indexRemove(HttpServletRequest request, HttpServletResponse response) {
        String json = "";
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/static/o_index_remove.do", null);
        } catch (Exception e) {
            e.printStackTrace();
            json = "{'success':false}";
        }
        return json;
    }

    // 读取静态化操作记录
    @ResponseBody
    @RequestMapping(value = "getRecordList")
    public String getRecordList(HttpServletRequest request, HttpServletResponse response, String _site_id_param) {
        String json = "";
        Map<String, Object> map = new HashMap<String, Object>();

        Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        if (size == null || size == 0) {
            size = 10;
        }
        map.put("pageSize", size);// 每页显示数量
        map.put("currentPage", currPage);// 当前第几页
        map.put("_site_id_param", _site_id_param);
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/static/getRecordList.do", map);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    // 全站点静态化
    @ResponseBody
    @RequestMapping(value = "site_static")
    public String channelSubmit(HttpServletRequest request, HttpServletResponse response, String _site_id_param) {
        String json = "";
        String userName = CookieUtil.getUserName(request);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("_site_id_param", _site_id_param);
        map.put("userName", userName);
            MessageDto dto = new MessageDto();
            MsgHeaderDto header = new MsgHeaderDto();
            header.setBizType("15");
            header.setServiceID("P133_03");
            header.setCount("1");
            header.setDestUrl(SystemConfig.STATIC_SYSTEM_URL + "/static/o_siteStatic.do");
            header.setCallbackUrl(SystemConfig.LOCAL_URL + "/statics/site_static");
            header.setDestCallType(0);
            header.setRouteKey("P201_03");
            header.setVersion("1");
            header.setSourceSysID("P133");
            header.setPriority("2");
            header.setToken("");
            header.setDestCallType(0);
            JSONArray arr = new JSONArray();
            arr.add(map);
            dto.setData(arr);
            dto.setHeader(header);
            JSONObject jsono = new JSONObject();
            String jsonString = jsono.fromObject(dto).toString();
         try {
             logger.info(className + ":全站静态化  MQ.dto:" + jsonString);
            json = HttpUtil.doPost(SystemConfig.MQ_POST_URL, jsonString);
        } catch (Exception e) {
            JSONObject errorJson = new JSONObject();
            errorJson.put("success", "false");
            errorJson.put("message", "网络链接失败，请联系管理员");
            return errorJson.toString();
        }
         if(!StringUtils.isNotBlank(json)){
             JSONObject errorJson = new JSONObject();
             errorJson.put("success", "false");
             errorJson.put("message", "网络链接失败，请联系管理员");
             return errorJson.toString();
         }
         JSONObject MQresultJson = JSONObject.fromObject(json);
         String respStatus = MQresultJson.get("respStatus").toString();
         if("".equals(respStatus) || "0".equals(respStatus) || "null".equals(respStatus)){
             JSONObject errorJson = new JSONObject();
             errorJson.put("success", "false");
             errorJson.put("message", "调用MQ失败，请联系管理员");
             return errorJson.toString();
         }
         JSONObject jsonObject  = new JSONObject();
         jsonObject.put("success", "true");
         jsonObject.put("message", "创建成功");
        return jsonObject.toString();
    }

}
