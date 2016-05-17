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
import com.wangfj.order.utils.HttpUtil;

@RequestMapping(value="/proStanClassDict")
@Controller
public class ProductStanClassDictContoller {

	/**
	 * 获取规格属性分类，一般取三级分类
	 * @Methods Name getProStanCategorys
	 * @Create In 2015-3-11 By chengsj
	 * @param model
	 * @param request
	 * @param respone
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/getProStanCategorys",method={RequestMethod.GET,RequestMethod.POST})
	public String getProStanCategorys(Model model, HttpServletRequest request,HttpServletResponse respone){
		String json  = "";
		Map<String,Object> map = new HashMap<String,Object>();
		try{
		json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,"/bw/getProStanCategorys.html" , map);
		}catch(Exception e){
			json = "";
		}finally{
			
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value="/queryAllSizeClass",method={RequestMethod.GET,RequestMethod.POST})
	public String queryAllProductSizeClass(Model model, HttpServletRequest request,HttpServletResponse respone){
		String json  = "";
		Map<String,Object> map = new HashMap<String,Object>();
		try{
		json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,"/bw/queryAllSizeClass.html" , map);
		}catch(Exception e){
			json = "";
		}finally{
			
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value="/getProSizeClass",method={RequestMethod.GET,RequestMethod.POST})
	public String getProSizeClass(String sid){
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null !=sid & !"".equals(sid)){
			map.put("sid",sid);
		}
		json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,"/bw/getProStanClass.html" , map);
		return json;
	}
	
}