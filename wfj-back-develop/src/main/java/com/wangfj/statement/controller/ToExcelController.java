package com.wangfj.statement.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.statement.entity.OrderCount;
import com.wangfj.statement.entity.OrderEntity;
import com.wangfj.statement.entity.OrderPayType;
import com.wangfj.statement.entity.SaleEntity;
import com.wangfj.statement.service.IStateToExcelService;
import com.wangfj.wms.util.ResultUtil;

@Controller
@RequestMapping("/stateExcel")
public class ToExcelController {
	
	private StatementController stateCon = new StatementController();
	
	@Autowired
	@Qualifier("stateToExcelService")
	private IStateToExcelService stateToExcel;
	
	@ResponseBody
	@RequestMapping("/payTypeToExcel")
	public String payTypeToExcel(HttpServletRequest request, HttpServletResponse response) {

		String jsons = "";
		
		List<OrderPayType> listCods = new ArrayList<OrderPayType>();
		String title = request.getParameter("title");
		try{
			
			String l;
				// 得到返回的String字符串
				l = stateCon.OrderPayTypeController(request, response);
				// 对得到的Sting字符窜进行处理
				JSONObject js = JSONObject.fromObject(l);
				Object objs = js.get("list");
				// 得到JSONArray
				JSONArray arr = JSONArray.fromObject(objs);
				if(arr.size()>0){
					for(int i = 0; i < arr.size(); i++){
						
						JSONObject jOpt = arr.getJSONObject(i);
						OrderPayType opt = (OrderPayType) JSONObject.toBean(jOpt, OrderPayType.class);
						listCods.add(opt);
					}
				}
			
			String result = stateToExcel.OrderPayTypeStateToExcel(response,listCods,title);
			jsons = ResultUtil.createSuccessResult(result);
		}catch (Exception e) {
			System.out.println(e);
			jsons = ResultUtil.createFailureResult(e);
			return jsons;
		}
		return jsons;
	}
	
	@ResponseBody
	@RequestMapping("/shopSaleToExcel")
	public String shopSaleToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		List<SaleEntity> listSales = new ArrayList<SaleEntity>();
		String title = request.getParameter("title");
		String ls = stateCon.shopSaleController(request, response);
		
		JSONObject js = JSONObject.fromObject(ls);
		Object objs = js.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		if(arr.size()>0){
			for(int i = 0; i < arr.size(); i++){
				
				JSONObject jOpt = arr.getJSONObject(i);
				SaleEntity opt = (SaleEntity) JSONObject.toBean(jOpt, SaleEntity.class);
				listSales.add(opt);
			}
		}
		String result = stateToExcel.ShopSaleTypeStateToExcel(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	
	@ResponseBody
	@RequestMapping("/shopAllSaleToExcel")
	public String shopAllSaleToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		List<SaleEntity> listSales = new ArrayList<SaleEntity>();
		String title = request.getParameter("title");
		String ls = stateCon.shopAllSaleController(request, response);
		
		JSONObject js = JSONObject.fromObject(ls);
		Object objs = js.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		if(arr.size()>0){
			for(int i = 0; i < arr.size(); i++){
				
				JSONObject jOpt = arr.getJSONObject(i);
				SaleEntity opt = (SaleEntity) JSONObject.toBean(jOpt, SaleEntity.class);
				listSales.add(opt);
			}
		}
		String result = stateToExcel.ShopAllSaleTypeStateToExcel(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	/**
	 * @Methods Name orderSourceToExcel
	 * @Create In 2014-1-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderSourceToExcel")
	public String orderSourceToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		List<OrderCount> listOrder = new ArrayList<OrderCount>();
		String title = request.getParameter("title");
		String ls = stateCon.OrderSourceController(request,response);
		
		JSONObject js = JSONObject.fromObject(ls);
		Object objs = js.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		if(arr.size()>0){
			for(int i = 0; i < arr.size(); i++){
				
				JSONObject jOpt = arr.getJSONObject(i);
				OrderCount opt = (OrderCount) JSONObject.toBean(jOpt, OrderCount.class);
				listOrder.add(opt);
			}
		}
		String result = stateToExcel.orderSourceStateToExcel(response,listOrder,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	/** 
	 * @Methods Name SaleNoToExcel
	 * @Create In 2014-1-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/SaleNoToExcel")
	public String SaleNoToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		List<SaleEntity> listSales = new ArrayList<SaleEntity>();
		String title = request.getParameter("title");
		String ls = stateCon.SaleNOController(request, response);
		
		JSONObject js = JSONObject.fromObject(ls);
		Object objs = js.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		if(arr.size()>0){
			for(int i = 0; i < arr.size(); i++){
				
				JSONObject jOpt = arr.getJSONObject(i);
				SaleEntity opt = (SaleEntity) JSONObject.toBean(jOpt, SaleEntity.class);
				listSales.add(opt);
			}
		}
		String result = stateToExcel.SaleNoStateToExcel(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	/**
	 * 
	 * @Methods Name orderSumToExcelBack
	 * @Create In 2015-5-18 By chenh
	 * @param request
	 * @param response
	 * @return String
	 */
	
	@ResponseBody
	@RequestMapping("/orderSumToExcelBack")
	public String orderSumToExcelBack(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		List<OrderEntity> listSales = new ArrayList<OrderEntity>();
		String title = request.getParameter("title");
		String ls = stateCon.OrderSumController(request, response);
		JSONObject page = JSONObject.fromObject(ls);
//		Object pageob = page.get("page");
//		ls = pageob.toString();
//		JSONObject js = JSONObject.fromObject(ls);
		
		Object objs = page.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		if(arr.size()>0){
			for(int i = 0; i < arr.size(); i++){
				
				JSONObject jOpt = arr.getJSONObject(i);
				OrderEntity opt = (OrderEntity) JSONObject.toBean(jOpt, OrderEntity.class);
				listSales.add(opt);
			}
		}
		String result = stateToExcel.orderSumStateToExcel(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	
	/**
	 * 
	 * @Methods Name orderSumToExcel
	 * @Create In 2014-1-10 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/orderSumToExcel")
	public String orderSumToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		List<OrderEntity> listSales = new ArrayList<OrderEntity>();
		String title = request.getParameter("title");
		String ls = stateCon.OrderSumController(request, response);
		JSONObject page = JSONObject.fromObject(ls);
		Object pageob = page.get("page");
		ls = pageob.toString();
		JSONObject js = JSONObject.fromObject(ls);
		
		Object objs = page.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		if(arr.size()>0){
			for(int i = 0; i < arr.size(); i++){
				
				JSONObject jOpt = arr.getJSONObject(i);
				OrderEntity opt = (OrderEntity) JSONObject.toBean(jOpt, OrderEntity.class);
				listSales.add(opt);
			}
		}
		String result = stateToExcel.orderSumStateToExcel(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	/**
	 * @Methods Name 网络订单导出Excel
	 * @Create In 2014-1-13 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/netOrderToExcel")
	public String netOrderToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		List<OrderCount> listSales = new ArrayList<OrderCount>();
		String title = request.getParameter("title");
		String ls = stateCon.NetOrderController(request, response);
		JSONObject pageob = JSONObject.fromObject(ls);
		Object pagels = pageob.get("page");
		ls = pagels.toString();
		JSONObject js = JSONObject.fromObject(ls);
		Object objs = js.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		if(arr.size()>0){
			for(int i = 0; i < arr.size(); i++){
				
				JSONObject jOpt = arr.getJSONObject(i);
				OrderCount opt = (OrderCount) JSONObject.toBean(jOpt, OrderCount.class);
				listSales.add(opt);
			}
		}
		String result = stateToExcel.netOrderStateToExcel(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	/**
	 * 
	 * @Methods Name 实体每日销售统计
	 * @Create In 2014-1-21 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/entityAllSaleToExcel")
	public String entityAllSaleToExcel(HttpServletRequest request, HttpServletResponse response) {
		String jsons = "";
		List<SaleEntity> listSales = new ArrayList<SaleEntity>();
		String title = request.getParameter("title");
		String ls = stateCon.entityAllSaleController(request, response);
		
		JSONObject js = JSONObject.fromObject(ls);
		Object objs = js.get("list");
		// 得到JSONArray
		JSONArray arr = JSONArray.fromObject(objs);
		if(arr.size()>0){
			for(int i = 0; i < arr.size(); i++){
				
				JSONObject jOpt = arr.getJSONObject(i);
				SaleEntity opt = (SaleEntity) JSONObject.toBean(jOpt, SaleEntity.class);
				listSales.add(opt);
			}
		}
		String result = stateToExcel.EntityAllSaleTypeStateToExcel(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
}
