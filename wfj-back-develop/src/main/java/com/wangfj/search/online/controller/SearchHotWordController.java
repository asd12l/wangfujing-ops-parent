package com.wangfj.search.online.controller;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.google.common.base.Optional;
import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
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
 * @author litao / 2015年12月22日
 * @author liufl
 * @since 1.0.0
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
        if (StringUtils.isNotBlank(hotWordSite)) {
            messageBody.put("site", hotWordSite);
        }
        if (StringUtils.isNotBlank(hotWordChannel)) {
            messageBody.put("channel", hotWordChannel);
        }
        messageBody.put("limit", size);
        messageBody.put("start", start);

        //签名验证
        String signatureJson; // 列表，响应中站点/频道只有ID没有名称
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, SHWC0091");
            return json.toJSONString();
        }
        String signatureJsonBaseData; // 站点/频道
        JSONObject messageBodyBaseData = new JSONObject();
        try {
            signatureJsonBaseData = SignatureHandler
                    .sign(messageBodyBaseData, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, SHWC0102");
            return json.toJSONString();
        }

        //服务发现
        Optional<String> serviceAddressSite;
        Optional<String> serviceAddressRead;
        Optional<String> serviceAddressChannel;
        try {
            serviceAddressSite = serviceProvider.provideServiceAddress(serviceNameSite);
            serviceAddressRead = serviceProvider.provideServiceAddress(serviceNameRead);
            serviceAddressChannel = serviceProvider.provideServiceAddress(serviceNameChannel);
        } catch (Exception e) {
            logger.error("获取服务地址失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, SHWC0118");
            return json.toJSONString();
        }
        String siteAddress = serviceAddressSite.orNull();
        String readAddress = serviceAddressRead.orNull();
        String channelAddress = serviceAddressChannel.orNull();
        if (com.utils.StringUtils.isBlank(siteAddress)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, SHWC0127");
            return json.toJSONString();
        }
        if (com.utils.StringUtils.isBlank(readAddress)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, SHWC0133");
            return json.toJSONString();
        }
        if (com.utils.StringUtils.isBlank(channelAddress)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, SHWC0139");
            return json.toJSONString();
        }

        String allSiteJsonStr;
        String allChannelJsonStr;
        String resultJsonStr;
        try {
            resultJsonStr = okHttpOperator.postJsonTextForTextResp(readAddress, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, SHWC0152");
            return json.toJSONString();
        }
        try {
            allSiteJsonStr = okHttpOperator.postJsonTextForTextResp(siteAddress, signatureJsonBaseData);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, SHWC0161");
            return json.toJSONString();
        }

        JSONObject resultJson = JSONObject.parseObject(resultJsonStr);
        if (!resultJson.getBoolean("success")) {
            resultJson.put("pageCount", 0);
            return resultJson.toString();
        } else {
            JSONObject allAvailableSiteJson = JSONObject.parseObject(allSiteJsonStr);
            JSONArray allAvailableSiteList = allAvailableSiteJson.getJSONArray("list");
            int allAvailableSiteCount = allAvailableSiteList.size();
            Map<String, String> siteMap = Maps.newHashMapWithExpectedSize(allAvailableSiteCount);
            for (int i = 0; i < allAvailableSiteCount; i++) {
                JSONObject siteJson = allAvailableSiteList.getJSONObject(i);
                siteMap.put(siteJson.getString("id"), siteJson.getString("name"));
            }
            JSONArray hotWordJsonArray = resultJson.getJSONArray("list");
            int resultSize = hotWordJsonArray.size();
            Set<String> resultSites = Sets.newHashSet();
            for (int i = 0; i < resultSize; i++) {
                JSONObject hotWordJson = hotWordJsonArray.getJSONObject(i);
                String siteId = hotWordJson.getString("site");
                resultSites.add(siteId);
                hotWordJson.put("siteName", siteMap.get(siteId));
            }
            for (String siteId : resultSites) {
                messageBodyBaseData.put("siteId", siteId);
                try {
                    signatureJsonBaseData = SignatureHandler
                            .sign(messageBodyBaseData, privateRsaKeyProvider.get(), caller,
                                    CookieUtil.getUserName(request));
                } catch (Exception e) {
                    logger.error("签名处理失败", e);
                    JSONObject json = new JSONObject();
                    json.put("success", false);
                    json.put("message", "签名处理失败, SHWC0201");
                    return json.toJSONString();
                }
                try {
                    allChannelJsonStr = okHttpOperator
                            .postJsonTextForTextResp(channelAddress, signatureJsonBaseData);
                } catch (IOException e) {
                    logger.error("请求后台服务失败", e);
                    JSONObject json = new JSONObject();
                    json.put("success", false);
                    json.put("message", "请求后台服务失败, SHWC0211");
                    return json.toJSONString();
                }
                JSONObject availableChannelJson = JSONObject.parseObject(allChannelJsonStr);
                if (availableChannelJson.getBoolean("success")) {
                    JSONArray availableChannelJSONArray = availableChannelJson.getJSONArray("list");
                    int channelsCount = availableChannelJSONArray.size();
                    Map<String, String> channelMap = Maps.newHashMap();
                    for (int n = 0; n < channelsCount; n++) {
                        JSONObject channelJson = availableChannelJSONArray.getJSONObject(n);
                        channelMap.put(channelJson.getString("id"), channelJson.getString("name"));
                    }
                    for (int i = 0; i < resultSize; i++) {
                        JSONObject hotWordJson = hotWordJsonArray.getJSONObject(i);
                        if (hotWordJson.getString("site").equals(siteId)) {
                            hotWordJson.put("channelName", channelMap.get(hotWordJson.getString("channel")));
                        }
                    }
                }
            }
            Integer total = (Integer) resultJson.get("total");
            int pageCount = total % size == 0 ? total / size : (total / size + 1);
            resultJson.put("pageCount", pageCount);
            resultJson.put("list", hotWordJsonArray);
            logger.info("返回的热词列表：" + resultJson.toString());
            return resultJson.toString();
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
            json.put("message", "签名处理失败, SHWC0252");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameSite);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameSite, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, SHWC0262");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, SHWC0269");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, SHWC0279");
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
            json.put("message", "签名处理失败, SHWC0299");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameChannel);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameChannel, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, SHWC0309");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, SHWC0316");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, SHWC0326");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/deleteHotWord", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteHotWord(HttpServletRequest request, String sid, String site, String channel, String value,
            String link, String orders, String enabled) {
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
            json.put("message", "签名处理失败, SHWC0353");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameDestroy);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameDestroy, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, SHWC0363");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, SHWC0370");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, SHWC0380");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/addHotWord", method = {RequestMethod.GET, RequestMethod.POST})
    public String addHotWord(HttpServletRequest request, String site, String channel, String value, String link,
            String orders, String enabled) {
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
            json.put("message", "签名处理失败, SHWC0406");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameCreate);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameCreate, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, SHWC0416");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, SHWC0423");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, SHWC0433");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }

    @ResponseBody
    @RequestMapping(value = "/updateHotWord", method = {RequestMethod.GET, RequestMethod.POST})
    public String updateHotWord(HttpServletRequest request, String sid, String site, String channel, String value,
            String link, String orders, String enabled) {
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
            json.put("message", "签名处理失败, SHWC0460");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameUpdate);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameUpdate, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, SHWC0470");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (com.utils.StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, SHWC0477");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, SHWC0487");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }


    @ResponseBody
    @RequestMapping(value = "/enabledHotWord", method = {RequestMethod.GET, RequestMethod.POST})
    public String enabledHotWord(HttpServletRequest request, String sid, String site, String channel, String value,
            String link, String orders, String enabled) {
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
            json.put("message", "签名处理失败, SHWC0515");
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
                json.put("message", "获取后台服务地址失败, SHWC0527");
                return json.toJSONString();
            }
            String address = serviceAddress.orNull();
            if (com.utils.StringUtils.isBlank(address)) {
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "后台无活动的服务节点, SHWC0534");
                return json.toJSONString();
            }
            try {
                resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
            } catch (IOException e) {
                logger.error("请求后台服务失败", e);
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "请求后台服务失败, SHWC0543");
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
                json.put("message", "获取后台服务地址失败, SHWC0554");
                return json.toJSONString();
            }
            String address = serviceAddress.orNull();
            if (com.utils.StringUtils.isBlank(address)) {
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "后台无活动的服务节点, SHWC0561");
                return json.toJSONString();
            }
            try {
                resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
            } catch (IOException e) {
                logger.error("请求后台服务失败", e);
                JSONObject json = new JSONObject();
                json.put("success", false);
                json.put("message", "请求后台服务失败, SHWC0570");
                return json.toJSONString();
            }
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }
}
