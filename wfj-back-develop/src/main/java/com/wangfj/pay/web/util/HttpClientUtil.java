package com.wangfj.pay.web.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpClientUtil {
	private static final Logger log = LoggerFactory.getLogger(HttpClientUtil.class);
//	/**
//	 * Post请求
//	 * @param url
//	 * @param params
//	 * @return
//	 * @throws IOException 
//	 * @throws ClientProtocolException 
//	 */
//	public static String post(String url, Map<String, String> params) {
//		try{
//			//HttpPost连接对象          
//			HttpPost httpRequest = new HttpPost(url);
//			
//			//使用NameValuePair来保存要传递的Post参数         
//			List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();          
//	
//			//添加要传递的参数
//			for(String key : params.keySet()){
//				nameValuePairs.add(new BasicNameValuePair(key, params.get(key))); 
//			}
//	
//			//设置字符集             
//			HttpEntity httpentity = new UrlEncodedFormEntity(nameValuePairs, "UTF-8");
//	
//			//请求httpRequest             
//			httpRequest.setEntity(httpentity);              
//	
//			//取得默认的HttpClient              
//			HttpClient httpclient = MyHttpClient.getHttpClient();           
//			//取得HttpResponse             
//			HttpResponse httpResponse = httpclient.execute(httpRequest);              
//			
//			//HttpStatus.SC_OK表示连接成功              
//			if (httpResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
//				return EntityUtils.toString(httpResponse.getEntity(),"UTF-8");
//			}    
//		}catch(Exception e){
//			e.printStackTrace();
//			return null;
//		}
//		return null;
//	}
	
//	
//	/**
//	 * Post请求
//	 * @param url
//	 * @param params
//	 * @return
//	 * @throws IOException 
//	 * @throws ClientProtocolException 
//	 */
//	public static String postJSON(String url, JSONObject json) throws Exception {
//		
//		//HttpPost连接对象          
//		HttpPost httpRequest = new HttpPost(url);
//		
//		StringEntity se = new StringEntity(json.toString(), "UTF-8");   // 中文乱码在此解决
//		se.setContentType("application/json");
//		httpRequest.setEntity(se);
//
//		//取得默认的HttpClient              
//		HttpClient httpclient = MyHttpClient.getHttpClient();           
//
//		//取得HttpResponse             
//		HttpResponse httpResponse = httpclient.execute(httpRequest);         
//		
//		//HttpStatus.SC_OK表示连接成功              
//		if (httpResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
//			return EntityUtils.toString(httpResponse.getEntity(),"UTF-8");
//		}    
//		
//		return null;
//	}
//	
//	public static String get(String url, Map<String, String> params) throws Exception{
//		try{
//		//使用NameValuePair来保存要传递的Post参数         
//		List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();          
//
//		//添加要传递的参数
//		for(String key : params.keySet()){
//			nameValuePairs.add(new BasicNameValuePair(key, params.get(key))); 
//		}
//		
//		//对参数编码 
//		String param = URLEncodedUtils.format(nameValuePairs, "UTF-8");
//		
//		//将URL与参数拼接 
//		HttpGet httpRequest = new HttpGet(url + "?" + param); 
//		
//		System.out.println(url + "?" + param);
//
//		//取得默认的HttpClient              
//		HttpClient httpclient = MyHttpClient.getHttpClient();           
//
//		//取得HttpResponse             
//		HttpResponse httpResponse = httpclient.execute(httpRequest);              
//		
//		//HttpStatus.SC_OK表示连接成功              
//		if (httpResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
//			return EntityUtils.toString(httpResponse.getEntity(),"UTF-8");
//		}    
//		}catch(Exception e){
//			log.debug(e.getMessage());
//		}
//		return null;
//	}
//	/**
//	 * Post请求
//	 * @param url
//	 * @param params
//	 * @return
//	 * @throws IOException 
//	 * @throws ClientProtocolException 
//	 */
//	public static String postString(String url, String str) throws Exception {
//		
//		//HttpPost连接对象          
//		HttpPost httpRequest = new HttpPost(url);
//		
//		StringEntity se = new StringEntity(str, "UTF-8");   // 中文乱码在此解决
//		se.setContentType("application/json");
//		httpRequest.setEntity(se);
//
//		//取得默认的HttpClient              
//		HttpClient httpclient = MyHttpClient.getHttpClient();           
//
//		//取得HttpResponse             
//		HttpResponse httpResponse = httpclient.execute(httpRequest);         
//		
//		//HttpStatus.SC_OK表示连接成功              
//		if (httpResponse.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
//			return EntityUtils.toString(httpResponse.getEntity(),"UTF-8");
//		}    
//		
//		return null;
//	}
	
	/**
	 * Post请求
	 * @param url
	 * @param params
	 * @return
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 */
	public static String post(String url, Map<String, String> params) {
			String res=null;
			//HttpPost连接对象          
			HttpPost httpRequest = new HttpPost(url);
			CloseableHttpResponse response=null;
			//使用NameValuePair来保存要传递的Post参数         
			List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();          
	
			//添加要传递的参数
			for(String key : params.keySet()){
				nameValuePairs.add(new BasicNameValuePair(key, params.get(key))); 
			}
			try {
				//设置字符集             
				HttpEntity httpentity = new UrlEncodedFormEntity(nameValuePairs, "UTF-8");
				//请求httpRequest             
				httpRequest.setEntity(httpentity);              
				//取得默认的HttpClient              
				CloseableHttpClient httpclient = MyHttpClient.getHttpClient();    
				//执行请求
				response = httpclient.execute(httpRequest);
				//获得响应的消息实体  
	            HttpEntity entity = response.getEntity();  
				//HttpStatus.SC_OK表示连接成功              
				if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK){
					res=EntityUtils.toString(entity,"UTF-8");
				}   
				 //关闭httpEntity流  
	            EntityUtils.consume(entity); 
	            return res;
			} catch (ClientProtocolException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}  finally{           
				if(response!=null){
					try {
						response.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			
			 
		return null;
	}
}
