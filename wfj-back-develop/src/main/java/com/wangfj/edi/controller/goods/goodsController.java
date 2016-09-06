package com.wangfj.edi.controller.goods;

import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.edi.bean.EdiGoodsRelation;
import com.wangfj.edi.util.PropertiesUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;

import net.sf.json.JSONObject;


@Controller
@RequestMapping("/ediGoods")
public class goodsController {
	private final static Logger logger = Logger.getLogger(goodsController.class);
	
	/**
	 * 根据条件查询
	 * @Methods Name selectOrderList
	 * @Create In 2016年1月27日 By wangjl
	 * @param status
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectGoodsList")
	public String selectOrderList(String channel_code,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null
				: Integer.valueOf(Integer.parseInt(request.getParameter("pageSize")));
		Integer currPage = request.getParameter("page") == null ? null
				: Integer.valueOf(Integer.parseInt(request.getParameter("page")));
		if(size == null || size == 0){
			size = 15;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		paramMap.put("num_iid", request.getParameter("num_iid"));
		paramMap.put("outer_id", request.getParameter("outer_id"));
		paramMap.put("sku_name", request.getParameter("sku_name"));
		paramMap.put("brand_name", request.getParameter("brand_name"));
		if(channel_code!=null || "null".equals(channel_code)){
			paramMap.put("channel_code", channel_code);
		}else{
			paramMap.put("channel_code", request.getParameter("channel_code"));
		}
		paramMap.put("currentPage", currPage);
		paramMap.put("pageSize", size);
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<Object, Object> goods = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			goods.put("orderVo", jsonStr);
			logger.info("jsonStr:" + jsonStr);
			String url = "";
			if("M4".equals(channel_code)){
				url = (String) PropertiesUtil.getContextProperty("edi_goods_yzsearch");
			}else if("CC".equals(channel_code)){
				url = (String) PropertiesUtil.getContextProperty("edi_goods_hlmsearch");
			}
			else{
				url = (String) PropertiesUtil.getContextProperty("edi_goods_search");
			}
			json = HttpUtilPcm.doPost(url, jsonStr);
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonPage = JSONObject.fromObject(json);
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0) : jsonPage.get("pages"));
				} else {
					map.put("list", null);
					map.put("pageCount", Integer.valueOf(0));
				}
			} else {
				map.put("list", null);
				map.put("pageCount", Integer.valueOf(0));
			}
			logger.info("json:" + json);
		} catch (Exception e) {
			map.put("pageCount", Integer.valueOf(0));
		}
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			map.put("userName", CookiesUtil.getUserName(request));
		}else{
			map.put("userName", "");
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println(gson.toJson(map));
		return gson.toJson(map);
	}
	
	/**
	 * 手动关联
	 * @Methods Name goodsManual
	 * @Create In 2016年1月27日 By wangjl
	 * @param numiid
	 * @param request
	 * @param response void
	 */
	@RequestMapping("/goodsManual")
	public void goodsManual(String numiid,String channelCode,HttpServletRequest request, HttpServletResponse response) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		paramMap.put("num_iid", numiid);
		paramMap.put("channel_code", channelCode);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url;
			if("M4".equals(channelCode)){
				url = (String) PropertiesUtil.getContextProperty("edi_goods_yzmanual");
			}else if("CC".equals(channelCode)){
				url = (String) PropertiesUtil.getContextProperty("edi_goods_hlmmanual");
			}else{
				url = (String) PropertiesUtil.getContextProperty("edi_goods_manual");
			}
			HttpUtilPcm.doPost(url, jsonStr);
		} catch (Exception e) {
			map.put("pageCount", 0);
			map.put("success", "false");
		}
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}
	}
	
	/**
	 * 批量关联
	 * @Methods Name goodsBatch
	 * @Create In 2016年3月8日 By wangjl
	 * @param request
	 * @param response
	 * @param file
	 * @throws IOException void
	 */
	@RequestMapping("/goodsBatch")
	public void goodsBatch(@RequestParam MultipartFile file,String channelCode,HttpServletRequest request,HttpServletResponse response)  throws IOException {
		Map<Object, Object> paramMap = new HashMap<Object, Object>();

		if(file != null && file.getInputStream() != null){
			Workbook book = null;
			try {
				book = create(file.getInputStream());
			} catch (IOException e) {
				logger.error("上传的excel文件不正确!", e);
			} catch (InvalidFormatException e) {
				logger.error("不合法的excel文件格式!", e);
			}
			if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
				paramMap.put("userName", CookiesUtil.getUserName(request));
			}else{
				paramMap.put("userName", "");
			}
			if(book != null){
				readPushSkuFromXls(book,channelCode,request);
			}
		}
		//response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
	
	private Workbook create(InputStream inp) throws IOException, InvalidFormatException {
		if(!inp.markSupported()) {
			inp = new PushbackInputStream(inp, 8);
		}
		if(POIFSFileSystem.hasPOIFSHeader(inp)) {
			return new HSSFWorkbook(inp);
		}
		if(POIXMLDocument.hasOOXMLHeader(inp)) {
			return new XSSFWorkbook(OPCPackage.open(inp));
		}
		throw new IllegalArgumentException("Your InputStream was neither an OLE2 stream, nor an OOXML stream");
	}
	
	public void readPushSkuFromXls(Workbook book,String channelCode,HttpServletRequest request){
		List<EdiGoodsRelation> list = new ArrayList<EdiGoodsRelation>();
		Sheet sheet = book.getSheetAt(0);
		int rowNum = sheet.getLastRowNum();
		for(int i = 1; i <= rowNum; i ++) {
			EdiGoodsRelation edi = new EdiGoodsRelation();
			Row row = sheet.getRow(i);
			Cell cell = row.getCell(0);
			String numid = null;
			if(cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC){
				Double val = cell.getNumericCellValue();
				numid = String.valueOf(val.longValue());
			}else if(cell.getCellType() == HSSFCell.CELL_TYPE_STRING){
				numid = new String(cell.getStringCellValue());
			}
			if(numid != null){
				edi.setNum_iid(numid);
				edi.setChannel_code(channelCode);
				list.add(edi);
			}
		}
		String url;
		if("M4".equals(channelCode)){
			url = (String) PropertiesUtil.getContextProperty("edi_goods_yzbatch");
		}else if("CC".equals(channelCode)){
			url = (String) PropertiesUtil.getContextProperty("edi_goods_hlmbatch");
		}else{
			url = (String) PropertiesUtil.getContextProperty("edi_goods_batch");
		}
		url += "?userName=" + CookiesUtil.getUserName(request) ;
		String jsonStr = JSON.toJSONString(list);
		HttpUtilPcm.doPost(url, jsonStr);
	}
	
	/**
	 * 自动关联
	 * @Methods Name goodsAutomatic
	 * @Create In 2016年1月27日 By wangjl
	 * @param numiid
	 * @param request
	 * @param response void
	 */
	@RequestMapping("/goodsAutomatic")
	public void goodsAutomatic(String channelCode,HttpServletRequest request, HttpServletResponse response) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		paramMap.put("channel_code", channelCode);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url = "";
			if("M4".equals(channelCode)){
				url = (String) PropertiesUtil.getContextProperty("edi_goods_yzautomatic");
			}else{
				url = (String) PropertiesUtil.getContextProperty("edi_goods_automatic");
			}
			HttpUtilPcm.doPost(url, jsonStr);
		} catch (Exception e) {
			map.put("pageCount", 0);
			map.put("success", "false");
		}
	}
	
	/**
	 * 解除关联关系
	 * @Methods Name goodsAutomatic
	 * @Create In 2016年1月28日 By wangjl
	 * @param numiid
	 * @param request
	 * @param response void
	 */
	@RequestMapping("/goodsRemove")
	public void goodsRemove(String outerid,String numiid,String channelCode,HttpServletRequest request, HttpServletResponse response) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}

		paramMap.put("num_iid", numiid);
		paramMap.put("outer_id", outerid);
		paramMap.put("channel", channelCode);
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url = "";
			if("M4".equals(channelCode)){
				url = (String) PropertiesUtil.getContextProperty("edi_goods_yzrelieve");
			}else if("CC".equals(channelCode)){
				url = (String) PropertiesUtil.getContextProperty("edi_goods_hlmrelieve");
			}else{
				url = (String) PropertiesUtil.getContextProperty("edi_goods_relieve");
			}
			HttpUtilPcm.doPost(url, jsonStr);
		} catch (Exception e) {
			map.put("pageCount", 0);
			map.put("success", "false");
		}
		if(StringUtils.isNotEmpty(CookiesUtil.getUserName(request))){
			paramMap.put("userName", CookiesUtil.getUserName(request));
		}else{
			paramMap.put("userName", "");
		}
	}
}
