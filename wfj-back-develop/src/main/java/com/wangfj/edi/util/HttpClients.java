package com.wangfj.edi.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.URI;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;

import net.sf.json.JSONObject;

@SuppressWarnings("deprecation")
public class HttpClients {

	public static String httpdoGet(String url) {

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
			System.out.println("++++++++++" + statusCode);
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
		System.out.println("_res" + res);
		return res;
	}
	
	public static String sendPost(String url, String param) throws UnsupportedEncodingException {
        param=java.net.URLEncoder.encode(param, "UTF-8");
  		DataOutputStream  out= null;
//       /   PrintWriter out = null;
          BufferedReader in = null;
          String result = "";
         
          try {
              URL realUrl = new URL(url);
	             // 打开和URL之间的连接
	              URLConnection conn = realUrl.openConnection();

              // 设置通用的请求属性
              conn.setRequestProperty("accept", "*/*");
              conn.setRequestProperty("connection", "Keep-Alive");
           //  conn.setRequestProperty("user-agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
              conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
              // 发送POST请求必须设置如下两行
             conn.setDoOutput(true);
             conn.setDoInput(true);
             
             
             // 获取URLConnection对象对应的输出流
             out = new DataOutputStream(conn.getOutputStream());
             // 发送请求参数
             out.writeBytes(param);
             // flush输出流的缓冲
             out.flush();
             System.out.println("conn.getInputStream()::=="+conn.getInputStream());
             // 定义BufferedReader输入流来读取URL的响应
             in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
             String line;
             while ((line = in.readLine()) != null) {
                result += line;
            }
             if(conn !=null){
	        	 System.out.println("链接未关闭");	
	         }
 		} catch (Exception e) {
             System.out.println("发送 POST 请求出现异常！" + e);
             e.printStackTrace();
         }
         // 使用finally块来关闭输出流、输入流
         finally {
             try {
                 if (out != null) {
                     out.close();
                 }
                 if (in != null) {
                     in.close();
                }
               
             } catch (IOException ex) {
                 ex.printStackTrace();
             }
            
         }
        
         return result;
     }
	
	public static String httpPost(String url,JSONObject jsonParam){
        //post请求返回结果
        @SuppressWarnings("resource")
		DefaultHttpClient httpClient = new DefaultHttpClient();
        @SuppressWarnings("unused")
		JSONObject jsonResult = null;
        HttpPost method = new HttpPost(url);
        String str = "";
        try {
            if (null != jsonParam) {
                //解决中文乱码问题
                StringEntity entity = new StringEntity(jsonParam.toString(), "utf-8");
                entity.setContentEncoding("UTF-8");
                entity.setContentType("application/json");
                method.setEntity(entity);
            }
            HttpResponse result = httpClient.execute(method);
            url = URLDecoder.decode(url, "UTF-8");
            /**请求发送成功，并得到响应**/
            if (result.getStatusLine().getStatusCode() == 200) {
                try {
                    /**读取服务器返回过来的json字符串数据**/
                    str = EntityUtils.toString(result.getEntity(),HTTP.UTF_8);
                } catch (Exception e) {
                	e.printStackTrace();
                }
            }
        } catch (IOException e) {
        	e.printStackTrace();
        }
        return str;
    }
	
	/**
	 * 发送json数据
	 * @param response
	 * @param result
	 * @throws Exception 
	 */
	public static void sendResult(HttpServletResponse response, String result) throws Exception {
		try {
			response.setCharacterEncoding("utf-8");
			response.setContentType("application/json;charset=utf-8");
			response.setHeader("Pragma", "No-cache");
			response.setHeader("Cache-Control", "no-cache");
			response.setDateHeader("Expires", 0);
			response.getWriter().write(result);
			response.getWriter().flush();
		} catch(Exception ex) {
			ex.printStackTrace();
			throw new Exception("http返回失败");
		}
	}
}
