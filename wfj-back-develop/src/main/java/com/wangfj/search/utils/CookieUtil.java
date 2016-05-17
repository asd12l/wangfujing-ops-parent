package com.wangfj.search.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

public class CookieUtil {
	public static String getUserName(HttpServletRequest request){
		String username = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for(Cookie cookie : cookies){
				if(cookie.getName().equals("username")){
					username = cookie.getValue();
				}
			}
		}
		return username;
	}
}
