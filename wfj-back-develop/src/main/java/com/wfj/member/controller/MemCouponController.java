package com.wfj.member.controller;
import java.beans.PropertyDescriptor;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.beanutils.PropertyUtilsBean;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.search.utils.CookieUtil;
import com.wfj.member.utils.Constants;
import com.wfj.member.pojo.CouponAppplyDto;
import com.wfj.member.pojo.ResultVO;

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
	/**
	 * 优惠券申请查询
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value ="/getMemCoupon", method = { RequestMethod.POST, RequestMethod.GET })
	public String getMemCoupon(HttpServletRequest request, 
			HttpServletResponse response){
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
        paraMap.put("checkStatus", request.getParameter("checkStatus"));
        paraMap.put("m_timeApStartDate",  request.getParameter("m_timeApStartDate"));
        paraMap.put("m_timeApEndDate",  request.getParameter("m_timeApEndDate"));
        paraMap.put("m_timeChStartDate",  request.getParameter("m_timeChStartDate"));
        paraMap.put("m_timeChEndDate",  request.getParameter("m_timeChEndDate"));
        String url = CommonProperties.get("member_ops_url");
		String method = "/memberCoupon/getMemberCoupon.do";
        String resultString = null;
		try {
            logger.info("========	wfj-back-develop to Member-ops "+url+method+"  =========parameter:"+paraMap);
            resultString = HttpUtil.HttpPost(url, method, paraMap);
            logger.info("========	wfj-back-develop to Member-ops "+url+method+"  =========parameter:"+paraMap+"=========resultsource:"+resultString);
        } catch (Exception e) {
            logger.error("========	wfj-back-develop to Member-ops "+url+method+"  =========parameter:"+paraMap + "=========error:"+e.getMessage());
        }
        return resultString;
    }
	
	
	/**
	 * 添加优惠券申请
	 * @param request
	 * @param response
	 * @param couponAppplyDto
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value= "/saveNewCouponApply",produces = "text/html;charset=UTF-8",method={RequestMethod.GET,RequestMethod.POST})
	public String saveNewCouponApply(HttpServletRequest request,HttpServletResponse response,CouponAppplyDto couponAppplyDto ){
		String url = CommonProperties.get("member_ops_url");
		String resultString = null;
		Map<String,Object> map = MemCouponController.beanToMap(couponAppplyDto);
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		simpleDateFormat.format(new Date());
		map.put("applyTime", simpleDateFormat.format(new Date()));
		map.put("applyCouponNum",1);
		map.put("checkStatus","1");
		map.put("applyName",CookieUtil.getUserName(request));
		try{
			resultString = HttpUtil.HttpPost(url, "/memberCoupon/saveNreCouponApply.do", map);
		}catch(Exception e){
            logger.error("========	wfj-back-develop to Member-ops "+url+"  =========parameter:"+JSONObject.fromObject(map) + "=========error:"+e.getMessage());
		}
		ResultVO resultVO = new ResultVO();
		if(StringUtils.isNotBlank(resultString)){
			JSONObject resultJson = JSONObject.fromObject(resultString);
			String returnCode = (String) resultJson.get("code");
			if(Constants.RESULT_SUCCESS.equals(returnCode)){	//成功返回
				resultVO.setCode(Constants.RESULT_SUCCESS);
			}else{
				resultVO.setCode(Constants.RESULT_FAIL);
				resultVO.setDesc(resultJson.getString("desc"));
			}
		}else{
			resultVO.setCode(Constants.RESULT_FAIL);
			resultVO.setDesc("网络连接异常");
		}
 		return JSONObject.fromObject(resultVO).toString();
		
	}
	
	/**
	 * 修改优惠券申请
	 * @param request
	 * @param response
	 * @param couponApplyDto
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/updateCouponApply",produces = "text/html;charset=UTF-8", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateCouponApply(HttpServletRequest request,HttpServletResponse response,CouponAppplyDto couponApplyDto){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(StringUtils.isNotBlank(couponApplyDto.getSid())){
			paramMap.put("sid", couponApplyDto.getSid());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getLoginName())){
			paramMap.put("login_name", couponApplyDto.getLoginName());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getApplyCid())){
			paramMap.put("apply_cid", couponApplyDto.getApplyCid());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getApplyName())){
			paramMap.put("apply_name", couponApplyDto.getApplyName());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getApplyType())){
			paramMap.put("apply_type", couponApplyDto.getApplyType());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getApplyTime())){
			paramMap.put("apply_time", couponApplyDto.getApplyTime());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getApplyCouponNum())){
			paramMap.put("apply_coupon_num", couponApplyDto.getApplyCouponNum());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getFromOrder())){
			paramMap.put("from_order", couponApplyDto.getFromOrder());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getSourceType())){
			paramMap.put("source_type", couponApplyDto.getSourceType());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getApplyReason())){
			paramMap.put("apply_reason", couponApplyDto.getApplyReason());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCheckStatus())){
			paramMap.put("check_status", couponApplyDto.getCheckStatus());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCheckName())){
			paramMap.put("check_name", couponApplyDto.getCheckName());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCheckTime())){
			paramMap.put("check_time", couponApplyDto.getCheckTime());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCheckMemo())){
			paramMap.put("check_memo", couponApplyDto.getCheckMemo());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCoupenTemplate())){
			paramMap.put("coupon_template", couponApplyDto.getCoupenTemplate());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCouponType())){
			paramMap.put("coupon_type", couponApplyDto.getCouponType());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCouponType())){
			paramMap.put("coupon_type", couponApplyDto.getCouponType());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCouponBatch())){
			paramMap.put("coupon_batch", couponApplyDto.getCouponBatch());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCouponName())){
			paramMap.put("coupon_name", couponApplyDto.getCouponName());
		}
		if(StringUtils.isNotBlank(couponApplyDto.getCouponMemo())){
			paramMap.put("coupon_memo", couponApplyDto.getCouponMemo());
		}
		String resultString = null;
		String url = CommonProperties.get("member_ops_url");
		try{
			resultString = HttpUtil.HttpPost(url, "/memberCoupon/updateCouponApply.do", paramMap);
		}catch(Exception e){
            logger.error("========	wfj-back-develop to Member-ops "+url+"/memberCoupon/updateCouponApply.do  =========parameter:"+JSONObject.fromObject(paramMap) + "=========error:"+e.getMessage());
		}
		ResultVO resultVO = new ResultVO();
		if(StringUtils.isNotBlank(resultString)){
			JSONObject resultJson = JSONObject.fromObject(resultString);
			String code = (String) resultJson.get("code");
			if(Constants.RESULT_SUCCESS.equals(code)){
				resultVO.setCode(Constants.RESULT_SUCCESS);
			}else{
				resultVO.setCode(Constants.RESULT_FAIL);
				resultVO.setDesc(resultJson.getString("desc"));
			}
		}else{
			resultVO.setCode(Constants.RESULT_FAIL);
			resultVO.setDesc("网络连接异常");
		}
		return JSONObject.fromObject(resultVO).toString();
	}
	
	/**
	 * 审核优惠券申请
	 * @param request
	 * @param response
	 * @param sid
	 * @return
	 */
	@ResponseBody
    @RequestMapping(value="/checkCouponApply", produces = "text/html;charset=UTF-8", method={RequestMethod.GET,RequestMethod.POST})
    public String checkCouponApply(HttpServletRequest request,HttpServletResponse response ,Integer sid, String checkStatus, String checkMemo){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("sid",sid.toString());
		paramMap.put("checkStatus",1);
		paramMap.put("check_name",CookieUtil.getUserName(request));
		paramMap.put("checkStatus2",checkStatus);
		paramMap.put("checkMemo", checkMemo);
		String url = CommonProperties.get("member_ops_url");
		String resultString = null;
		try{
			resultString = HttpUtil.HttpPost(url, "/memberCoupon/checkCouponApply.do", paramMap);
		}catch(Exception e){
            logger.error("========	wfj-back-develop to Member-ops "+url+"/memberCoupon/checkCouponApply.do  =========parameter:"+JSONObject.fromObject(paramMap) + "=========error:"+e.getMessage());
		}
		ResultVO resultVO = new ResultVO();
		if(StringUtils.isNotBlank(resultString)){
			JSONObject resultJson = JSONObject.fromObject(resultString);
			String code = (String) resultJson.get("code");
			if(code.equals(Constants.RESULT_SUCCESS)){
				resultVO.setCode(Constants.RESULT_SUCCESS);
			}else{
				resultVO.setCode(Constants.RESULT_FAIL);
				resultVO.setDesc((String) resultJson.get("desc"));
			}
		}else{
			resultVO.setCode(Constants.RESULT_FAIL);
			resultVO.setDesc("网络连接异常");
		}
    	return JSONObject.fromObject(resultVO).toString();
    }
	
	
	/**
	 * 审核优惠券申请
	 * @param request
	 * @param response
	 * @param sid
	 * @return
	 */
	@ResponseBody
    @RequestMapping(value="/cancleCouPonApply", produces = "text/html;charset=UTF-8", method={RequestMethod.GET,RequestMethod.POST})
    public String cancleCouPonApply(HttpServletRequest request,HttpServletResponse response ,Integer sid){
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("sid",sid.toString());
		paramMap.put("checkStatus",1);
		paramMap.put("check_name",CookieUtil.getUserName(request));
		paramMap.put("checkStatus2",Constants.COUPONAPPLY_CHECKSTATUS_4);
		String url = CommonProperties.get("member_ops_url");
		String resultString = null;
		try{
			resultString = HttpUtil.HttpPost(url, "/memberCoupon/checkCouponApply.do", paramMap);
		}catch(Exception e){
            logger.error("========	wfj-back-develop to Member-ops "+url+"/memberCoupon/checkCouponApply.do  =========parameter:"+JSONObject.fromObject(paramMap) + "=========error:"+e.getMessage());
		}
		ResultVO resultVO = new ResultVO();
		if(StringUtils.isNotBlank(resultString)){
			JSONObject resultJson = JSONObject.fromObject(resultString);
			String code = (String) resultJson.get("code");
			if(code.equals(Constants.RESULT_SUCCESS)){
				resultVO.setCode(Constants.RESULT_SUCCESS);
			}else{
				resultVO.setCode(Constants.RESULT_FAIL);
				resultVO.setDesc((String) resultJson.get("desc"));
			}
		}else{
			resultVO.setCode(Constants.RESULT_FAIL);
			resultVO.setDesc("网络连接异常");
		}
    	return JSONObject.fromObject(resultVO).toString();
    }
	
	
	
	/**		
	 * 实体转换成map		
	 * @param obj	
	 * @return
	 */
    public static Map<String, Object> beanToMap(Object obj) { 
        Map<String, Object> params = new HashMap<String, Object>(0); 
        try { 
            PropertyUtilsBean propertyUtilsBean = new PropertyUtilsBean(); 
            PropertyDescriptor[] descriptors = propertyUtilsBean.getPropertyDescriptors(obj); 
            int length = descriptors.length;
            for (int i = 0; i < length; i++) { 
                String name = descriptors[i].getName(); 
                if (!"class".equals(name)) { 
                	String value = (String) propertyUtilsBean.getNestedProperty(obj, name);
                	if(StringUtils.isNotBlank(value)){
                		params.put(name, propertyUtilsBean.getNestedProperty(obj, name)); 
                	}
                    
                } 
            } 
        } catch (Exception e) { 
            e.printStackTrace(); 
        } 
        return params; 
}

		
}
