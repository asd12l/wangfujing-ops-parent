package com.wangfj.pay.web.controller;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.text.ParseException;
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
import com.wangfj.pay.web.vo.ExcelStaticsVo;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.JsonUtil;
@Controller
@RequestMapping(value = "/wfjpay")
public class StaticsController {
	private static final Logger logger = LoggerFactory.getLogger(StaticsController.class);
	private static final String EXPORT_SIZE="10000";
	String statList;
	/**
	 * 品牌分类控制器
	 * 
	 * @Class Name Controller
	 * @Author xionghang
	 * @Create In 2015年12月15日
	 */

	

		/**
		 * 查询品牌分类列表
		 * 
		 * @Methods Name queryAllBrandCate
		 * @Create In 2015年8月8日 By wangsy
		 * @param request
		 * @param response
		 * @param brandName
		 * @return String
		 */
		@ResponseBody
		@RequestMapping(value = "/statistic/staticsSelect",method={RequestMethod.GET,RequestMethod.POST})
		public String staticsSelect(HttpServletRequest request, HttpServletResponse response){
			String json="";
			Map<String,String>map=new HashMap<String,String>();
			Map<Object,Object>m=new HashMap<Object,Object>();
			map.put("pageSize", request.getParameter("pageSize"));
			map.put("pageNo", request.getParameter("page"));
			map.put("bpId", request.getParameter("bpId"));
			map.put("startTime",request.getParameter("startTime"));
			map.put("endTime", request.getParameter("endTime"));
			map.put("groupTime", request.getParameter("groupTime"));
			map.put("initOrderTerminal",request.getParameter("initOrderTerminal"));
			map.put("statList",request.getParameter("statList"));
			map.put("userId", CookieUtil.getUserName(request));
			try{
				String jsonStr = JSON.toJSONString(map);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_STATISTICS_LIST);
				json=HttpClientUtil.post(url, map);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject object=jsonObject.getJSONObject("data");
				logger.info("json:" + json);
				
				List<Object> list = (List<Object>)object.get("listData");
				if (list != null && list.size() != 0) {
					m.put("list", list);
					m.put("success", "true");
					m.put("pageCount",object.getString("totalPages"));
				} else {
					m.put("success", "false");
					m.put("pageCount","0");
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
			
			
	/*String bpId1=request.getParameter("bpId");
			Long bpId=Long.parseLong(bpId1);
			String startTime=request.getParameter("startTime");
			SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	 
			Date dts =null;
			Date dte=null;
			long sTime = 0;
			long eTime=0;
			try {
				dts= sdf.parse(startTime);
			 sTime = dts.getTime();
				
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
					
			String endTime=request.getParameter("endTime");
			try {
				dte= sdf.parse(endTime);
			    eTime = dte.getTime();
				
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			System.out.println(sTime+eTime);
			String groupTime1=request.getParameter("groupTime");
			Integer groupTime=Integer.parseInt(groupTime1);
			String initOrderTerminal=request.getParameter("initOrderTerminal");
			String startList1=request.getParameter("statList");
			Integer startList=Integer.parseInt(startList1);
			System.out.println(bpId+startTime+endTime+groupTime+initOrderTerminal+startList);
			String json="";
			Map<Object,Object> map=new HashMap<Object,Object>();
			map.put("bpId", bpId);
			map.put("startTime", sTime);
			map.put("endTime", eTime);
			map.put("groupTime", groupTime);
			map.put("initOrderTerminal", initOrderTerminal);
			map.put("startList", startList);
			map.put("pageNo", 1);
			map.put("pageSize", 10);*/
			/*Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
			Integer currPage = Integer.parseInt(request.getParameter("page"));
			if(size==null || size==0){
				size = 10;
			}
			int start = (currPage-1)*size;*/
			
			//Map<String, Object> map = new HashMap<String, Object>();
			/*map.put("start",start);
			map.put("limit",size);*/
			/*if(null != brandName && !"".equals(brandName)){
				map.put("brandName",brandName);
			}*/
			/*String bpid=request.getParameter(bpId);
			String starTime=request.getParameter(startTime);
			String endTime1=request.getParameter(endTime);
			String groupTime1=request.getParameter(groupTime);
			String initOrderTerminal1=request.getParameter(initOrderTerminal);
			String startList1=request.getParameter(startList);*/
			/*map.put("bpId",bpId);
			map.put("starTime",sTime);
			map.put("endTime",eTime);
			map.put("groupTime",groupTime);
			map.put("initOrderTerminal",initOrderTerminal);
			map.put("startList",startList);*/
			//map.put("limit",groupTime1);
		/*	String url=SystemConfig.PAY_SYSTEM;
			System.out.println("url"+url);
			
			try{
				json=HttpUtil.HttpPost(url,"admin/statistics/list.do", map);
				System.out.println("+++"+json+"+++");
							}catch(Exception e){
				e.printStackTrace();
				//json = "{'success':false}";
			}finally{
				*/
		
			
		}

		/**
		 * 导出excel
		 * 
		 * @Methods Name queryAllBrandCate
		 * @Create In 2015年8月8日 By wangsy
		 * @param request
		 * @param response
		 * @param brandName
		 * @return String
		 */
		@ResponseBody
		@RequestMapping(value="/statistic/statisticsExport")
		public String checkChannelExport(HttpServletRequest request, HttpServletResponse response) {
					String json = "";
			Map<String,String> paramMap = new HashMap<String,String>();
			Map<Object, Object> m = new HashMap<Object, Object>();
			paramMap.put("userId", CookieUtil.getUserName(request));
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				System.out.println("json:"+jsonStr);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_STATISTICS_EXPORT);
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
		 * excel渠道导出检查
		 * @Methods Name checkChannelExport
		 * @Create In 2015-12-17 By yangyinbo
		 * @param request
		 * @param response
		 * @return String
		 */
		@ResponseBody
		@RequestMapping(value="/statistics/checkStatisticsExport")
		public String checkStatisticsExport(HttpServletRequest request, HttpServletResponse response) {
					String json = "";
			Map<String,String> paramMap = new HashMap<String,String>();
			Map<Object, Object> m = new HashMap<Object, Object>();
		    paramMap.put("bpId", request.getParameter("bpId"));
			paramMap.put("endTime", request.getParameter("endTime"));
			paramMap.put("initOrderTerminal", request.getParameter("initOrderTerminal"));
			paramMap.put("showType", request.getParameter("showType"));
			paramMap.put("groupTime", request.getParameter("groupTime"));
			paramMap.put("startTime", request.getParameter("startTime"));
			paramMap.put("statList", request.getParameter("statList"));
			paramMap.put("userId", CookieUtil.getUserName(request));
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.CHECK_STATISTICS_EXPORT);
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
		@RequestMapping(value = "/statistics/getStatisticsToExcel",method={RequestMethod.GET,RequestMethod.POST})
		public String getChannelToExcel(HttpServletRequest request, HttpServletResponse response){
			String jsons = "";	
			String title = "payStatistics_"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"_";
			String json="";
			Map<String,String> paramMap = new HashMap<String,String>();
			Map<Object, Object> m = new HashMap<Object, Object>();
			if(StringUtils.isNotEmpty(request.getParameter("bpId"))){
				paramMap.put("bpId", request.getParameter("bpId"));
			}
			/*if(StringUtils.isNotEmpty(request.getParameter("pageSize"))){
				paramMap.put("pageSize", request.getParameter("pageSize"));
			}
			if(StringUtils.isNotEmpty(request.getParameter("page"))){
				paramMap.put("pageNo", request.getParameter("page"));
			}*/
			if(StringUtils.isNotEmpty(request.getParameter("startTime"))){
				paramMap.put("startTime", request.getParameter("startTime"));
			}
			if(StringUtils.isNotEmpty(request.getParameter("endTime"))){
				paramMap.put("endTime", request.getParameter("endTime"));
			}
			if(StringUtils.isNotEmpty(request.getParameter("groupTime"))){
				paramMap.put("groupTime", request.getParameter("groupTime"));
			}
			if(StringUtils.isNotEmpty(request.getParameter("initOrderTerminal"))){
				paramMap.put("initOrderTerminal", request.getParameter("initOrderTerminal"));
			}
			
			if(StringUtils.isNotEmpty(request.getParameter("statList"))){
				statList=request.getParameter("statList");
				paramMap.put("statList", statList);
			}
			/*if(StringUtils.isNotEmpty(request.getParameter("bpId"))&&!request.getParameter("bpId").equals("0")){
				paramMap.put("bpIds", request.getParameter("bpId"));
			}*/
			paramMap.put("pageSize", EXPORT_SIZE);
			paramMap.put("pageNo", "1");
			paramMap.put("userId", CookieUtil.getUserName(request));
			String str = JsonUtil.getJSONString(paramMap);
			try {
				String jsonStr = JSON.toJSONString(paramMap);
				logger.info("jsonStr:" + jsonStr);
				String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_STATISTICS_LIST);
				json=HttpClientUtil.post(url, paramMap);
				logger.info("json:" + json);
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject object=jsonObject.getJSONObject("data");
				JSONArray arr = object.getJSONArray("listData");
				title+=object.get("totalHit");
				List<ExcelStaticsVo> list = new ArrayList<ExcelStaticsVo>();
				if (arr != null && arr.size() != 0) {
					for (int i=0;i<arr.size();i++){
						JSONObject obj = arr.getJSONObject(i);
						ExcelStaticsVo vo = (ExcelStaticsVo) JSONObject.toBean(obj,ExcelStaticsVo.class);
						list.add(vo);
					}
					String result = allStaticsToExcel(response, list, title,statList);
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
		public String allStaticsToExcel(HttpServletResponse response,List<ExcelStaticsVo> list, String title,String statList) {
			List<String> header = new ArrayList<String>();
			
			header.add("时间区间");
			header.add("所属业务接口");


		    String msg = statList; 
		    System.out.print(msg);
			switch(msg) {
			case "0":header.add("支付成功金额");
			break;
			case "1":header.add("生成订单数");
			break;
			case "2":header.add("支付成功订单数");
			break;
			case "3":header.add("支付账号数");
			break;
			case "4":header.add("首次支付帐号数");
			break;
			
			}
			
		
			List<List<String>> data = new ArrayList<List<String>>();
			for(ExcelStaticsVo vo:list){
				List<String> inlist = new ArrayList<String>();		
				if(vo.getTime()!=null){
					//System.out.print("+++++++++++++++时间"+vo.getTime());
					//SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
					//inlist.add(sdf.format(vo.getTime()));
					inlist.add(vo.getTime()==null?"":vo.getTime());
				}else{
					inlist.add("");
				}
				inlist.add(vo.getBpName()==null?"":vo.getBpName());
				inlist.add(vo.getData()==null?"":vo.getData());
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
