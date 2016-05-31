package com.wfj.member.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by litao on 2016/5/31.
 */
@Controller
@RequestMapping("/balanceApply")
public class BalanceApplyController {
    private static  Logger logger= LoggerFactory.getLogger(BalanceApplyController.class);

    @RequestMapping("/getList")
    @ResponseBody
    public String getList(HttpServletRequest request,String hidMemberNum, String hidStartApplyTime, String hidEndApplyTime, String hidStartCheckTime,
                          String hidEndCheckTime, String hidMemberAccount, String hidVoucherNum, String hidApplyName, String hidCheckStatus){
        logger.info("======== getList  =========");
        String method = "/balanceApply/getList.do";
        Integer currPage;
        if(StringUtils.isBlank(request.getParameter("page"))){
            currPage = 0;
        }else{
            currPage = Integer.parseInt(request.getParameter("page"));
        }
        int start = (currPage - 1) * 10;
        if(start < 0){
            start = 0;
        }
        Integer pageSize = 10;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        Map<Object, Object> map = new HashMap<>();
        map.put("start",start);
        map.put("pageSize",pageSize);
        if(StringUtils.isNotBlank(hidMemberNum)){
            map.put("memberNum",hidMemberNum);
        }
        if(StringUtils.isNotBlank(hidStartApplyTime)){
            try {
                map.put("startApplyTime",sdf.parse(hidStartApplyTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        if(StringUtils.isNotBlank(hidEndApplyTime)){
            try {
                map.put("endApplyTime",sdf.parse(hidEndApplyTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        if(StringUtils.isNotBlank(hidStartCheckTime)){
            try {
                map.put("startCheckTime",sdf.parse(hidStartCheckTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        if(StringUtils.isNotBlank(hidEndCheckTime)){
            try {
                map.put("endCheckTime",sdf.parse(hidEndCheckTime));
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        if(StringUtils.isNotBlank(hidMemberAccount)){
            map.put("memberAccount",hidMemberAccount);
        }
        if(StringUtils.isNotBlank(hidVoucherNum)){
            map.put("voucherNum",hidVoucherNum);
        }
        if(StringUtils.isNotBlank(hidApplyName)){
            map.put("applyName",hidApplyName);
        }
        if(StringUtils.isNotBlank(hidCheckStatus)){
            map.put("checkStatus",hidCheckStatus);
        }
        String reqJsonString;
        try {
            String url = CommonProperties.get("member_ops_url");
            logger.info("======== getList url "+url+"  =========");
            reqJsonString = HttpUtil.doPost(url + method, net.sf.json.JSONObject.fromObject(map).toString());
            JSONObject json = JSONObject.parseObject(reqJsonString);
            JSONArray ja = json.getJSONArray("object");
            if(ja == null || ja.size() == 0){
                json.put("pageCount", 0);
                return json.toString();
            }
            int pageCount = ja.size() % 10 == 0 ? ja.size() / 10 : (ja.size() / 10 + 1);
            json.put("pageCount", pageCount);
            return json.toString();
        } catch (Exception e) {
            JSONObject json = new JSONObject();
            json.put("code", "0");
            reqJsonString = json.toString();
            return reqJsonString;
        }

    }
}
