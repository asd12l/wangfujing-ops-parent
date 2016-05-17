/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.LeaveMessageTypeController.java
 * @Create By chengsj
 * @Create In 2013-8-14 下午6:54:18
 * TODO
 */
package com.wangfj.wms.controller;

import java.util.ArrayList;
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
import com.wangfj.wms.domain.entity.LeaveMessageType;
import com.wangfj.wms.service.ILeaveMessageTypeService;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name LeaveMessageTypeController
 * @Author chengsj
 * @Create In 2013-8-14
 */
@Controller
@RequestMapping(value = "/leaveMessageType")
public class LeaveMessageTypeController {

	@Autowired
			@Qualifier("leaveMessageTypeService")
	ILeaveMessageTypeService leaveMessageTypeService;

	@ResponseBody
	@RequestMapping(value = "/selectByPid", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectByPid(String pid, HttpServletRequest request,
			HttpServletResponse response) {

		String json = "";
		List list = null;
		try {
			if (pid != null && !"".equals(pid)) {
				list = this.leaveMessageTypeService.selectByPid(Integer
						.valueOf(pid));
			} else {
				LeaveMessageType leaveMessageType = new LeaveMessageType();
				list = this.leaveMessageTypeService
						.selectList(leaveMessageType);
			}
			json = ResultUtil.createSuccessResultJson(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	/**
	 * 说明：
	 * 
	 * @Methods Name selectByParentId
	 * @Create In 2013-12-2 By chengsj
	 * @param pid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectByParentId", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectByParentId(Integer pid, HttpServletRequest request,
			HttpServletResponse response) {

		String json = "";
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			List<LeaveMessageType> list =  new ArrayList<LeaveMessageType>();
			if(pid != null && pid == 9999) {
				 list = this.leaveMessageTypeService.selectList(new LeaveMessageType());
			} else {
				 list = this.leaveMessageTypeService.selectByParentId(pid);
			}
			resultMap.put("leaveMsgTypeList", list);
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			json = gson.toJson(resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 
	 * @Methods Name selectByParentIdBack
	 * @Create In 2015-6-2 By chenhu
	 * @param pid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectByParentIdBack", method = { RequestMethod.GET,
			RequestMethod.POST })
			public String selectByParentIdBack(Integer pid, HttpServletRequest request,
					HttpServletResponse response) {
		
		String json = "";
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			List<LeaveMessageType> list =  new ArrayList<LeaveMessageType>();
			if(pid == null){
				pid = 9999;
			}
			if(pid == 9999) {
				 list = this.leaveMessageTypeService.selectList(new LeaveMessageType());
			} else {
				 list = this.leaveMessageTypeService.selectByParentId(pid);
			}
			resultMap.put("leaveMsgTypeList", list);
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			json = gson.toJson(resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		保存新的留言类别
	 * @Methods Name saveLeaveMsgType
	 * @Create In 2013-12-5 By chengsj
	 * @param type
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveLeaveMsgType(LeaveMessageType type, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			Integer id = this.leaveMessageTypeService.insert(type);
			if(id != null && id >0) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("", "");
			}
		} catch(Exception e) {
		 	json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		根据tid删除留言分类记录
	 * @Methods Name deleteLeaveMsgType
	 * @Create In 2013-12-5 By chengsj
	 * @param tid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteByPrimaryKey", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteLeaveMsgType(Integer tid, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			if(tid == null || tid <1) {
				return ResultUtil.createFailureResult("", "该记录不存在");
			}
			List<LeaveMessageType> list = this.leaveMessageTypeService.selectByParentId(tid);
			if(list !=null && !list.isEmpty()) {
				json = ResultUtil.createFailureResult("", "删除失败,该留言类下有子节点");
			} else {
				Integer id = this.leaveMessageTypeService.deleteByPrimaryKey(tid);
				if(id != null && id >0) {
					json = ResultUtil.createSuccessResult();
				} else {
					json = ResultUtil.createFailureResult("","删除失败,请联系管理员");
				}
			}
		} catch(Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		修改留言类别
	 * @Methods Name update
	 * @Create In 2013-12-6 By chengsj
	 * @param type
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String update(LeaveMessageType type, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			List<LeaveMessageType> list = this.leaveMessageTypeService.selectByParentId(type.getTid());
			if(list != null && !list.isEmpty()) {
				return ResultUtil.createFailureResult("", "修改失败,该留言类下有子节点");
			}
			if(type != null && type.getPid() != null && type.getPid() == 9998) {
				type.setPid(null);
			}
			Integer id = this.leaveMessageTypeService.updateByPrimaryKeySelective(type);
			if(id != null && id >0) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("","修改失败,请联系管理员");
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
}
