package com.wfj.member.controller;

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
    public String getBalanceRecord(HttpServletRequest request, String hidAccount, String hidPhone, String hidEmail, String hidStartTime, String hidEndTime) {
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
        String reqJsonString;
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
