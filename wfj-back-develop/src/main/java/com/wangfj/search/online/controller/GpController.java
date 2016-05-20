package com.wangfj.search.online.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Optional;
import com.utils.StringUtils;
import com.wangfj.search.utils.*;
import com.wfj.search.utils.http.OkHttpOperator;
import com.wfj.search.utils.zookeeper.discovery.SpringWebMvcServiceProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by litao on 2016/5/17.
 */
@Controller
@RequestMapping("/gp")
public class GpController {
    private final Logger logger = LoggerFactory.getLogger(GpController.class);
    @Autowired
    private PrivateRsaKeyProvider privateRsaKeyProvider;
    @Autowired
    private SpringWebMvcServiceProvider serviceProvider;
    @Autowired
    private OkHttpOperator okHttpOperator;
    @Value("${search.caller}")
    private String caller;
    @Value("${search.service.gp.list}")
    private String serviceNameList;
    @Value("${search.service.gp.create}")
    private String serviceNameCreate;
    @Value("${search.service.gp.confirm}")
    private String serviceNameConfirm;
    @Value("${search.gp.urlTemplate}")
    private String searchUrlTemplate;
    /**
     *查询gp
     *
     */
    @RequestMapping("/getGpList")
    @ResponseBody
    public String getGpList(HttpServletRequest request) {
        Integer size = request.getParameter("pageSize") == null ? null
                : Integer.parseInt(request.getParameter("pageSize"));
        if (size == null || size == 0) {
            size = 10;
        }
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        int start = (currPage - 1) * size;
        JSONObject messageBody = new JSONObject();
        messageBody.put("start",start);
        messageBody.put("fetch",size);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(messageBody, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, GC0069");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameList);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameList, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, GC0079");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, GC0086");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (Exception e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, GC096");
            return json.toJSONString();
        }
        JSONObject jsonObject = JSONObject.parseObject(resultJson);
        if (!jsonObject.getBoolean("success")) {
            jsonObject.put("pageCount", 0);
            return jsonObject.toString();
        } else {
            Integer total = jsonObject.getLong("total").intValue();
            int pageCount = total % size == 0 ? total / size : (total / size + 1);
            jsonObject.put("pageCount", pageCount);
            jsonObject.put("urlTemplate",searchUrlTemplate);
            return jsonObject.toString();
        }
    }

    /**
     *
     * 添加gp
     */
    @RequestMapping("add")
    @ResponseBody
    public String add(HttpServletRequest request, String title, String ids){
        String[] itemIds = ids.split("\\n|\\r");
        JSONArray jsonArray = new JSONArray();
        for(String id:itemIds){
            jsonArray.add(id);
        }
        JSONObject jsonrequest = new JSONObject();
        jsonrequest.put("title",title);
        jsonrequest.put("itemsIds",jsonArray);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(jsonrequest, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, GC0135");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameCreate);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameCreate, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, GC0145");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, GC0152");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, GC0162");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }

    /**
     * 确认gp
     */
    @RequestMapping("/confirm")
    @ResponseBody
    public String confirm(HttpServletRequest request, String gp){
        JSONObject jsonrequest = new JSONObject();
        jsonrequest.put("gp",gp);
        String signatureJson;
        try {
            signatureJson = SignatureHandler
                    .sign(jsonrequest, privateRsaKeyProvider.get(), caller, CookieUtil.getUserName(request));
        } catch (Exception e) {
            logger.error("签名处理失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "签名处理失败, GC0185");
            return json.toJSONString();
        }
        Optional<String> serviceAddress;
        try {
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameConfirm);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameConfirm, e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "获取后台服务地址失败, GC0195");
            return json.toJSONString();
        }
        String address = serviceAddress.orNull();
        if (StringUtils.isBlank(address)) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "后台无活动的服务节点, GC0202");
            return json.toJSONString();
        }
        String resultJson;
        try {
            resultJson = okHttpOperator.postJsonTextForTextResp(address, signatureJson);
        } catch (IOException e) {
            logger.error("请求后台服务失败", e);
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "请求后台服务失败, GC0212");
            return json.toJSONString();
        }
        JSONObject Json = JSONObject.parseObject(resultJson);
        return Json.toString();
    }
}
