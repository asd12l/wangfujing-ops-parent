package com.wangfj.order.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.methods.ByteArrayRequestEntity;
import org.apache.commons.httpclient.methods.PostMethod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.order.utils.CommonProperties;

@Controller
@RequestMapping("/pay")
public class PaymentOrderController {
	
	private static Logger log =  LoggerFactory.getLogger(PaymentOrderController.class);
	public static final String FROM_SYSTEM = "ORDERBACK";
	/**
	 * @    如果需要改动：网站通过消息调用此接口，使用原有接口   kanglei
	 *
	 *
	 * 接口名称：/pay/payOrder
	 * 接口描述：通过网站传递的参数进行正常支付和超时支付的处理,并以json的形式返回支付结果
	 * @param request
	 * 			String fromSystem//系统
	 * 			String orderNo
	 * 			String tradeNo  银行交易号
	 * 			String totalFee 支付总金额
	 * 			String discount
	 * @param response
	 * 			{'success' : 'true'}
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/toPaymentOrder")
	public String selectOrder(HttpServletRequest request, HttpServletResponse response) {
		String result = "";
		String url = CommonProperties.get("order_pay");
		HttpClient httpClient = new HttpClient(new MultiThreadedHttpConnectionManager());
		PostMethod postMethod = new PostMethod(url);
		String orderNo = request.getParameter("orderNo");
		String tradeNo = request.getParameter("tradeNo");
		String totalFee = request.getParameter("totalFee");
		String discount = request.getParameter("discount");
		String t = "{'fromSystem':'"+FROM_SYSTEM +"','orderNo':'"+orderNo+"','tradeNo':'"
				+tradeNo+"','totalFee':'"+totalFee+"','discount':'"+discount+"'}";
		log.info("调用接口提交信息："+t);
		try {
			postMethod.setRequestEntity(new ByteArrayRequestEntity( t.getBytes("UTF-8")));
	  	} catch (Exception e1) {
			e1.printStackTrace();
			return "系统出现异常";
		}
	  	try {
			httpClient.getHttpConnectionManager().getParams().setConnectionTimeout(10000);
			httpClient.getHttpConnectionManager().getParams().setSoTimeout(10000);
		  	   int statusCode = httpClient.executeMethod(postMethod);
		  	   if (statusCode != HttpStatus.SC_OK) {
		  		   // 返回系统调用不通
		  		   return  "系统调用不通！";
		  	   }else{
		  		   String s;
		  		   StringBuffer sb = new StringBuffer();
		  			InputStream resStream = postMethod.getResponseBodyAsStream();
		  			BufferedReader in = new BufferedReader(new InputStreamReader(resStream, "utf-8"));
					while ((s = in.readLine()) != null)
					{
						sb.append(s);
						sb.append("\n");
					}
					String answerString = sb.toString();
					log.info("调用订单支付接口返回的信息"+answerString);
					return answerString;
		  	   }//结束
		  	  } catch (HttpException e) {
		  	   //
		  	 e.printStackTrace();
		  	   return "请检查你的调用地址";
		  	   
		  	  } catch (IOException e) {
		  		e.printStackTrace();
		  		 return "系统出现异常";
		  	  } finally {
		  		postMethod.releaseConnection();
		  	  }
	}
}
