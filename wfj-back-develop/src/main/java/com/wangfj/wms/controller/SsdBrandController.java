package com.wangfj.wms.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;

@RequestMapping(value="/SsdBrand")
@Controller
public class SsdBrandController {

	@RequestMapping(value="/queryAllSsdBrand")
	public String queryAllSsBrand(){
		String json = "";
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL, "/bw/queryAallSsdBrand.json", null);
		}catch(Exception e){
			json = "";
		}finally{
			
		}
		return json;
	}
}
