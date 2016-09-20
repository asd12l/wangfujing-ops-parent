package com.wfj.member.controller;

import com.wangfj.back.util.HttpUtil;
import com.wangfj.cms.utils.Constants;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wfj.member.pojo.ResultVO;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by MaYong on 2015/11/24.
 * 会员积分相关
 */
@Controller
@RequestMapping("memScore")
public class MemScoreController {
	private static Logger logger = LoggerFactory.getLogger(MemCouponController.class);
//    1、查询积分
//    2、查询积分变化
	
	/**
	 * 积分记录查询
	 * @param
	 * @param
	 * @param
	 * @param
	 * @param
	 * @param
	 * @param page
	 * @param pageSize
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/searchMemberScore" , method = {RequestMethod.GET,RequestMethod.POST})
	public String searchMemberScore(HttpServletRequest request ,HttpServletResponse response,
			String hidAccount,String hidPhone,String hidEmail, String hidStartTime , String hidEndTime, String hidIntegralType ,String page,String pageSize ){
		JSONObject resultJson = new JSONObject();
		ResultVO resultVO =  new ResultVO();
		Map<String ,Object> map = new HashMap<String ,Object>();
		String url = CommonProperties.get("member_ops_url");
		String start = null;
		if(StringUtils.isNotBlank(pageSize)){
		}else{
			pageSize = Constants.PAGESIZE;
		}
		start = String.valueOf((Integer.parseInt(page) - 1) * Integer.parseInt(pageSize));
		if(StringUtils.isNotBlank(hidAccount)){
			map.put("account", hidAccount);
		}
		if(StringUtils.isNotBlank(hidPhone)){
			map.put("mobile", hidPhone);
		}
		if(StringUtils.isNotBlank(hidEmail)){
			map.put("email", hidEmail);
		}
		if(StringUtils.isNotBlank(hidStartTime)){
			map.put("startTime", hidStartTime);
		}
		if(StringUtils.isNotBlank(hidEndTime)){
			map.put("endTime", hidEndTime);
		}
		if(StringUtils.isNotBlank(hidIntegralType)){
			map.put("integralType", hidIntegralType);
		}
		if(StringUtils.isNotBlank(start)){
			map.put("page_no",page);
		}
		if(StringUtils.isNotBlank(pageSize)){
			map.put("page_size", pageSize);
		}
		String resultMemberScore = null;
		//屏显规则
		String json1 = "";
		String sysValue = "";
		String username = CookiesUtil.getCookies(request, "username");
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("keys", "memberInfo");
		paramMap.put("username", username);
		try {
			logger.info("paramMap:" + paramMap);
			json1 = HttpUtilPcm.HttpGet(CommonProperties.get("select_ops_sysConfig"),"findSysConfigByKeys",paramMap);
			if(!StringUtils.isEmpty(json1)){
				net.sf.json.JSONObject jsonObject = net.sf.json.JSONObject.fromObject(json1);
				String isTrue = jsonObject.getString("success");
				if(isTrue.equals("true")){
					net.sf.json.JSONArray jsonArray = jsonObject.getJSONArray("data");
					sysValue = jsonArray.getJSONObject(0).getString("sysValue");
				}
			}
		} catch (Exception e) {
			logger.error("查询屏显规则异常！返回结果json="+json1);
		}
		map.put("mask","1");
		/**
		 * 调用member-ops
		 */
		try{
			resultMemberScore = HttpUtil.HttpPost(url, "/memberScore/"+"searchMemberScore.do", map);
		}catch(Exception e){
			e.printStackTrace();
			logger.error(url+"/memberScore/"+"searchMemberScore.do"+"---------------param: "+map);
		}
		if(StringUtils.isNotBlank(resultMemberScore)){
			JSONObject resMemberJson = JSONObject.fromObject(resultMemberScore);
			String desc = (String) resMemberJson.get("desc");
			String code = (String) resMemberJson.get("code");
			if("1".equals(code)){
				JSONObject  ObjectJson = (JSONObject) resMemberJson.get("object");
				resultVO.setCode(Constants.SUCCRSSCODE);
				resultVO.setObject(ObjectJson.toString());
				resultVO.setPageCount(ObjectJson.getInt("page_count"));
			}
			if("参数缺失".equals(desc)){
				//默认可以不查出数据
				resultVO.setCode(Constants.SUCCRSSCODE);
				resultVO.setPageCount(0);
			}
			if(!"参数缺失".equals(desc) && "0".equals(code)){
				resultVO.setCode(Constants.FAILCODE);
				resultVO.setDesc((String) resMemberJson.get("desc"));
				resultVO.setPageCount(0);
			}
		}else{
			resultVO.setCode(Constants.FAILCODE);
			resultVO.setPageCount(0);
			resultVO.setDesc("网络异常");
		}
		resultJson = JSONObject.fromObject(resultVO);
		return resultJson.toString();
	}
}
