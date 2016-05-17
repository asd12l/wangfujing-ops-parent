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
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;

@RequestMapping(value="/SsdProductStanDict")
@Controller
public class SsdProductStanDictController {
	
	/**
	 * 根据三级分类获取对应的商品规格
	 * @Methods Name getProStanDictByCategory
	 * @Create In 2015-3-4 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getProStanDictByCategory",method={RequestMethod.GET,RequestMethod.POST})
	public String getProStanDictByCategory(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		String categoryId = request.getParameter("categoryId");
		if(StringUtils.isNotEmpty(categoryId)){
			map.put("categoryId", categoryId);
		}
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/getProStanDictByCategory.json", map);
		} catch (Exception e) {
			e.printStackTrace();
			json = "";
		}
		return json;
	}
	/**
	 * 显示所有尺码属性信息，带分页功能
	 * @Methods Name queryAllStanDict
	 * @Create In 2015-1-5 By xuxu
	 * @param model
	 * @param request
	 * @param response
	 * @param sizeName
	 * @param classId
	 * @param start
	 * @param pageSize
	 * @return String
	 */
	@ResponseBody
	@RequestMapping( value ="/queryAllStanDict" ,method={RequestMethod.GET,RequestMethod.POST})
	public String queryAllStanDict(Model model ,HttpServletRequest request,HttpServletResponse response,
			String sizeName,String classId){
		String json = "";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		//Integer size = 10;
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(null != sizeName && !"".equals(sizeName)){
			map.put("sizeName", sizeName);
		}else if("10000001".equals(classId)) {
			try{
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllStanDict.json", null);
			}catch(Exception e){
				json = "";
			}finally{
				
			}
			return json;
		}
		if(null != classId && !"".equals(classId)){
			map.put("classId", classId);
		}
		
		map.put("start",start);
		map.put("limit",size);
			
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllStanDict.json", map);
		}catch(Exception e){
			
		}finally{
			
		}
		return json;
	}
	
	
	/**
	 *获得所有商品属性信息，不添加分页属性
	 * @Methods Name queryAllProductClssName
	 * @Create In 2015-1-5 By xuxu
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/queryaAllProductSizeName",method={RequestMethod.GET,RequestMethod.POST})
	public String queryAllProductClssName(){
		String json = "";
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllProductSizeName.json", null);
		}catch(Exception e){
		
		}finally{
			
		}
		return json;
	}
	
	/**
	 * 
	 * 添加商品尺码属性信息，可跟品牌关联。
	 * @Methods Name addProductSizeClass
	 * @Create In 2015-1-5 By xuxu
	 * @param model
	 * @param request
	 * @param response
	 * @param sid
	 * @param sizeName
	 * @param sizeDesc
	 * @param brandSid
	 * @param lastOptUser
	 * @param lastOptDate
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/addPorductSizeClass",method={RequestMethod.GET,RequestMethod.POST})
	public String  addProductSizeClass(Model model,HttpServletRequest request,HttpServletResponse response,
			String sizeClassSid,String sizeName,String sizeDesc,String brandSid,String lastOptUser,String lastOptDate){
		String json = null;
		Map<String,Object> map = new HashMap<String,Object>();
		if(null !=sizeClassSid & !"".equals(sizeClassSid)){
			map.put("sizeClassSid",sizeClassSid);
		}
		if(null != sizeName & !"".equals(sizeName)){
			map.put("sizeName",sizeName);
		}
		if(null !=sizeDesc & !"".equals(sizeDesc)){
			map.put("sizeDesc", sizeDesc);
		}
		if(null != brandSid & !"".equals(brandSid)){
			map.put("brandSid",brandSid);
		}
		if(null != lastOptUser & !"".equals(lastOptUser)){
			map.put("lastOptUser", lastOptUser);
		}
		if(null != lastOptDate & !"".equals(lastOptDate)){
			map.put(lastOptDate, lastOptDate);
		}
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/addProductSizeClass.json", map);
			if(null == json & "".equals(json)){
				return "{success:false}";
			}
		}catch(Exception e){
			return "{success:false}";
		}finally{
			
		}
		return json;
	}
	
	
	/**
	 * 删除尺码信息
	 * @Methods Name deleteStanDict
	 * @Create In 2015-1-5 By xuxu
	 * @param model
	 * @param request
	 * @param response
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/deleteStanDict",method={RequestMethod.GET,RequestMethod.POST})
	public String deleteStanDict(Model model ,HttpServletRequest request ,HttpServletResponse response,
			String sid ){
		String json = null;
		Map map = new HashMap();
		if(null != sid & !"".equals(sid)){
			map.put("sid",sid);
		}
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/deleteStanDict.json", map);
		}catch(Exception e){
			
		}finally{
			
		}
		return json;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/updateStanDict",method={RequestMethod.GET,RequestMethod.POST})
	public String updateStanDict(Model model,HttpServletRequest request,HttpServletResponse response,
		String sid,	String classId,String sizeName,String sizeDesc,String brandSid,String lastOptUser,String lastOptDate){
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null !=sid & !"".equals(sid)){
			map.put("sid",sid);
		}
		if(null !=classId & !"".equals(classId)){
			map.put("classId",classId);
		}
		if(null != sizeName & !"".equals(sizeName)){
			map.put("sizeName",sizeName);
		}
		if(null !=sizeDesc & !"".equals(sizeDesc)){
			map.put("sizeDesc", sizeDesc);
		}
		if(null != brandSid & !"".equals(brandSid)){
			map.put("brandSid",brandSid);
		}
		if(null != lastOptUser & !"".equals(lastOptUser)){
			map.put("lastOptUser", lastOptUser);
		}
		try{
			json = HttpUtil.HttpPostForJson(SystemConfig.SSD_SYSTEM_URL, "/bw/updateStanDict.html", map);
		}catch(Exception e){
			
		}finally{
			
		}
		return json;
	}
	
	
	/**
	 * 根据id查询商品尺码信息
	 * @Methods Name getProductStanDict
	 * @Create In 2015-1-5 By xuxu
	 * @param sid
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/getProductStanDict",method={RequestMethod.GET,RequestMethod.POST})
	public String getProductStanDict(String sid){
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null !=sid & !"".equals(sid)){
			map.put("sid", sid);
		}
		json = HttpUtil.HttpPostForJson(SystemConfig.SSD_SYSTEM_URL, "/bw/getProductStanDictById.html", map);
		return json;
	}
	
	
	
}
