package com.wangfj.wms.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookiesUtil {
	
	/**
	 * 
	 * @Methods Name setCookies
	 * @Create In 2016年3月23日 By zdl
	 * @param response
	 * @param key
	 * @param value
	 * @param maxAge 失效时间
	 */
	public static void setCookies(HttpServletResponse response,
			String key, String value, Integer maxAge){
		Cookie cookie = new Cookie(key, value);
		cookie.setPath("/");
		if(maxAge != null){
			cookie.setMaxAge(maxAge);
		}
		response.addCookie(cookie);
	}
	
	/**
	 * 
	 * @Methods Name getCookies
	 * @Create In 2016年3月23日 By zdl
	 * @param request
	 * @param key
	 * @return String
	 */
	public static String getCookies(HttpServletRequest request, String key){
		Cookie[] cookies = request.getCookies();
		String value = null;
		try {
			for(Cookie cookie : cookies) {
			    if(key.equals(cookie.getName())) {
			    	value = cookie.getValue();
			    	break;
			    }
			}
		} catch (Exception e) {
			value = null;
		}
		return value;
	}
	
	/**
	 * 获取当前用户名
	 * @Methods Name getUserName
	 * @Create In 2016年4月6日 By zdl
	 * @param request
	 * @return String
	 */
	public static String getUserName(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		String value = null;
		try {
			for(Cookie cookie : cookies) {
			    if("username".equals(cookie.getName())) {
			    	value = cookie.getValue();
			    	break;
			    }
			}
		} catch (Exception e) {
			value = null;
		}
		return value;
	}
	
	/**
	 * 
	 * @Methods Name delCookies
	 * @Create In 2016年3月23日 By zdl
	 * @param response
	 * @param key
	 */
	public static void delCookies(HttpServletResponse response, String key){
		Cookie cookie = new Cookie(key, null);
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
	
	/**
	 * 
	 * @Methods Name delAllCookies
	 * @Create In 2016年3月23日 By zdl
	 * @param response
	 * @param request
	 */
	public static void delAllCookies(HttpServletRequest request, HttpServletResponse response){
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			Cookie cookie1 = new Cookie(cookie.getName(), null);
			cookie1.setMaxAge(0);
			cookie1.setPath("/");
			response.addCookie(cookie1);
		}
	}
}
