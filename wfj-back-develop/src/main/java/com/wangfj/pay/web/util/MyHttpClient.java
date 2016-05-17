package com.wangfj.pay.web.util;

import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;

public class MyHttpClient {
	
	//超时时间
	private static int CONNECTION_TIMEOUT = 30 * 1000;
	//最大连接数
	private static int MAX_TOTAL=200;
	//设置单个路由最大的连接线程数量
	private static int DEFAULT_MAX_PER_ROUTE=20;
	private static CloseableHttpClient client = null;  //应用共享的对象
	
	private MyHttpClient(){};
	
//	/**
//	 * 通过静态调用获取对象，第一次调用为空时进行创建
//	 **/ 
//    public static synchronized HttpClient getHttpClient(){ 
//        if(client == null){ 
//        	client = HttpClients.custom().build();
//        } 
//        return client; 
//    }
    
    /**
     * 禁止clone，同样也是保证对象的唯一性
     **/ 
    public Object clone() throws CloneNotSupportedException{ 
        throw new CloneNotSupportedException(); 
    } 
    
	/**
	 * 通过静态调用获取对象，第一次调用为空时进行创建
	 **/ 
    public static synchronized CloseableHttpClient getHttpClient(){ 
        if(client == null){ 
        	//创建http request的配置信息  
        	RequestConfig requestConfig=RequestConfig.custom()
        			.setConnectionRequestTimeout(CONNECTION_TIMEOUT)
        		    .setConnectTimeout(CONNECTION_TIMEOUT)
        		    .setSocketTimeout(CONNECTION_TIMEOUT)
        		    .build();
        	
        	 //创建httpclient连接池 
        	PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager();
        	 // 将最大连接数增加到200
            cm.setMaxTotal(MAX_TOTAL);
            // 将每个路由基础的连接增加到20
            cm.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);
            
            //设置重定向策略  
            LaxRedirectStrategy redirectStrategy = new LaxRedirectStrategy(); 
            
            client = HttpClients.custom()
                    .setConnectionManager(cm)
                    .setDefaultRequestConfig(requestConfig)
//                    .setUserAgent(NewsConstant.USER_AGENT)
                    .setRedirectStrategy(redirectStrategy)
                    .build();
        } 
        return client; 
    }
}
