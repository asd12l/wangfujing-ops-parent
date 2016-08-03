package com.wangfj.back.controller;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.wangfj.back.util.CaptchaUtil;

@Controller
@RequestMapping(value="/mycaptcha")
public class CaptchaController {
	
	@RequestMapping(value="/image/*", method = { RequestMethod.GET, RequestMethod.POST })
	public void image(HttpServletRequest request, HttpServletResponse response){
		String projectRootPath = request.getServletContext().getRealPath("/");
		String requestPath = request.getRequestURI().substring(1);
		String picPath = requestPath.substring(requestPath.indexOf("mycaptcha")+10);
		String url = projectRootPath + picPath;
		String ss = picPath.substring(picPath.lastIndexOf("_")+1, picPath.lastIndexOf("."));
		try {
			CaptchaUtil captcha = new CaptchaUtil();
			if("big".equals(ss)){
				captcha.getBigPic(url, response.getOutputStream());
			} else {
				captcha.getLittlePic(url, response.getOutputStream());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/getCaptcha", method = { RequestMethod.GET, RequestMethod.POST })
	public String getCaptcha(HttpServletRequest request, HttpServletResponse response){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Random random = new Random();
		int name = random.nextInt(5)+1;
		int startX = random.nextInt(210)+50;
		int startY = random.nextInt(45);
		
		String bigPic = "/mycaptcha/image/" + name + "_" + startX + "_" + startY + "_big.do";
		String litPic = "/mycaptcha/image/" + name + "_" + startX + "_" + startY + "_lit.do";
		resultMap.put("success", true);
		resultMap.put("bigPic", bigPic);
		resultMap.put("litPic", litPic);
		resultMap.put("startX", startX);
		resultMap.put("startY", startY);
		return JSONObject.toJSONString(resultMap);
	}
	
	@ResponseBody
	@RequestMapping(value="/checked", method = { RequestMethod.GET, RequestMethod.POST })
	public String check(HttpServletRequest request, HttpServletResponse response){
		Date dateNow = new Date();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String moveX = request.getParameter("moveX");
		String startX = request.getParameter("startX");
		if("".equals(moveX) || moveX == null){
			resultMap.put("success", false);
			return JSONObject.toJSONString(resultMap);
		}
		int startXInt = Integer.valueOf(startX);
		int moveXInt = Integer.valueOf(moveX);
		if(Math.abs(startXInt - moveXInt) > 2){
			resultMap.put("success", false);
			return JSONObject.toJSONString(resultMap);
		}
		String datastr = request.getParameter("datastr");
		Date date = new Date(Long.valueOf(datastr));
		if((dateNow.getTime()-date.getTime())<1000){
			resultMap.put("success", false);
			return JSONObject.toJSONString(resultMap);
		}
		resultMap.put("success", true);
		return JSONObject.toJSONString(resultMap);
	}

}
