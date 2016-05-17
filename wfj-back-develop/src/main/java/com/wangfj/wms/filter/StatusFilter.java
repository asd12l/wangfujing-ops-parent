/**
 * 说明: 
 *     后台过滤器，拦截所有POST请求，判断session是否有用户名，没有用户名返回跳转到登录页面
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.filterLoginFilter.java
 * @Create By wangc
 * @Create In 2015-12-17 下午2:33:34
 * TODO
 */
package com.wangfj.wms.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wangfj.wms.util.CookiesUtil;

/**
 * @Class Name StatusFilter
 * @Author wangc
 * @Create In 2015-12-17
 */
public class StatusFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		String url = httpRequest.getRequestURI();
//		String username = (String) httpRequest.getSession().getAttribute("username");
		String username = CookiesUtil.getCookies(httpRequest, "username");
		String type = httpRequest.getMethod();
		//System.out.println("url="+url+",type="+type+",username-="+username);
		if (url.endsWith("security/login")) {
			chain.doFilter(request, response);
			return;
		}
		if ("POST".equals(type)) {
			if (username == null || "".equals(username)) {
				if (httpRequest.getHeader("x-requested-with") != null
						&& httpRequest.getHeader("x-requested-with").equalsIgnoreCase(
								"XMLHttpRequest")) {
					httpResponse.setStatus(200);
					httpResponse.setHeader("sessionStatus", "sessionOut");				
				}
				return;
			} else {
				chain.doFilter(request, response);
				return;
			}
		} else {
			chain.doFilter(request, response);
			return;
		}

	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
