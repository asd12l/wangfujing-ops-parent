package com.wangfj.wms.controller.product;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.back.controller.SecutityController;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/productDesc")
public class ProductDescController {
	
	protected final Log logger = LogFactory.getLog(SecutityController.class);
	
	@RequestMapping(value = "/loadProPacking", method = { RequestMethod.GET, RequestMethod.POST })
	public String loadColors(String proSid, Model m, String mark, HttpServletRequest request) {
		Map<String, Object> proMap = new HashMap<String, Object>();
		proMap.put("spuCode", proSid);
		String forwardUrl = "";
		String json = "";
		json = HttpUtilPcm.doPost(
				SystemConfig.SSD_SYSTEM_URL + "/productPrcture/queryColorBySpu.htm",
				JsonUtil.getJSONString(proMap));
		proMap.clear();

		try {
			if (!"".equals(json) && json != null) {
				JSONObject colorJson = JSONObject.fromObject(json);
				if ("true".equals(colorJson.get("success"))) {
					m.addAttribute("mark", mark);
					m.addAttribute("", "");
					m.addAttribute("colors", colorJson.get("data"));
					m.addAttribute("productCode", proSid);
					forwardUrl = "/product/ProFinePacking";
				} else {
					m.addAttribute("error", "系统异常，请联系管理员！");
					forwardUrl = "forward:/404.jsp";
				}
			} else {
				m.addAttribute("error", "系统异常，请联系管理员！");
				forwardUrl = "forward:/404.jsp";
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			m.addAttribute("error", "系统异常，请联系管理员！");
			forwardUrl = "forward:/404.jsp";
		}
		return forwardUrl;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getProPackingBySkuAndColorSid", method = { RequestMethod.GET, RequestMethod.POST })
	public String getProPackingBySkuAndColorSid(String proSid, Model m, String mark, String colorSid, HttpServletRequest request) {
		Map<String, Object> proMap = new HashMap<String, Object>();
		proMap.put("productSid", proSid);
		proMap.put("color", colorSid);
		
		JSONObject data = new JSONObject();
		String json = "";
		
		json = HttpUtilPcm.doPost(
				SystemConfig.SSD_SYSTEM_URL + "/productDesc/findListByParam.htm",
				JsonUtil.getJSONString(proMap));
		proMap.clear();

		try {
			if (!"".equals(json) && json != null) {
				JSONObject colorJson = JSONObject.fromObject(json);
				data.put("success", "true");
				data.put("data", colorJson.get("data"));
			} else {
				data.put("success", "false");
				data.put("data", "系统错误");
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
			data.put("success", "false");
			data.put("data", "系统错误");
		}
		return data.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/saveProPacking", method = { RequestMethod.GET, RequestMethod.POST })
	public String saveProPacking(String proSid, Model m, String mark, String colorSid,
			String contents, HttpServletRequest request) {
		Map<String, Object> proMap = new HashMap<String, Object>();
		proMap.put("productSid", proSid);
		proMap.put("color", colorSid);
		proMap.put("contents", contents);
		
		String json = "";
		
		json = HttpUtilPcm.doPost(
				SystemConfig.SSD_SYSTEM_URL + "/productDesc/addOrModifyProductDesc.htm",
				JsonUtil.getJSONString(proMap));
		proMap.clear();

		return json;
	}
}
