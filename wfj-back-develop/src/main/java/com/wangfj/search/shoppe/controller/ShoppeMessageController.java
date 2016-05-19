package com.wangfj.search.shoppe.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;

/**
 * @Class Name ShoppeMessageController
 * @Author litao
 * @Create In 2015年12月15日
 */
@Controller
@RequestMapping(value = "/shoppe")
public class ShoppeMessageController {
    private final Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    private PrivateRsaKeyProvider privateRsaKeyProvider;
    @Autowired
    private SpringWebMvcServiceProvider serviceProvider;
    @Autowired
    private OkHttpOperator okHttpOperator;
    @Value("${search.caller}")
    private String caller;
    @Value("${search.service.shoppeIndex.brandUpdate}")
    private String serviceNameBrandUpdate;
    @Value("${search.service.shoppeIndex.freshIndex}")
    private String serviceNameFreshIndex;
    @Value("${search.service.shoppeIndex.itemIndex}")
    private String serviceNameItemIndex;
    @Value("${search.service.shoppeIndex.allErpIndex}")
    private String serviceNameAllErpIndex;
    @Value("${search.service.shpooeIndex.updateItemByParam}")
    private String serviceNameUpdateItemByParam;

    /**
     * 品牌信息修改
     */
    @ResponseBody
    @RequestMapping(value = "/brand_Update", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String updateBrand(HttpServletRequest request, String storeCode, String storeBrandCode) {
        JSONObject messageBody = new JSONObject();
        messageBody.put("storeCode", storeCode);
        messageBody.put("storeBrandCode", storeBrandCode);
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
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameBrandUpdate);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameBrandUpdate, e);
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

    /**
     * 根据条件刷新索引
     */
    @ResponseBody
    @RequestMapping(value = "/freshIndex", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String freshIndex(HttpServletRequest request, String storeCode, String shoppeCode, String spuCode, String skuCode, String storeBrandCode) {
        JSONObject messageBody = new JSONObject();
        messageBody.put("storeCode", storeCode);
        messageBody.put("storeBrandCode", storeBrandCode);
        messageBody.put("shoppeCode", shoppeCode);
        messageBody.put("spuCode", spuCode);
        messageBody.put("skuCode", skuCode);

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
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameUpdateItemByParam);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameUpdateItemByParam, e);
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

    /**
     * 专柜商品刷新索引
     */
    @ResponseBody
    @RequestMapping(value = "/itemIndex", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String itemIndex(HttpServletRequest request, String itemCode) {
        JSONObject messageBody = new JSONObject();
        messageBody.put("itemCode", itemCode);

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
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameItemIndex);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameItemIndex, e);
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


    /**
     * 全量刷新索引
     */
    @ResponseBody
    @RequestMapping(value = "/allFresh", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String allIndex(HttpServletRequest request) {
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
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameFreshIndex);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameFreshIndex, e);
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

    /**
     * 全量刷新大码商品
     */
    @ResponseBody
    @RequestMapping(value = "/allFreshERP", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String allERPIndex(HttpServletRequest request) {
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
            serviceAddress = serviceProvider.provideServiceAddress(serviceNameAllErpIndex);
        } catch (Exception e) {
            logger.error("获取服务{}地址失败", serviceNameAllErpIndex, e);
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

}
