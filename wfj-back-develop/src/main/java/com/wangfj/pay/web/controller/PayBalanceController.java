package com.wangfj.pay.web.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.wangfj.pay.web.vo.ExcelBalanceVo;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value="/wfjpay")
public class PayBalanceController {
	private static final Logger logger = LoggerFactory.getLogger(PayBalanceController.class);
	private static final String EXPORT_SIZE="10000";
	
	/**
	 * 查询对账列表
	 * @Methods Name balance
	 * @Create In 2015-12-17 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/balance")
	public String balance(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("bpId", request.getParameter("bpId"));
		paramMap.put("endTime", request.getParameter("endTime"));
		paramMap.put("finalPayTerminal", request.getParameter("finalPayTerminal"));
		paramMap.put("payService", request.getParameter("payService"));
		paramMap.put("userName",request.getParameter("userName"));
		paramMap.put("pageNo",request.getParameter("page"));
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("payBank", request.getParameter("payBank"));
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("startTime", request.getParameter("startTime"));
		paramMap.put("sortType", request.getParameter("sortType"));
		paramMap.put("sortParam", request.getParameter("sortParam"));
		paramMap.put("userId", CookieUtil.getUserName(request));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_BALANCE_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			List<Object> list = (List<Object>)object.get("listData");
			if (list != null && list.size() != 0) {
				m.put("list", list);
				m.put("success", "true");
				m.put("pageCount",object.getString("totalPages"));
				m.put("pageNo", object.getString("pageNo"));
				m.put("totalHit", object.getString("totalHit"));
				m.put("pageStartRow", object.getString("pageEndRow"));
				m.put("next",object.getString("next"));
				m.put("previous",object.getString("previous"));
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
	 * 查询对账-合计统计
	 * @Methods Name balanceCount
	 * @Create In 2015-12-17 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/balance/count")
	public String balanceCount(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("bpId", request.getParameter("bpId"));
		paramMap.put("endTime", request.getParameter("endTime"));
		paramMap.put("finalPayTerminal", request.getParameter("finalPayTerminal"));
		paramMap.put("pageNo",request.getParameter("page"));
		paramMap.put("pageSize", request.getParameter("pageSize"));
		paramMap.put("payBank", request.getParameter("payBank"));
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("payService", request.getParameter("payService"));
		paramMap.put("startTime", request.getParameter("startTime"));
		paramMap.put("sortType", request.getParameter("sortType"));
		paramMap.put("sortParam", request.getParameter("sortParam"));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_VERIFICA_COUNT);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			if (object!=null&&object.size()!=0) {
				m.put("object", object);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * excel对账导出检查
	 * @Methods Name checkBalanceExport
	 * @Create In 2015-12-17 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/balance/checkBalanceExport")
	public String checkBalanceExport(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("bpId", request.getParameter("bpId"));
		paramMap.put("endTime", request.getParameter("endTime"));
		paramMap.put("finalPayTerminal", request.getParameter("finalPayTerminal"));
		paramMap.put("payBank", request.getParameter("payBank"));
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("startTime", request.getParameter("startTime"));
		paramMap.put("sortType", request.getParameter("sortType"));
		paramMap.put("sortParam", request.getParameter("sortParam"));
		paramMap.put("userId", CookieUtil.getUserName(request));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_BALANCE_EXPORT);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			if (jsonObject!=null&&jsonObject.size()!=0) {
				m.put("object", jsonObject);
				m.put("success", "true");
			} else {
				m.put("success", "false");
			}
		} catch (Exception e) {
			m.put("success", "false");
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 订单导出Excel
	 * @Methods Name getBalanceToExcel
	 * @Create In 2015-10-9 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/balance/getBalanceToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getBalanceToExcel(HttpServletRequest request, HttpServletResponse response){
		String jsons = "";	
		
		String title = "payStatistics_"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"_";
		String json="";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
			paramMap.put("startTime", request.getParameter("startTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
			paramMap.put("endTime", request.getParameter("endTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("bpId"))){
			paramMap.put("bpId", request.getParameter("bpId"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payBank"))){
			paramMap.put("payBank", request.getParameter("payBank"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("payType"))){
			paramMap.put("payType", request.getParameter("payType"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("finalPayTerminal"))){
			paramMap.put("finalPayTerminal", request.getParameter("finalPayTerminal"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("sortParam"))){
			paramMap.put("sortParam", request.getParameter("sortParam"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("sortType"))){
			paramMap.put("sortType", request.getParameter("sortType"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("userName"))){
			paramMap.put("userName", request.getParameter("userName"));
		}
		paramMap.put("userId", CookieUtil.getUserName(request));
		paramMap.put("pageSize", EXPORT_SIZE);
		paramMap.put("pageNo", "1");
		String str = JsonUtil.getJSONString(paramMap);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_BALANCE_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			JSONArray arr = object.getJSONArray("listData");
			title+=object.get("totalHit");
			List<ExcelBalanceVo> list = new ArrayList<ExcelBalanceVo>();
			if (arr != null && arr.size() != 0) {
				for (int i=0;i<arr.size();i++){
					JSONObject obj = arr.getJSONObject(i);
					ExcelBalanceVo vo = (ExcelBalanceVo) JSONObject.toBean(obj,ExcelBalanceVo.class);
					list.add(vo);
				}
				String result = allOrderToExcel(response, list, title);
				m.put("success", "true");
				m.put("msg", "导出成功！");
			} else {
				m.put("success", "true");
				m.put("msg", "查询为空！");
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("msg", "导出异常！");
			logger.error(e.getMessage());
		}
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	/**
	 * 
	 * @Methods Name allBalanceToExcel
	 * @Create In 2015-10-10 By yangyinbo
	 * @param response
	 * @param list
	 * @param title
	 * @return String
	 */
	public String allOrderToExcel(HttpServletResponse response,List<ExcelBalanceVo> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("业务平台订单号");
		header.add("业务接口");
		header.add("支付平台订单号");
		header.add("付款时间");
		header.add("订单内容");
		header.add("支付账户");
//		header.add("UID");
		header.add("支付金额(元)");
		header.add("应付金额(元)");
		header.add("订单终端类型");
		header.add("支付渠道");
		header.add("支付服务");
		header.add("支付方式");
		header.add("支付平台流水号");
		header.add("费率");
		header.add("手续费支出(元)");
//		header.add("议价收入(元)");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelBalanceVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getBpOrderId()==null?"":vo.getBpOrderId());			
			inlist.add(vo.getBpName()==null?"":vo.getBpName());
			inlist.add(vo.getOrderTradeNo()==null?"":vo.getOrderTradeNo());
			if(vo.getPayDate()!=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				inlist.add(sdf.format(new Date(vo.getPayDate())));
			}else{
				inlist.add("");
			}
			inlist.add(vo.getContent()==null?"":vo.getContent());
			inlist.add(vo.getUserName()==null?"":vo.getUserName());
//			inlist.add(vo.getUnid()==null?"":vo.getUnid());
			inlist.add(vo.getTotalFee()==null?"":vo.getTotalFee()+"");
			inlist.add(vo.getNeedPayPrice()==null?"":vo.getNeedPayPrice()+"");	
			inlist.add(vo.getFinalPayTerminalName()==null?"":vo.getFinalPayTerminalName());
			inlist.add(vo.getPayTypeName()==null?"":vo.getPayTypeName());
			inlist.add(vo.getPayServiceName()==null?"":vo.getPayServiceName());	
			inlist.add(vo.getPayBankName()==null?"":vo.getPayBankName());
			inlist.add(vo.getPaySerialNumber()==null?"":vo.getPaySerialNumber());
			inlist.add(vo.getRate()==null?"":vo.getRate());
			inlist.add(vo.getChannelFeeCost()==null?"":vo.getChannelFeeCost()+"1");
//			inlist.add(vo.getBargainIncome()==null?"":vo.getBargainIncome()+"");
			data.add(inlist);
		}
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
