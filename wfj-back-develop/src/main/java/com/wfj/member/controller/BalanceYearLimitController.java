package com.wfj.member.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by litao on 2016/5/23.
 */
@Controller
@RequestMapping("/balanceYearLimit")
public class BalanceYearLimitController {
    private static Logger log =  LoggerFactory.getLogger(BalanceYearLimitController.class);

    @RequestMapping("/getList")
    @ResponseBody
    public String getList(HttpServletRequest request, Integer start, Integer pageSize){
        log.debug("查询余额年限制，参数start:{}, pageSize:{}",start,pageSize);
        if (pageSize == null || pageSize == 0) {
            pageSize = 10;
        }
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        start = (currPage - 1) * pageSize;
        JSONObject json = new JSONObject();
        json.put("start", start);
        json.put("pageSize", pageSize);
        String url = CommonProperties.get("member_ops_url");
        String method = "/setYearBal/getList.do";
        String req;
        try {
            req = HttpUtil.doPost(url + method, json.toString());
            JSONObject resJson = JSONObject.parseObject(req);
            JSONArray ja = resJson.getJSONArray("object");
            if(ja == null || ja.size() == 0){
                resJson.put("pageCount", 0);
                return resJson.toString();
            }
            int pageCount = ja.size() % pageSize == 0 ? ja.size() / pageSize : (ja.size() / pageSize + 1);
            resJson.put("pageCount", pageCount);
            return resJson.toString();
        } catch (Exception e) {
            log.error("查询出错！", e);
            JSONObject errJson = new JSONObject();
            errJson.put("code","0");
            errJson.put("desc","查询出错！");
            return errJson.toString();
        }
    }

    @RequestMapping("/insert")
    @ResponseBody
    public String insert(HttpServletRequest request, String setupComplaintBal, String setupCarriageBal, String year){
        Map<String,String> map = new HashMap<>();
        map.put("sid",Long.toString(System.currentTimeMillis()));
        map.put("setupComplaintBal",setupComplaintBal);
        map.put("usableComplaintBal",setupComplaintBal);
        map.put("setupCarriageBal",setupCarriageBal);
        map.put("usableCarriageBal",setupCarriageBal);
        map.put("year",year);
        String url = CommonProperties.get("member_ops_url");
        String method = "/setYearBal/insert.do";
        String req;
        try {
            req = HttpUtil.HttpPost(url,method, map);
            return req;
        } catch (Exception e) {
            log.error("添加失败",e);
            JSONObject errJson = new JSONObject();
            errJson.put("code","0");
            errJson.put("desc", "添加失败！");
            return errJson.toString();
        }
    }
}
