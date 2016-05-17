/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerSysParameterValueController.java
 * @Create By chengsj
 * @Create In 2013-11-28 下午4:22:11
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
import com.wangfj.wms.domain.entity.SysParameterValue;
import com.wangfj.wms.service.ISysParameterValueService;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name SysParameterValueController
 * @Author chengsj
 * @Create In 2013-11-28
 */
@Controller
@RequestMapping(value = "sysParameterValue")
public class SysParameterValueController {
	
	@Autowired
	@Qualifier("sysParameterValueService")
	private ISysParameterValueService sysParameterValueService;
	/**
	 * 说明：
	 * 		根据
	 * @Methods Name selectByName
	 * @Create In 2013-11-18 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectBySysParamType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectByType(Integer typeSid, HttpServletRequest request, HttpServletResponse response){
		
		String json = "";
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			List<SysParameterValue> list = this.sysParameterValueService.selectByParamType(typeSid);
			resultMap.put("sysParameterValues", list);
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			json = gson.toJson(resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		添加系统参数
	 * @Methods Name saveSysParameter
	 * @Create In 2013-12-2 By chengsj
	 * @param sysParameter
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveSysParameter(SysParameterValue sysParameter,HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			Integer id = this.sysParameterValueService.insert(sysParameter);
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
	 * 		删除系统参数
	 * @Methods Name deleteSysParameter
	 * @Create In 2013-12-2 By chengsj
	 * @param sid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteByPrimaryKey", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteSysParameter(Integer sid, HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			Integer id = this.sysParameterValueService.deleteByPrimaryKey(sid);
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
	public String updateSysParameter(SysParameterValue sysParameter, HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			if(sysParameter == null || sysParameter.getSid() == null || sysParameter.getSid() < 0) {
				json = ResultUtil.createFailureResult("", "要修改的记录不存在");
			}
			Integer id = this.sysParameterValueService.updateByPrimaryKeySelective(sysParameter);;
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
