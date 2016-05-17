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
import com.wangfj.statement.service.IStateToPDFService;
import com.wangfj.wms.util.ResultUtil;

@Controller
@RequestMapping("/statePDF")
public class ToPDFController {
	
	private StatementController stateCon = new StatementController();
	
	@Autowired
	@Qualifier("stateToPDFService")
	private IStateToPDFService pdfService;
	/**
	 * @Methods Name 网络每日销售
	 * @Create In 2014-1-16 By Administrator
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/shopAllSaleToPDF")
	public String shopAllSaleToPDF(HttpServletRequest request, HttpServletResponse response) {
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
		String result = pdfService.netEveryDaySale(response, listSales, title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	
	@ResponseBody
	@RequestMapping("/netOrderToPDF")
	public String netOrderToPDF(HttpServletRequest request, HttpServletResponse response) {
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
		String result = pdfService.netOrderStateToPDF(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	
	@ResponseBody
	@RequestMapping("/payTypeToPDF")
	public String payTypeToPDF(HttpServletRequest request, HttpServletResponse response) {

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
			
			String result = pdfService.OrderPayTypeStateToPDF(response,listCods,title);
			jsons = ResultUtil.createSuccessResult(result);
		}catch (Exception e) {
			System.out.println(e);
			jsons = ResultUtil.createFailureResult(e);
			return jsons;
		}
		return jsons;
	}
	
	@ResponseBody
	@RequestMapping("/orderSourceToPDF")
	public String orderSourceToPDF(HttpServletRequest request, HttpServletResponse response) {
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
		String result = pdfService.orderSourceStateToPDF(response,listOrder,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	/**
	 * 
	 * @Methods Name orderSumToExcelBack
	 * @Create In 2015-5-18 By chenhu
	 * @param request
	 * @param response
	 * @return String
	 */
	
	@ResponseBody
	@RequestMapping("/orderSumToPDFBack")
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
		String result = pdfService.orderSumStateToPDF(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	
	@ResponseBody
	@RequestMapping("/orderSumToPDF")
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
		String result = pdfService.orderSumStateToPDF(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	@ResponseBody
	@RequestMapping("/SaleNoToPDF")
	public String SaleNoToPDF(HttpServletRequest request, HttpServletResponse response) {
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
		String result = pdfService.SaleNoStateToPDF(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	
	@ResponseBody
	@RequestMapping("/shopSaleToPDF")
	public String shopSaleToPDF(HttpServletRequest request, HttpServletResponse response) {
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
		String result = pdfService.ShopSaleTypeStateToPDF(response,listSales,title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	
	@ResponseBody
	@RequestMapping("/entityAllSaleToPDF")
	public String entityAllSaleToPDF(HttpServletRequest request, HttpServletResponse response) {
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
		String result = pdfService.entityEveryDaySale(response, listSales, title);
		jsons = ResultUtil.createSuccessResult(result);
		
		return jsons;
	}
	

}
