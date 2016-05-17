/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerNoticeTypeController.java
 * @Create By chengsj
 * @Create In 2013-11-18 下午2:35:46
 * TODO
 */
package com.wangfj.wms.controller;

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
import com.wangfj.wms.domain.entity.NoticeType;
import com.wangfj.wms.service.INoticeTypeService;
import com.wangfj.wms.util.ResultUtil;

/**
 * 说明：
 * 		公告类别
 * @Class Name NoticeTypeController
 * @Author chengsj
 * @Create In 2013-11-18
 */
@Controller
@RequestMapping(value = "/noticeType")
public class NoticeTypeController {
	@Autowired
	@Qualifier("noticeTypeService")
	private INoticeTypeService noticeTypeService;
	@ResponseBody
	@RequestMapping(value = "/selectAll", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectAll(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<NoticeType> list = this.noticeTypeService.selectAll();
		resultMap.put("noticeTypes", list);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	/**
	 * 说明：
	 * 		查询公告类别
	 * @Methods Name selectByName
	 * @Create In 2013-11-18 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectByParams", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectByName(HttpServletRequest request, HttpServletResponse response){
		String name = request.getParameter("noticeTypeName");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		NoticeType record = new NoticeType();
		if(name != null) {
			record.setName(name);
		}
		List<NoticeType> list = this.noticeTypeService.selectByParams(record);
		resultMap.put("noticeTypes", list);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	/**
	 * 说明：
	 * 		添加公告类型
	 * @Methods Name saveNoticeType
	 * @Create In 2013-11-18 By chengsj
	 * @param type
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveNoticeType(NoticeType type,HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			if(type == null || type.getName() == null || "".equals(type.getName())) {
				json = ResultUtil.createFailureResult("name", "name为空");
			} else {
				this.noticeTypeService.insert(type);
				json = ResultUtil.createSuccessResult();
			}
		} catch(Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		根据sid删除公告类型
	 * @Methods Name deleteNoticeType
	 * @Create In 2013-11-19 By chengsj
	 * @param type
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteByPrimaryKey", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteNoticeType(Integer sid, HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			if(sid == null) {
				json = ResultUtil.createFailureResult("sid", "sid不能为null");
				return json;
			}
			NoticeType noticeType = this.noticeTypeService.selectByPrimaryKey(sid);
			if(noticeType.getSid() == null) {
				json = ResultUtil.createFailureResult("sid", "没有主键为sid="+ sid +"的公告类型记录");
			} else {
				this.noticeTypeService.deleteByPrimaryKey(sid);
				json = ResultUtil.createSuccessResult();
			}
		} catch(Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/update", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateNoticeType(NoticeType noticeType, HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			if(noticeType.getSid() == null) {
				json = ResultUtil.createFailureResult("sid", "sid不能为null");
				return json;
			}
			Integer id = this.noticeTypeService.updateByPrimaryKey(noticeType);
			if(id != null && id != 0) {
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
