package com.wangfj.back.util;


import java.io.BufferedReader;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;


public class DataUtil {
	
	

	public static Object readRequest(HttpServletRequest request){
		 String str="";
		 String readerStr="";
		try {
			InputStreamReader in=new InputStreamReader(request.getInputStream(),"utf8");
			BufferedReader reader=new BufferedReader(in);
			while((str=reader.readLine())!=null){
				readerStr=readerStr+str;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return readerStr;
	}
	

	
}
