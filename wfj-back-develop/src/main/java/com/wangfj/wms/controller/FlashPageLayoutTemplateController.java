/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerFlashPageLayoutController.java
 * @Create By chengsj
 * @Create In 2013-9-2 下午4:44:24
 * TODO
 */
package com.wangfj.wms.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.wms.domain.entity.PageLayoutTemplateMql;
import com.wangfj.wms.service.IPageLayoutTemplateMqlService;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name FlashPageLayoutController
 * @Author chengsj
 * @Create In 2013-9-2
 */

@Controller
@RequestMapping("/flashPageLayoutTemplate")
public class FlashPageLayoutTemplateController {

	@Autowired
	@Qualifier("pageLayoutTemplateMqlService")
	private IPageLayoutTemplateMqlService pageLayoutTemplateMqlService;

	@ResponseBody
	@RequestMapping(value = "/queryAllTemplates", method = RequestMethod.POST)
	public String queryAllTemplates(Model mode, HttpServletRequest request,
			HttpServletResponse response) {

		String json = "";
		try {

			List list = this.pageLayoutTemplateMqlService.queryAllTemplates();
			json = ResultUtil.createSuccessResult(list);

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryBySelect", method = RequestMethod.POST)
	public String queryBySelect(Model mode, String name,
			HttpServletRequest request, HttpServletResponse response) {

		String json = "";
		try {
			PageLayoutTemplateMql pageLayoutTemplateMql = new PageLayoutTemplateMql();
			if (name != null && !"".equals(name)) {
				pageLayoutTemplateMql.setName(name);
			}
			List list = this.pageLayoutTemplateMqlService
					.queryBySelect(pageLayoutTemplateMql);
			json = ResultUtil.createSuccessResult(list);

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/savePageLayoutTemplate", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String savePageLayoutTemplate(Model m, HttpServletRequest request,
			HttpServletResponse response, String name, String memo,
			String minProQuantity, String maxProQuantity, String template) {

		PageLayoutTemplateMql pageLayoutTemplateMql = new PageLayoutTemplateMql();
		if (name != null && !"".equals(name)) {
			pageLayoutTemplateMql.setName(name);
		}
		if (memo != null && !"".equals(memo)) {
			pageLayoutTemplateMql.setMemo(memo);
		}
		if (minProQuantity != null && !"".equals(minProQuantity)) {
			pageLayoutTemplateMql.setMinProQuantity(Integer
					.valueOf(minProQuantity));
		}
		if (maxProQuantity != null && !"".equals(maxProQuantity)) {
			pageLayoutTemplateMql.setMaxProQuantity(Integer
					.valueOf(maxProQuantity));
		}
		if (template != null && !"".equals(template)) {
			pageLayoutTemplateMql.setTemplate(template);
		}
		this.pageLayoutTemplateMqlService
				.insertSelective(pageLayoutTemplateMql);

		return ResultUtil.createSuccessResult();
	}

	@ResponseBody
	@RequestMapping(value = "/updatePageLayoutTemplate", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updatePageLayoutTemplate(Model m, HttpServletRequest request,
			HttpServletResponse response, String name, String memo,
			String minProQuantity, String maxProQuantity, String template,
			String sid) {

		PageLayoutTemplateMql pageLayoutTemplateMql = this.pageLayoutTemplateMqlService
				.selectByPrimaryKey(Integer.valueOf(sid));
		if (name != null && !"".equals(name)) {
			pageLayoutTemplateMql.setName(name);
		}
		if (memo != null && !"".equals(memo)) {
			pageLayoutTemplateMql.setMemo(memo);
		}
		if (minProQuantity != null && !"".equals(minProQuantity)) {
			pageLayoutTemplateMql.setMinProQuantity(Integer
					.valueOf(minProQuantity));
		}
		if (maxProQuantity != null && !"".equals(maxProQuantity)) {
			pageLayoutTemplateMql.setMaxProQuantity(Integer
					.valueOf(maxProQuantity));
		}
		if (template != null && !"".equals(template)) {
			pageLayoutTemplateMql.setTemplate(template);
		}
		this.pageLayoutTemplateMqlService
				.updateByPrimaryKeySelective(pageLayoutTemplateMql);

		return ResultUtil.createSuccessResult();
	}

	@ResponseBody
	@RequestMapping(value = "/delPageLayoutTemplate", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String delPageLayoutTemplate(Model m, HttpServletRequest request,
			HttpServletResponse response, String sid) {

		this.pageLayoutTemplateMqlService.deleteByPrimaryKey(Integer
				.valueOf(sid));
		return ResultUtil.createSuccessResult();
	}

}
