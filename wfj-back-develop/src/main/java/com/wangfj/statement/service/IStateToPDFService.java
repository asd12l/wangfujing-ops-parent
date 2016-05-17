package com.wangfj.statement.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.wangfj.statement.entity.OrderCount;
import com.wangfj.statement.entity.OrderEntity;
import com.wangfj.statement.entity.OrderPayType;
import com.wangfj.statement.entity.SaleEntity;

public interface IStateToPDFService {

	public String netEveryDaySale(HttpServletResponse response,List<SaleEntity> list,String title);
	
	public String OrderPayTypeStateToPDF(HttpServletResponse response,List<OrderPayType> list,String title);
	
	public String ShopSaleTypeStateToPDF(HttpServletResponse response,List<SaleEntity> list,String title);
	
	public String orderSourceStateToPDF(HttpServletResponse response,List<OrderCount> list,String title);
	
	public String SaleNoStateToPDF(HttpServletResponse response,List<SaleEntity> list,String title);
	
	public String orderSumStateToPDF(HttpServletResponse response,List<OrderEntity> list,String title);
	
	public String netOrderStateToPDF(HttpServletResponse response,List<OrderCount> list,String title);
	
	public String entityEveryDaySale(HttpServletResponse response,List<SaleEntity> list,String title);
	
}
