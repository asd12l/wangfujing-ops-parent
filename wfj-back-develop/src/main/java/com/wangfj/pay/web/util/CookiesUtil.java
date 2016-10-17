package com.wangfj.pay.web.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;


public class CookiesUtil {
	/**
	 * 获取当前用户名
	 * @param request
	 * @return
	 * sunfei
	 * 2016-09-26
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
}
