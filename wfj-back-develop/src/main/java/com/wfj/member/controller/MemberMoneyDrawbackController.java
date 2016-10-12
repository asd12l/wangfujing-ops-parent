package com.wfj.member.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.back.service.ISysConfigService;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.search.utils.CookieUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wfj.member.pojo.ResultVO;
import com.wfj.member.pojo.Withdraw;
import com.wfj.member.utils.Constants;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/memDrawback")
public class MemberMoneyDrawbackController {
	private static Logger log =  LoggerFactory.getLogger(MemberMoneyDrawbackController.class);
	@Autowired
	private ISysConfigService sysConfigService;
	/**
	 * 发送验证码
	 */
	@ResponseBody
	@RequestMapping(value ="/sendPhoneCode", method = { RequestMethod.POST, RequestMethod.GET })
	public String sendPhoneCode(HttpServletRequest request,
			HttpServletResponse response,String phone) {
		log.info("======== sendPhoneCode  =========");
		String method = "/moneyWithdrawals/sendPhoneCode.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("phone", phone);
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== sendPhoneCode url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== sendPhoneCode url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
			JSONObject json = JSONObject.parseObject(jsonString);
			if("1".equals(json.getString("code"))){
				jsonString = HttpUtil.HttpPost(url,"/moneyWithdrawals/getFuJiBalanceMoeny.do", map);
			}
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 查看用户信息
	 */
	@ResponseBody
	@RequestMapping(value ="/getMemberInfoByMobile", method = { RequestMethod.POST, RequestMethod.GET })
	public String getMemberInfoByMobile(HttpServletRequest request,
			HttpServletResponse response,String mobile) {
		log.info("======== getMemberInfoByMobile  =========");
		String method = "/moneyWithdrawals/getMemberInfoBymobile.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("mobile", mobile);
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== sendPhoneCode url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== sendPhoneCode url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 查看余额
	 */
	@ResponseBody
	@RequestMapping(value ="/getFuJiBalanceMoeny", method = { RequestMethod.POST, RequestMethod.GET })
	public String getFuJiBalanceMoeny(HttpServletRequest request,
			HttpServletResponse response,String phone) {
		log.info("======== getFuJiBalanceMoeny  =========");
		String method = "/moneyWithdrawals/getFuJiBalanceMoeny.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("phone", phone);
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== getFuJiBalanceMoeny url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== getFuJiBalanceMoeny url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,"/moneyWithdrawals/getFuJiBalanceMoeny.do", map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 验证码验证
	 */
	@ResponseBody
	@RequestMapping(value ="/checkPhoneCode", method = { RequestMethod.POST, RequestMethod.GET })
	public String checkPhoneCode(HttpServletRequest request,
			HttpServletResponse response,String phone, String code) {
		log.info("======== checkPhoneCode  =========");
		String method = "/moneyWithdrawals/checkPhoneCode.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("phone", phone);
		map.put("codeNum", code);
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== checkPhoneCode url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== checkPhoneCode url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 提交退款申请
	 */
	@ResponseBody
	@RequestMapping(value ="/applyWithdrawals", method = { RequestMethod.POST, RequestMethod.GET })
	public String applyWithdrawals(HttpServletRequest request,
			HttpServletResponse response,String phone, String code, Long memberSid, Double balance1, 
			Double withdrowMoney, String name, String bank, String bankCardNo, String withdrowReason,
			String withdrowType, String withdrowMedium) {
		log.info("======== checkPhoneCode  =========");
		String method = "/moneyWithdrawals/applyWithdrawals.do";
/*		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);*/
		Map<Object, Object> map = new HashMap<Object, Object>();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		Random rd = new Random();
		String a="";
		for(int i=0; i<3; i++){
			a+=rd.nextInt(10);
		}
		String seqno = sf.format(new Date()) + a;
		map.put("applyName", phone);
		map.put("mobile", phone);
		map.put("memberSid", memberSid);
		map.put("balance", balance1);
		map.put("withdrowMoney", withdrowMoney);
		map.put("check_status", "1");
		map.put("name", name);
		map.put("bank", bank);
		map.put("bankCardNo", bankCardNo);
		map.put("withdrowReason", withdrowReason);
		map.put("withdrowType", withdrowType);
		map.put("withdrowMedium", withdrowMedium);
		map.put("seqno", seqno);
		map.put("applyCustomer", CookieUtil.getUserName(request));
		String url = CommonProperties.get("member_ops_url");
		String jsonString = null;
		try {
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", Constants.RESULT_FAIL);
			log.error("======== applyWithdrawals url "+url+"  ========= error: " + e.getMessage());
		}
		ResultVO resultVO =  new ResultVO();
		if(StringUtils.isNotBlank(jsonString)){
			JSONObject jsonObject = (JSONObject) JSONObject.parse(jsonString);
			if(jsonObject.getString("code").equals(Constants.MEMBER_OPS_SUCCESS_CODE)){
				resultVO.setCode(Constants.RESULT_SUCCESS);
			}else{
				resultVO.setCode(Constants.RESULT_FAIL);
				resultVO.setDesc(jsonObject.getString("desc"));
			}
		}else{
			resultVO.setCode(Constants.RESULT_FAIL);
			resultVO.setDesc("member-ops网络异常，请求超时！！！");
		}
		return JSONObject.toJSONString(resultVO);
	}
	
	/**
	 * 修改退款申请
	 */
	@ResponseBody
	@RequestMapping(value ="/editApplyWithdrawals", method = { RequestMethod.POST, RequestMethod.GET })
	public String editApplyWithdrawals(HttpServletRequest request,
			HttpServletResponse response,String sid, Double withdrowMoney, String name, String bank, String bankCardNo, String withdrowReason) {
		log.info("======== editApplyWithdrawals  =========");
		String method = "/moneyWithdrawals/editApplyWithdrawals.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("sid", sid);
		map.put("name", name);
		map.put("bank", bank);
		map.put("bankCardNo", bankCardNo);
		map.put("withdrowReason", withdrowReason);
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== editApplyWithdrawals url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== editApplyWithdrawals url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 取消退款申请
	 */
	@ResponseBody
	@RequestMapping(value ="/giveupApplyWithdrawals", method = { RequestMethod.POST, RequestMethod.GET })
	public String giveupApplyWithdrawals(HttpServletRequest request,
			HttpServletResponse response,String sid, String cancelReason,String checkStatus,String phone,String billno) {
		log.info("======== giveupApplyWithdrawals  =========");
		String method = "/moneyWithdrawals/giveupApplyWithdrawals.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("sid", sid);
		map.put("cancelReason", cancelReason);
		map.put("checkStatus", checkStatus);
		map.put("mobile", phone);
		map.put("billno", billno);
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== giveupApplyWithdrawals url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== giveupApplyWithdrawals url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 分页查询退款申请
	 */
	@ResponseBody
	@RequestMapping(value ="/getWithdrawlsList", method = { RequestMethod.POST, RequestMethod.GET })
	public String getWithdrawlsList(HttpServletRequest request,
			HttpServletResponse response, String hidsid, String hidapplyName, String hidcheckStatus, String hidrefundStatus,
			String hidStartApplyTime, String hidEndApplyTime, String hidStartCheckTime, String hidEndCheckTime) {
		log.info("======== getWithdrawlsList  =========");
		String method = "/moneyWithdrawals/getWithdrawlsList.do";
		Integer currPage;
		if(StringUtils.isBlank(request.getParameter("page"))){
			currPage = 0;
		}else{
			currPage = Integer.parseInt(request.getParameter("page"));
		}
		Integer size = null;
		String pageSize = request.getParameter("pageSize");
		if (pageSize == null || "0".equals(pageSize)){
			size = 10;
		}else{
			size = Integer.valueOf(pageSize);
		}
		int pageNo = (currPage - 1) * size;
		if(pageNo < 0){
			pageNo = 0;
		}

		Gson gson = new Gson();
		List<Object> list = new ArrayList<>();
		String jsonString;
		Map<Object, Object> map = new HashMap<>();
		map.put("pageNo", pageNo);
		map.put("pageSize", size);
		map.put("sid", hidsid);
		map.put("startApplyTime", hidStartApplyTime);
		map.put("endApplyTime", hidEndApplyTime);
		map.put("startCheckTime", hidStartCheckTime);
		map.put("endCheckTime", hidEndCheckTime);
		map.put("mobile", hidapplyName);
		map.put("checkStatus", hidcheckStatus);
		map.put("refundStatus", hidrefundStatus);
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== getWithdrawlsList url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== getWithdrawlsList url "+url+ method+"  =========");
			/*List<String> keys=new ArrayList<String>();
			keys.add("memberInfo");
			List<SysConfig>list1=sysConfigService.selectByKeys(keys);
			String value="";
			value = list1.get(0).getSysValue();
			map.put("mask",value);*/
			//屏显规则
			String json1 = "";
			String sysValue = "";
			String username = CookiesUtil.getCookies(request, "username");
			Map<Object, Object> paramMap = new HashMap<Object, Object>();
			paramMap.put("keys", "memberInfo");
			paramMap.put("username", username);
			try {
				log.info("paramMap:" + paramMap);
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
				log.error("查询屏显规则异常！返回结果json="+json1);
			}
			map.put("mask",sysValue);
			jsonString = HttpUtil.HttpPost(url,method, map);
			if (jsonString == null || "".equals(jsonString)){
				log.info("调取member-ops失败");
				JSONObject json = new JSONObject();
				json.put("code", "0");
				json.put("pageCount", 0);
				jsonString = json.toString();
				return jsonString;
			}
			JSONObject json = JSONObject.parseObject(jsonString);
			JSONObject jsonObject = json.getJSONObject("object");
			JSONArray ja = jsonObject.getJSONArray("resList");
			if(ja == null || ja.size() == 0){
				json.put("pageCount", 0);
				return json.toString();
			}
			int count = jsonObject.getInteger("count");
//			if (count == 0){
//				JSONArray resList = new JSONArray();
//				json.put("resList",resList);
//			}
			int pageCount = count % size == 0 ? count / size : (count / size + 1);
			json.put("pageCount", pageCount);
			return json.toString();
		} catch (Exception e) {
			log.error("getWithdrawlsList异常"+e.getMessage());
			JSONObject json = new JSONObject();
			json.put("code", "0");
			json.put("pageCount", 0);
			jsonString = json.toString();
			return jsonString;
		}
	}
	
	/**
	 * 审核通过
	 */
	@ResponseBody
	@RequestMapping(value ="/checkPass", method = { RequestMethod.POST, RequestMethod.GET })
	public String checkPass(HttpServletRequest request,
			HttpServletResponse response,String sid,
			 String billno) {
		log.info("======== checkPhoneCode  =========");
		String method = "/moneyWithdrawals/checkPass.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("sid", sid);
		map.put("billno", billno);
		map.put("p_Oper", CookieUtil.getUserName(request));
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== checkPass url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== checkPass url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 审核不通过
	 */
	@ResponseBody
	@RequestMapping(value ="/nopass", method = { RequestMethod.POST, RequestMethod.GET })
	public String nopass(HttpServletRequest request,
			HttpServletResponse response,String sid, String checkMemo,String checkStatus,String billno) {
		log.info("======== nopass  =========");
		String method = "/moneyWithdrawals/checkNoPass.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("sid", sid);
		map.put("checkMemo", checkMemo);
		map.put("checkStatus", checkStatus);
		map.put("billno", billno);
		map.put("p_Oper", CookieUtil.getUserName(request));
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== nopass url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== nopass url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 退款成功
	 */
	@ResponseBody
	@RequestMapping(value ="/refundTrue", method = { RequestMethod.POST, RequestMethod.GET })
	public String refundTrue(HttpServletRequest request,
			HttpServletResponse response,String sid,
			 String billno) {
		log.info("======== checkPhoneCode  =========");
		String method = "/moneyWithdrawals/refundTrue.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("sid", sid);
		map.put("billno", billno);
		map.put("p_Oper", CookieUtil.getUserName(request));
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== checkPass url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== checkPass url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 退款失败
	 */
	@ResponseBody
	@RequestMapping(value ="/refundFalse", method = { RequestMethod.POST, RequestMethod.GET })
	public String refundFalse(HttpServletRequest request,
			HttpServletResponse response,String sid,
			 String billno, String failReason) {
		log.info("======== checkPhoneCode  =========");
		String method = "/moneyWithdrawals/refundFalse.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("sid", sid);
		map.put("billno", billno);
		map.put("failReason", failReason);
		map.put("p_Oper", CookieUtil.getUserName(request));
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== checkPass url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== checkPass url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
	}
	
	/**
	 * 导出Excel
	 */
	@ResponseBody
	@RequestMapping(value = "/getWithdrowToExcel",method={RequestMethod.GET,RequestMethod.POST})
	public String getBalanceToExcel(HttpServletRequest request, HttpServletResponse response){
	
		String title = "withdrow_"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"_";
		String method = "/moneyWithdrawals/getWithdrawlsList.do";
		Gson gson = new Gson();
		List<Withdraw> list = new ArrayList<Withdraw>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		map.put("pageNo", 0);
		map.put("pageSize", 10000);
		map.put("sid", request.getParameter("hidsid"));
		map.put("startApplyTime",request.getParameter("hidStartApplyTime"));
		map.put("endApplyTime",request.getParameter("hidEndApplyTime"));
		map.put("startCheckTime",request.getParameter("hidStartCheckTime"));
		map.put("endCheckTime", request.getParameter("hidEndCheckTime"));
		map.put("applyName", request.getParameter("hidapplyName"));
		map.put("mobile", request.getParameter("hidapplyName"));
		map.put("checkStatus",request.getParameter("hidcheckStatus") );
		map.put("refundStatus",request.getParameter("hidrefundStatus"));
		//屏显规则
		String json1 = "";
		String sysValue = "";
		String username = CookiesUtil.getCookies(request, "username");
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("keys", "memberInfo");
		paramMap.put("username", username);
		try {
			log.info("paramMap:" + paramMap);
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
			log.error("查询屏显规则异常！返回结果json="+json1);
		}
		map.put("mask",sysValue);
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== getWithdrawlsList url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== getWithdrawlsList url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
			if (jsonString == null || "".equals(jsonString)){
				log.error(url+method+"getWithdrowToExcel查询提现申请单详情失败!");
				m.put("success", "false");
				m.put("msg", "导出异常！");
			}
			JSONObject json = JSONObject.parseObject(jsonString);
			JSONObject jsonObject = json.getJSONObject("object");
			JSONArray arr = jsonObject.getJSONArray("resList");
			List<Withdraw> list1 = new ArrayList<Withdraw>();
			if (arr != null && arr.size() != 0) {
				for (int i=0;i<arr.size();i++){
					JSONObject obj = arr.getJSONObject(i);
					Withdraw vo = (Withdraw) JSONObject.toJavaObject(obj,Withdraw.class);
					list1.add(vo);
				}
				String result = allOrderToExcel(response, list1, title,sysValue);
				m.put("success", "true");
				m.put("msg", "导出成功！");
			} else {
				m.put("success", "true");
				m.put("msg", "查询为空！");
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("msg", "导出异常！");
			log.error(e.getMessage());
		}
		
		Gson gson1 = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson1.toJson(m);
	}
	
	public String allOrderToExcel(HttpServletResponse response,List<Withdraw> list, String title,String sysValue) {
		List<String> header = new ArrayList<String>();
		
		header.add("申请单号");
		header.add("申请人");
		header.add("申请时间");
		header.add("提现原因");
		header.add("提现银行");
		header.add("提现金额");
//		header.add("UID");
		header.add("用户余额");
		header.add("取消原因");
		header.add("审核状态");
		header.add("审核备注");
		header.add("提现状态");
		header.add("审核人");
		header.add("审核时间");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(Withdraw vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getSeqno()==null?"":vo.getSeqno());
			if (!"1".equals(sysValue)){
				inlist.add(vo.getMobile()==null?"":vo.getMobile());
			}else {
				inlist.add(vo.getMobileStr()==null?"":vo.getMobileStr());
			}

			if(vo.getApplyTime()!=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				inlist.add(sdf.format(vo.getApplyTime()));
			}else{
				inlist.add("");
			}
			inlist.add(vo.getWithdrowReason()==null?"":vo.getWithdrowReason());
			inlist.add(vo.getBank()==null?"":vo.getBank());
			inlist.add(vo.getWithdrowMoney()==null?"":vo.getWithdrowMoney()+"");
			inlist.add(vo.getBalance()==null?"":vo.getBalance()+"");	
			inlist.add(vo.getCancelReason()==null?"":vo.getCancelReason());
			if("1".equals(vo.getCheckStatus())){
				inlist.add("待审核");
			}else if("2".equals(vo.getCheckStatus())){
				inlist.add("审核通过");
			}else if("3".equals(vo.getCheckStatus())){
				inlist.add("审核不通过");
			}else if("4".equals(vo.getCheckStatus())){
				inlist.add("取消");
			}else{
				inlist.add("");
			}
			inlist.add(vo.getCheckMemo()==null?"":vo.getCheckMemo());
			if("1".equals(vo.getRefundStatus())){
				inlist.add("待退款");
			}else if("2".equals(vo.getRefundStatus())){
				inlist.add("退款成功");
			}else if("3".equals(vo.getRefundStatus())){
				inlist.add("退款失败");
			}else{
				inlist.add("");
			}
			inlist.add(vo.getCheckName()==null?"":vo.getCheckName());
			if(vo.getCheckTime()!=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				inlist.add(sdf.format(vo.getCheckTime()));
			}else{
				inlist.add("");
			}
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}finally{
			try {
				response.getOutputStream().close();
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}
		
	}
	
	
	/**
	 * 导出Excel
	 */
	@ResponseBody
	@RequestMapping(value = "/getWithdrowToExcel2",method={RequestMethod.GET,RequestMethod.POST})
	public String getBalanceToExcel2(HttpServletRequest request, HttpServletResponse response){
	
		String title = "withdrow_"+new SimpleDateFormat("yyyy-MM-dd").format(new Date())+"_";
		String method = "/moneyWithdrawals/getWithdrawlsList.do";
		Gson gson = new Gson();
		List<Withdraw> list = new ArrayList<Withdraw>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<Object, Object> m = new HashMap<Object, Object>();
		map.put("pageNo", 0);
		map.put("pageSize", 10000);
		map.put("sid", request.getParameter("hidsid"));
		map.put("startApplyTime",request.getParameter("hidStartApplyTime"));
		map.put("endApplyTime",request.getParameter("hidEndApplyTime"));
		map.put("startCheckTime",request.getParameter("hidStartCheckTime"));
		map.put("endCheckTime", request.getParameter("hidEndCheckTime"));
		map.put("applyName", request.getParameter("hidapplyName"));
		map.put("checkStatus",request.getParameter("hidcheckStatus") );
		map.put("refundStatus",request.getParameter("hidrefundStatus"));
		try {
			String url = CommonProperties.get("member_core_url");
			log.info("======== getWithdrawlsList url "+url+"  =========");
			System.err.println("============== member_core_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== getWithdrawlsList url "+url+ method+"  =========");
			jsonString = HttpUtil.doPost(url+method, net.sf.json.JSONObject.fromObject(map).toString());
			JSONObject json = JSONObject.parseObject(jsonString);
			JSONArray arr = json.getJSONArray("object");
			List<Withdraw> list1 = new ArrayList<Withdraw>();
			if (arr != null && arr.size() != 0) {
				for (int i=0;i<arr.size();i++){
					JSONObject obj = arr.getJSONObject(i);
					Withdraw vo = (Withdraw) JSONObject.toJavaObject(obj,Withdraw.class);
					list1.add(vo);
				}
				String result = allOrderToExcel2(response, list1, title);
				m.put("success", "true");
				m.put("msg", "导出成功！");
			} else {
				m.put("success", "true");
				m.put("msg", "查询为空！");
			}
		} catch (Exception e) {
			m.put("success", "false");
			m.put("msg", "导出异常！");
			log.error(e.getMessage());
		}
		
		Gson gson1 = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson1.toJson(m);
	}
	
	public String allOrderToExcel2(HttpServletResponse response,List<Withdraw> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("申请单号");
		header.add("申请人");
		header.add("申请时间");
		header.add("提现原因");
		header.add("提现银行");
		
		header.add("开户名");
		header.add("卡号");
		
		header.add("提现金额");
//		header.add("UID");
		header.add("用户余额");
		header.add("取消原因");
		header.add("审核状态");
		header.add("审核备注");
		
		header.add("审核人");
		header.add("审核时间");
		header.add("退款状态");
		header.add("失败原因");
		header.add("退款人");
		header.add("退款时间");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(Withdraw vo:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(vo.getBillno()==null?"":vo.getBillno());
			inlist.add(vo.getMobile()==null?"":vo.getMobile());
			
			if(vo.getApplyTime()!=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				inlist.add(sdf.format(vo.getApplyTime()));
			}else{
				inlist.add("");
			}
			inlist.add(vo.getWithdrowReason()==null?"":vo.getWithdrowReason());
			inlist.add(vo.getBank()==null?"":vo.getBank());
			
			inlist.add(vo.getName()==null?"":vo.getName());
			inlist.add(vo.getBankCardNo()==null?"":vo.getBankCardNo());
			
			inlist.add(vo.getWithdrowMoney()==null?"":vo.getWithdrowMoney()+"");
			inlist.add(vo.getBalance()==null?"":vo.getBalance()+"");	
			inlist.add(vo.getCancelReason()==null?"":vo.getCancelReason());
			if(vo.getCheckStatus()=="1"){
				inlist.add("待审核");
			}else if(vo.getCheckStatus() == "2"){
				inlist.add("审核通过");
			}else if(vo.getCheckStatus() == "3"){
				inlist.add("审核不通过");
			}else if(vo.getCheckStatus() == "4"){
				inlist.add("取消");
			}else{
				inlist.add("");
			}
			
			inlist.add(vo.getCheckMemo()==null?"":vo.getCheckMemo());
			inlist.add(vo.getCheckName()==null?"":vo.getCheckName());
			if(vo.getCheckTime()!=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				inlist.add(sdf.format(vo.getCheckTime()));
			}else{
				inlist.add("");
			}
			if(vo.getRefundStatus()=="1"){
				inlist.add("待退款");
			}else if(vo.getRefundStatus() == "2"){
				inlist.add("退款成功");
			}else if(vo.getRefundStatus() == "3"){
				inlist.add("退款失败");
			}else{
				inlist.add("");
			}
			inlist.add(vo.getFailReason()==null?"":vo.getFailReason());
			inlist.add(vo.getRefundName()==null?"":vo.getRefundName());
			if(vo.getRefundTime()!=null){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				inlist.add(sdf.format(vo.getRefundTime()));
			}else{
				inlist.add("");
			}
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM"); 
			response.setHeader("Content-disposition",
					"attachment; filename=/"+title+".xls");
			
			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}finally{
			try {
				response.getOutputStream().close();
			} catch (IOException e) {
				log.error(e.getMessage());
			}
		}
		
	}
}
