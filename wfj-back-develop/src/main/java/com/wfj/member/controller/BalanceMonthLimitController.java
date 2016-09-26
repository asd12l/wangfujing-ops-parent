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
 * Created by litao on 2016/5/25.
 */
@Controller
@RequestMapping("/balanceMonthLimit")
public class BalanceMonthLimitController {
    private static Logger log =  LoggerFactory.getLogger(BalanceYearLimitController.class);

    @RequestMapping("/getList")
    @ResponseBody
    public String getList(HttpServletRequest request, Integer start, Integer pageSize, String year,String _site_id_param){
        log.debug("查询余额年限制，参数start:{}, pageSize:{}, year:{}",start,pageSize,year);
        if (pageSize == null || pageSize == 0) {
            pageSize = 10;
        }
        Integer currPage = Integer.parseInt(request.getParameter("page"));
        start = (currPage - 1) * pageSize;
        JSONObject json = new JSONObject();
        json.put("start", start);
        json.put("pageSize", pageSize);
        if(year != null && !"".equals(year)){
        	json.put("year",year);
        }
        if(_site_id_param != null && !"".equals(_site_id_param)){
        	json.put("year",_site_id_param);
        }
        String url = CommonProperties.get("member_ops_url");
        String method = "/setMonthBal/select.do";
        String req;
        try {
            req = HttpUtil.doPost(url + method, json.toString());
            JSONObject resJson = JSONObject.parseObject(req);
            JSONObject jsonObject=resJson.getJSONObject("object");
            JSONArray ja = jsonObject.getJSONArray("list");
            if(ja == null || ja.size() == 0){
                resJson.put("pageCount", 0);
                return resJson.toString();
            }
            int count=jsonObject.getInteger("count");
            int pageCount=count % pageSize  == 0 ? count /pageSize:count/pageSize+1;
            //int pageCount = ja.size() % pageSize == 0 ? ja.size() / pageSize : (ja.size() / pageSize + 1);
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
    private String vilStr(String str){
        StringBuffer sb = new StringBuffer(str);
        if (str.indexOf(".") != -1){
            String str1 =str.substring(str.indexOf(".")+1, str.length());
            if (str1.length()<2){
                sb.append("0");
                str = sb.toString();

            }
        }else {
            sb.append(".00");
            str = sb.toString();
        }
        return str;
    }
    @RequestMapping("/insert")
    @ResponseBody
    public String insert(HttpServletRequest request, String yearMonth, String setupComplaintBal, String setupCarriageBal){
        Map<String,String> map = new HashMap<>();
        setupComplaintBal= vilStr(setupComplaintBal);
        setupCarriageBal = vilStr(setupCarriageBal);
        map.put("sid", Long.toString(System.currentTimeMillis()));
        map.put("setupComplaintBal", setupComplaintBal);
        map.put("setupCarriageBal",setupCarriageBal);
        map.put("yearMonth",yearMonth);
        String url = CommonProperties.get("member_ops_url");
        String method = "/setMonthBal/insert.do";
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

    @RequestMapping("/update")
    @ResponseBody
    public String update(HttpServletRequest request, String sid, String yearSid, String yearMonth, String setupComplaintBal,
                         String usableMonthcptBal, String usedMonthcptBal, String setupCarriageBal, String usableMonthcrgBal,String usedMonthcrgBal){
        String url = CommonProperties.get("member_ops_url");
        String method = "/setMonthBal/update.do";
        setupComplaintBal= vilStr(setupComplaintBal);
        usableMonthcptBal= vilStr(usableMonthcptBal);
        usedMonthcptBal =vilStr(usedMonthcptBal);
        setupCarriageBal = vilStr(setupCarriageBal);
        usableMonthcrgBal=vilStr(usableMonthcrgBal);
        usedMonthcrgBal =vilStr(usedMonthcrgBal) ;
        String req;
        Map<String,String> mapRequest = new HashMap<>();
        mapRequest.put("sid",sid);
        mapRequest.put("yearSid",yearSid);
        mapRequest.put("yearMonth",yearMonth);
        mapRequest.put("setupComplaintBal",setupComplaintBal);
        mapRequest.put("usableMonthcptBal",usableMonthcptBal);
        mapRequest.put("usedMonthcptBal",usedMonthcptBal);
        mapRequest.put("setupCarriageBal",setupCarriageBal);
        mapRequest.put("usableMonthcrgBal",usableMonthcrgBal);
        mapRequest.put("usedMonthcrgBal",usedMonthcrgBal);
        try {
            req = HttpUtil.HttpPost(url,method, mapRequest);
        } catch (Exception e) {
            log.error("修改月限制出错！",e);
            JSONObject errJson = new JSONObject();
            errJson.put("code","0");
            errJson.put("desc", "修改失败！");
            return errJson.toString();
        }
        return req;

    }
}
