package com.wangfj.back.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.wangfj.edi.util.PropertiesUtil;

@Controller
@RequestMapping(value="loadSystemParam")
public class LoadSystemParamController {
	
	/**
     * 根据参数key值获取配置文件中的value
     *
     * @param productCode
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"/findValueFronSystemParamByKey"})
    public String findValueFronSystemParamByKey(String key) {
    	Map<String, Object> para = new HashMap<String, Object>();
    	try{
    		String value = PropertiesUtil.getDestValue("system.properties", key);
    		para.put("value", value);
    		para.put("success", true);
    	} catch(Exception e) {
    		para.put("msg", "系统错误");
    		para.put("success", false);
    	}
        return JSONObject.toJSONString(para);
    }
}
