/**
 * 说 明     : HttpClient
 * author: 陆湘星
 * data  : 2011-6-13
 * email : xiangxingchina@163.com
 **/
package com.utils.httpclient;

import java.io.IOException;
import java.util.List;


import org.apache.commons.httpclient.DefaultHttpMethodRetryHandler;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class HttpClientUtil {
	
	/**
	 * Get方式获取
	 * @param webUrl
	 * @param encoding
	 * @return
	 */
	public static String GetUrlContent(String webUrl,String encoding){
		if(encoding==null || "".equals(encoding)) encoding = "UTF-8";
		StringBuffer sBuffer = new StringBuffer();
		 //构造HttpClient的实例
	  	  HttpClient httpClient = new HttpClient();
	  	  //创建GET方法的实例
	  	  GetMethod getMethod = new GetMethod(webUrl);
	  	getMethod.addRequestHeader("Content-Type","text/html;charset="+encoding);
	  	  //使用系统提供的默认的恢复策略
	  	  getMethod.getParams().setParameter(HttpMethodParams.RETRY_HANDLER,
	  	    new DefaultHttpMethodRetryHandler());
	  	  try {
	  	   //执行getMethod
	  	   int statusCode = httpClient.executeMethod(getMethod);
	  	   if (statusCode != HttpStatus.SC_OK) {
//	  	    System.err.println("Method failed: "	  	      + getMethod.getStatusLine());
	  	   }
	  	   //读取内容 
	  	   byte[] responseBody = getMethod.getResponseBody();
	  	   //处理内容
	  	   sBuffer.append(new String(responseBody,encoding));
	  	  } catch (HttpException e) {
	  	   //发生致命的异常，可能是协议不对或者返回的内容有问题
//	  	   System.out.println("Please check your provided http address!");
	  	   e.printStackTrace();
	  	  } catch (IOException e) {
	  	   //发生网络异常
	  	   e.printStackTrace();
	  	  } finally {
	  	   //释放连接
	  	   getMethod.releaseConnection();
	  	  }
	  	  return sBuffer.toString();
	}
	
	

	
	/**
	 * 根据PageUrl获取Content
	 * @param webUrl
	 * @param parametersBody
	 * @param encoding
	 * @return
	 */
	public static String PostUrlContent(String webUrl,List<Parameter> parameters,String encoding){
		if(encoding==null || "".equals(encoding)) encoding = "UTF-8";
				StringBuffer sBuffer = new StringBuffer();
				//构造HttpClient的实例
			  	HttpClient httpClient = new HttpClient();
	  	  		//创建POS方法的实例
			  	NameValuePair[] pairs = null;
			  	PostMethod postMethod = new PostMethod(webUrl);
			  	if(parameters!=null && parameters.size()>0){
			  		pairs = new NameValuePair[parameters.size()];
			  		for (int i = 0; i < parameters.size(); i++) {
			  			Parameter parameter = parameters.get(i);
			  			pairs[i] = new NameValuePair(parameter.getKey(), parameter.getValue());
					}
			  		postMethod.setRequestBody(pairs); 
			  	}
			  	postMethod.getParams().setParameter( HttpMethodParams.HTTP_CONTENT_CHARSET, encoding);  
			  	
	  	  try {
	  	   //执行getMethod
	  	   int statusCode = httpClient.executeMethod(postMethod);
	  	   if (statusCode != HttpStatus.SC_OK) {
	  	    System.err.println("Method failed: " + postMethod.getStatusLine());
	  	   }
	  	   //读取内容 
	  	   byte[] responseBody = postMethod.getResponseBody();
	  	   //处理内容
	  	   sBuffer.append(new String(responseBody,encoding));
	  	  } catch (HttpException e) {
	  	   //发生致命的异常，可能是协议不对或者返回的内容有问题
	  	   System.out.println("Please check your provided http address!");
	  	   e.printStackTrace();
	  	  } catch (IOException e) {
	  	   //发生网络异常
	  	   e.printStackTrace();
	  	  } finally {
	  	   //释放连接
	  		postMethod.releaseConnection();
	  	  }
	  	  return sBuffer.toString();
	}
	
}
