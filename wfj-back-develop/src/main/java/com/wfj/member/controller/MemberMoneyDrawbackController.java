package com.wfj.member.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.pay.web.vo.ExcelBalanceVo;
import com.wangfj.search.utils.CookieUtil;
import com.wfj.member.pojo.Withdraw;

@Controller
@RequestMapping("/memDrawback")
public class MemberMoneyDrawbackController {
	private static Logger log =  LoggerFactory.getLogger(MemberMoneyDrawbackController.class);
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
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
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
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== applyWithdrawals url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
			System.err.println("=============method:"+method);
			System.err.println("======== applyWithdrawals url "+url+ method+"  =========");
			jsonString = HttpUtil.HttpPost(url,method, map);
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
			jsonString = json.toString();
		}
		return jsonString;
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
			HttpServletResponse response,String sid, String cancelReason,String checkStatus) {
		log.info("======== giveupApplyWithdrawals  =========");
		String method = "/moneyWithdrawals/giveupApplyWithdrawals.do";
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("sid", sid);
		map.put("cancelReason", cancelReason);
		map.put("checkStatus", checkStatus);
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
		int pageNo = (currPage - 1) * 10;
		if(pageNo < 0){
			pageNo = 0;
		}
		Gson gson = new Gson();
		List<Object> list = new ArrayList<Object>();
		String jsonString = gson.toJson(list);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("pageNo", pageNo);
		map.put("pageSize", 10);
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
			jsonString = HttpUtil.doPost(url+method, net.sf.json.JSONObject.fromObject(map).toString());
			JSONObject json = JSONObject.parseObject(jsonString);
			JSONArray ja = json.getJSONArray("object");
			if(ja == null || ja.size() == 0){
				json.put("pageCount", 0);
				return json.toString();
			}
			int pageCount = ja.size() % 10 == 0 ? ja.size() / 10 : (ja.size() / 10 + 1);
			json.put("pageCount", pageCount);
			return json.toString();
		} catch (Exception e) {
			JSONObject json = new JSONObject();
			json.put("code", "0");
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
		map.put("checkStatus",request.getParameter("hidcheckStatus") );
		map.put("refundStatus",request.getParameter("hidrefundStatus"));
		try {
			String url = CommonProperties.get("member_ops_url");
			log.info("======== getWithdrawlsList url "+url+"  =========");
			System.err.println("============== member_ops_url:" + url);
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
				String result = allOrderToExcel(response, list1, title);
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
	
	public String allOrderToExcel(HttpServletResponse response,List<Withdraw> list, String title) {
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
			if(vo.getRefundStatus()=="1"){
				inlist.add("待退款");
			}else if(vo.getRefundStatus() == "2"){
				inlist.add("退款成功");
			}else if(vo.getRefundStatus() == "3"){
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
