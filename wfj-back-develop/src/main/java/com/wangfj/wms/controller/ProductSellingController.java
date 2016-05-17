package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;

@Controller
@RequestMapping(value = "/productSelling")
public class ProductSellingController {
	
	//商品上下架
	@ResponseBody
	@RequestMapping(value="/updateProSelling", method = {RequestMethod.POST})
	public String updateProSelling(HttpServletRequest request , HttpServletResponse response){
		Map map = new HashMap();
		String sid = request.getParameter("sid");
		String pro_selling = request.getParameter("pro_selling");
		map.put("sid", sid);
		map.put("pro_selling",pro_selling);
		String json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/bw/BwProductSelling.html", map);
		return json;
	}
}
