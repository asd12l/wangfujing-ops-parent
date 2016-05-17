/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerSysParameterTypeController.java
 * @Create By chengsj
 * @Create In 2013-11-27 下午2:01:35
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
import com.wangfj.wms.domain.entity.SysParameterType;
import com.wangfj.wms.service.ISysParameterTypeService;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name SysParameterTypeController
 * @Author chengsj
 * @Create In 2013-11-27
 */
@Controller
@RequestMapping(value = "/sysParameterType")
public class SysParameterTypeController {
	@Autowired
	@Qualifier("sysParameterTypeService")
	private ISysParameterTypeService sysParameterTypeService;
	
	/**
	 * 说明：
	 * 		查询系统参数类别
	 * @Methods Name selectByCode
	 * @Create In 2013-11-28 By chengsj
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectByCode", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectByCode(HttpServletRequest request, HttpServletResponse response){
		String code = request.getParameter("code");
		String json = "";
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			List<SysParameterType> list = this.sysParameterTypeService.selectByCode(code);
			resultMap.put("sysParameterTypeList", list);
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			json = gson.toJson(resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
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
	public String saveSysParameterType(SysParameterType type,HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			if(type == null || type.getCode() == null || "".equals(type.getCode())) {
				json = ResultUtil.createFailureResult("code", "code为空");
			} else {
				this.sysParameterTypeService.insert(type);
				json = ResultUtil.createSuccessResult();
			}
		} catch(Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		删除系统参数类型
	 * @Methods Name deleteSysParameterType
	 * @Create In 2013-11-28 By chengsj
	 * @param sid
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteByPrimaryKey", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteSysParameterType(Integer sid, HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			if(sid == null) {
				json = ResultUtil.createFailureResult("sid", "sid不能为null");
				return json;
			}
				Integer id = this.sysParameterTypeService.deleteByPrimaryKey(sid);
				if(id != null && id > 0) {
					json = ResultUtil.createSuccessResult();
				} else {
					json = ResultUtil.createFailureResult("", "该记录不存在");
				}
		} catch(Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	/**
	 * 说明：
	 * 		修改系统参数类型
	 * @Methods Name updateSysParameterType
	 * @Create In 2013-11-28 By chengsj
	 * @param type
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateSysParameterType(SysParameterType type, HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			if(type.getSid() == null) {
				json = ResultUtil.createFailureResult("sid", "记录不存在");
				return json;
			}
			Integer id = this.sysParameterTypeService.updateByPrimaryKeySelective(type);
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
