package com.wangfj.search.online.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.google.common.base.Optional;
import com.wangfj.search.utils.*;
import com.wfj.search.utils.http.OkHttpOperator;
import com.wfj.search.utils.zookeeper.discovery.SpringWebMvcServiceProvider;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * 热词管理接口
 *
 * @Class Name HotWordController
 * @Author litao
 * @Create In 2015年12月22日
 */
@Controller
@RequestMapping(value = "/hotWord")
public class SearchHotWordController {

    private final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private PrivateRsaKeyProvider privateRsaKeyProvider;
    @Autowired
    private SpringWebMvcServiceProvider serviceProvider;
    @Autowired
    private OkHttpOperator okHttpOperator;
    @Value("${search.caller}")
    private String caller;
    @Value("${search.service.hotWord.read}")
    private String serviceNameRead;
    @Value("${search.service.hotWord.create}")
    private String serviceNameCreate;
    @Value("${search.service.hotWord.destroy}")
    private String serviceNameDestroy;
    @Value("${search.service.hotWord.update}")
    private String serviceNameUpdate;
    @Value("${search.service.hotWord.enabled}")
    private String serviceNameEnabled;
    @Value("${search.service.hotWord.disabled}")
    private String serviceNameDisabled;
    @Value("${search.service.hotWord.site}")
    private String serviceNameSite;
    @Value("${search.service.hotWord.channel}")
    private String serviceNameChannel;

    @ResponseBody
    @RequestMapping(value = "/getList", method = {RequestMethod.GET, RequestMethod.POST})
    public String getHotWordList(HttpServletRequest request, String hotWordSite, String hotWordChannel) {
        Integer size = request.getParameter("pageSize") == null ? null
                : Integer.parseInt(request.getParameter("pageSize"));
        if (size == null || size == 0) {
            size = 10;
        }
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        int start = (currPage - 1) * size;
        JSONObject messageBody = new JSONObject();
        JSONObject messageBody1 = new JSONObject();
        if (StringUtils.isNotBlank(hotWordSite)) {
            messageBody.put("site", hotWordSite);
        }
        if (StringUtils.isNotBlank(hotWordChannel)) {
            messageBody.put("channel", hotWordChannel);
        }
        messageBody.put("limit", size);
        messageBody.put("start", start);

        //签名验证
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0132");
            return json.toJSONString();
        }
        String signatureJson1;
        try {
            signatureJson1 = SignatureHandler
                    .sign(messageBody1, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0132");
            return json.toJSONString();
        }

        //服务发现
        Optional<String> serviceAddress1;
        Optional<String> serviceAddress2;
        Optional<String> serviceAddress3;
        try {
            serviceAddress1 = serviceProvider.provideServiceAddress(serviceNameSite);
            serviceAddress2 = serviceProvider.provideServiceAddress(serviceNameRead);
            serviceAddress3 = serviceProvider.provideServiceAddress(serviceNameChannel);
        } catch (Exception e) {
            logger.error("获取服务地址失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, BLC0142");
            return json.toJSONString();
        }
        String SiteAddress = serviceAddress1.orNull();
        String readAddress = serviceAddress2.orNull();
        String channelAddress = serviceAddress3.orNull();
        if (com.utils.StringUtils.isBlank(SiteAddress)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0149");
            return json.toJSONString();
        }
        if (com.utils.StringUtils.isBlank(readAddress)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0149");
            return json.toJSONString();
        }
        if (com.utils.StringUtils.isBlank(channelAddress)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0149");
            return json.toJSONString();
        }

        String resultStie;
        String resultChannel;
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(readAddress, signatureJson);
            resultStie = okHttpOperator.postJsonTextForTextResp(SiteAddress, signatureJson1);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, BLC0161");
            return json.toJSONString();
        }

        if (!JSONObject.parseObject(resultJson).getBoolean("success")) {
            JSONObject Json = JSONObject.parseObject(resultJson);
            Json.put("pageCount", 0);
            return Json.toString();
        } else {
            JSONObject Json = JSONObject.parseObject(resultJson);
            JSONObject Json1 = JSONObject.parseObject(resultStie);
            JSONArray jsonHotWord = Json.getJSONArray("list");
            for (int i = 0; i < jsonHotWord.size(); i++) {
                for (int j = 0; j < Json1.getJSONArray("list").size(); j++) {
                    if (Json1.getJSONArray("list").getJSONObject(j).getString("id").equals(jsonHotWord.getJSONObject(i).getString("site"))) {
                        jsonHotWord.getJSONObject(i).put("siteName", Json1.getJSONArray("list").getJSONObject(j).getString("name"));
                        messageBody1.put("siteId", Json1.getJSONArray("list").getJSONObject(j).getString("id"));
                        try {
                            signatureJson1 = SignatureHandler
                                    .sign(messageBody1, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
                        } catch (Exception e) {
                            logger.error("签名处理失败", e);
                            JSONObject json = new JSONObject();
                            json.put("success", false);
                            json.put("message", "签名处理失败, BLC0132");
                            return json.toJSONString();
                        }
                        try {
                            resultChannel = okHttpOperator.postJsonTextForTextResp(channelAddress, signatureJson1);
                        } catch (IOException e) {
                            logger.error("请求后台服务失败", e);
                            JSONObject json = new JSONObject();
                            json.put("success", false);
                            json.put("message", "请求后台服务失败, BLC0161");
                            return json.toJSONString();
                        }
                        JSONObject Json2 = JSONObject.parseObject(resultChannel);
                        if (Json2.getBoolean("success")) {
                            for (int n = 0; n < Json2.getJSONArray("list").size(); n++) {
                                if (Json2.getJSONArray("list").getJSONObject(n).getString("id").equals(jsonHotWord.getJSONObject(i).getString("channel"))) {
                                    jsonHotWord.getJSONObject(i).put("channelName", Json2.getJSONArray("list").getJSONObject(n).getString("name"));
                                }
                            }
                        }
                    }
                }


            }
            Integer total = (Integer) Json.get("total");
            int pageCount = total % size == 0 ? total / size : (total / size + 1);
            Json.put("pageCount", pageCount);
            Json.put("list", jsonHotWord);
            logger.info("返回的热词列表：" + Json.toString());
            return Json.toString();
        }
    }

    @ResponseBody
    @RequestMapping(value = "/queryListSite", method = {RequestMethod.GET, RequestMethod.POST})
    public String getSiteList(HttpServletRequest request) {
        JSONObject messageBody = new JSONObject();
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0132");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameSite);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameSite, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, BLC0142");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0149");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, BLC0161");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/queryListChannel", method = {RequestMethod.GET, RequestMethod.POST})
    public String getChannelList(HttpServletRequest request, String siteId) {
        JSONObject messageBody = new JSONObject();
        messageBody.put("siteId", siteId);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0132");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameChannel);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameChannel, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, BLC0142");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0149");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, BLC0161");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/deleteHotWord", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteHotWord(HttpServletRequest request, String sid, String site, String channel, String value, String link, String orders, String enabled) {
        JSONObject messageBody = new JSONObject();
        messageBody.put("sid", sid);
        messageBody.put("site", site);
        messageBody.put("channel", channel);
        messageBody.put("value", value);
        messageBody.put("link", link);
        messageBody.put("orders", orders);
        messageBody.put("enabled", enabled);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0132");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameDestroy);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameDestroy, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, BLC0142");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0149");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, BLC0161");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/addHotWord", method = {RequestMethod.GET, RequestMethod.POST})
    public String addHotWord(HttpServletRequest request, String site, String channel, String value, String link, String orders, String enabled) {
        JSONObject messageBody = new JSONObject();
        messageBody.put("site", site);
        messageBody.put("channel", channel);
        messageBody.put("value", value);
        messageBody.put("link", link);
        messageBody.put("orders", orders);
        messageBody.put("enabled", enabled);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0132");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameCreate);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameCreate, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, BLC0142");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0149");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, BLC0161");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/updateHotWord", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateHotWord(HttpServletRequest request, String sid, String site, String channel, String value, String link, String orders, String enabled) {
        JSONObject messageBody = new JSONObject();
        messageBody.put("sid", sid);
        messageBody.put("site", site);
        messageBody.put("channel", channel);
        messageBody.put("value", value);
        messageBody.put("link", link);
        messageBody.put("orders", orders);
        messageBody.put("enabled", enabled);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0132");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameUpdate);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameUpdate, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, BLC0142");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0149");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, BLC0161");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }


    @ResponseBody
    @RequestMapping(value = "/enabledHotWord", method = {RequestMethod.GET, RequestMethod.POST})
    public String enabledHotWord(HttpServletRequest request, String sid, String site, String channel, String value, String link, String orders, String enabled) {
        JSONObject messageBody = new JSONObject();
        messageBody.put("sid", sid);
        messageBody.put("site", site);
        messageBody.put("channel", channel);
        messageBody.put("value", value);
        messageBody.put("link", link);
        messageBody.put("orders", orders);
        messageBody.put("enabled", enabled);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0132");
            return json.toJSONString();
        }
        String resultJson;
        if (enabled.equals("true")) {
            Optional<String> serviceAddress;
            try {
                serviceAddress = serviceProvider.provideServiceAddress(serviceNameDisabled);
            } catch (Exception e) {
                logger.error("获取服务{}地址失败", serviceNameDisabled, e);
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "获取后台服务地址失败, BLC0142");
                return json.toJSONString();
            }
            String address = serviceAddress.orNull();
            if (com.utils.StringUtils.isBlank(address)) {
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "后台无活动的服务节点, BLC0149");
                return json.toJSONString();
            }
            try {
                resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
            } catch (IOException e) {
                logger.error("请求后台服务失败", e);
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "请求后台服务失败, BLC0161");
                return json.toJSONString();
            }
        } else {
            Optional<String> serviceAddress;
            try {
                serviceAddress = serviceProvider.provideServiceAddress(serviceNameEnabled);
            } catch (Exception e) {
                logger.error("获取服务{}地址失败", serviceNameEnabled, e);
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "获取后台服务地址失败, BLC0142");
                return json.toJSONString();
            }
            String address = serviceAddress.orNull();
            if (com.utils.StringUtils.isBlank(address)) {
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "后台无活动的服务节点, BLC0149");
                return json.toJSONString();
            }
            try {
                resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
            } catch (IOException e) {
                logger.error("请求后台服务失败", e);
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "请求后台服务失败, BLC0161");
                return json.toJSONString();
            }
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }


}
