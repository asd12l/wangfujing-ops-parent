package com.wangfj.pay.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.pay.web.constant.Constants;
import com.wangfj.pay.web.util.HttpClientUtil;

/**
 * 支付渠道类型
 * @author sunfei
 *
 */
@Controller
@RequestMapping(value="/wfjpay")
public class PayChannelTypeController {
	private static final Logger logger = LoggerFactory.getLogger(PayChannelTypeController.class);
	/**
	 * 查询渠道类型
	 */
	@ResponseBody
	@RequestMapping(value="/selectChannelType")
	public String selectChannelType(HttpServletRequest request, HttpServletResponse response) {
		String json="";
		Map<String,String> paramMap = new HashMap<String,String>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String url=CommonProperties.get(Constants.PAY_CORE_URL)+"/"+CommonProperties.get(Constants.SELECT_PAY_CHANNEL_TYPE);
			json=HttpClientUtil.post(url,paramMap);
			JSONObject jsonObject = JSONObject.fromObject(json);
			JSONArray object=jsonObject.getJSONArray("data");
			
			List<Object> list = new ArrayList<Object>();
			for (int i = 0; i < object.size(); i++) {
				Object object2 = object.get(i);
				list.add(object2);
			}
			if(list !=null && list.size() !=0){
			m.put("list", list);
			m.put("success", "true");
			m.put("msg", "查询下拉渠道类型列表成功！");
			} else {
				m.put("success", "false");
				m.put("msg", "查询下拉渠道类型列表成功！");
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("msg", "查询下拉渠道类型列表异常！");
			logger.error(e.getMessage());
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(m);
	}
}
