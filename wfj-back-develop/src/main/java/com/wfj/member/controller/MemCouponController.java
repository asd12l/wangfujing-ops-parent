package com.wfj.member.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;

/**
 * Created by Qihl on 2016/07/12.
 * 优惠券相关
 */
@Controller
@RequestMapping("/memCoupon")
public class MemCouponController {
//    1、查询优惠券
//    2、优惠券使用情况
	private static Logger logger = LoggerFactory.getLogger(MemCouponController.class);
	@ResponseBody
	@RequestMapping(value ="/getMemCoupon", method = { RequestMethod.POST, RequestMethod.GET })
	public String getMemCoupon(HttpServletRequest request, 
			HttpServletResponse response){
		logger.info("============getMemCoupon in================");
		String method = "/memberCoupon/getMemberCoupon.do";
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
            logger.info("======== getMemberCoupon url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== getByMemberIntegral url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }
		
}
