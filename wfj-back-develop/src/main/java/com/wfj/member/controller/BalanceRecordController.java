package com.wfj.member.controller;

import com.alibaba.fastjson.JSONObject;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by litao on 2016/6/6.
 */
@Controller
@RequestMapping("/balanceRecord")
public class BalanceRecordController {
    private static Logger logger= LoggerFactory.getLogger(BalanceRecordController.class);

    @RequestMapping("/get")
    @ResponseBody
    public String getBalanceRecord(HttpServletRequest request, String hidAccount, String hidPhone, String hidEmail, String hidStartTime, String hidEndTime, String groupId) {
        logger.info("======== get  =========");
        String method = "/balanceRecord/get.do";
        Integer currPage;
        if(StringUtils.isBlank(request.getParameter("page"))){
            currPage = 1;
        }else{
            currPage = Integer.parseInt(request.getParameter("page"));
        }
        Integer pageSize = 10;
        Map<Object,Object> map = new HashMap<>();
        map.put("account",hidAccount);
        map.put("phone",hidPhone);
        map.put("email",hidEmail);
        map.put("startTime",hidStartTime);
        map.put("endTime",hidEndTime);
        map.put("page_no", currPage);
        map.put("page_size", pageSize);
        map.put("group_id",groupId);
        String reqJsonString;
        //屏显规则
        String json1 = "";
        String sysValue = "";
        String username = CookiesUtil.getCookies(request, "username");
        Map<Object, Object> paramMap = new HashMap<Object, Object>();
        paramMap.put("keys", "memberInfo");
        paramMap.put("username", username);
        try {
            logger.info("paramMap:" + paramMap);
            json1 = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
            if(!StringUtils.isEmpty(json1)){
                net.sf.json.JSONObject jsonObject = net.sf.json.JSONObject.fromObject(json1);
                String isTrue = jsonObject.getString("success");
                if(isTrue.equals("true")){
                    net.sf.json.JSONArray jsonArray = jsonObject.getJSONArray("data");
                    sysValue = jsonArray.getJSONObject(0).getString("sysValue");
                }
            }
        } catch (Exception e) {
            logger.error("查询屏显规则异常！返回结果json="+json1);
        }
        map.put("mask",sysValue);
        try {
            String url = CommonProperties.get("member_ops_url");
            logger.info("======== update url "+url+"  =========");
            reqJsonString = HttpUtil.doPost(url + method, net.sf.json.JSONObject.fromObject(map).toString());
            JSONObject jsonObject = JSONObject.parseObject(reqJsonString);
            jsonObject.put("pageCount", jsonObject.getJSONObject("object").getInteger("pageCount"));
            return jsonObject.toString();

        } catch (Exception e) {
            JSONObject json = new JSONObject();
            json.put("code", "0");
            json.put("desc","查询出错！");
            reqJsonString = json.toString();
            return reqJsonString;
        }
    }
}
