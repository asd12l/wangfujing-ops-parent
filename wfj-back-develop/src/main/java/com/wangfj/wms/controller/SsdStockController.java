package com.wangfj.wms.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;

@Controller
@RequestMapping(value = "/ssdStock1")
public class SsdStockController {
	@ResponseBody
	@RequestMapping(value = "/selectAllSupply2",method={RequestMethod.GET,RequestMethod.POST})
	public String getAllSupply2(){
		String json = "";
		try{
			Map map = new HashMap();
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllSupply2.json", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}
	@ResponseBody
	@RequestMapping(value = "/selectAllShop",method={RequestMethod.GET,RequestMethod.POST})
	public String getAllShop(){
		String json = "";
		try{
			Map map = new HashMap();
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAllShops.json", map);
		}catch(Exception e){
			json = "{'success':false}";
		}
		return json;
	}

}
