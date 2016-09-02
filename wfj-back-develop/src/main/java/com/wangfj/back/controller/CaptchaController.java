package com.wangfj.back.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.wangfj.back.entity.po.Captcha;
import com.wangfj.back.service.ICaptchaService;

@Controller
@RequestMapping(value="/mycaptcha")
public class CaptchaController {
	
	@Autowired
	ICaptchaService captchaService;
	
	@ResponseBody
	@RequestMapping(value="/getCaptcha", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCaptcha(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int count = 0;
		String maxRandomNum = request.getParameter("maxRandomNum");
		
		Captcha capParam = new Captcha();
		if(maxRandomNum == null || "".equals(maxRandomNum)){
			count = captchaService.selectCountBySelective(capParam);
		} else {
			count = Integer.valueOf(maxRandomNum);
		}
		
		Random random = new Random();
		List<Captcha> list = new ArrayList<Captcha>();
		do{
			int randomNum = random.nextInt(count)+1;
			capParam.setRandom(randomNum);
			list = captchaService.selectBySelective(capParam);
		}while(list.size() == 0);
		Captcha cap = list.get(0);
		resultMap.put("success", true);
		resultMap.put("bigPic", cap.getBigImg());
		resultMap.put("litPic", cap.getLitImg());
		resultMap.put("startX", cap.getStartX());
		resultMap.put("maxRandomNum", count);
		return JSONObject.toJSONString(resultMap);
	}
	
	@ResponseBody
	@RequestMapping(value="/checked", method = { RequestMethod.GET, RequestMethod.POST })
	public String check(HttpServletRequest request, HttpServletResponse response){
//		Date dateNow = new Date();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String moveX = request.getParameter("moveX");
		String startX = request.getParameter("startX");
		if("".equals(moveX) || moveX == null){
			resultMap.put("success", false);
			return JSONObject.toJSONString(resultMap);
		}
		int startXInt = Integer.valueOf(startX);
		double moveXInt = Double.valueOf(moveX);
		if(Math.abs(startXInt - moveXInt) > 3){
			resultMap.put("success", false);
			return JSONObject.toJSONString(resultMap);
		}
		/*String datastr = request.getParameter("datastr");
		Date date = new Date(Long.valueOf(datastr));
		if((dateNow.getTime()-date.getTime())<1000){
			resultMap.put("success", false);
			return JSONObject.toJSONString(resultMap);
		}*/
		resultMap.put("success", true);
		return JSONObject.toJSONString(resultMap);
	}

}
