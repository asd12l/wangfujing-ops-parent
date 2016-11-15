package com.wangfj.pay.web.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.pay.web.constant.Constants;
import com.wangfj.pay.web.util.HttpClientUtil;
import com.wangfj.pay.web.vo.ExcelPayStaticsVo;
import com.wangfj.wms.util.CookiesUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 統計查詢
 * @author Administrator
 * @date 2016年11月9日 下午12:53:03
 */
@Controller
@RequestMapping(value="/wfjpay")
public class PayMentDateController {
	private static final Logger logger = LoggerFactory.getLogger(PayMentDateController.class);
	private static final String EXPORT_SIZE="10000";
	
	/**
	 * 統計查詢
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/selectpayMentDate")
	public String payMentDate(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		paramMap.put("startTime", request.getParameter("startTime"));
		paramMap.put("endTime", request.getParameter("endTime"));
		paramMap.put("payTypes", request.getParameter("payTypes"));
		paramMap.put("merCodes", request.getParameter("merCodes"));
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_MENT_DATE_LIST);
			logger.info("--------------------------"+url);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			//JSONObject object=jsonObject.getJSONObject("data");
			List<Object> list = (List<Object>)jsonObject.get("data");
			//计算开始
			JSONArray arr = jsonObject.getJSONArray("data");
			List<ExcelPayStaticsVo> countlist = new ArrayList<ExcelPayStaticsVo>();
			if (arr != null && arr.size() != 0) {
				for (int i=0;i<arr.size();i++){
					JSONObject obj = arr.getJSONObject(i);
					ExcelPayStaticsVo vo = (ExcelPayStaticsVo) JSONObject.toBean(obj,ExcelPayStaticsVo.class);
					countlist.add(vo);
				}
			}
			List<String> countList = new ArrayList<String>();
			//countList.add("总计");//门店编号
			//countList.add("");//门店名称
			BigDecimal payTotalFee = BigDecimal.ZERO;
			Integer PayToalCount = 0;
			BigDecimal RefundTotalFee = BigDecimal.ZERO;;
			Integer RefundTotalCount = 0;
			BigDecimal CouponTotalFee = BigDecimal.ZERO;;
			for(ExcelPayStaticsVo vo:countlist){
				payTotalFee = payTotalFee.add(BigDecimal.valueOf((vo.getPayTotalFee())));
				PayToalCount += vo.getPayToalCount();
				RefundTotalFee = RefundTotalFee.add(BigDecimal.valueOf((vo.getRefundTotalFee())));
				RefundTotalCount += vo.getRefundTotalCount();
				CouponTotalFee = CouponTotalFee.add(BigDecimal.valueOf((vo.getCouponTotalFee())));
			}
			countList.add(payTotalFee.toString());
			countList.add(PayToalCount.toString());
			countList.add(RefundTotalFee.toString());
			countList.add(RefundTotalCount.toString());
			countList.add(CouponTotalFee.toString());
			//计算结束
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
				m.put("countList", countList);
			//	m.put("pageCount",object.getString("totalPages"));
			} else {
				m.put("success", "false");
				m.put("pageCount",0);
				if(list.size()==0){
					m.put("msg","emptyData");
				}
			}
		} catch (Exception e) {
			m.put("success", "false");
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
	 * 统计查询导出Excel
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/getPayMentDateToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getStockToExcel(HttpServletRequest request, HttpServletResponse response){
		
		String json="";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
			paramMap.put("startTime", request.getParameter("startTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
			paramMap.put("endTime", request.getParameter("endTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payTypes"))){
			paramMap.put("payTypes", request.getParameter("payTypes"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("merCodes"))){
			paramMap.put("merCodes", request.getParameter("merCodes"));
		}
	//	String title = "payRecorder_"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"_";
		String title = new SimpleDateFormat("yyyy-MM-dd").format(new Date(Long.parseLong(request.getParameter("startTime"))))+
				"-"+new SimpleDateFormat("yyyy-MM-dd").format(new Date(Long.parseLong(request.getParameter("endTime"))));
	//	paramMap.put("pageSize", EXPORT_SIZE);
	//	paramMap.put("pageNo", "1");
	//	paramMap.put("userId", CookieUtil.getUserName(request));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_MENT_DATE_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			//JSONObject object=jsonObject.getJSONObject("data");
			JSONArray arr = jsonObject.getJSONArray("data");
			//title+=jsonObject.get("totalHit");
			List<ExcelPayStaticsVo> list = new ArrayList<ExcelPayStaticsVo>();
			if (arr != null && arr.size() != 0) {
				for (int i=0;i<arr.size();i++){
					JSONObject obj = arr.getJSONObject(i);
					ExcelPayStaticsVo vo = (ExcelPayStaticsVo) JSONObject.toBean(obj,ExcelPayStaticsVo.class);
					list.add(vo);
				}
				allOrderToExcel(response, list, title);
				m.put("success", "true");
				m.put("msg", "导出成功！");
			} else {
				m.put("success", "true");
				m.put("msg", "查询为空！");
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("msg", "导出异常！");
			logger.error(e.toString());
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * 
	 * @param response
	 * @param list
	 * @param title
	 * @return
	 */
	public String allOrderToExcel(HttpServletResponse response,List<ExcelPayStaticsVo> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("门店编码");
		header.add("门店名称");
		header.add("支付金额(万元)");
		header.add("支付笔数");
		header.add("退款金额(万元)");
		header.add("退款笔数");
		header.add("活动金额(元,正向)");
	
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelPayStaticsVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getStoreNo()==null?"":vo.getStoreNo());
			inlist.add(vo.getStoreName()==null?"":vo.getStoreName());			
			inlist.add(vo.getPayTotalFee()==null?"":String.valueOf(vo.getPayTotalFee()));
			inlist.add(vo.getPayToalCount()==null?"":String.valueOf(vo.getPayToalCount()));
			inlist.add(vo.getRefundTotalFee()==null?"":String.valueOf(vo.getRefundTotalFee()));
			inlist.add(vo.getRefundTotalCount()==null?"":String.valueOf(vo.getRefundTotalCount()));
			inlist.add(vo.getCouponTotalFee()==null?"":String.valueOf(vo.getCouponTotalFee()));
			data.add(inlist);
		}
		//总计
		List<String> countList = new ArrayList<String>();
		countList.add("总计");//门店编号
		countList.add("");//门店名称
		BigDecimal payTotalFee = BigDecimal.ZERO;
		Integer PayToalCount = 0;
		BigDecimal RefundTotalFee = BigDecimal.ZERO;;
		Integer RefundTotalCount = 0;
		BigDecimal CouponTotalFee = BigDecimal.ZERO;;
		for(ExcelPayStaticsVo vo:list){
			payTotalFee = payTotalFee.add(BigDecimal.valueOf((vo.getPayTotalFee())));
			PayToalCount += vo.getPayToalCount();
			RefundTotalFee = RefundTotalFee.add(BigDecimal.valueOf((vo.getRefundTotalFee())));
			RefundTotalCount += vo.getRefundTotalCount();
			CouponTotalFee = CouponTotalFee.add(BigDecimal.valueOf((vo.getCouponTotalFee())));
		}
		countList.add(payTotalFee.toString());
		countList.add(PayToalCount.toString());
		countList.add(RefundTotalFee.toString());
		countList.add(RefundTotalCount.toString());
		countList.add(CouponTotalFee.toString());
		data.add(countList);
		
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}finally{
			try {
				response.getOutputStream().close();
			} catch (IOException e) {
				logger.error(e.getMessage());
			}
		}
		
	}
}
