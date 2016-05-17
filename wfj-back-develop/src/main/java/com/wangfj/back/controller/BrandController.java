/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.controllerBrandController.java
 * @Create By chengsj
 * @Create In 2013-5-13 下午2:18:38
 * TODO
 */
package com.wangfj.back.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.InfoConstants.CodeInfo;
import com.framework.AbstractController;
import com.framework.page.Paginator;
import com.framework.returnObj.Infos;
import com.framework.validation.EValidator;
import com.wangfj.back.entity.cond.BrandCond;
import com.wangfj.back.service.IBrandservice;

/**
 * @Class Name BrandController
 * @Author chengsj
 * @Create In 2013-5-13
 */

@Controller
@RequestMapping(value="brand")
public class BrandController extends AbstractController {
	
	@Autowired
			@Qualifier(value = "brandService")
	IBrandservice brandService;
	/**
	 * 
	 * @Methods Name find
	 * @Create In 2013-5-13 By chengsj
	 * @param sid
	 * @param mode
	 * @param request
	 * @param response
	 * @return String
	 */
	@EValidator(value = "sid,主键,validate-required validate-length-max-32;")
	@ResponseBody
	@RequestMapping(value = "/{sid}", method = RequestMethod.GET)
	public String find(@PathVariable Long sid, Model mode,HttpServletRequest request, HttpServletResponse response) {

		Infos infos = init(request, "sid=" + sid);
		try {
			if (doValidate(infos)) {
				this.brandService.findObjBySid(infos, sid);
			}
		} catch (SQLException e) {
			infos.printLogExceptionLog(CodeInfo.SQL连接错误, e);
		} finally {
			return returnResultJson(infos);
		}
	}
	
	/**
	 * 
	 * @Methods Name query
	 * @Create In 2013-5-13 By chengsj
	 * @param cond
	 * @param mode
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/query", method = RequestMethod.POST)
	public String query(@ModelAttribute("brandCond") BrandCond cond,Model mode, HttpServletRequest request, HttpServletResponse response) {
		Infos infos = init(request, cond);
		// 验证
		Paginator page = null;
		try {
			page = (Paginator) brandService.queryObjs(infos, cond);
			setReturnObj(infos, page);
		} catch (Exception e) {
			infos.printLogExceptionLog(CodeInfo.SQL连接错误, e);
		} finally {
			return returnResultJson(infos);
		}
	}

	/**
	 * 
	 * @Methods Name insert
	 * @Create In 2013-5-13 By chengsj
	 * @param cond
	 * @param mode
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(@ModelAttribute("brandCond") BrandCond cond,Model mode, HttpServletRequest request, HttpServletResponse response) {
		Infos infos = init(request, cond);
		try {
			if (doValidate(infos)) {
				brandService.insert(infos, cond);
				setReturnObj(infos, true);
			}
		} catch (SQLException e) {
			infos.printLogExceptionLog(CodeInfo.SQL连接错误, e);
		} finally {
			return returnResultJson(infos);
		}
	}
	
	/**
	 * 
	 * @Methods Name update
	 * @Create In 2013-5-13 By chengsj
	 * @param cond
	 * @param mode
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute("brandCond") BrandCond cond,Model mode, HttpServletRequest request, HttpServletResponse response) {
		Infos infos = init(request, cond);
		try {
			if (doValidate(infos)) {
				brandService.update(infos, cond);
				setReturnObj(infos, true);
			}
		} catch (SQLException e) {
			infos.printLogExceptionLog(CodeInfo.SQL连接错误, e);
		} finally {
			return returnResultJson(infos);
		}
	}
	
	/**
	 * 
	 * @Methods Name delete
	 * @Create In 2013-5-13 By chengsj
	 * @param sid
	 * @param mode
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/delete/{sid}", method = RequestMethod.POST)
	public String delete(@PathVariable Long sid, Model mode,HttpServletRequest request, HttpServletResponse response) {
		
		Infos infos = init(request, "sid=" + sid);
		try {
			brandService.delete(infos, sid);
			setReturnObj(infos, true);
		} catch (SQLException e) {
			infos.printLogExceptionLog(CodeInfo.SQL连接错误, e);
		} finally {
			return returnResultJson(infos);
		}
	}

}
