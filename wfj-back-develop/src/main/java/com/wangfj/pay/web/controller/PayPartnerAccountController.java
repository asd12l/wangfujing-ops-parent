package com.wangfj.pay.web.controller;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.pay.web.constant.Constants;
import com.wangfj.pay.web.util.CookiesUtil;
import com.wangfj.pay.web.util.HttpClientUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping(value="/wfjpay")
public class PayPartnerAccountController {
	private static final Logger logger = LoggerFactory.getLogger(PayPartnerAccountController.class);
	
	
	/*
	*//**
	 * 查询签约商户
	 * @Methods Name order
	 * @Create In 2015-12-16 By xionghang
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/selectPayPartnerAccount")
	public String selectMerchant(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("payType",request.getParameter("payType"));
		paramMap.put("partner",request.getParameter("businessID"));  //商户ID
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAYPARTNER_ACCOUNT_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			List<Object> list = (List<Object>)object.get("listData");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
				m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("pageCount",0);
			}
		} catch (Exception e) {
			m.put("success", "error");
			m.put("pageCount",0);
			e.printStackTrace();
		}
		String js =CommonProperties.get(Constants.WFJ_LOG_JS);
		m.put("logJs", js);
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			m.put("userName", CookiesUtil.getUserName(request));
		}else{
			m.put("userName", "");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	@ResponseBody
	@RequestMapping(value="/selectPayPartnerAccountPartner")
	public String selectPayPartnerAccountById(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("partner",request.getParameter("partner"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PARTNER_ACCOUNT_BYPARTNER);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONArray object=jsonObject.getJSONArray("messages");
			//List<Object> list = (List<Object>)object.get("listData");
			
			
			if (object != null && "0".equals(object.getString(0))) {
				//m.put("list", list);
				m.put("success", "false");
                
			} else if(object !=null && "1".equals(object.getString(0))) {
				m.put("success", "success");
				//m.put("pageCount",0);
			}
		} catch (Exception e) {
			m.put("success", "error");
			m.put("pageCount",0);
			e.printStackTrace();
		}
		String js =CommonProperties.get(Constants.WFJ_LOG_JS);
		m.put("logJs", js);
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			m.put("userName", CookiesUtil.getUserName(request));
		}else{
			m.put("userName", "");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}


	/**
	 * 添加渠道号
	 * @Methods Name order
	 * @Create In 2015-12-16 By xionghang
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/addchannelPartnerAccount")
	public String addMerchant(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("partner", request.getParameter("partner"));
		paramMap.put("encryptKey", request.getParameter("encryptKey"));
		paramMap.put("feeCostRate", request.getParameter("feeCostRate"));
		paramMap.put("sellerEmail",request.getParameter("sellerEmail"));
		paramMap.put("keyPath",request.getParameter("keyPath"));
		//paramMap.put("createDate",createDate);
		paramMap.put("payMediumCode",request.getParameter("payMediumCode"));
		paramMap.put("payMediumCodeCredit",request.getParameter("payMediumCodeCre"));
		paramMap.put("branchId",request.getParameter("branchId"));
		paramMap.put("appid",request.getParameter("appid"));
		paramMap.put("publicKey", request.getParameter("publicKey"));
		paramMap.put("privateKey", request.getParameter("privateKey"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.ADD_PAYPARTNER_ACCOUNT_ID);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			//List<Object> list = (List<Object>)object.get("listData");
			if (jsonObject.getString("result").equals("success")){
				//m.put("list", list);
				m.put("success", "true");
				//m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("errors",object.getJSONObject("errors"));
			}
		} catch (Exception e) {
			m.put("success", "false");
			//m.put("pageCount",0);
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}

	
	/**
	 * 修改渠道号
	 * @Methods Name order
	 * @Create In 2015-12-16 By xionghang
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/updatechannelPartnerAccount")
	public String updateMerchant(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", request.getParameter("id"));
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("partner", request.getParameter("partner"));
		paramMap.put("encryptKey", request.getParameter("encryptKey"));
		paramMap.put("feeCostRate", request.getParameter("feeCostRate"));
		paramMap.put("sellerEmail",request.getParameter("sellerEmail"));
		paramMap.put("keyPath",request.getParameter("keyPath"));
		paramMap.put("payMediumCode",request.getParameter("payMediumCode"));
		paramMap.put("branchId",request.getParameter("branchId"));
		paramMap.put("payMediumCodeCredit",request.getParameter("payMediumCodeCre"));
		paramMap.put("appid",request.getParameter("appid"));
		paramMap.put("publicKey", request.getParameter("publicKey"));
		paramMap.put("privateKey", request.getParameter("privateKey"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_PAYPARTNER_ACCOUNT);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			//List<Object> list = (List<Object>)object.get("listData");
			if (jsonObject.getString("result").equals("success")){
				//m.put("list", list);
				m.put("success", "true");
				//m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("errors",object.getJSONObject("errors"));
			}
		} catch (Exception e) {
			m.put("success", "false");
			//m.put("pageCount",0);
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
     @ResponseBody
     @RequestMapping(value="/findAllMediumListNoParam")
     public String findAllMediumListNoParam(HttpServletRequest request,HttpServletResponse response){
    	 String json="";
    	 Map<String,String>paramMap=new HashMap<String,String>();
    	 Map<Object,Object>m =new HashMap<Object,Object>();
    	 try{
    		 String jsonStr=JSON.toJSONString(paramMap);
    		 logger.info("jsonStr:"+jsonStr);
    		 String url=CommonProperties.get(Constants.MEDIUM_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_ALLMEDIUM_ZTREELIST);
    		 json=HttpClientUtil.post(url, paramMap);
    		 logger.info("json:"+json);
    		 	JSONObject jsonObject=JSONObject.fromObject(json);
    		 if (jsonObject.getString("result").equals("success")) {
 				List<Object> list = (List<Object>)jsonObject.get("data");
 				m.put("list", list);
 				m.put("success", true);
 			} else {
 				m.put("success", false);
 				m.put("msg", "查询支付介质失败！");
 			}
    	 }catch(Exception e){
    		 m.put("success", "false");
 			m.put("msg","error！");
 			e.printStackTrace();
    	 }
    	 Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
 		 return gson.toJson(m);
     }
	
     /**
      * 查询渠道费率
      * @Methods Name selectChannelFeeRate
      * @Create In 2016年4月18日 By yangyinbo 
      * @param request
      * @param response
      * @return String
      */
 	@ResponseBody
 	@RequestMapping(value="/selectChannelFeeRateList")
 	public String selectChannelFeeRateList(HttpServletRequest request, HttpServletResponse response) {
 		String json = "";
 		Map<String,String> paramMap = new HashMap<String,String>();
 		paramMap.put("payPartner", request.getParameter("payPartner"));
 		paramMap.put("payType", request.getParameter("payType"));
 		Map<Object, Object> m = new HashMap<Object, Object>();
 		try {
 			String jsonStr = JSON.toJSONString(paramMap);
 			logger.info("jsonStr:" + jsonStr);
 			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_CHANNEL_FEE_RATE_LIST);
 			json=HttpClientUtil.post(url, paramMap);
 			logger.info("json:" + json);
 			JSONObject resJson = JSONObject.fromObject(json);
 			if(resJson!=null&&resJson.containsKey("result")&&"success".equals(resJson.getString("result"))){
 				List list = (List)resJson.get("data");
 				if(list!=null&&list.size()!=0){
 					m.put("list", list);
 					m.put("success", true);
 				}else{
 					m.put("success", false);
 					m.put("msg", "emptyData");
 				}
 			} else {
 				m.put("success", false);
 			}
 		} catch (Exception e) {
 			e.printStackTrace();
 			m.put("success", false);
 		}
 		String js =CommonProperties.get(Constants.WFJ_LOG_JS);
		m.put("logJs", js);
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			m.put("userName", CookiesUtil.getUserName(request));
		}else{
			m.put("userName", "");
		}
 		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
 		return gson.toJson(m);
 	}
 	
    /**
     * 添加渠道费率
     * @Methods Name selectChannelFeeRate
     * @Create In 2016年4月18日 By yangyinbo
     * @param request
     * @param response
     * @return String
     */
	@ResponseBody
	@RequestMapping(value="/addChannelFeeRate")
	public String addChannelFeeRate(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String errorMsg="";
		JSONObject res=new JSONObject();
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("payPartner", request.getParameter("payPartner"));
		paramMap.put("feeCostRate", request.getParameter("feeCostRate"));
		paramMap.put("rateType", request.getParameter("rateType"));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.ADD_CHANNEL_FEE_RATE);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject resJson = JSONObject.fromObject(json);
			if(resJson==null||!resJson.containsKey("result")){
				res.put("success", false);
				res.put("msg", "添加费率超时！");
				return res.toString();
			}
			if("failure".equals(resJson.getString("result"))){
				errorMsg=resJson.getJSONArray("messages").size()>0?resJson.getJSONArray("messages").getString(0):"添加费率失败！";
				res.put("success", false);
				res.put("msg", errorMsg);
				return res.toString();
			}
			res.put("success", true);
			res.put("msg","添加渠道费率成功！");
		} catch (Exception e) {
			e.printStackTrace();
			res.put("success", false);
			res.put("msg", "添加渠道费率异常！");
		}
		return res.toString();
	}
	
    /**
     * 更新渠道费率
     * @Methods Name selectChannelFeeRate
     * @Create In 2016年4月18日 By yangyinbo
     * @param request
     * @param response
     * @return String
     */
	@ResponseBody
	@RequestMapping(value="/updateChannelFeeRate")
	public String updateChannelFeeRate(HttpServletRequest request, HttpServletResponse response) {
		String errorMsg="";
		JSONObject res=new JSONObject();
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("id", request.getParameter("id"));
		paramMap.put("payPartner", request.getParameter("payPartner"));
		paramMap.put("feeCostRate", request.getParameter("feeCostRate"));
		paramMap.put("rateType", request.getParameter("rateType"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.UPDATE_CHANNEL_FEE_RATE);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject resJson = JSONObject.fromObject(json);
			if(resJson==null||!resJson.containsKey("result")){
				res.put("success", false);
				res.put("msg", "更新渠道费率超时！");
				return res.toString();
			}
			
			if("failure".equals(resJson.getString("result"))){
				errorMsg=resJson.getJSONArray("messages").size()>0?resJson.getJSONArray("messages").getString(0):"更新渠道费率失败！";
				res.put("success", false);
				res.put("msg", errorMsg);
				return res.toString();
			}
			res.put("success", true);
			res.put("msg","更新渠道费率成功！");
		} catch (Exception e) {
			e.printStackTrace();
			res.put("success", false);
			res.put("msg", "更新渠道费率异常！");
		}
		return res.toString();
	}
	
    /**
     * 查询费率类型
     * @Methods Name selectChannelFeeRate
     * @Create In 2016年4月18日 By yangyinbo 
     * @param request
     * @param response
     * @return String
     */
	@ResponseBody
	@RequestMapping(value="/selectChannelFeeRateType")
	public String selectChannelFeeRateType(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("payType", request.getParameter("payType"));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_CHANNEL_FEE_RATE_TYPE);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject resJson = JSONObject.fromObject(json);
			if(resJson!=null&&resJson.containsKey("result")&&"success".equals(resJson.getString("result"))){
				List list = (List)resJson.get("data");
				if(list!=null&&list.size()!=0){
 					m.put("list", list);
 					m.put("success", true);
 				}else{
 					m.put("success", false);
 					m.put("msg", "emptyData");
 				}
			} else {
				m.put("success", false);
			}
		} catch (Exception e) {
			e.printStackTrace();
			m.put("success", false);
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
}
