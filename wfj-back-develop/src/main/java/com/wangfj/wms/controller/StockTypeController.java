package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;


@Controller
public class StockTypeController {
	
	/**
	 * 商品模块-商品信息管理-库类型字典管理-查询所有
	 * @Methods Name getList
	 * @Create In 2015-4-17 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param rows
	 * @param stockName
	 * @return String
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/stockType/list", method = {RequestMethod.POST,RequestMethod.GET})
	public String getList(Model model,HttpServletRequest request,HttpServletResponse response,
			String rows,String stockName){
		String json = null;
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		Map map = new HashMap();
		if(null!= rows && !"".equals(rows)){
			map.put("rows",rows);
		}
		if(null != stockName && !"".equals(stockName)){
			map.put("stockName",stockName);
		}
		map.put("start",start);
		map.put("limit",size);
		try{
			json =	HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/stockTypelist.json", map);
		}catch(Exception e){
			
		}finally{
			
		}
		return json;
	}
	
	/**
	 * 保存库类型字典
	 * @Methods Name save
	 * @Create In 2015-4-23 By wangsy
	 * @param model
	 * @param request
	 * @param response
	 * @param sid
	 * @param sid1
	 * @param stockName
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/stockType/save", method = {RequestMethod.GET,RequestMethod.POST})
	public String save(Model model,HttpServletRequest request,HttpServletResponse response,
			String sid,String sid1,String stockName){
		String json = "";
		Map map = new HashMap();
		try{
			if(null != sid && !"".equals(sid)){
				map.put("sid",sid);
			}
			if(null != sid1 && !"".equals(sid1)){
				map.put("sid1", sid1);
			}
			if(null != stockName  && !"".equals(stockName)){
				map.put("stockName",stockName);
			}
			json =	HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/stockTypesave.json", map);
		}catch(Exception e){
			//{"status":"failure","message":"操作失败"}
		}finally{
			
		}
		return json;
	}
    /**
     * 新增库类型名称，查询是否已重复
     * @Methods Name queryByStockName
     * @Create In 2015年3月27日 By chengsj
     * @param model
     * @param request
     * @param response
     * @param stockName
     * @return String
     */
	@ResponseBody
	@RequestMapping(value="/stockType/query",method={RequestMethod.POST,RequestMethod.GET})
	public String queryByStockName(Model model,HttpServletRequest request,HttpServletResponse response,String stockName){
		  String json="";
		  Map map=new HashMap();		  
		  if(null!=stockName&&!"".equals(stockName)){				  
			  map.put("stockName", stockName);				  
		  }
		  try {
			json=HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/stockTypequery.json", map);
		  } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{				
				
			}
	
         return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/stockType/delete", method = {RequestMethod.POST,RequestMethod.GET})
	public String delRow(Model model,HttpServletRequest request,HttpServletResponse response,String sid){
		String json = "";
		Map map = new HashMap();
		try{
			if(null !=sid && !"".equals(sid)){
				map.put("sid",sid);
			}
			json =	HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/stockTypedelete.json", map);
		}catch(Exception e){
			
		}finally{
			
		}
		return json ;
	}
	
}
