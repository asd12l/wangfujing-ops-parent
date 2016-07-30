package com.wangfj.edi.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.URI;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.DateUtils;
import com.utils.StringUtils;
import com.wangfj.edi.util.PropertiesUtil;
import com.wangfj.order.controller.OmsOrderController;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;

import net.sf.json.JSONObject;

/**
 * EDI操作日志控制器
 * @Class Name EdiLogController
 * @Author gaoshanhu
 * @Create In 2016-4-7
 */
@Controller
@RequestMapping("/ediLog")
public class EdiLogController {
	
	private static final Logger logger = LoggerFactory.getLogger(EdiLogController.class);
	
	/**
	 * 查询订单信息（带分页）
	 * @Methods Name selectOrderList
	 * @Create In 2016-01-21 By dingjf
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectLogList")
	public String selectLogList(String status,String tradesource,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer pageSize = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currentPage = Integer.parseInt(request.getParameter("page"));
		if(pageSize==null || pageSize==0){
			pageSize = 15;
		}
		int start = (currentPage-1)*pageSize;
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("userName", CookiesUtil.getUserName(request));
		paramMap.put("tid", request.getParameter("tid"));
		paramMap.put("channel", request.getParameter("channel"));
		paramMap.put("operationType", request.getParameter("operationType"));
		paramMap.put("operation", request.getParameter("operation"));
		
		paramMap.put("startDate", request.getParameter("startDate"));
		paramMap.put("endDate", request.getParameter("endDate"));
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);

			String url=	(String) PropertiesUtil.getContextProperty("edi_log_select");
			paramMap.put("currentPage", currentPage);
			paramMap.put("pageSize", pageSize);
			JSONObject jo = JSONObject.fromObject(paramMap);
			json =HttpUtilPcm.doPost(url, jo.toString());
			logger.info("json:" + json);
			paramMap.clear();
			if (!"".equals(json)) {
				JSONObject jsonPage = JSONObject.fromObject(json);
				if (jsonPage != null) {
					paramMap.put("list", jsonPage.get("list"));
					paramMap.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0) : jsonPage.get("pages"));
				} else {
					paramMap.put("list", null);
					paramMap.put("pageCount", Integer.valueOf(0));
				}
			} else {
				paramMap.put("list", null);
				paramMap.put("pageCount", Integer.valueOf(0));
			}
		} catch (Exception e) {
			paramMap.put("pageCount", Integer.valueOf(0));
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println(gson.toJson(paramMap));
		return gson.toJson(paramMap);
	}
	
}
