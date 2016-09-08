package com.wangfj.edi.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;

import javax.servlet.http.HttpServletRequest;

public class RequestUtils {
	/**
	 * 获取流数据
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	public static String getData(HttpServletRequest request) throws Exception {
		InputStream stream = null;
		try {
			stream = request.getInputStream();
			Reader reader = new InputStreamReader(request.getInputStream(),
					"UTF-8");
			StringBuilder response = new StringBuilder();
			final char[] buff = new char[1024];
			int read = 0;
			while ((read = reader.read(buff)) > 0) {
				response.append(buff, 0, read);
			}

			return response.toString();
		} catch (Exception e) {
			throw new Exception("数据获取失败");
		} finally {
			if (stream != null) {
				try {
					stream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public static String decode(String str) throws Exception{
    	return new String(str.getBytes("ISO-8859-1"), "UTF-8");
    }
	
	public static String hideSecret(String s,int front,int back) { 
		int len = s.length()-front-back;
		String xing = "";
		for (int i=0;i<len;i++) {
			xing+='*';
		}
		return s.substring(0,front)+xing+s.substring(s.length()-back);
	}

}
