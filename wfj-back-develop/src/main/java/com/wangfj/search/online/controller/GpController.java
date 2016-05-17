package com.wangfj.search.online.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wangfj.search.utils.*;
import com.wfj.platform.util.signature.handler.PrivateSignatureHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URISyntaxException;

/**
 * Created by litao on 2016/5/17.
 */
@Controller
@RequestMapping("/gp")
public class GpController {
    private final Logger logger = LoggerFactory.getLogger(GpController.class);
    @Autowired
    private RsaResource rsaResource;
    @Autowired
    private PrivateSignatureHandler privateSignatureHandler;
    @Autowired
    private GpConfig gpConfig;

    @RequestMapping("/getGpList")
    @ResponseBody
    public JSONObject getGpList(HttpServletRequest request) {
        privateSignatureHandler.setPrivateKeyString(rsaResource.get());
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
        String signatureJson = null;
        signatureJson = privateSignatureHandler.sign(messageBody,CookieUtil.getUserName(request));
        String resultJson = null;
        try {
            resultJson = HttpRequester.httpPostString(gpConfig.getGpPath() + gpConfig.getGpGetList(),
                    signatureJson);
            logger.debug("gp列表{}", resultJson);
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        } catch (HttpRequestException e) {
            logger.error(e.getMessage(),e);
        } catch (URISyntaxException e) {
            logger.error(e.getMessage(),e);
        }
        int total = 0;
        JSONObject json = JSONObject.parseObject(resultJson);
        if(json.getBoolean("success")){
            total = json.getLong("total").intValue();
        }
        int pageCount = total % size == 0 ? total / size : (total / size + 1);
        json.put("pageCount",pageCount);
        json.put("urlTemplate",gpConfig.getGpUrlTemplate());
        return json;
    }
    @RequestMapping("add")
    @ResponseBody
    public String add(HttpServletRequest request, String title, String itemsIds){
        String[] ids = itemsIds.split(",");
        JSONArray jsonArray = new JSONArray();
        for(String id:ids){
            jsonArray.add(id);
        }
        JSONObject jsonrequest = new JSONObject();
        jsonrequest.put("title",title);
        jsonrequest.put("itemsIds",jsonArray);
        String signatureJson = null;
        signatureJson = privateSignatureHandler.sign(jsonrequest,CookieUtil.getUserName(request));
        return signatureJson;
    }
}
