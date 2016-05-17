package com.wangfj.order.controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.wangfj.order.entity.OrderDetailInfor;
import com.wangfj.order.entity.order;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;

@Controller
@RequestMapping(value = "/shop")
public class ShopController {

	@ResponseBody
	@RequestMapping(value = "/getAllShopList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllShopList(HttpServletRequest request,
			HttpServletResponse response) {
		String result = "";
		try { // http://192.168.40.116/oms_admin/back/addToOrder/selectShopInfo.json?start=0&pageSize=20
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("start", 0);
			map.put("pageSize", 10);
			result = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"),
					"/back/addToOrder/selectShopInfo.json", map);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		if (null == result && "".equals(result)) {
			return null;
		}

		return result;

	}
	
	
	
	

	@ResponseBody
	@RequestMapping(value = "/getAllShopProduct", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllShopProduct(HttpServletRequest request,
			HttpServletResponse response, String shopSid, String currentPage,
			String start, String pageSize, String limit) {
		Map map = new HashMap();
		String result = "";
		try {
			if (null != shopSid && !"".equals(shopSid)) {
				map.put("shopSid", shopSid);
				map.put("start", start);
				map.put("pageSize", limit);
				result = HttpUtil.HttpPost(CommonProperties.get("oms_core_url"),
						"/back/addToOrder/selectProductInfo.json", map);
			} else {
				return null;
			}
			if (null == result && "".equals(result)) {
				return null;
			} else {
				return result;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/addOrder", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String addOrder(HttpServletRequest request,
			HttpServletResponse response, String str, String receptName,
			String receptPhone, String receptAddress,String shopId) {
	
		BigDecimal seleSum = new BigDecimal(0);
		BigDecimal sumPrice = new BigDecimal(0);
		int sum  =0;
		Gson gson = new Gson();
		
		String strs ="";
		OrderDetailInfor order = new OrderDetailInfor();
		
		Map map = new HashMap();
		if (null == str && "".equals(str) && null == receptName
				&& "".equals(receptName) && null == receptPhone
				&& "".equals(receptPhone) && null == receptAddress
				&& "".equals(receptAddress)) {
			return "{success:false}";
		} else {
			
			order.setMemberSid(1);
			order.setSendCost("10.00");
			order.setReceptName(receptName);
			order.setReceptAddress(receptAddress);
			order.setReceptPhone(receptPhone);
			order.setPaymentTypeSid(1);
			order.setSendType(1);
			order.setOrderSourceSid(1101);
			order.setExtractFlag(0);
	/*		map.put("receptName", receptName);
			map.put("receptPhone", receptPhone);
			map.put("receptAddress", receptAddress);*/
			String array[] = new String[20];
			array = str.split("]");
			List list = new ArrayList();
			
		
			for (int i = 0; i < array.length; i++) {
			
				String params[] = array[i].split(",");
				order orderDetails = new order();
				for (int k = 0; k < params.length; k++) {
					
					if (params[k].split(":")[0].equals("productDetailSid")) {
					
					
						orderDetails.setProDetailSid(Integer.parseInt(params[k]
								.split(":")[1]));
					}
					if (params[k].split(":")[0].equals("promotionPrice")) {
						String s  = params[k].split(":")[1];
						seleSum = new BigDecimal(params[k].split(":")[1]);
						orderDetails.setPromotionPrice(new BigDecimal(
								params[k].split(":")[1]));
					}
					if (params[k].split(":")[0].equals("currentPrice")) {
						orderDetails.setCurrentPrice(new BigDecimal(
								params[k].split(":")[1]));
					}
					if (params[k].split(":")[0].equals("originalPrice")) {
						orderDetails.setOriginalPrice(new BigDecimal(
								params[k].split(":")[1]));
					}
					if (params[k].split(":")[0].equals("number")) {
						if (params[k].split(":")[1].equals("undefined")||null==params[k].split(":")[1]||"".equals(params[k].split(":")[1])) {
							
							orderDetails.setSaleSum(1);
						sum =orderDetails.getSaleSum();
						} else {
							orderDetails.setSaleSum(Integer.parseInt(params[k].split(":")[1]));
							sum =orderDetails.getSaleSum();
						}
					}
				}
				
				orderDetails.setQuickBuyBit(0);
		
					orderDetails.setSalePrice(orderDetails.getPromotionPrice());
					orderDetails.setExtractFlag(0);
					orderDetails.setShopSid(Integer.parseInt(shopId));
					
					
				list.add(orderDetails);
				sumPrice =sumPrice.add(seleSum.multiply( new BigDecimal(sum)));
			}

			order.setOrderDetails(list);
			order.setNeedSaleMoneySum(new BigDecimal(order.getSendCost()).add(sumPrice));
			 
			  strs= "{\"fromSystem\":\"THIRD\""+",\"order\":"+gson.toJson(order)+"}";
		}
		String result="";
		try {
			result = HttpUtil.sendPost(CommonProperties.get("oms_core")+"/order/ThridPartyOrderController",strs);
			if(null!=result && !"".equals(result)){
				if(-1!=result.indexOf("true")){
					return "{success:true}";
				}else{
					return "{success:false}";
				}
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "{success:false}";
		}
		return result;
	}

}
