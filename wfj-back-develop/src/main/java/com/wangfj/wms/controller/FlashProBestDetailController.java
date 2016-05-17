/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerFlashProBestDetailController.java
 * @Create By chengsj
 * @Create In 2013-9-3 上午10:47:39
 * TODO
 */
package com.wangfj.wms.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.wms.domain.entity.PriceProduct;
import com.wangfj.wms.domain.entity.ProBestDetailMql;
import com.wangfj.wms.service.IPriceProductService;
import com.wangfj.wms.service.IProBestDetailMqlService;
import com.wangfj.wms.util.HttpUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name FlashProBestDetailController
 * @Author chengsj
 * @Create In 2013-9-3
 */
@Controller
@RequestMapping("/flashProBestDetail")
public class FlashProBestDetailController {
	@Autowired
	@Qualifier("proBestDetailMqlService")
	private IProBestDetailMqlService proBestDetailMqlService;

	@Autowired
			@Qualifier("priceProductService")
	IPriceProductService priceProductService;

	@ResponseBody
	@RequestMapping(value = { "/products" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryProducts(Model m, HttpServletRequest request,
			HttpServletResponse response, String pageLayoutSid) {
		String resultJson = "";
		List<Integer> proLists = new ArrayList();
		if(pageLayoutSid == null || "".equals(pageLayoutSid) ){
			return ResultUtil.createSuccessResult(proLists);
		}
		List<ProBestDetailMql> proList = this.proBestDetailMqlService
				.queryProList(Integer.valueOf(pageLayoutSid));
		if (proList.size() <= 0) {
			return ResultUtil.createSuccessResultJson(proList);
		}
		StringBuffer param = new StringBuffer();
		Map resultMap = new HashMap();
		for (int i = 0; i < proList.size(); i++) {
			proLists.add(proList.get(i).getProductListSid());

		}
		for (Integer productListSid : proLists) {
			if (proList != null) {
				param.append(productListSid + ",");
			}
		}
		if (proList.size() > 0) {
			// 去除最后的逗号
			param = param.deleteCharAt(param.length() - 1);
			resultMap.put("param", param.toString());
			try {
				resultJson = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"bw/getByProductSids.html", resultMap);
				JSONObject obj = JSONObject.fromObject(resultJson);
				if (obj != null && !obj.isEmpty()
						&& obj.get("success").equals("true")) {
					JSONArray resultArray = obj.getJSONArray("result");
					JSONArray notArray = obj.getJSONArray("not exists");

					JSONArray result = new JSONArray();
					for (int j = 0; j < proLists.size(); j++) {
						int a = proLists.get(j);
						boolean flag = false;
						for (int i = 0; i < resultArray.size(); i++) {
							JSONObject t = resultArray.getJSONObject(i);
							int id = t.getInt("id");
							if (a == id) {
								
								ProBestDetailMql pbd = new ProBestDetailMql();
								pbd.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
								pbd.setProductListSid(Integer.valueOf(id));//id查出来的商品id，要查他的序列号
								ProBestDetailMql selectedVo = this.proBestDetailMqlService
										.queryOrderNumber(pbd);
								Integer seq = selectedVo.getOrderNumber();
								t.put("seq", seq); //将查出来了的商品的顺序以seq字段返回来
								
								result.add(t);
								flag = true;
								break;
							}
						}
						if (!flag) {
							for (int i = 0; i < notArray.size(); i++) {
								JSONObject t = notArray.getJSONObject(i);
								int id = t.getInt("id");
								if (a == id) {
									result.add(t);
									break;
								}
							}
						}

					}

					obj.put("result", result);
					Gson gson = new GsonBuilder().create();
					resultJson = gson.toJson(obj);
				} else {
					return "{success:true,result:[]}";
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return resultJson;
	}

	@ResponseBody
	@RequestMapping(value = "/{sid}", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String find(@PathVariable String sid, Model m,
			HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Assert.notNull(this.proBestDetailMqlService);
		try {
			ProBestDetailMql vo = this.proBestDetailMqlService
					.selectByPrimaryKey(Integer.valueOf(sid));
			json = ResultUtil.createSuccessResult(vo);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		} finally {
			return json;
		}
	}

	@ResponseBody
	@RequestMapping(value = { "/updateProducts" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public void updateProducts(String productsListSid, String orderNum,
			String pageLayoutSid, Model m, HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		// System.out.println("productsListSid---------------"+productsListSid);
		// System.out.println("orderNum---------------"+orderNum);
		// System.out.println("pageLayoutSid--------------"+pageLayoutSid);
		ProBestDetailMql cond = new ProBestDetailMql();

		cond.setOrderNumber(Integer.valueOf(orderNum));
		cond.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
		cond.setProductListSid(Integer.valueOf(productsListSid));
		ProBestDetailMql vo = proBestDetailMqlService.queryOrderNumber(cond);

		ProBestDetailMql pro = new ProBestDetailMql();
		pro.setSid(Integer.valueOf(vo.getSid()));
		pro.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
		pro.setProductListSid(Integer.valueOf(productsListSid));
		pro.setOrderNumber(Integer.valueOf(orderNum) - 1);
		ProBestDetailMql cond2 = new ProBestDetailMql();
		this.proBestDetailMqlService.updateByPrimaryKeySelective(cond2);

	}

	@ResponseBody
	@RequestMapping(value = { "/deleteproducts" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deleteProduct(Model m, HttpServletRequest request,
			HttpServletResponse response, String productsListSid,
			String pageLayoutSid) {
		String json = "";
		ProBestDetailMql proBestDetailMql = new ProBestDetailMql();
		proBestDetailMql.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
		proBestDetailMql.setProductListSid(Integer.valueOf(productsListSid));

		try {
			this.proBestDetailMqlService
					.deleteByProductListSid(proBestDetailMql);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;

	}

	@ResponseBody
	@RequestMapping(value = { "/delProInPromotion" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deleteProductsInPromotion(Model m,
			HttpServletRequest request, HttpServletResponse response,
			String productsListSid, String pageLayoutSid,String username) {
		String json = "";
		ProBestDetailMql proBestDetailMql = new ProBestDetailMql();
		proBestDetailMql.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
		proBestDetailMql.setProductListSid(Integer.valueOf(productsListSid));

		PriceProduct priceProduct = new PriceProduct();
		priceProduct.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
		priceProduct.setProductListSid(Integer.valueOf(productsListSid));

		try {
			this.proBestDetailMqlService
					.deleteByProductListSid(proBestDetailMql);
			int stat = this.priceProductService.deleteBySelect(priceProduct);

			// 恢复变价商品的价格，若不是变价商品则维持原价
			if (stat >= 1) {
				Map parmMap = new HashMap();
				parmMap.put("productSid", productsListSid);
				parmMap.put("activityFlg", 0);
				parmMap.put("user", username);
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"/photo/updateFlg.html", parmMap);
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;

	}

	@ResponseBody
	@RequestMapping(value = { "/drag" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public void updatejson1(Model m, HttpServletRequest request,
			HttpServletResponse response) throws SQLException {

		String pageLayoutSid = request.getParameter("pageLayoutSid");
		// 拖拽前的productListSid
		String selectRowPid = request.getParameter("selectRowPid");
		// 拖拽后的productListSid
		String toRowPid = request.getParameter("toRowPid");

		// 获取拖拽前的顺序号
		ProBestDetailMql selectRow = new ProBestDetailMql();
		selectRow.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
		selectRow.setProductListSid(Integer.valueOf(selectRowPid));
		ProBestDetailMql selectedVo = this.proBestDetailMqlService
				.queryOrderNumber(selectRow);
		Integer selectRowOrderNumber = selectedVo.getOrderNumber();
		// 获取拖拽后的顺序号
		ProBestDetailMql toRow = new ProBestDetailMql();
		toRow.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
		toRow.setProductListSid(Integer.valueOf(toRowPid));
		ProBestDetailMql toVo = this.proBestDetailMqlService
				.queryOrderNumber(toRow);
		Integer toRowOrderNumber = toVo.getOrderNumber();

		List<ProBestDetailMql> list = this.proBestDetailMqlService
				.queryProList(Integer.valueOf(pageLayoutSid));
		for (int i = 0; i < list.size(); i++) {
			Integer orderNumber = list.get(i).getOrderNumber();
			if (selectRowOrderNumber < orderNumber
					&& orderNumber <= toRowOrderNumber) {
				list.get(i).setOrderNumber(orderNumber - 1);
				this.proBestDetailMqlService.updateByPrimaryKeySelective(list
						.get(i));
			}
			if (toRowOrderNumber <= orderNumber
					&& orderNumber < selectRowOrderNumber) {
				list.get(i).setOrderNumber(orderNumber + 1);
				this.proBestDetailMqlService.updateByPrimaryKeySelective(list
						.get(i));
			}
		}

		// 更新选中的数据
		selectRow.setSid(selectedVo.getSid());
		selectRow.setOrderNumber(toRowOrderNumber);
		this.proBestDetailMqlService.updateByPrimaryKeySelective(selectRow);

	}
	
	
	
	@ResponseBody
	@RequestMapping(value = { "/Editdrag" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updatejsonByEdit(Model m, HttpServletRequest request,
			HttpServletResponse response) throws SQLException {
		String json = "";
		
		String proSid = request.getParameter("proSid");//商品id
		String proseq = request.getParameter("proseq");//排序号
		String pageLayoutSid = request.getParameter("pageLayoutSid");

		// 获取修改之前的排序号
		ProBestDetailMql pbd = new ProBestDetailMql();
		pbd.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
		pbd.setProductListSid(Integer.valueOf(proSid));
		ProBestDetailMql selectedVo = this.proBestDetailMqlService
				.queryOrderNumber(pbd);
		Integer oldON = selectedVo.getOrderNumber();
		selectedVo.setOrderNumber(Integer.parseInt(proseq));
	
		try{
		int result = this.proBestDetailMqlService.updateByPrimaryKeySelective(selectedVo);
			if(result==1){
				json =  ResultUtil.createSuccessResult();
			}else{
				json =  ResultUtil.createFailureResult(new Exception("更新失败"));
			}
		}catch(Exception e){
			json =  ResultUtil.createFailureResult(e);
		}
		
		

/*		List<ProBestDetailMql> list = this.proBestDetailMqlService
				.queryProList(Integer.valueOf(pageLayoutSid));
		for (int i = 0; i < list.size(); i++) {
			Integer orderNumber = list.get(i).getOrderNumber();
			if (selectRowOrderNumber < orderNumber
					&& orderNumber <= toRowOrderNumber) {
				list.get(i).setOrderNumber(orderNumber - 1);
				this.proBestDetailMqlService.updateByPrimaryKeySelective(list
						.get(i));
			}
			if (toRowOrderNumber <= orderNumber
					&& orderNumber < selectRowOrderNumber) {
				list.get(i).setOrderNumber(orderNumber + 1);
				this.proBestDetailMqlService.updateByPrimaryKeySelective(list
						.get(i));
			}
		}

		// 更新选中的数据
		selectRow.setSid(selectedVo.getSid());
		selectRow.setOrderNumber(toRowOrderNumber);
		this.proBestDetailMqlService.updateByPrimaryKeySelective(selectRow);*/
		return json;
	}
	
	
	

}
