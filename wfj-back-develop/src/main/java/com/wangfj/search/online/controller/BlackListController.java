package com.wangfj.search.online.controller;

import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Optional;
import com.utils.StringUtils;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.search.utils.PrivateRsaKeyProvider;
import com.wangfj.search.utils.SignatureHandler;
import com.wfj.search.utils.http.OkHttpOperator;
import com.wfj.search.utils.zookeeper.discovery.SpringWebMvcServiceProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Objects;

/**
 * 黑名单
 *
 * @author litao / 2015年11月24日
 * @author liufl
 * @since 1.0.0
 */
@Controller
@RequestMapping(value = "/blackList")
public class BlackListController {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private PrivateRsaKeyProvider privateRsaKeyProvider;
    @Autowired
    private SpringWebMvcServiceProvider serviceProvider;
    @Value("${search.caller}")
    private String caller;
    @Value("${search.service.blacklist.read}")
    private String serviceNameRead;
    @Value("${search.service.blacklist.create}")
    private String serviceNameCreate;
    @Value("${search.service.blacklist.delete}")
    private String serviceNameDelete;
    @Autowired
    private OkHttpOperator okHttpOperator;

    @ResponseBody
    @RequestMapping(value = "/getList", method = {RequestMethod.GET, RequestMethod.POST})
    public String getBlackList(HttpServletRequest request, String blackType, String id) {
        Integer size = request.getParameter("pageSize") == null ? null
                : Integer.parseInt(request.getParameter("pageSize"));
        if (size == null || size == 0) {
            size = 10;
        }
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        int start = (currPage - 1) * size;
        JSONObject messageBody = new JSONObject();
        if (blackType != null && !Objects.equals(blackType, "")) {
            messageBody.put("type", blackType);
        }
        if (id != null && !Objects.equals(id, "")) {
            messageBody.put("id", id);
        }
        messageBody.put("limit", size);
        messageBody.put("start", start);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0072");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameRead);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameRead, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, BLC0082");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0089");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (Exception e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, BLC0101");
            return json.toJSONString();
        }
        JSONObject jsonObject = JSONObject.parseObject(resultJson);
        if (!jsonObject.getBoolean("success")) {
            jsonObject.put("pageCount", 0);
            return jsonObject.toString();
        } else {
            Integer total = jsonObject.getInteger("total");
            int pageCount = total % size == 0 ? total / size : (total / size + 1);
            jsonObject.put("pageCount", pageCount);
            return jsonObject.toString();
        }
    }

    @ResponseBody
    @RequestMapping(value = "/addBlackList", method = {RequestMethod.GET, RequestMethod.POST})
    public String addBlackList(HttpServletRequest request, String type, String id) {
        JSONObject messageBody = new JSONObject();
        if (type != null && !Objects.equals(type, "")) {
            messageBody.put("type", type);
        }
        if (id != null && !Objects.equals(id, "")) {
            messageBody.put("id", id);
        }
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
        if (StringUtils.isBlank(address)) {
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
    @RequestMapping(value = "/deleteBlackList", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteBlackList(HttpServletRequest request, String id, String type) {
        JSONObject messageBody = new JSONObject();
        if (type != null && !Objects.equals(type, "")) {
            messageBody.put("type", type);
        }
        if (id != null && !Objects.equals(id, "")) {
            messageBody.put("id", id);
        }
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, BLC0186");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameDelete);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameDelete, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, BLC0196");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, BLC0203");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (Exception e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, BLC0214");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }
}
