package com.wfj.member.controller;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.back.entity.po.SysConfig;
import com.wangfj.back.service.ISysConfigService;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
 * 会员基本信息展示
 * Created by shenjp on 2016/6/6.
 */
@Controller
@RequestMapping("/memBasic")
public class MemberBasicController {
	@Autowired
	private ISysConfigService isysConfigService;
	 
    private static org.slf4j.Logger log =  LoggerFactory.getLogger(MemberBasicController.class);
    @Autowired
    private ISysConfigService sysConfigService;

    /**
     * 解除黑名单
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/relieveBlackList", method = { RequestMethod.POST, RequestMethod.GET })
    public String relieveBlackList(HttpServletRequest request,
                                HttpServletResponse response) {
        log.info("======== relieveBlackList in  =========");
        String method = "/memBasic/relieveBlackList.do";
        String jsonString="";
        Map<String, String> paraMap = new HashMap<String, String>();
        paraMap.put("sid", request.getParameter("sid"));
        paraMap.put("relServiceId", request.getParameter("relServiceId"));
        paraMap.put("relieveReason", request.getParameter("relieveReason"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== relieveBlackList url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== relieveBlackList url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }
    
    
    
    /**
     * 编辑黑名单
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/editBlackList", method = { RequestMethod.POST, RequestMethod.GET })
    public String editBlackList(HttpServletRequest request,
                               HttpServletResponse response) {
        log.info("======== editBlackList in  =========");
        String method = "/memBasic/editBlackList.do";
        String jsonString="";
        Map<String, String> paraMap = new HashMap<String, String>();
        paraMap.put("sid", request.getParameter("sid"));
        paraMap.put("pullType", request.getParameter("pullType"));
        paraMap.put("pullReason", request.getParameter("pullReason"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== editBlackList url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== editBlackList url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
        	log.error(this.getClass()+" :"+method+e.getMessage());
            jsonString = "{success :false}";
        }
        return jsonString;
    }
    @ResponseBody
    @RequestMapping(value ="/getUserName", method = { RequestMethod.POST, RequestMethod.GET })
    public String getUserName(HttpServletRequest request,
            HttpServletResponse response){
    	String userName=CookiesUtil.getCookies(request, "username");
			return userName;
    	
    }
    
    /**
     * 查询黑名单
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/getBlackList", method = { RequestMethod.POST, RequestMethod.GET })
    public String getBlackList(HttpServletRequest request,
                                      HttpServletResponse response) {
        log.info("======== getBlackList in  =========");
        String method = "/memBasic/getBlackList.do";
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
        //屏显规则
        String json = "";
        String sysValue = "";
        String username = CookiesUtil.getCookies(request, "username");
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("keys", "memberInfo");
		paramMap.put("username", username);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			log.info("paramMap:" + paramMap);
			json = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
			if(!StringUtils.isEmpty(json)){
				JSONObject jsonObject = JSONObject.fromObject(json);
				String isTrue = jsonObject.getString("success");
				if(isTrue.equals("true")){
				JSONArray jsonArray = jsonObject.getJSONArray("data");
				sysValue = jsonArray.getJSONObject(0).getString("sysValue");
				}
			}
		} catch (Exception e) {
			log.error("查询屏显规则异常！返回结果json="+json);
		}
        int start = (currPage - 1) * pageSize;
        Map<Object, Object> paraMap = new HashMap<Object, Object>();
        paraMap.put("start", String.valueOf(start));
        paraMap.put("limit", String.valueOf(pageSize));
        paraMap.put("pullId", request.getParameter("pullId"));
        paraMap.put("backId", request.getParameter("backId"));
        paraMap.put("cid", request.getParameter("cid"));
        paraMap.put("listtype", request.getParameter("listtype"));
        paraMap.put("m_timePullStartDate",  request.getParameter("m_timePullStartDate"));
        paraMap.put("m_timePullEndDate",  request.getParameter("m_timePullEndDate"));
        paraMap.put("m_timeBackStartDate",  request.getParameter("m_timeBackStartDate"));
        paraMap.put("m_timeBackEndDate",  request.getParameter("m_timeBackEndDate"));
        paraMap.put("mask", sysValue);
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== getBlackList url "+url+"  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== getBlackList url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }
    /**
     * 将会员拉黑
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/pullBlackList", method = { RequestMethod.POST, RequestMethod.GET })
    public String pullBlackList(HttpServletRequest request,
                                     HttpServletResponse response) {
        log.info("======== pullBlackList in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memBasic/pullBlackList.do";
        String jsonString="";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("cid", request.getParameter("cid"));
        paraMap.put("serviceId",request.getParameter("serviceId"));
        paraMap.put("pullType",request.getParameter("pullType"));
        paraMap.put("pullReason",request.getParameter("pullReason"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== pullBlackList url " + url + "  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== pullBlackList url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }
    /**
     * 展示会员基本信息
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/getMemBasicInfo", method = { RequestMethod.POST, RequestMethod.GET })
    public String getMemBasicInfo(HttpServletRequest request,
                                      HttpServletResponse response) {
        log.info("======== getMemBasicInfo in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memBasic/getMemBasicInfo.do";
        String jsonString="";
        //获取每页显示多少条数据
        Integer pageSize = 0;
        //获取当前页
        Integer currPage =Integer.parseInt(request.getParameter("page"));
        pageSize = request.getParameter("pageSize") == null ? null
                : Integer.parseInt(request.getParameter("pageSize"));
        if (pageSize == null || pageSize == 0) {
            pageSize = 10; 
        }
           
        log.info("member getMemBasicInfo的请求参数:cid:"+request.getParameter("cid")+",belongStore:"
        		+request.getParameter("belongStore")+",mobile:"+request.getParameter("mobile")+
        		",idType:"+request.getParameter("idType")+",identityNo:"+request.getParameter("identityNo")
        		+",email:"+request.getParameter("email")+",timeStartDate:"+request.getParameter("timeStartDate")
        		+",timeEndDate:"+request.getParameter("timeEndDate")+",memberLevel:"+request.getParameter("memberLevel"));
        
        Map<String, Object> paraMap = new HashMap<String, Object>();
        
        /*//获取value值0或1,1隐藏，0不隐藏
			List<String> paramKeys = new ArrayList<String>();
			paramKeys.add("memberInfo");
			List<SysConfig> list = isysConfigService.selectByKeys(paramKeys);
			String value="";
			for (int i = 0; i < list.size(); i++) {
			 value=list.get(i).getSysValue();
			}*/
		 	//屏显
		        String json = "";
		        String sysValue = "";
		        String username = CookiesUtil.getCookies(request, "username");
				Map<Object, Object> paramMap = new HashMap<Object, Object>();
				paramMap.put("keys", "memberInfo");
				paramMap.put("username", username);
			try {
				log.info("paramMap:" + paramMap);
				json = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
				if(!StringUtils.isEmpty(json)){
					JSONObject jsonObject = JSONObject.fromObject(json);
					String isTrue = jsonObject.getString("success");
					if(isTrue.equals("true")){
					JSONArray jsonArray = jsonObject.getJSONArray("data");
					sysValue = jsonArray.getJSONObject(0).getString("sysValue");
					}
				}
			} catch (Exception e) {
				log.error("查询屏显规则异常！返回结果json="+json);
			}
		
		paraMap.put("mask", sysValue);	
        paraMap.put("currPage", String.valueOf(currPage));
        paraMap.put("pageSize", String.valueOf(pageSize));
        paraMap.put("cid", request.getParameter("cid"));
        paraMap.put("belongStore", request.getParameter("belongStore"));
        paraMap.put("mobile", request.getParameter("mobile"));
        paraMap.put("idType",request.getParameter("idType"));
        paraMap.put("identityNo",request.getParameter("identityNo"));
        paraMap.put("email",request.getParameter("email"));
        //注册时间
        paraMap.put("timeStartDate", request.getParameter("timeStartDate"));
        paraMap.put("timeEndDate", request.getParameter("timeEndDate"));
        //会员等级
        paraMap.put("memberLevel", request.getParameter("memberLevel"));
        
        
        
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== getMemBasicInfo url " + url + "  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== getMemBasicInfo url "+url+ method+"  =========");
            String resJson = HttpUtil.HttpPost(url, method, paraMap);
            JSONObject resJsonObj= JSONObject.fromObject(resJson);
            String code=resJsonObj.getString("code");
            if(code==null||!"0".equals(code)){
                jsonString="{success :false}";
            }else{
                jsonString=resJsonObj.getJSONObject("object").toString();
            }
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }

    /**
     * 将支付密码重置的验证码发送到用户手机
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/sendPayCodeToPhone", method = { RequestMethod.POST, RequestMethod.GET })
    public String sendPayCodeToPhone(HttpServletRequest request,
                                      HttpServletResponse response) {
        log.info("======== sendPayCodeToPhone in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memBasic/sendPayCodeToPhone.do";
        String jsonString="";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("mobile", request.getParameter("pay_mobile"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== sendPayCodeToPhone url " + url + "  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== sendPayCodeToPhone url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }

    /**
     * 将重置后的支付密码发送到用户手机
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/sendPayPwdToPhone", method = { RequestMethod.POST, RequestMethod.GET })
    public String sendPayPwdToPhone(HttpServletRequest request,
                                     HttpServletResponse response) {
        log.info("======== sendPayPwdToPhone in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memBasic/sendPayPwdToPhone.do";
        String jsonString="";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("mobile", request.getParameter("pay_mobile"));
        paraMap.put("cid",request.getParameter("cid"));
        
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== sendPayPwdToPhone url " + url + "  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== sendPayPwdToPhone url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }

    /**
     * 将重置登录密码的验证码发送至邮箱
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/sendCodeToEmail", method = { RequestMethod.POST, RequestMethod.GET })
    public String sendCodeToEmail(HttpServletRequest request,
                                     HttpServletResponse response) {
        log.info("======== sendCodeToEmail in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memBasic/sendCodeToEmail.do";
        String jsonString="";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("email", request.getParameter("email"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== sendCodeToEmail url " + url + "  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== sendCodeToEmail url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }

    /**
     * 将登录密码重置的验证码发送到用户手机
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/sendLoginCodeToPhone", method = { RequestMethod.POST, RequestMethod.GET })
    public String sendLoginCodeToPhone(HttpServletRequest request,
                                     HttpServletResponse response) {
        log.info("======== sendLoginCodeToPhone in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memBasic/sendPayCodeToPhone.do";
        String jsonString="";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("mobile", request.getParameter("pay_mobile"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== sendLoginCodeToPhone url " + url + "  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== sendLoginCodeToPhone url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }

    /**
     * 将重置后的登录密码发送至用户手机或邮箱
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/sendLoginPwd", method = { RequestMethod.POST, RequestMethod.GET })
    public String sendLoginPwd(HttpServletRequest request,
                                    HttpServletResponse response) {
        log.info("======== sendLoginPwd in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memBasic/sendLoginPwd.do";
        String jsonString="";
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("mobile", request.getParameter("mobile"));
        paraMap.put("email",request.getParameter("email"));
        paraMap.put("loginStatus",request.getParameter("loginStatus"));
        paraMap.put("cid",request.getParameter("cid"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== sendLoginPwd url " + url + "  =========");
            System.err.println("============== member_ops_url:" + url);
            System.err.println("=============method:"+method);
            System.err.println("======== sendLoginPwd url "+url+ method+"  =========");
            jsonString = HttpUtil.HttpPost(url, method, paraMap);
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }

    /**
     * 查询会员购买记录
     * @param request
     * @param response
     * @return
     */
    @ResponseBody
    @RequestMapping(value ="/getMemPurchase", method = { RequestMethod.POST, RequestMethod.GET })
    public String getMemPurchase(HttpServletRequest request,
                               HttpServletResponse response) {
        log.info("======== getMemPurchase in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memRecord/getMemPurchase.do";
        String jsonString="";
        String json = "";
        String sysValue = "";
        String username = CookiesUtil.getCookies(request, "username");
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("keys", "memberInfo");
		paramMap.put("username", username);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			log.info("paramMap:" + paramMap);
			json = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
			if(!StringUtils.isEmpty(json)){
				JSONObject jsonObject = JSONObject.fromObject(json);
				String isTrue = jsonObject.getString("success");
				if(isTrue.equals("true")){
				JSONArray jsonArray = jsonObject.getJSONArray("data");
				sysValue = jsonArray.getJSONObject(0).getString("sysValue");
				}
			}
		} catch (Exception e) {
			log.error("查询屏显规则异常！返回结果json="+json);
		}
        //获取每页显示多少条数据
        Integer pageSize = 0;
        //获取当前页
        Integer currPage =Integer.parseInt(request.getParameter("page"));
        pageSize = request.getParameter("pageSize") == null ? null
                : Integer.parseInt(request.getParameter("pageSize"));
        if (pageSize == null || pageSize == 0) {
            pageSize = 10;
        }
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("currPage",currPage);
        paraMap.put("pageSize",pageSize);
        paraMap.put("mask", sysValue);
        paraMap.put("username",request.getParameter("username"));
        paraMap.put("memberNo",request.getParameter("cid"));
        paraMap.put("mobile",request.getParameter("mobile"));
        paraMap.put("email",request.getParameter("email"));
        paraMap.put("saleNo",request.getParameter("saleNo"));
        paraMap.put("orderNo",request.getParameter("orderNo"));
        paraMap.put("outOrderNo",request.getParameter("outOrderNo"));
        paraMap.put("orderStatus",request.getParameter("orderStatus"));
        paraMap.put("orderFrom",request.getParameter("orderFrom"));
        paraMap.put("m_timeStartDate",  request.getParameter("m_buytimeStartDate"));
        paraMap.put("m_timeEndDate",  request.getParameter("m_buytimeEndDate"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== getMemPurchase url " + url + "  =========");
           
            String resJson = HttpUtil.HttpPost(url, method, paraMap);
            JSONObject resJsonObj= JSONObject.fromObject(resJson);
                jsonString=resJsonObj.getJSONObject("object").toString();
           
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }
/**
 *查询 退货记录
 *@return
 *@param request
 *@param response
 **/
    @ResponseBody
    @RequestMapping(value ="/getMemRefund", method = { RequestMethod.POST, RequestMethod.GET })
    public String getMemRefund(HttpServletRequest request,
                                 HttpServletResponse response) {
        log.info("======== getMemRefund in  =========");
        response.setCharacterEncoding("utf-8");
        String method = "/memRecord/getMemRefund.do";
        String jsonString="";
        //屏显判断
        String json = "";
        String sysValue = "";
        String username = CookiesUtil.getCookies(request, "username");
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("keys", "memberInfo");
		paramMap.put("username", username);
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			log.info("paramMap:" + paramMap);
			json = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
			if(!StringUtils.isEmpty(json)){
				JSONObject jsonObject = JSONObject.fromObject(json);
				String isTrue = jsonObject.getString("success");
				if(isTrue.equals("true")){
				JSONArray jsonArray = jsonObject.getJSONArray("data");
				sysValue = jsonArray.getJSONObject(0).getString("sysValue");
				}
			}
		} catch (Exception e) {
			log.error("查询屏显规则异常！返回结果json="+json);
		}
        //获取每页显示多少条数据
        Integer pageSize = 0;
        //获取当前页
        Integer currPage =Integer.parseInt(request.getParameter("page"));
        pageSize = request.getParameter("pageSize") == null ? null
                : Integer.parseInt(request.getParameter("pageSize"));
        if (pageSize == null || pageSize == 0) {
            pageSize = 10;
        }
        Map<String, Object> paraMap = new HashMap<String, Object>();
        paraMap.put("currPage",currPage);
        paraMap.put("pageSize",pageSize);
        paraMap.put("mask", sysValue);
        paraMap.put("memberNo",request.getParameter("cid"));
        paraMap.put("username",request.getParameter("username"));
        paraMap.put("mobile",request.getParameter("mobile"));
        paraMap.put("email",request.getParameter("email"));
        paraMap.put("reOrderNo",request.getParameter("refundNo"));
        paraMap.put("orderNo",request.getParameter("orderNo"));
        paraMap.put("m_timeStartDate",  request.getParameter("startTime"));
        paraMap.put("m_timeEndDate",  request.getParameter("endTime"));
        try {
            String url = CommonProperties.get("member_ops_url");
            log.info("======== getMemRefund url " + url + "  =========");
            
            String resJson = HttpUtil.HttpPost(url, method, paraMap);
            JSONObject resJsonObj= JSONObject.fromObject(resJson);
                jsonString=resJsonObj.getJSONObject("object").toString();
          
        } catch (Exception e) {
            jsonString = "{success :false}";
        }
        return jsonString;
    }
 /**
  * 查询订单来源
  * @param request
  * @param response
  * @return
  * **/
    @ResponseBody
    @RequestMapping(value="/selectOrderFrom",method= {RequestMethod.POST, RequestMethod.GET})
    public String selectOrderFrom(HttpServletRequest request,HttpServletResponse response){
    	String json = "";
        Map<String, Object> map = new HashMap<String, Object>();
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/pcmAdminChannel/findListChannel.htm", JsonUtil.getJSONString(map));
            map.clear();
            JSONObject jsonObject = JSONObject.fromObject(json);
            List<?> list = (List<?>) jsonObject.get("data");
            if ((list != null) && (list.size() != 0)) {
                map.put("list", list);
                map.put("success", "true");
            } else {
                map.put("success", "false");
            }
        } catch (Exception e) {
            map.put("success", "false");
        }

        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);    	
    }
   
}
