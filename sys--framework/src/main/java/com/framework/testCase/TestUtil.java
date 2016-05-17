package com.framework.testCase;

public class TestUtil {
	public static String doGetTest(String url,String params){
		HttpClient client = new HttpClient(url);
		client.setParams(params);
		String content = client.getGetResult();
		System.out.println("result = "+content);
		return content;
	}
	public static String doPostTest(String url,String params){
		HttpClient client = new HttpClient(url);
		client.setParams(params);
		String content = client.getPostResult();
		System.out.println("result = "+content);
		return content;
	}
	public static String doPostTest(String url,String method,String params){
		HttpClient client = new HttpClient(url);
		if(method!=null&&!"".equals(method)) client.setParam("_method", method);
		client.setParams(params);
		String content = client.getPostResult();
		System.out.println("result = "+content);
		return content;
	}

}
