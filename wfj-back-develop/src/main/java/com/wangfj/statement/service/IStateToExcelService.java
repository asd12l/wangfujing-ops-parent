package com.wangfj.statement.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import com.wangfj.statement.entity.OrderCount;
import com.wangfj.statement.entity.OrderEntity;
import com.wangfj.statement.entity.OrderPayType;
import com.wangfj.statement.entity.SaleEntity;

public interface IStateToExcelService {
	
	public String OrderPayTypeStateToExcel(HttpServletResponse response,List<OrderPayType> list,String title);
	
	public String ShopSaleTypeStateToExcel(HttpServletResponse response,List<SaleEntity> list,String title);
	
	public String ShopAllSaleTypeStateToExcel(HttpServletResponse response,List<SaleEntity> list,String title);
	
	public String orderSourceStateToExcel(HttpServletResponse response,List<OrderCount> list,String title);
	
	public String SaleNoStateToExcel(HttpServletResponse response,List<SaleEntity> list,String title);
	
	public String orderSumStateToExcel(HttpServletResponse response,List<OrderEntity> list,String title);
	
	public String netOrderStateToExcel(HttpServletResponse response,List<OrderCount> list,String title);
	
	public String EntityAllSaleTypeStateToExcel(HttpServletResponse response,List<SaleEntity> list,String title);
	
	
}
