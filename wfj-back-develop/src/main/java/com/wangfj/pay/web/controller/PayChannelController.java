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
import com.wangfj.pay.web.vo.ExcelChannelVo;
import com.wangfj.pay.web.vo.ExcelOrderVo;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value="/wfjpay")
public class PayChannelController {
	private static final Logger logger = LoggerFactory.getLogger(PayChannelController.class);
	private static final String EXPORT_SIZE="10000";
	
	/**
	 * 查询渠道
	 * @Methods Name channel
	 * @Create In 2015-12-17 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/channel")
	public String channel(HttpServletRequest request, HttpServletResponse response) {
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
		paramMap.put("startTime", request.getParameter("startTime"));
		paramMap.put("payService", request.getParameter("payService"));
		paramMap.put("userId", CookieUtil.getUserName(request));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_CHANNEL_LIST);
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
				m.put("pageCount","0");
				if(list.size()==0){
					m.put("msg","emptyData");
				}
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("pageCount",0);
			e.printStackTrace();
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
	
	/**
	 * excel渠道导出检查
	 * @Methods Name checkChannelExport
	 * @Create In 2015-12-17 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/statisticsType/checkChannelExport")
	public String checkChannelExport(HttpServletRequest request, HttpServletResponse response) {
				String json = "";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		paramMap.put("bpId", request.getParameter("bpId"));
		paramMap.put("endTime", request.getParameter("endTime"));
		paramMap.put("finalPayTerminal", request.getParameter("finalPayTerminal"));
		paramMap.put("payBank", request.getParameter("payBank"));
		paramMap.put("payType", request.getParameter("payType"));
		paramMap.put("startTime", request.getParameter("startTime"));
		/*if(bpId!=null&&!bpId.equals("")&&!bpId.equals("0")){
			paramMap.put("bpIds", request.getParameter("bpId"));
		}*/
		paramMap.put("userId",CookieUtil.getUserName(request));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_CHANNEL_EXPORT);
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
	 * @Methods Name getChannelToExcel
	 * @Create In 2016-1-27 By yangyinbo
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/statisticsType/getChannelToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getChannelToExcel(HttpServletRequest request, HttpServletResponse response){
		String jsons = "";	
		String title = "payChannel_"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"_";
		String json="";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(request.getParameter("bpId"))){
			paramMap.put("bpId", request.getParameter("bpId"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
			paramMap.put("endTime", request.getParameter("endTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
			paramMap.put("startTime", request.getParameter("startTime"));
		}
		if(StringUtils.isNotEmpty(request.getParameter("finalPayTerminal"))){
			paramMap.put("finalPayTerminal", request.getParameter("finalPayTerminal"));
		}
		/*if(StringUtils.isNotEmpty(request.getParameter("bpId"))&&!request.getParameter("bpId").equals("0")){
			paramMap.put("bpIds", request.getParameter("bpId"));
		}*/
		paramMap.put("userId", CookieUtil.getUserName(request));
		paramMap.put("pageSize", EXPORT_SIZE);
		paramMap.put("pageNo", "1");
		String str = JsonUtil.getJSONString(paramMap);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_CHANNEL_LIST);
			json=HttpClientUtil.post(url, paramMap);
			logger.info("json:" + json);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONObject object=jsonObject.getJSONObject("data");
			JSONArray arr = object.getJSONArray("listData");
			title+=object.get("totalHit");
			List<ExcelChannelVo> list = new ArrayList<ExcelChannelVo>();
			if (arr != null && arr.size() != 0) {
				for (int i=0;i<arr.size();i++){
					JSONObject obj = arr.getJSONObject(i);
					ExcelChannelVo vo = (ExcelChannelVo) JSONObject.toBean(obj,ExcelChannelVo.class);
					list.add(vo);
				}
				String result = allChannelToExcel(response, list, title);
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
	 * @Methods Name allChannelToExcel
	 * @Create In 2016-1-27 By yangyinbo
	 * @param response
	 * @param list
	 * @param title
	 * @return String
	 */
	public String allChannelToExcel(HttpServletResponse response,List<ExcelChannelVo> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("订单终端");
		header.add("创建时间");
		header.add("业务接口");
		header.add("支付渠道");
		header.add("支付服务");
		header.add("充值方式");
		header.add("支付金额(元)");
		header.add("应付金额(元)");
		header.add("实际收入");
		header.add("费率(元)");
		header.add("手续费支出(元)");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(ExcelChannelVo vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getFinalPayTerminalName()==null?"":vo.getFinalPayTerminalName());			
			if(vo.getCreateDate()!=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				inlist.add(sdf.format(new Date(vo.getCreateDate())));
			}else{
				inlist.add("");
			}
			inlist.add(vo.getBpName()==null?"":vo.getBpName());
			inlist.add(vo.getPayType()==null?"":vo.getPayType());
			inlist.add(vo.getPayService()==null?"":vo.getPayService());
			inlist.add(vo.getPayBank()==null?"":vo.getPayBank());
			inlist.add(vo.getPrice()==null?"":vo.getPrice());
			inlist.add(vo.getNeedPayPrice()==null?"":vo.getNeedPayPrice()+"");		
			inlist.add(vo.getRealIncome()==null?"":vo.getRealIncome()+"");
			inlist.add(vo.getRate()==null?"":vo.getRate());
			inlist.add(vo.getChannelCost()==null?"":vo.getChannelCost()+"");
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
