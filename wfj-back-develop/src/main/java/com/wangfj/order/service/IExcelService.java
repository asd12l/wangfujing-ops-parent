package com.wangfj.order.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wangfj.back.entity.vo.CheckAccounts;
import com.wangfj.order.entity.CodHandover;
import com.wangfj.order.entity.RefundApply;
import com.wangfj.order.entity.RefundForExcel;
import com.wangfj.order.entity.Sale;

public interface IExcelService {

	public String exprtExcel(HttpServletRequest request,
			HttpServletResponse response,List<CodHandover> list,String title);
	
	public String exprtExcel(HttpServletResponse response,List<Sale> list,String title);
	
	public String exprtRefundExcel(HttpServletResponse response,List<RefundForExcel> list,String title);
	
	public String exprtRefundApplyExcel(HttpServletResponse response,List<RefundApply> list,String title);
	
	public String exprtExcelForCheckAccounts(HttpServletResponse response,List<CheckAccounts> list,String title);
}
