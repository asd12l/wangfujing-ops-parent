package com.wangfj.wms.controller.brand;

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

/**
 * 品牌分类控制器
 * 
 * @Class Name BrandCategoryController
 * @Author wangsy
 * @Create In 2015年8月8日
 */
@Controller
@RequestMapping(value = "/brandCategory")
public class BrandCategoryController {

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
	@RequestMapping(value = "/selectAllBrandCategory",method={RequestMethod.GET,RequestMethod.POST})
	public String queryAllBrandCate(HttpServletRequest request, HttpServletResponse response,String brandName){
		String json="";
		Integer size = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if(size==null || size==0){
			size = 10;
		}
		int start = (currPage-1)*size;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start",start);
		map.put("limit",size);
		if(null != brandName && !"".equals(brandName)){
			map.put("brandName",brandName);
		}
		try{
			json =	HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllBrandCategory.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}finally{
			
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/liste",method={RequestMethod.GET,RequestMethod.POST})
	public String liste(String brandSid,String id){
		String json = "";
		
		try{
			Map<String, Object> map = new HashMap<String, Object>();
			if( null !=brandSid || "".equals(brandSid)){
				map.put("brandSid", brandSid);
			}
			if( null !=id || "".equals(id)){
				map.put("id", id);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/BrandCategoryListe2.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/edit",method={RequestMethod.GET,RequestMethod.POST})
	public String edit(Model model,HttpServletRequest request,HttpServletResponse response,
			String brandSid){
		String json="";
		try{
			Map<String, Object> map = new HashMap<String, Object>();
			if( null !=brandSid || "".equals(brandSid)){
				map.put("brandSid", brandSid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/BrandCategoryEdit.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/save",method={RequestMethod.GET,RequestMethod.POST})
	public String saveBrandCategory(String brandSid,String categorySid){
		String json="";
		try{
			Map<String, Object> map = new HashMap<String, Object>();
			if( null !=brandSid || "".equals(brandSid)){
				map.put("brandSid", brandSid);
			}
			if( null !=categorySid || "".equals(categorySid)){
				map.put("categorySid", categorySid);
			}
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/BrandCategorySave.html", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	
}
