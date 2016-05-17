package com.wangfj.order.service.impl;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.wangfj.back.entity.vo.CheckAccounts;
import com.wangfj.order.entity.CodHandover;
import com.wangfj.order.entity.ExcelFile;
import com.wangfj.order.entity.RefundApply;
import com.wangfj.order.entity.RefundForExcel;
import com.wangfj.order.entity.Sale;
import com.wangfj.order.service.IExcelService;
import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.util.ResultUtil;

@Service("excelService")
public class ExcelServiceImpl implements IExcelService {

	@Override
	public String exprtExcel(HttpServletRequest request,
			HttpServletResponse response, List<CodHandover> list, String title) {
		// response.setCharacterEncoding("UTF-8");

		List<String> header = new ArrayList<String>();
		header.add("配送状态");
		header.add("订单号");
		header.add("父订单号");
		header.add("回款状态");
		header.add("销售时间");
		header.add("运单号");
		header.add("订单金额");
		header.add("订单商品金额");
		header.add("优惠券使用金额");
		header.add("顾客运费");
		header.add("发货金额");
		header.add("快递公司运费");
		header.add("省");
		header.add("市");
		header.add("区/县");
		header.add("快递公司");
		header.add("订单数量");
		header.add("发货数量");
		header.add("打印时间");
		header.add("发货时间");
		header.add("签收时间");
		header.add("退货时间");
		header.add("对账时间");
		header.add("回款时间");
		header.add("回款操作人");
		header.add("运费结算日期");
		header.add("运费差额");
		header.add("是否需要发票");
		header.add("订单重量");
		header.add("实际重量");
		header.add("异常信息");
		header.add("备注");
		String sendStatus = "";
		String returnMoneyStatus = "";
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		List<List<String>> data = new ArrayList<List<String>>();
		for (CodHandover cod : list) {
			List<String> inlist = new ArrayList<String>();

			if (cod.getSendStatus() == 1) {
				sendStatus = "配送在途";
			} else if (cod.getSendStatus() == 2) {
				sendStatus = "配送成功";
			} else if (cod.getSendStatus() == 3) {
				sendStatus = "配送失败";
			} else if (cod.getSendStatus() == 4) {
				sendStatus = "正常退货";
			}
			if (cod.getReturnMoneyStatus() == 1) {
				returnMoneyStatus = "已对账未回款";
			} else if (cod.getReturnMoneyStatus() == 2) {
				returnMoneyStatus = "已回款未结邮费";
			} else if (cod.getReturnMoneyStatus() == 3) {
				returnMoneyStatus = "已结邮费";
			} else if (cod.getReturnMoneyStatus() == 0) {
				returnMoneyStatus = "未对账";
			}
			inlist.add(sendStatus);
			inlist.add(cod.getOrderNo() + "");
			inlist.add(cod.getParentOrderNo() == null ? "" : cod.getParentOrderNo());
			inlist.add(returnMoneyStatus); // returnMoneyStatus
			inlist.add(cod.getSaleTime() == null ? "" : df.format(cod
					.getSaleTime()));// saleTime
			inlist.add(cod.getDelivetyNo() == null ? "" : cod.getDelivetyNo());// deliveryNo
			inlist.add(cod.getOrderMoneySum() + "");// orderMoneySum
			inlist.add(cod.getSaleMoneySum() + "");// saleMoneySum
			inlist.add(cod.getTicketSn() + "");// 优惠券使用金额
			inlist.add(cod.getNeedSendCost() + "");// needSendCost
			// inlist.add(cod.getNeedSaleMoney()+"");//sendMoneySum
			inlist.add(cod.getSendMoneySum() + "");
			inlist.add(cod.getPaySendCost() + "");// paySendCost
			inlist.add(cod.getInceptProvince() + "");// inceptProvince
			inlist.add(cod.getInceptCity() + "");// inceptCity
			inlist.add(cod.getInceptArea() + "");// inceptArea
			inlist.add(cod.getDeliveryComName() + "");// deliveryComName
			inlist.add(cod.getOrderNum() + "");// orderNum
			inlist.add(cod.getSendNum() + "");// sendNum
			inlist.add(cod.getPrintTime() == null ? "" : df.format(cod
					.getPrintTime()));// printTime
			inlist.add(cod.getSendTime() == null ? "" : df.format(cod
					.getSendTime()));// sendTime
			inlist.add(cod.getConfirmTime() == null ? "" : df.format(cod
					.getConfirmTime()));// confirmTime
			inlist.add(cod.getRefundTime() == null ? "" : df.format(cod
					.getRefundTime()));// refundTime
			inlist.add(cod.getCheckTime() == null ? "" : df.format(cod
					.getCheckTime()));// checkTime
			inlist.add(cod.getBackMoneyTime() == null ? "" : df.format(cod
					.getBackMoneyTime()));// backMoneyTime
			inlist
					.add(cod.getBackOptUser() == null ? "" : cod
							.getBackOptUser());// backOptUser
			inlist.add(cod.getSendMoneyConfirmTime() == null ? "" : df
					.format(cod.getSendMoneyConfirmTime()));// sendMoneyConfirmTime
			inlist.add(cod.getSendDiffMoney() + "");// sendDiffMoney
			inlist.add(cod.getNeedBill() + "");// needBill
			inlist.add(cod.getOrderWeight() + "");// orderWeight
			inlist.add(cod.getRealWeight() + "");// realWeight
			inlist.add(cod.getSendInfo() + "");// sendInfo
			inlist.add(cod.getRemark() + "");// remark
			data.add(inlist);
		}
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-disposition",
					"attachment; filename=/cod.xls");

			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}

	@Override
	public String exprtExcel(HttpServletResponse response, List<Sale> list,
			String title) {

		List<String> header = new ArrayList<String>();
		header.add("销售单号");
		header.add("订单号");
		header.add("父订单号");
		header.add("顾客实际支付运费");
		header.add("收银流水号");
		header.add("支付方式");
		header.add("销售时间");
		header.add("实际的销售编码");
		header.add("销售主单销售金额");
		header.add("销售主单销售数量");
		header.add("优惠券使用金额");
		header.add("店名");
		header.add("销售状态");
		header.add("退货类型");
		header.add("收款确认人");
		header.add("收货人地址");
		header.add("是否有调拨");
		header.add("备注");
		Map<String, String> refundMap = new HashMap<String, String>();
		refundMap.put("1", "部分退货");
		refundMap.put("2", "整单退货");
		refundMap.put("0", "没有退货");
		List<List<String>> data = new ArrayList<List<String>>();
		Map<String, String> paymentMap = getType("1");
		Map<String, String> saleStatusMap = getType("10");
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		for (Sale sale : list) {
			List<String> inlist = new ArrayList<String>();
			inlist.add(sale.getSaleNo() + "");
			inlist.add(sale.getOrderNo() + "");
			inlist.add(sale.getParentOrderNo() == null ? "" : sale.getParentOrderNo());
			inlist.add(sale.getPayCost() + "");
			inlist.add(sale.getCashierNumber() == null ? "" : sale
					.getCashierNumber());
			if (sale.getPaymentMode() != null) {
				inlist.add(paymentMap.get(sale.getPaymentMode().toString())
						+ "");
			} else {
				inlist.add("");
			}
			if (sale.getDraftTime() != null) {
				inlist.add(df.format(sale.getDraftTime()) + "");
			} else {
				inlist.add("");
			}
			;
			inlist.add(sale.getSaleCode() + "");
			inlist.add(sale.getSaleMoneySum() + "");
			inlist.add(sale.getSaleNumSum() + "");
			inlist.add(sale.getTicket() == null ? "" : sale.getTicket());
			inlist.add(sale.getShopName() + "");
			if (sale.getSaleStatus() != null) {
				inlist.add(saleStatusMap.get(sale.getSaleStatus().toString())
						+ "");
			} else {
				inlist.add("");
			}
			if (sale.getRefundTotalBit() != null) {
				inlist.add(refundMap.get(sale.getRefundTotalBit().toString())
						+ "");
			} else {
				inlist.add("");
			}
			inlist.add(sale.getPaymentRealName() == null ? "" : sale
					.getPaymentRealName());
			inlist.add(sale.getReceptAddress());
			if (sale.getAllotBit() != null && sale.getAllotBit() == 1) {
				inlist.add("需要调拨");
			} else {
				inlist.add("没有调拨");
			}
			inlist.add(sale.getOrderMemo() == null ? "" : sale.getOrderMemo());
			data.add(inlist);
		}
		title = "sheet1";
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-disposition",
					"attachment; filename=saleExcel.xls");

			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.getMessage();
		}
	}

	public Map<String, String> getType(String dictTypeCode) {

		String json = "";

		Map<String, String> parmMap = new HashMap<String, String>();
		if (dictTypeCode != null && dictTypeCode.length() > 0) {
			parmMap.put("dictTypeCode", dictTypeCode);
			try {
				json = com.wangfj.back.util.HttpUtil.HttpPost(CommonProperties
						.get("oms_core_url"),
						"back/dictItem/selectListByParam.json", parmMap);
			} catch (Exception e) {
				json = ResultUtil.createFailureResult(e);
			}
		}
		JSONObject resJson = JSONObject.fromObject(json);
		String resListJson = resJson.getString("list");
		JSONArray resArr = JSONArray.fromObject(resListJson);
		Map<String, String> map = new HashMap<String, String>();
		for (int i = 0; i < resArr.size(); i++) {
			map.put(resArr.getJSONObject(i).getString("dictItemCode"), resArr
					.getJSONObject(i).getString("dictItemName"));
		}
		return map;
	}

	/**
	 * 导出每日退货单
	 */
	@Override
	public String exprtRefundExcel(HttpServletResponse response,
			List<RefundForExcel> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("调入POS时间");
		header.add("退货门店");
		header.add("销售编码");
		header.add("订单号");
		header.add("父订单号");
		header.add("退货单号");
		header.add("原销售单号");
		header.add("流水号");
		header.add("退货数量");
		header.add("退货金额");
		header.add("退货原因");
		header.add("购买时间");
		header.add("支付方式");
		header.add("备注");
		Map<String, String> paymentMap = getType("1");
		List<List<String>> data = new ArrayList<List<String>>();
		for (RefundForExcel rfe : list) {
			List<String> inlist = new ArrayList<String>();
			inlist.add(rfe.getCashReturnedTime() == null ? "" : rfe
					.getCashReturnedTime());
			inlist.add(rfe.getShopName() == null ? "" : rfe.getShopName());
			inlist.add(rfe.getSaleCode() == null ? "" : rfe.getSaleCode());
			inlist.add(rfe.getOrderNo() == null ? "" : rfe.getOrderNo());
			inlist.add(rfe.getParentOrderNo() == null ? "" : rfe.getParentOrderNo());
			inlist.add(rfe.getRefundNo() == null ? "" : rfe.getRefundNo());
			inlist.add(rfe.getSaleNo() == null ? "" : rfe.getSaleNo());
			inlist.add(rfe.getCashierNumber() == null ? "" : rfe
					.getCashierNumber());
			inlist.add(rfe.getRefundNum() + "");
			inlist.add(rfe.getRefundMoneySum() == null ? "" : rfe
					.getRefundMoneySum()
					+ "");
			inlist.add(rfe.getRefundDesc() == null ? "" : rfe.getRefundDesc());
			inlist.add(rfe.getSaleTime() == null ? "" : rfe.getSaleTime());
			inlist.add(rfe.getPaymentTypeSid() == null ? "" : paymentMap
					.get(rfe.getPaymentTypeSid().toString()));
			inlist.add(rfe.getMemo() == null ? "" : rfe.getMemo());
			data.add(inlist);
		}

		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-disposition", "attachment; filename=/"
					+ title + ".xls");

			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}

	@Override
	public String exprtRefundApplyExcel(HttpServletResponse response,
			List<RefundApply> list, String title) {
		List<String> header = new ArrayList<String>();

		header.add("订单号");
		header.add("父订单号");
		header.add("支付方式");
		header.add("退货数量");
		header.add("退款总金额");
		header.add("公司应付运费");
		header.add("顾客购买运费");
		header.add("顾客寄回运费");
		// header.add("顾客应付运费");
		header.add("退券金额");
		header.add("实际退款金额");
		header.add("退货类型");
		header.add("退货申请单状态");
		header.add("退货申请单号");
		header.add("优惠券使用金额");
		header.add("收货人");
		header.add("退款确认人姓名");
		header.add("退货申请时间");
		header.add("财务退款时间");
		header.add("物流确认收货时间");
		header.add("物流备注");
		header.add("客服备注");

		List<List<String>> data = new ArrayList<List<String>>();
		Map<String, String> paymentMap = getType("1");
		Map<String, String> refundTypeMap = getType("5");
		Map<String, String> refundApplyMap = getType("7");
		for (RefundApply rfe : list) {
			List<String> inlist = new ArrayList<String>();

			inlist.add(rfe.getOrderNo() + "");
			if(rfe.getParentOrderNo()!=null){
				inlist.add(rfe.getParentOrderNo());
			}else{
				inlist.add("");
			}
			
			if (rfe.getPaymentTypeSid() != null) {
				inlist.add(paymentMap.get(rfe.getPaymentTypeSid().toString())
						.toString()
						+ "");
			} else {
				inlist.add("");
			}
			inlist.add(rfe.getRefundNum() + "");
			inlist.add(rfe.getRefundMoneySum() + "");
			inlist.add(rfe.getCompanyPostage() + "");
			inlist.add(rfe.getGoPostage() == null ? "" : rfe.getGoPostage()
					.toString());
			inlist.add(rfe.getComePostage() == null ? "" : rfe.getComePostage()
					.toString());
			// inlist.add(rfe.getCustomerPostage()+"");
			inlist.add(rfe.getRefundTicketSnPrice() == null ? "" : rfe
					.getRefundTicketSnPrice().toString());
			inlist.add(rfe.getNeedRefundMoney() + "");
			if (rfe.getRefundGoodType() != null) {
				inlist.add(refundTypeMap
						.get(rfe.getRefundGoodType().toString()).toString()
						+ "");
			} else {
				inlist.add("");
			}
			if (rfe.getRefundStatus() != null) {
				inlist.add(refundApplyMap.get(rfe.getRefundStatus().toString())
						.toString()
						+ "");
			} else {
				inlist.add("");
			}
			inlist.add(rfe.getRefundApplyNo() + "");
			inlist.add(rfe.getTicketSnUsePrice() == null ? "" : rfe
					.getTicketSnUsePrice().toString());
			inlist.add(rfe.getReceptName() == null ? "" : rfe.getReceptName());
			inlist.add(rfe.getPaymentRealName() == null ? "" : rfe
					.getPaymentRealName());
			inlist.add(rfe.getApplyTime() == null ? "" : rfe.getApplyTime());
			inlist.add(rfe.getFinaceConfirmTime() == null ? "" : rfe
					.getFinaceConfirmTime());
			inlist.add(rfe.getLogisticsConfirmTime() == null ? "" : rfe
					.getLogisticsConfirmTime());
			inlist.add(rfe.getLogisticsMemo() == null ? "" : rfe
					.getLogisticsMemo());
			inlist.add(rfe.getCustomerServiceMemo() == null ? "" : rfe
					.getCustomerServiceMemo());

			data.add(inlist);
		}

		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-disposition", "attachment; filename=/"
					+ title + ".xls");

			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.toString();
		}
	}

	@Override
	public String exprtExcelForCheckAccounts(HttpServletResponse response,
			List<CheckAccounts> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("平台对账结果");
		header.add("流水号");
		header.add("OMS销售金额");
		header.add("富基销售金额");
		header.add("SAP销售金额");
		header.add("销售类型");
		header.add("订单类型");
		header.add("销售单号");
		header.add("订单号");
		header.add("门店");
//		header.add("门店SID");
		header.add("供应商SID");
		header.add("收银时间");
		header.add("富基支付方式");
		Map<String, String> paymentMap=new HashMap<String, String>();

		paymentMap.put("1001", "王府井店");
		paymentMap.put("1002", "亚运村店");
		paymentMap.put("1003","首体店");
		paymentMap.put("1004", "五棵松店");
		paymentMap.put("1005", "中关村店");
		paymentMap.put("1006", "朝阳门店");
		paymentMap.put("1007", "三里河店");
		paymentMap.put("1008", "来广营店");
		paymentMap.put("1010", "回龙观店");
		paymentMap.put("1011", "草桥店");
		paymentMap.put("1301", "下沙店");
		paymentMap.put("5000", "DC分销中心");
		List<List<String>> data = new ArrayList<List<String>>();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		for(CheckAccounts ca:list){
			List<String> inlist = new ArrayList<String>();
			String SupplyInfoSid ="";
			String saleType="";
			String orderType = "";
			inlist.add(ca.getCheckStatusDesc());
			inlist.add(ca.getCashierNumber() + "");
			inlist.add(ca.getOmsMoneySum()+"");
			inlist.add(ca.getFutureMoneySum()+"");
			inlist.add(ca.getSapMoneySum()+"");
			if(ca.getSaleType()==1){
				saleType = "销售";
			}else if(ca.getSaleType()==4){
				saleType = "退货";
			}
			inlist.add(saleType);
			if(ca.getOrderType()==0){
				orderType="实体";
			}else if(ca.getOrderType()==1){
				orderType="网络";
			} else if(ca.getOrderType()==2){
				orderType="微信";
			}
			inlist.add(orderType);
			inlist.add(ca.getSaleNo()+"");
			inlist.add(ca.getOrderNo()+"");
			inlist.add(paymentMap.get(ca.getShopSid().toString()));
//			inlist.add(ca.getShopSid()+"");
			if(ca.getSupplyInfoSid()!=null){
				SupplyInfoSid= ca.getSupplyInfoSid().toString();
			}
			inlist.add(SupplyInfoSid);
			inlist.add(df.format(ca.getCashTime())+"");
			inlist.add(ca.getFuturePaymentMode()+"");
			data.add(inlist);
		}
		
		ExcelFile ef = new ExcelFile(title, header, data);
		try {
			OutputStream file = response.getOutputStream();
			response.reset();
			response.setContentType("APPLICATION/OCTET-STREAM");
			response.setHeader("Content-disposition", "attachment; filename=/"
					+ title + ".xls");

			ef.save(file);
			return "成功";
		} catch (Exception e) {
			return e.getMessage();
		}
	}

}
