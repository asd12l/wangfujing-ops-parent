package com.wangfj.pay.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
import com.wangfj.pay.web.exception.payBizException;
import com.wangfj.pay.web.util.HttpClientUtil;
import com.wangfj.wms.util.CookiesUtil;

@Controller
@RequestMapping(value="/wfjpay/coupon")
public class CouponController {
	private static final Logger logger = LoggerFactory.getLogger(CouponController.class);
	
	/**
	 * 查询支付日志明细
	 * @Methods Name order
	 * @Create In 2015-12-16 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value="/findAllYZCouponByPage")
	public String findAllYZCouponByPage(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		//设置请求参数
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("pageNo", request.getParameter("page"));
		paramMap.put("orderId", request.getParameter("orderId"));
		paramMap.put("outerTid", request.getParameter("outerTid"));
		paramMap.put("outerItemId", request.getParameter("outerItemId"));
		paramMap.put("verifyStoreId",request.getParameter("verifyStoreId"));
		paramMap.put("verifyStartTime",request.getParameter("verifyStartTime"));
		paramMap.put("verifyEndTime", request.getParameter("verifyEndTime"));
		paramMap.put("sortParam", request.getParameter("sortParam"));
		paramMap.put("sortType", request.getParameter("sortType"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			//调用券核销系统查询数据
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.COUPON_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_YZ_COUPON_VERIFY_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			//检查返回数据
			if(json==null||"".equals(json)){
				throw new payBizException("调用支付券核销系统查询结果为空！");
			}
			JSONObject jsonObject = JSONObject.fromObject(json);
			//检查返回结果
			if(!"success".equals(jsonObject.getString("result"))){
				JSONArray msgArr=jsonObject.getJSONArray("messages");
				throw new payBizException(msgArr.size()==0?"调用支付券核销系统查询结果错误！":msgArr.getString(0));
			}
			//设置响应数据
			JSONObject data=jsonObject.getJSONObject("data");
			JSONArray listData=data.getJSONArray("listData");
			if(listData==null||listData.isEmpty()){
				getDefaultFailerResponse(m,"查询结果为空！");
			}else{
				List<Object> list = (List<Object>)data.get("listData");
				m.put("list", list);
				m.put("success", true);
				m.put("pageCount",data.getString("totalPages"));
			}
		} catch(payBizException e){
			logger.error("券查询业务异常：",e);
			getDefaultFailerResponse(m,e.getMessage());
		}catch (Exception e) {
			logger.error("券查询未知异常：",e);
			getDefaultFailerResponse(m,"有赞券核销查询异常！");
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
	 * 获取缺省的错误响应信息
	 * @param m 响应map
	 * @param msg 响应错误信息
	 */
	public void getDefaultFailerResponse(Map<Object,Object> m,String msg){
		m.put("success", false);
		m.put("pageCount",0);
		m.put("msg", msg);
	}
}
