package com.wangfj.wms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.order.utils.HttpUtil;

@RequestMapping(value="/Color")
@Controller
public class SsdColorDictController {
	/**
	 * 获取所有颜色列表
	 * @Methods Name getAllColor
	 * @Create In 2014-12-31 By xuxu
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/getAllColor",method={RequestMethod.GET,RequestMethod.POST})
	public String getAllColor(){
		String json = "";
		try{
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,"/bw/getAllColor.json", null);
		}catch(Exception e){
			json="";
		}finally{
			
		}
		return json;
		
	}

}
