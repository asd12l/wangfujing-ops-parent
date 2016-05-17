/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerNoticeTypeController.java
 * @Create By chengsj
 * @Create In 2013-11-18 下午2:35:46
 * TODO
 */
package com.wangfj.wms.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.wms.domain.entity.ShopNotice;
import com.wangfj.wms.service.IShopNoticeService;
import com.wangfj.wms.util.ResultUtil;

/**
 * 说明：
 * 		公告管理
 * @Class Name ShopNoticeController
 * @Author chengsj
 * @Create In 2013-11-19
 */
@Controller
@RequestMapping(value = "/shopNotice")
public class ShopNoticeController {
	@Autowired
	@Qualifier("shopNoticeService")
	private IShopNoticeService shopNoticeService;

	
	/**
	 * 说明：
	 * 		根据公告类别查询公告
	 * @Methods Name selectByName
	 * @Create In 2013-11-18 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectByNoticeType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectByType(Integer typeSid, HttpServletRequest request, HttpServletResponse response){
		
		String json = "";
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			List<ShopNotice> list = this.shopNoticeService.selectByNoticeType(typeSid);
			resultMap.put("shopNotices", list);
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			json = gson.toJson(resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		保存网站公告
	 * @Methods Name saveShopNotice
	 * @Create In 2013-11-20 By chengsj
	 * @param shopNotice
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveShopNotice(ShopNotice shopNotice,HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			//公告生成时间
			Date noticesTime = new Date();
			shopNotice.setNoticesTime(noticesTime);
			shopNotice.setStatus(0);
			Integer id = this.shopNoticeService.insert(shopNotice);
			if(id != null && id >0) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("", "插入数据库失败");
			}
		} catch(Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		根据主键删除公告记录
	 * @Methods Name deleteShopNotice
	 * @Create In 2013-11-20 By chengsj
	 * @param sid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteByPrimaryKey", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteShopNotice(Integer sid, HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			Integer id = this.shopNoticeService.deleteByPrimaryKey(sid);
			if(id != null && id >0) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("", "删除记录失败");
			}
		} catch(Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/update", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateNoticeType(ShopNotice shopNotice, HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			if(shopNotice == null || shopNotice.getSid() == null || shopNotice.getSid() < 0) {
				json = ResultUtil.createFailureResult("", "要修改的记录不存在");
			}
			Integer id = this.shopNoticeService.updateByPrimaryKeySelective(shopNotice);;
			if(id != null && id > 0 ) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("", "更新失败");
			}
		} catch(Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
}
