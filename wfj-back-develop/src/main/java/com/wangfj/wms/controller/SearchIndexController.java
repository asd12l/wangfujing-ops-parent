package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * 
 * @Class Name SearchIndexController
 * @Author wwb
 * @Create In 2015-5-18
 */
@Controller
@RequestMapping(value = "/searchIndex")
public class SearchIndexController {
	/**
	 * 商品索引管理记录列表
	 */
	@ResponseBody
	@RequestMapping(value = "/getProIndexList",method={RequestMethod.GET,RequestMethod.POST})
	public String getProIndexList(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		//String chnId=request.getParameter("start");
		try {
			Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
			//Integer size = 10;
			Integer currPage = Integer.parseInt(request.getParameter("page"));
			if(size==null || size==0){
				size = 10;
			}
			int start = (currPage-1)*size;
			map.put("start", start);
			map.put("limit", size);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/indexOp/all/list.json", map);
			JSONObject jsonObj=new JSONObject();
			jsonObj=JSONObject.fromObject(json);
			if(jsonObj.get("success").equals(true)||jsonObj.get("success").equals("true")){
				int total=(Integer) jsonObj.get("total");
				int pageCount=total%size==0?total/size:(total/size+1);
				jsonObj.put("pageCount", pageCount);
				json=jsonObj.toString();
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 商品索引管理记录列表
	 */
	@ResponseBody
	@RequestMapping(value = "/proIndexFresh",method={RequestMethod.GET,RequestMethod.POST})
	public String proIndexFresh(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		//String chnId=request.getParameter("start");
		try {
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/indexOp/all/fresh.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 单件商品索引更新
	 */
	@ResponseBody
	@RequestMapping(value = "/proIndexSigleFresh",method={RequestMethod.GET,RequestMethod.POST})
	public String proIndexSigleFresh(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		String sid=request.getParameter("sid");
		try {
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/indexOp/single/fresh/"+sid+".json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 单件商品索引删除
	 */
	@ResponseBody
	@RequestMapping(value = "/proIndexSigleDel",method={RequestMethod.GET,RequestMethod.POST})
	public String proIndexSigleDel(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		String sid=request.getParameter("sid");
		try {
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/indexOp/cleanOut/"+sid+".json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 刷新前台缓存
	 * @Methods Name proIndexSigleDel
	 * @Create In 2015-5-19 By wwb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/flushWebCache",method={RequestMethod.GET,RequestMethod.POST})
	public String flushWebCache(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		//String sid=request.getParameter("sid");
		try {
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/cache/flush.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 品牌商品索引记录
	 * @Methods Name proIndexSigleDel
	 * @Create In 2015-5-19 By wwb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/brandProRecordList",method={RequestMethod.GET,RequestMethod.POST})
	public String brandProRecordList(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		//String sid=request.getParameter("sid");
		try {
			Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
			//Integer size = 10;
			Integer currPage = Integer.parseInt(request.getParameter("page"));
			if(size==null || size==0){
				size = 10;
			}
			int start = (currPage-1)*size;
			map.put("start", start);
			map.put("limit", size);
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/indexOp/brandPro/list.json", map);
			JSONObject jsonObj=new JSONObject();
			jsonObj=JSONObject.fromObject(json);
			if(jsonObj.get("success").equals(true)||jsonObj.get("success").equals("true")){
				int total=(Integer) jsonObj.get("total");
				int pageCount=total%size==0?total/size:(total/size+1);
				jsonObj.put("pageCount", pageCount);
				json=jsonObj.toString();
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 获取品牌商品列表
	 * @Methods Name proIndexSigleDel
	 * @Create In 2015-5-19 By wwb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/brandProList",method={RequestMethod.GET,RequestMethod.POST})
	public String brandProList(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		//String sid=request.getParameter("sid");
		try {
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/indexOp/brandPro/brands.json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 刷新品牌商品索引
	 * @Methods Name proIndexSigleDel
	 * @Create In 2015-5-19 By wwb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/freshBrandPro",method={RequestMethod.GET,RequestMethod.POST})
	public String freshBrandPro(HttpServletRequest request, HttpServletResponse response){
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		String sid=request.getParameter("brandSid");
		try {
			json = HttpUtil.HttpPost(SystemConfig.SEARCH_URL, "/admin/indexOp/brandPro/fresh/"+sid+".json", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
}
