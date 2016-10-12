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
import java.text.DecimalFormat;
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
            JSONObject jsonObject = resJson.getJSONObject("object");
            JSONArray ja = jsonObject.getJSONArray("list");
            if(ja == null || ja.size() == 0){
                resJson.put("pageCount", 0);
                return resJson.toString();
            }
            int count = jsonObject.getInteger("count");
            int pageCount = count % pageSize == 0 ? count / pageSize : (count / pageSize + 1);
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
        setupComplaintBal= vilStr(setupComplaintBal);
        setupCarriageBal = vilStr(setupCarriageBal);
        map.put("sid",Long.toString(System.currentTimeMillis()));
        map.put("setupComplaintBal", setupComplaintBal);
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

    @RequestMapping("/update")
    @ResponseBody
    public String update(HttpServletRequest request, String sid, String setupComplaintBal, String setupCarriageBal, String year){
        Map<String,String> map = new HashMap<>();
        setupComplaintBal= vilStr(setupComplaintBal);
        setupCarriageBal = vilStr(setupCarriageBal);
        map.put("sid",sid);
        String url = CommonProperties.get("member_ops_url");
        String method = "/setYearBal/getBySid.do";
        String req;
        try {
            req = HttpUtil.HttpPost(url,method, map);
        } catch (Exception e) {
            log.error("以sid查询出错！",e);
            JSONObject errJson = new JSONObject();
            errJson.put("code","0");
            errJson.put("desc", "修改失败！查询出错");
            return errJson.toString();
        }
        JSONObject jsonObject = JSONObject.parseObject(req);
        Map<String,String> mapRequest = new HashMap<>();
        mapRequest.put("sid",sid);
        mapRequest.put("year",year);
        String method2 = "/setYearBal/update.do";
        String req2;
        if(jsonObject.getJSONObject("object") != null){
            JSONObject json = jsonObject.getJSONObject("object");
            String setupComplaintBalOld = json.getString("setupComplaintBal");
//            setupComplaintBalOld= vilStr(setupComplaintBalOld);
            String setupCarriageBalOld = json.getString("setupCarriageBal");
//            setupCarriageBalOld= vilStr(setupCarriageBalOld);
            String usableComplaintBalOld = json.getString("usableComplaintBal");
//            usableComplaintBalOld = vilStr(usableComplaintBalOld);
            String usableCarriageBalOld = json.getString("usableCarriageBal");
//            usableCarriageBalOld = vilStr(usableCarriageBalOld);
            DecimalFormat df = new DecimalFormat("#0.00");
            if(Double.parseDouble(setupComplaintBal) < Double.parseDouble(setupComplaintBalOld)){
                mapRequest.put("setupComplaintBal",setupComplaintBal);
                mapRequest.put("usableComplaintBal",df.format(Double.parseDouble(usableComplaintBalOld) - (Double.parseDouble(setupComplaintBalOld) - Double.parseDouble(setupComplaintBal))));
            }else {
                mapRequest.put("setupComplaintBal",setupComplaintBal);
                mapRequest.put("usableComplaintBal",df.format(Double.parseDouble(usableComplaintBalOld) + (Double.parseDouble(setupComplaintBal) - Double.parseDouble(setupComplaintBalOld))));
            }
            if(Double.parseDouble(setupCarriageBal) < Double.parseDouble(setupCarriageBalOld)){
                mapRequest.put("setupCarriageBal",setupCarriageBal);
                mapRequest.put("usableCarriageBal",df.format(Double.parseDouble(usableCarriageBalOld) - (Double.parseDouble(setupCarriageBalOld) - Double.parseDouble(setupCarriageBal))));
            }else {
                mapRequest.put("setupCarriageBal",setupCarriageBal);
                mapRequest.put("usableCarriageBal",df.format(Double.parseDouble(usableCarriageBalOld) + (Double.parseDouble(setupCarriageBal) - Double.parseDouble(setupCarriageBalOld))));
            }

            try {
                req2 = HttpUtil.HttpPost(url,method2, mapRequest);
            } catch (Exception e) {
                log.error("修改年限制出错！",e);
                JSONObject errJson = new JSONObject();
                errJson.put("code","0");
                errJson.put("desc", "修改失败！");
                return errJson.toString();
            }
            return req2;
        }else {
            JSONObject errJson = new JSONObject();
            errJson.put("code","0");
            errJson.put("desc", "没有改修改记录！");
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
}
