package com.wangfj.edi.util;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.URI;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class HttpUtils {

	public static String HttpdoGet(String url) {

		// 设置编码格式
		String encoding = "UTF-8";
		if (encoding == null || "".equals(encoding))
			encoding = "UTF-8";
		StringBuffer sBuffer = new StringBuffer();

		HttpClient httpClient = new HttpClient();
		GetMethod gettMethod = null;
		// httpClient.set
		try {
			URI uri = new URI(url, false, encoding);
			gettMethod = new GetMethod(uri.toString());
			gettMethod.setRequestHeader("Connection", "close");
			gettMethod.setRequestHeader("Content-type", "text/html;charset=utf-8");
			gettMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, encoding);
			httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(5000); // 连接5秒超时
			httpClient.getHttpConnectionManager().getParams().setSoTimeout(30000);// 读取30秒超时
			// 执行getMethod
			int statusCode = httpClient.executeMethod(gettMethod);
			if (statusCode != HttpStatus.SC_OK) {
				System.err.println("Method failed: " + gettMethod.getStatusLine());
				sBuffer = new StringBuffer();
			} else {
				sBuffer = new StringBuffer(gettMethod.getResponseBodyAsString() + "");
				System.out.println(sBuffer);
			}
		} catch (Exception e) {
			System.out.println("cuo!!");
			System.out.println(e.getMessage());
			System.out.println("----------");
		} finally {
			// 释放连接
			gettMethod.releaseConnection();
		}
		String res = sBuffer.toString();
		return res;
	}
}
