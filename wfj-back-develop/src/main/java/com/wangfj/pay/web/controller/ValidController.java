package com.wangfj.pay.web.controller;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ValidController {
	@RequestMapping("/wfjpay/valid/valStringLength")
	@ResponseBody
	public String valStringLength(Integer length,String content){
		JSONObject obj=new JSONObject();
		content=content.trim().replaceAll("[\u4e00-\u9fa5]", "00");
		if(content.length()>length){
			obj.put("valid", false);
		}else{
			obj.put("valid", true);
		}
		return obj.toString();
	}
	
}
	
