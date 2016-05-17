/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.PromotionController.java
 * @Create By chengsj
 * @Create In 2013-8-30 下午4:35:23
 * TODO
 */
package com.wangfj.wms.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.framework.page.Paginator;
import com.wangfj.wms.domain.entity.ErweimaPromotions;
import com.wangfj.wms.domain.view.ErweimaPromotionsVO;
import com.wangfj.wms.service.IErweimaPromotionService;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name ErweimaPromotionController
 * @Author chengsj
 * @Create In 2014-4-16
 */
@Controller
@RequestMapping("/erweimapromotions")
public class ErweimaPromotionController {

	@Autowired
			@Qualifier(value = "erweimapromotionService")
	IErweimaPromotionService erweimaPromotionService ;

	private int maxPostSize = 100 * 1024 * 1024;

	/**
	 * 说明： 分页查询活动记录
	 * 
	 * @Methods Name selectPromotions
	 * @Create In 2014-3-24 By chengsj
	 * @param key
	 */
	@ResponseBody
	@RequestMapping(value = "/selectErweimaPromotionListByKey", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectErweimaPromotionListByKey(ErweimaPromotionsVO key) {
		Paginator paginator = new Paginator();
		String resultJson = "";
		try {
			paginator.setPageSize(key.getPageSize());
			paginator.setCurrentPage(key.getCurrentPage());
			paginator.setTotalRecordsBuild(this.erweimaPromotionService
					.selectCountByPrams(key));
			paginator.setList(this.erweimaPromotionService
					.selectByPrams(key));
			resultJson = ResultUtil.createSuccessResultPage(paginator);
		} catch (Exception e) {
			resultJson = ResultUtil.createFailureResult(e);
		}
		return resultJson;
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveEwmPromotion", method = {RequestMethod.GET, RequestMethod.POST})
	public String saveEwmPromotion(HttpServletRequest request, HttpServletResponse response,
			String title,String proDesc,String seq,String url,
			String startTime,String endTime) throws ParseException{
		String json="";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		ErweimaPromotions erweimaPro = new ErweimaPromotions();
		if(title!=null&&!"".equals(title)){
			erweimaPro.setTitle(title);
		}
		if(proDesc!=null&&!"".equals(proDesc)){
			erweimaPro.setProDesc(proDesc);
		}
		if(seq!=null&&!"".equals(seq)){
			erweimaPro.setSeq(Integer.valueOf(seq));
		}
		if(url!=null&&!"".equals(url)){
			erweimaPro.setUrl(url);
		}
		if(startTime!=null&&!"".equals(startTime)){
			erweimaPro.setStartTime(sdf.parse(startTime));
		}
		if(endTime!=null&&!"".equals(endTime)){
			erweimaPro.setEndTime(sdf.parse(endTime));
		}
		
		try {
			this.erweimaPromotionService.insertSelective(erweimaPro);
			json = "{'success':true}";
		} catch (Exception e) {
			json = "{'success':false}";
			e.printStackTrace();
		}
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateerweimapromotion", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateerweimapromotion(HttpServletRequest request, HttpServletResponse response,
			String proSid,String proTitle,String upproDesc,String proSeq,String proUrl,
			String proStartTime,String proEndTime) throws ParseException{
		String json="";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		ErweimaPromotions erweimaPro = new ErweimaPromotions();
		if(proSid!=null&&!"".equals(proSid)){
			erweimaPro.setSid(Integer.valueOf(proSid));
		}
		if(proTitle!=null&&!"".equals(proTitle)){
			erweimaPro.setTitle(proTitle);
		}
		if(upproDesc!=null&&!"".equals(upproDesc)){
			erweimaPro.setProDesc(upproDesc);
		}
		if(proSeq!=null&&!"".equals(proSeq)){
			erweimaPro.setSeq(Integer.valueOf(proSeq));
		}
		if(proUrl!=null&&!"".equals(proUrl)){
			erweimaPro.setUrl(proUrl);
		}
		if(proStartTime!=null&&!"".equals(proStartTime)){
			erweimaPro.setStartTime(sdf.parse(proStartTime));
		}
		if(proEndTime!=null&&!"".equals(proEndTime)){
			erweimaPro.setEndTime(sdf.parse(proEndTime));
		}
		
		try {
			this.erweimaPromotionService.updateByPrimaryKeySelective(erweimaPro);
			json = "{'success':true}";
		} catch (Exception e) {
			json = "{'success':false}";
			e.printStackTrace();
		}
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/delEwmPromotion", method = {RequestMethod.GET, RequestMethod.POST})
	public String delEwmPromotion(HttpServletRequest request, HttpServletResponse response,String sid){
		
		String json = "";
		try {
			this.erweimaPromotionService.deleteByPrimaryKey(Integer.valueOf(sid));
			json = "{'success':true}";
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
	
       }
	@ResponseBody
	@RequestMapping(value = "/enableFlag", method = {RequestMethod.GET, RequestMethod.POST})
	public  String enableFlag(HttpServletRequest request, HttpServletResponse response,String sid) {
		String json = "";
		ErweimaPromotions erweimaPro = new ErweimaPromotions();
		erweimaPro.setFlag(1);
		erweimaPro.setSid(Integer.valueOf(sid));
		try {
			this.erweimaPromotionService.updateByPrimaryKeySelective(erweimaPro);
			json = "{'success':true}";
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/disableFlag", method = {RequestMethod.GET, RequestMethod.POST})
	public  String disableFlag(HttpServletRequest request, HttpServletResponse response,String sid) {
		String json = "";
		ErweimaPromotions erweimaPro = new ErweimaPromotions();
		erweimaPro.setFlag(0);
		erweimaPro.setSid(Integer.valueOf(sid));
		try {
			this.erweimaPromotionService.updateByPrimaryKeySelective(erweimaPro);
			json = "{'success':true}";
		} catch (Exception e) {
			json = "{'success':false}";
		}
		return json;
		
	}
}
