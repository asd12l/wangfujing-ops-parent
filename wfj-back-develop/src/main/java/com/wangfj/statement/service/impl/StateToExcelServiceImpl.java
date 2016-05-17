package com.wangfj.statement.service.impl;

import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.wangfj.order.entity.ExcelFile;
import com.wangfj.statement.entity.OrderCount;
import com.wangfj.statement.entity.OrderEntity;
import com.wangfj.statement.entity.OrderPayType;
import com.wangfj.statement.entity.SaleEntity;
import com.wangfj.statement.service.IStateToExcelService;
@Service("stateToExcelService")
public class StateToExcelServiceImpl implements IStateToExcelService {

	@Override
	public String OrderPayTypeStateToExcel(HttpServletResponse response,
			List<OrderPayType> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("支付类型");
		header.add("支付金额");
		header.add("交易笔数");
		header.add("金额占比");
		header.add("数量占比");
		
		List<List<String>> data = new ArrayList<List<String>>();
		for(OrderPayType cod:list){
			List<String> inlist = new ArrayList<String>();
			
			inlist.add(cod.getPaymentTypeDesc()==null?"":cod.getPaymentTypeDesc());//
			inlist.add(cod.getSaleAllPrice()==null?"":cod.getSaleAllPrice());//
			inlist.add(cod.getSaleAllSum()==null?"":cod.getSaleAllSum());//
			inlist.add(cod.getPriceAccount()==null?"":cod.getPriceAccount());//
			inlist.add(cod.getNumAccount()==null?"":cod.getNumAccount());//


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
		}
	}

	@Override
	public String ShopSaleTypeStateToExcel(HttpServletResponse response,
			List<SaleEntity> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("门店");
		header.add("销售金额");
		header.add("销售数量");
		header.add("单价");
		header.add("退货金额");
		header.add("退货数量");
		header.add("退货单价");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(SaleEntity sale:list){
			List<String> inlist = new ArrayList<String>();
			
			inlist.add(sale.getShopName()==null?"":sale.getShopName());//
			inlist.add(sale.getShopSalePrice()==null?"":sale.getShopSalePrice());//
			inlist.add(sale.getShopSaleNumber()==null?"":sale.getShopSaleNumber());//
			inlist.add(sale.getShopSaleAvgPrice()==null?"":sale.getShopSaleAvgPrice());//
			inlist.add(sale.getShopRefundPrice()==null?"":sale.getShopRefundPrice());//
			inlist.add(sale.getShopRefundNumber()==null?"":sale.getShopRefundNumber());//
			inlist.add(sale.getShopRefundAvgPrice()==null?"":sale.getShopRefundAvgPrice());

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
		}
	}

	@Override
	public String orderSourceStateToExcel(HttpServletResponse response,
			List<OrderCount> list, String title) {
		List<String> header = new ArrayList<String>();
		
		header.add("订单来源");
		header.add("订单状态");
		header.add("是否退货");
		header.add("订单数量");
		header.add("销售总金额");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(OrderCount order:list){
			List<String> inlist = new ArrayList<String>();
			String orderSource = "";
			if("0".equals(order.getOrderSourceSid())){
				orderSource ="本网";
			}else if("1".equals(order.getOrderSourceSid())){
				orderSource ="淘宝";	
			}else if("7".equals(order.getOrderSourceSid())){
				orderSource ="天猫";	
			}else if("11".equals(order.getOrderSourceSid())){
				orderSource ="当当";	
			}
			inlist.add(orderSource);//
			String ifPay ="";
			if("1".equals(order.getIfPay())){ifPay="未支付";}else if("2".equals(order.getIfPay())){ifPay="已支付";}
			inlist.add(ifPay);//
			String IfRefund ="";
			if("1".equals(order.getIfRefund())){IfRefund="退货";}else if("0".equals(order.getIfRefund())){IfRefund="无退货";}
			inlist.add(IfRefund);//
			inlist.add(order.getSaleAllSum()==null?"":order.getSaleAllSum());//
			inlist.add(order.getSaleAllPrice()==null?"":order.getSaleAllPrice());//
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
		}
		
	}

	@Override
	public String SaleNoStateToExcel(HttpServletResponse response,
			List<SaleEntity> list, String title) {

		List<String> header = new ArrayList<String>();
		header.add("日期");
		header.add("门店");
		header.add("销售编码");
		header.add("品牌");
		header.add("单据号");
		header.add("实体销售");
		header.add("实体退货");
		header.add("网络销售");
		header.add("网络退货");
		header.add("小票号");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(SaleEntity sale:list){
			List<String> inlist = new ArrayList<String>();
			
			inlist.add(sale.getSaleTime()==null?"":sale.getSaleTime());//
			inlist.add(sale.getShopName()==null?"":sale.getShopName());//
			inlist.add(sale.getSaleCode()==null?"":sale.getSaleCode());//
			inlist.add(sale.getBrandName()==null?"":sale.getBrandName());//
			inlist.add(sale.getSaleNo()==null?"":sale.getSaleNo());//
			inlist.add(sale.getShopSaleNumber()==null?"":sale.getShopSaleNumber());//
			inlist.add(sale.getShopRefundNumber()==null?"":sale.getShopRefundNumber());
			inlist.add(sale.getNetSaleNumber()==null?"":sale.getNetSaleNumber());//
			inlist.add(sale.getNetRefundNumber()==null?"":sale.getNetRefundNumber());//
			inlist.add(sale.getCashierNumber()==null?"":sale.getCashierNumber());

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
		}
	}

	
	public String orderSumStateToExcel(HttpServletResponse response,
			List<OrderEntity> list, String title) {
		List<String> header = new ArrayList<String>();

		header.add("订单号");
		header.add("订单金额");
		header.add("姓名");
		header.add("电话");
		header.add("地址");
		header.add("款号");
		header.add("品牌");
		header.add("总金额");
		header.add("数量");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(OrderEntity order:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(order.getOrderNo()==null?"":order.getOrderNo());//
			inlist.add(order.getSaleMoneySum()==null?"":order.getSaleMoneySum());//
			inlist.add(order.getMemberName()==null?"":order.getMemberName());//
			inlist.add(order.getMemberPhone()==null?"":order.getMemberPhone());//
			inlist.add(order.getMemberAdress()==null?"":order.getMemberAdress());//
			inlist.add(order.getProSku()==null?"":order.getProSku());//
			inlist.add(order.getBrandName()==null?"":order.getBrandName());
			inlist.add(order.getProMoneySum()==null?"":order.getProMoneySum());//
			inlist.add(order.getRealSaleSum()==null?"":order.getRealSaleSum());//

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
		}
	}

	@Override
	public String netOrderStateToExcel(HttpServletResponse response,
			List<OrderCount> list, String title) {
		List<String> header = new ArrayList<String>();

		header.add("省份");
		header.add("城市");
		header.add("类型");
		header.add("订单数");
		header.add("订单金额");
		header.add("付款订单数");
		header.add("付款订单数金额");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(OrderCount order:list){
			List<String> inlist = new ArrayList<String>();
			inlist.add(order.getInceptProvince()==null?"":order.getInceptProvince());//
			inlist.add(order.getInceptCity()==null?"":order.getInceptCity());//
			inlist.add(order.getPaymentTypeDesc()==null?"":order.getPaymentTypeDesc());//
			inlist.add(order.getSaleAllSum()==null?"":order.getSaleAllSum());//
			inlist.add(order.getSaleAllPrice()==null?"":order.getSaleAllPrice());//
			inlist.add(order.getPaySaleAllSum()==null?"":order.getPaySaleAllSum());//
			inlist.add(order.getPaySaleAllPrice()==null?"":order.getPaySaleAllPrice());
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
		}
	}

	@Override
	public String ShopAllSaleTypeStateToExcel(HttpServletResponse response,
			List<SaleEntity> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("门店");
		header.add("销售总金额");
		header.add("退货总金额");
		header.add("合计");
	
		List<List<String>> data = new ArrayList<List<String>>();
		for(SaleEntity sale:list){
			List<String> inlist = new ArrayList<String>();
			
			inlist.add(sale.getShopName()==null?"":sale.getShopName());//
			inlist.add(sale.getShopSalePrice()==null?"":sale.getShopSalePrice());//
			inlist.add(sale.getShopRefundPrice()==null?"":sale.getShopRefundPrice());//
			inlist.add(sale.getShopRealPrice()==null?"":sale.getShopRealPrice());

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
		}
	}

	@Override
	public String EntityAllSaleTypeStateToExcel(HttpServletResponse response,
			List<SaleEntity> list, String title) {
		List<String> header = new ArrayList<String>();
		header.add("门店");
		header.add("销售总金额");
		header.add("退货总金额");
		header.add("合计");
	
		List<List<String>> data = new ArrayList<List<String>>();
		Map<String,String> shopMap = new HashMap<String, String>();
		shopMap.put("0", "物流中心");
		shopMap.put("68", "仓储店");
		shopMap.put("1001", "王府井");
		shopMap.put("1002", "亚运村");
		shopMap.put("1003", "首体");
		shopMap.put("1004", "五棵松");
		shopMap.put("1005", "中关村");
		shopMap.put("1006", "朝阳门");
		shopMap.put("1007", "三里河");
		shopMap.put("1008", "来广营");
		shopMap.put("5000", "仓储店");
		shopMap.put("1010", "回龙观");
		shopMap.put("1011", "草桥");
		shopMap.put("合计", "合计");
		for(SaleEntity sale:list){
			List<String> inlist = new ArrayList<String>();
			
			inlist.add(sale.getShopSid()==null?"":shopMap.get(sale.getShopSid()));//
			inlist.add(sale.getShopSalePrice()==null?"":sale.getShopSalePrice());//
			inlist.add(sale.getShopRefundPrice()==null?"":sale.getShopRefundPrice());//
			inlist.add(sale.getShopRealPrice()==null?"":sale.getShopRealPrice());

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
		}
	}

}
