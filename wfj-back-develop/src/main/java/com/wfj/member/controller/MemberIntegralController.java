package com.wfj.member.controller;

import com.google.gson.Gson;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/5/25.
 */
@Controller
@RequestMapping("/memberIntegral")
public class MemberIntegralController {
    private static Logger log =  LoggerFactory.getLogger(MemberAndInfoController.class);

    /**
     * 查询会员积分申请信息
     * @param request
     * @param response
     * @return
     * @author shenjp
     */
    @ResponseBody
    @RequestMapping(value ="/getByMemberIntegral", method = { RequestMethod.POST, RequestMethod.GET })
    public String getByMemberIntegral(HttpServletRequest request,
                                     HttpServletResponse response) {
        log.info("======== getByMemberIntegral in  =========");
        String method = "/memberIntegral/getByMemberIntegral.do";
        Gson gson = new Gson();
        List<Object> list = new ArrayList<Object>();
        String jsonString = gson.toJson(list);
        //获取每页显示多少条数据
        Integer pageSize = 0;
        //获取当前页
        Integer currPage =Integer.parseInt(request.getParameter("page"));;
        pageSize = request.getParameter("pageSize") == null ? null
                : Integer.parseInt(request.getParameter("pageSize"));
        if (pageSize == null || pageSize == 0) {
            pageSize = 10;
        }
        int start = (currPage - 1) * pageSize;
        Map<Object, Object> paraMap = new HashMap<Object, Object>();
        paraMap.put("start", String.valueOf(start));
        paraMap.put("limit", String.valueOf(pageSize));
        paraMap.put("login", request.getParameter("login"));
        paraMap.put("sid", request.getParameter("sid"));
        paraMap.put("order", request.getParameter("order"));
        paraMap.put("applyName",request.getParameter("applyName"));
        paraMap.put("m_timeApStartDate",  request.getParameter("m_timeApStartDate"));
        paraMap.put("m_timeApEndDate",  request.getParameter("m_timeApEndDate"));
        paraMap.put("m_timeChStartDate",  request.getParameter("m_timeChStartDate"));
        paraMap.put("m_timeChEndDate",  request.getParameter("m_timeChEndDate"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== getByMemberIntegral url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== getByMemberIntegral url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }

    /**
     * 添加积分申请
     * @param request
     * @param response
     * @author shenjp
     */
    @ResponseBody
    @RequestMapping(value ="/addMemberIntegral", method = { RequestMethod.POST, RequestMethod.GET })
    public String addMemberIntegral(HttpServletRequest request,
                                      HttpServletResponse response) {
        String jsonString="";
        log.info("======== addMemberIntegral in  =========");
        String method = "/memberIntegral/addMemberIntegral.do";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("loginName", request.getParameter("loginName"));
        paraMap.put("applyName",request.getParameter("applyName"));
        paraMap.put("applyType", request.getParameter("applyType"));
        paraMap.put("sourceType", request.getParameter("sourceType"));
        paraMap.put("orderNo",request.getParameter("orderNo"));
        paraMap.put("applyNo",  request.getParameter("applyNo"));
        paraMap.put("applyReason",  request.getParameter("applyReason"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== addMemberIntegral url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== addMemberIntegral url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success:false}";
        }
        return jsonString;
    }

    /**
     * 编辑积分申请
     * @param request
     * @param response
     * @author shenjp
     */
    @ResponseBody
    @RequestMapping(value ="/editMemberIntegral", method = { RequestMethod.POST, RequestMethod.GET })
    public String editMemberIntegral(HttpServletRequest request,
                                    HttpServletResponse response) {
        String jsonString="";
        log.info("======== addMemberIntegral in  =========");
        String method = "/memberIntegral/editMemberIntegral.do";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("sid", request.getParameter("sid"));
        paraMap.put("applyType", request.getParameter("applyType"));
        paraMap.put("sourceType", request.getParameter("sourceType"));
        paraMap.put("orderNo",request.getParameter("orderNo"));
        paraMap.put("applyNum",  request.getParameter("applyNum"));
        paraMap.put("applyReason",  request.getParameter("applyReason"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== addMemberIntegral url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== addMemberIntegral url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success:false}";
        }
        return jsonString;
    }

    /**
     * 审核积分申请
     * @param request
     * @param response
     * @author By shenjp
     */
    @ResponseBody
    @RequestMapping(value ="/checkMemberIntegral", method = { RequestMethod.POST, RequestMethod.GET })
    public String checkMemberIntegral(HttpServletRequest request,
                                     HttpServletResponse response) {
        String jsonString="";
        log.info("======== checkMemberIntegral in  =========");
        String method = "/memberIntegral/checkMemberIntegral.do";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("sid", request.getParameter("sid"));
        paraMap.put("checkName", request.getParameter("checkName"));
        paraMap.put("checkStatus", request.getParameter("checkStatus"));
        paraMap.put("checkMemo",request.getParameter("checkMemo"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== checkMemberIntegral url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== checkMemberIntegral url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success:false}";
        }
        return jsonString;
    }

    /**
     * 取消积分申请
     * @param request
     * @param response
     * @Author by shenjp
     */
    @ResponseBody
    @RequestMapping(value ="/cancleMemberIntegral", method = { RequestMethod.POST, RequestMethod.GET })
    public String cancleMemberIntegral(HttpServletRequest request,
                                      HttpServletResponse response) {
        String jsonString="";
        log.info("======== cancleMemberIntegral in  =========");
        String method = "/memberIntegral/cancleMemberIntegral.do";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("sid", request.getParameter("sid"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== cancleMemberIntegral url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== cancleMemberIntegral url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success:false}";
        }
        return jsonString;
    }
}
