package com.wangfj.wms.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.URI;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * http工具类
 * @Class Name HttpUtil
 * @Author wangfei
 * @Create In 2014年10月28日
 */
public class HttpUtilPcm {
	private static final Logger LOGGER = LoggerFactory.getLogger(HttpUtil.class);
	private static final HttpClient httpClient;
	
	static {
        // 构造HttpClient的实例
		httpClient = new HttpClient();
        httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(50000); // 连接5秒超时
        httpClient.getHttpConnectionManager().getParams().setSoTimeout(70000);// 读取30秒超时
	}
	
    /**
     * 发送post请求工具方法
     * @Methods Name HttpPost
     * @Create In 2014年10月28日 By wangfei
     * @param url
     * @param method
     * @param paramMap
     * @return String
     */
    @SuppressWarnings("rawtypes")
    public static String HttpPost(String url, String method, Map paramMap) {
    	LOGGER.debug("url is {},method is {},paramMap is {}",new Object[]{url,method,paramMap});
        String encoding = "UTF-8";
        String webUrl = url + "/" + method;
        if (encoding == null || "".equals(encoding))
            encoding = "UTF-8";
        StringBuffer sBuffer = new StringBuffer();
        // httpClient.set
        // 创建POS方法的实例
        NameValuePair[] pairs = null;
        List<NameValuePair> list=new ArrayList<NameValuePair>();
        PostMethod postMethod = new PostMethod(webUrl);
        if (paramMap != null) {
            pairs = new NameValuePair[paramMap.size()];
            Set set = paramMap.keySet();
            Iterator it = set.iterator();
            int i = 0;
            while (it.hasNext()) {
                Object key = it.next();
                Object value = paramMap.get(key);
                if(!HttpUtilPcm.checkNull(value)){
                	 pairs[i] = new NameValuePair(key.toString(), value.toString());
                	 list.add(pairs[i]);
                }
                i++;
            }
            postMethod.setRequestBody(list.toArray(new NameValuePair[0]));
        }
        postMethod.setRequestHeader("Connection", "close"); 
        postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, encoding);
        try {
            // 执行getMethod
            int statusCode = httpClient.executeMethod(postMethod);
            if (statusCode != HttpStatus.SC_OK) {
            	LOGGER.error("statusCode is {},paramMap is {}",new Object[]{statusCode,paramMap});
                System.err.println("Method failed: " + postMethod.getStatusLine());
                sBuffer = new StringBuffer();
            } else {
                sBuffer = new StringBuffer(postMethod.getResponseBodyAsString() + "");
            }
        } 
        catch (Exception e) {
            LOGGER.error("paras is {},exception is {}",new Object[]{paramMap,e});
        } 
        finally {
            // 释放连接
            postMethod.releaseConnection();
        }
        String res=sBuffer.toString();
        LOGGER.debug("url is {},method is {},paramMap is {},res is {}",new Object[]{url,method,paramMap,res});
        return res;
    }
    
    /**
     * 发送Get请求工具方法
     * @Methods Name HttpGet
     * @Create In Dec 30, 2014 By lihongfei
     * @param url
     * @param method
     * @param paramMap
     * @return String
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public static String HttpGet(String url, String method, Map paramMap) {
    	LOGGER.debug("HttpGet url is {},method is {},paramMap is {}",new Object[]{url,method,paramMap});
    	//设置编码格式
        String encoding = "GBK";
        String webUrl = url + "/" + method;
        if (encoding == null || "".equals(encoding))
            encoding = "GBK";
        if(paramMap!=null){
	        String queryString = createLinkString(paramMap);
	        webUrl = webUrl+"?"+queryString;
        }
        StringBuffer sBuffer = new StringBuffer();
        // 构造HttpClient的实例
        GetMethod gettMethod = null;  
        // httpClient.set
        try {
		URI uri = new URI(webUrl,false,encoding);
	 
        gettMethod = new GetMethod(uri.toString());

        gettMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, encoding);
//        gettMethod.setRequestHeader("Connection", "close");
            // 执行getMethod
            int statusCode = httpClient.executeMethod(gettMethod);
            if (statusCode != HttpStatus.SC_OK) {
                System.err.println("Method failed: " + gettMethod.getStatusLine());
                sBuffer = new StringBuffer();
            } else {
                sBuffer = new StringBuffer(gettMethod.getResponseBodyAsString() + "");
            }
        } catch (Exception e) {
  
        } finally {
            // 释放连接
        	gettMethod.releaseConnection();
        }
        String res=sBuffer.toString();
        LOGGER.debug("url is {},method is {},paramMap is {},response is {}",new Object[]{url,method,paramMap,res});
        return res;
    }
    
    /**
     * 发送Get请求工具方法,处理参数有中文字符
     * @Methods Name HttpGet
     * @Create In Dec 30, 2014 By songw
     * @param url
     * @param method
     * @param paramMap
     * @return String
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public static String HttpGetByUtf(String url, String method, Map paramMap) {
    	//设置编码格式
        String encoding = "UTF-8";
        String webUrl = url + "/" + method;
        if (encoding == null || "".equals(encoding))
            encoding = "UTF-8";
        String queryString = createLinkString(paramMap);
        webUrl = webUrl+"?"+queryString;
        StringBuffer sBuffer = new StringBuffer();

        HttpClient httpClient = new HttpClient();
        GetMethod gettMethod = null;  
        // httpClient.set
        try {
		URI uri = new URI(webUrl,false,encoding);
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
            }
        } catch (Exception e) {
        	LOGGER.error("HttpGetByUtf url is {},method is {},paramMap is {},exception is {}",new Object[]{url,method,paramMap,e.getMessage()});
        } finally {
            // 释放连接
        	gettMethod.releaseConnection();
        }
        String res=sBuffer.toString();
        LOGGER.debug("url is {},method is {},paramMap is {},response is {}",new Object[]{url,method,paramMap,res});
        return res;
    }
    
    

    /**
     * 执行一个HTTP POST请求，返回请求响应的HTML
     * 
     * @param url
     *            请求的URL地址
     * @param params
     *            请求的查询参数,可以为null
     * @return 返回请求响应的HTML
     */
    @SuppressWarnings("deprecation")
    public static String doPost(String url, String json) {
    	LOGGER.debug("doPost url is {},parajson is {}",new Object[]{url,json});
        String response = null;
        PostMethod method = new PostMethod(url);
        method.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET, "UTF-8");
        // 设置Http Post数据       
        try {
            method.setRequestBody(json); 
            method.setRequestHeader("Connection", "close");
            method.setRequestHeader("Content-type", "application/json");
            HttpClient httpClientNew=new HttpClient();
			httpClientNew.getHttpConnectionManager().getParams().setConnectionTimeout(50000); // 连接5秒超时
			httpClientNew.getHttpConnectionManager().getParams().setSoTimeout(70000);// 读取30秒超时
			httpClientNew.executeMethod(method);
            //if (method.getStatusCode() == HttpStatus.SC_OK) {
                response = method.getResponseBodyAsString();
            //}
        } catch (Exception e) {
            LOGGER.error("url is {},parajson is {},Exception is {}",new Object[]{url,json,e.getMessage()});
        } finally {
            method.releaseConnection();
        }
        LOGGER.debug("url is {},parajsonjson is {},response is {}",new Object[]{url,json,response});
        return response;
    }
    
    /** 
     * 把数组所有元素排序，并按照“参数=参数值”的模式用“&”字符拼接成字符串
     * @param params 需要排序并参与字符拼接的参数组
     * @return 拼接后字符串
     */
    public static String createLinkString(Map<String, String> params) {

        List<String> keys = new ArrayList<String>(params.keySet());
        Collections.sort(keys);

        String prestr = "";

        for (int i = 0; i < keys.size(); i++) {
            String key = keys.get(i);
            String value = params.get(key);

            if (i == keys.size() - 1) {//拼接时，不包括最后一个&字符
                prestr = prestr + key + "=" + value;
            } else {
                prestr = prestr + key + "=" + value + "&";
            }
        }

        return prestr;
    }
    
    public static boolean checkNull(Object target) {
        if (target == null || "".equals(target.toString().trim()) || "null".equalsIgnoreCase(target.toString().trim())) {
            return true;
        }
        return false;
    }
}
