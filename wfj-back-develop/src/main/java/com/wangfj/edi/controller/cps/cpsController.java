package com.wangfj.edi.controller.cps;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.DateUtils;
import com.utils.ServletUtils;
import com.utils.StringUtils;
import com.wangfj.edi.util.PropertiesUtil;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.HttpUtilPcm;




@Controller
@RequestMapping("/ediCps")
public class cpsController {

	private final static Logger logger = Logger.getLogger(cpsController.class);
	
	/**
	 * 查询cps信息（带分页）
	 * @Methods Name selectCpsList
	 * @Create In 2016-06-13
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/selectCpsList")
	public String selectOrderList(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Integer pageSize = request.getParameter("pageSize")==null?null:Integer.parseInt(request.getParameter("pageSize"));
		Integer currentPage = Integer.parseInt(request.getParameter("page"));
		if(pageSize==null || pageSize==0){
			pageSize = 15;
		}
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderId", request.getParameter("orderNo"));
		paramMap.put("src", request.getParameter("src"));
		paramMap.put("isPost", request.getParameter("isPost"));
		paramMap.put("startDate", request.getParameter("startDate"));
		paramMap.put("endDate", request.getParameter("endDate"));
		Map<Object, Object> orderVo = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			orderVo.put("orderVo", jsonStr);
			logger.info("jsonStr:" + jsonStr);
			String url=	(String) PropertiesUtil.getContextProperty("edi_cps_order");
			paramMap.put("currentPage", currentPage);
			paramMap.put("pageSize", pageSize);
			JSONObject jo = JSONObject.fromObject(paramMap);
			json =HttpUtilPcm.doPost(url, jo.toString());
			logger.info("json:" + json);
			paramMap.clear();
			if (!"".equals(json)) {
				JSONObject jsonPage = JSONObject.fromObject(json);
				if (jsonPage != null) {
					paramMap.put("list", jsonPage.get("list"));
					paramMap.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0) : jsonPage.get("pages"));
				} else {
					paramMap.put("list", null);
					paramMap.put("pageCount", Integer.valueOf(0));
				}
			} else {
				paramMap.put("list", null);
				paramMap.put("pageCount", Integer.valueOf(0));
			}
		} catch (Exception e) {
			paramMap.put("pageCount", Integer.valueOf(0));
		}
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println(gson.toJson(paramMap)+".....");
		return gson.toJson(paramMap);
		
	}
	/**
	 * CPS开关状态查询
	 * @Methods Name queryCpsToggle
	 * @Create In 2016-06-13
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/queryCpsToggle")
	public String queryCpsToggle(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		Map<String, String> paramMap;
		try {
			paramMap = getRequestParamMap(request);
			String url=(String) PropertiesUtil.getContextProperty("edi_cps");
			 JSONObject jo = JSONObject.fromObject(paramMap);
				json =HttpUtilPcm.doPost(url, jo.toString());
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
						 logger.info("json:" + json);
						 return gson.toJson(json);
	}
	
	/**
	 * CPS开关更新
	 * @Methods Name updateCpsToggle
	 * @Create In 2016-06-13
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/updateCpsToggle")
	public String updateCpsToggle(HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		
		try {
			Map<String, String> paramMap = getRequestParamMap(request);
			String url=(String) PropertiesUtil.getContextProperty("edi_cps_update");
			JSONObject jo = JSONObject.fromObject(paramMap);
			json =HttpUtilPcm.doPost(url, jo.toString());
			logger.info("json:" + json);
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		System.out.println(gson.toJson(json));
		return gson.toJson(json);
		
	}
	
	@RequestMapping(value = "/cpsDailyFixLinkTech")
    public void cpsDailyFixLinkTech(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		logger.info("cpsDailyFixLinkTech请求开始");
        resp.setContentType("text/xml; charset=UTF-8");
        resp.setHeader("Cache-Control", "no-store, no-cache");
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Expires", "now");
        Map<String, String> paramMap = getRequestParamMap(req);
        String url=(String) PropertiesUtil.getContextProperty("---------");
		JSONObject jo = JSONObject.fromObject(paramMap);
		String result =HttpUtilPcm.doPost(url, jo.toString());

        PrintWriter out = resp.getWriter();
        out.write(result);

        logger.info("response is :" + result);
        logger.info("cpsDailyFixLinkTech请求结束");

    }
	
	@RequestMapping(value = "/cpsDailyFixYiqifa")
    public void cpsDailyFixYiqifa(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		logger.info("cpsDailyFixYiqifa请求开始");
        resp.setContentType("text/xml; charset=UTF-8");
        resp.setHeader("Cache-Control", "no-store, no-cache");
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Expires", "now");
        Map<String, String> paramMap = getRequestParamMap(req);
        String url=(String) PropertiesUtil.getContextProperty("---------");
		JSONObject jo = JSONObject.fromObject(paramMap);
		String result =HttpUtilPcm.doPost(url, jo.toString());

        PrintWriter out = resp.getWriter();
        out.write(result);

        logger.info("response is :" + result);
        logger.info("cpsDailyFixYiqifa请求结束");

    }
	
	@RequestMapping(value = "/cpsDailyFixDuoMai")
    public void cpsDailyFixDuoMai(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		logger.info("cpsDailyFixDuoMai请求开始");
        resp.setContentType("text/xml; charset=UTF-8");
        resp.setHeader("Cache-Control", "no-store, no-cache");
        resp.setHeader("Pragma", "no-cache");
        resp.setHeader("Expires", "now");
        Map<String, String> paramMap = getRequestParamMap(req);
        String url=(String) PropertiesUtil.getContextProperty("---------");
		JSONObject jo = JSONObject.fromObject(paramMap);
		String result =HttpUtilPcm.doPost(url, jo.toString());

        PrintWriter out = resp.getWriter();
        out.write(result);

        logger.info("response is :" + result);
        logger.info("cpsDailyFixDuoMai请求结束");

    }
	
	
	
	
	
	 /**
     * 从请求中获取所有参数（当参数名重复时，用后者覆盖前者）
     * 
     * <pre>
     * 目前所有参数名称转小写
     * </pre>
     * 
     * @param request
     *            httpServletRequest
     * @return
     * @throws java.io.UnsupportedEncodingException
     * @Author Terry
     */
    public Map<String, String> getRequestParamMap(HttpServletRequest request)
            throws UnsupportedEncodingException {
        // 获取所有请求参数
        Map<String, String> paramMap = new HashMap<String, String>();
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            String paramValue = request.getParameter(paramName);
            paramMap.put(paramName, paramValue);
        }
        return paramMap;
    }
	
	
	/**
	 * 导出excel
	 * @Methods Name exportExcle
	 * @Create In 2016-06-13 
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping("/exportExcle")
	public String exportExcle(String status,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		Map<Object, Object> paramMap = new HashMap<Object, Object>();
		paramMap.put("orderId", request.getParameter("orderNo"));
		paramMap.put("src", request.getParameter("src"));
		paramMap.put("isPost", request.getParameter("isPost"));
		paramMap.put("startDate", request.getParameter("startDate"));
		paramMap.put("endDate", request.getParameter("endDate"));
		
		Map<Object, Object> m = new HashMap<Object, Object>();
		try {
			String jsonStr = JSON.toJSONString(paramMap);
			logger.info("jsonStr:" + jsonStr);
			String url=	(String) PropertiesUtil.getContextProperty("edi_cps_export");
			json =HttpUtilPcm.doPost(url, jsonStr);
			
			excelOrderDetailReport(paramMap,json,request,response);
			logger.info("json:" + json);
		} catch (Exception e) {
			m.put("pageCount", 0);
			m.put("success", "false");
		}
		return json;
	}
	
	private void excelOrderDetailReport(Map<Object, Object> paramMap, String json, HttpServletRequest request,
			HttpServletResponse response) throws IOException, FileNotFoundException {
		List cpsDataList = new ArrayList();
		
		if (!"".equals(json)) {
			JSONObject jsonPage = JSONObject.fromObject(json);
			if (jsonPage != null) {
				cpsDataList = (List) jsonPage.get("list");
			}
		} 
		
		String fileName = "ediCpsData.xls";

		String outFile = "CPS数据明细报表.xls";

		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(request.getRealPath("/") + fileName));
		HSSFSheet sheet = wb.getSheetAt(0);
		
		fillContent(paramMap,cpsDataList, sheet);
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		wb.write(byteArrayOutputStream);
		
		response.reset();
	    response.setContentType("application/vnd.ms-excel;charset=UTF-8");
	    response.addHeader("Content-Disposition", "attachment;filename="
	        + new String(outFile.getBytes("gbk"), "iso-8859-1"));
	    response.setContentLength(byteArrayOutputStream.size());

	    ServletOutputStream outputstream = response.getOutputStream(); // 取得输出流
	    byteArrayOutputStream.writeTo(outputstream); // 写到输出流
	    byteArrayOutputStream.close(); // 关闭
	    outputstream.flush(); // 刷数据
	}
	private void fillContent(Map<Object, Object> paramMap,List cpsDataList, HSSFSheet sheet) {
		HSSFCellStyle style1 = sheet.getRow(7).getCell(0).getCellStyle();
		style1.setWrapText(true);// 自动换行   
		String srcName = paramMap.get("src").toString();
		String startDate = paramMap.get("startDate").toString();
		String endDate = paramMap.get("endDate").toString();
		
		if(StringUtils.isNotEmpty(srcName)){
			sheet.getRow(4).getCell(0).setCellValue("来源:" + srcName);
		}else{
			sheet.getRow(4).getCell(0).setCellValue("来源:全部");
		}
		if(StringUtils.isNotEmpty(startDate)){
			sheet.getRow(4).getCell(7).setCellValue("订单起始时间:" + startDate);
		}else{
			sheet.getRow(4).getCell(7).setCellValue("订单起始时间:");
		}
		if(StringUtils.isNotEmpty(endDate)){
			sheet.getRow(4).getCell(15).setCellValue("订单截至时间:" + endDate);
		}else{
			sheet.getRow(4).getCell(15).setCellValue("订单截至时间:");
		}
		for (int i = 0; i < cpsDataList.size(); i++) {
			Map<String, Object> map = (Map) cpsDataList.get(i);

			String srcType = map.get("srcType") == null ? "" : map.get("srcType").toString();
			//渠道用户名
			String src = map.get("src") == null ? "" : map.get("src").toString();
			//订单状态
			String status = map.get("status") == null ? "" : map.get("status").toString();
			//订单编号
			String orderId = map.get("orderId") == null ? "" : map.get("orderId").toString();
			//订单时间
			String creatTime = map.get("creatTime") == null ? "" : map.get("creatTime").toString();
			//订单应付金额
			String totalFee = map.get("totalFee") == null ? "" : map.get("totalFee").toString();
			
			//工业一级分类		待定
			String gygoodCateName = map.get("goodCateName") == null ? "" : map.get("goodCateName").toString();
			//商品编码
			String partnumber = map.get("partnumber") == null ? "" : map.get("partnumber").toString();
			//商品名称
			String goodName = map.get("goodName") == null ? "" : map.get("goodName").toString();
			//商品金额		待定
			String goodstotalFee = map.get("totalFee") == null ? "" : map.get("totalFee").toString();
			//商品分类		待定
			String goodCateName = map.get("goodCateName") == null ? "" : map.get("goodCateName").toString();
			//商品数量
			String quantity = map.get("quantity") == null ? "" : map.get("quantity").toString();
			//退货数量
			String retNum = map.get("retNum") == null ? "" : map.get("retNum").toString();
			
			//是否使用优惠券	待定
			String yhq = map.get("yhq") == null ? "" : map.get("yhq").toString();
			//实付款
			String totalproduct = map.get("totalproduct") == null ? "" : map.get("totalproduct").toString();
			//是否为特例品
			String isSpecial = map.get("isSpecial") == null ? "" : map.get("isSpecial").toString();
			//是否为黄金珠宝
			String isGold = map.get("isGold") == null ? "" : map.get("isGold").toString();
			//用户id
			String memberId = map.get("memberId") == null ? "" : map.get("memberId").toString();
			//用户注册时间		待定
			String memberCreateTime = map.get("memberCreateTime") == null ? "" : map.get("memberCreateTime").toString();
			//用户姓名
			String userName = map.get("userName") == null ? "" : map.get("userName").toString();
			//电话
			String userPhone = map.get("userPhone") == null ? "" : map.get("userPhone").toString();
			//邮箱地址
			String userMail = map.get("userMail") == null ? "" : map.get("userMail").toString();
			//地址
			String userArea = map.get("userArea") == null ? "" : map.get("userArea").toString();
			
			HSSFRow row = sheet.createRow(i + 7);
			row.setHeightInPoints(20);

			createCell(style1, srcType, row, 0);
			createCell(style1, src, row, 1);
			createCell(style1, status, row, 2);
			createCell(style1, orderId, row, 3);
			createCell(style1, creatTime, row, 4);
			createCell(style1, totalFee, row, 5);
			createCell(style1, goodCateName, row, 6);
			createCell(style1, partnumber, row, 7);
			createCell(style1, goodName, row, 8);
			createCell(style1, totalFee, row, 9);
			createCell(style1, goodCateName, row, 10);
			createCell(style1, quantity, row, 11);
			createCell(style1, retNum, row, 12);
			createCell(style1, yhq, row, 13);
			createCell(style1, totalproduct, row, 14);
			createCell(style1, isSpecial, row, 15);
			createCell(style1, isGold, row, 16);
			createCell(style1, memberId, row, 17);
			createCell(style1, memberCreateTime, row, 18);
			createCell(style1, userName, row, 19);
			createCell(style1, userPhone, row, 20);
			createCell(style1, userMail, row, 21);
			createCell(style1, userArea, row, 22);
			
			this.calcAndSetRowHeigt(row);
				
		}
	}
	private void createCell(HSSFCellStyle style, String cellValue, HSSFRow row, int cellNum) {
		HSSFCell cell0 = row.createCell(cellNum);
		cell0.setCellValue(cellValue);
		cell0.setCellStyle(style);
	}
	/**
	 * 根据行内容重新计算行高
	 * @param row
	*/
	private void calcAndSetRowHeigt(HSSFRow sourceRow) {
	    //原行高
	    short height = sourceRow.getHeight();
	    //计算后的行高
	    double maxHeight = height;
	    for (int cellIndex = sourceRow.getFirstCellNum(); cellIndex <= sourceRow.getPhysicalNumberOfCells(); cellIndex++) {
	      HSSFCell sourceCell = sourceRow.getCell(cellIndex);
	      //单元格的内容
	      String cellContent = getCellContentAsString(sourceCell);
	      if(null == cellContent || "".equals(cellContent)){
	        continue;
	      }
	      //单元格的宽度
	      int columnWidth = getCellWidth(sourceCell);
	      //System.out.println("单元格的宽度 : " + columnWidth + "    单元格的高度 : " + maxHeight + ",    单元格的内容 : " + cellContent);
	      HSSFCellStyle cellStyle = sourceCell.getCellStyle();
	      HSSFFont font = cellStyle.getFont(sourceRow.getSheet().getWorkbook());
	      //字体的高度
	      short fontHeight = font.getFontHeight();
	      
	      //cell内容字符串总宽度
	      double cellContentWidth = cellContent.getBytes().length * 2 * 256;
	      
	       //字符串需要的行数 不做四舍五入之类的操作
	       double stringNeedsRows =(double)cellContentWidth / columnWidth;
	       //小于一行补足一行
	       if(stringNeedsRows < 1.0){
	       	stringNeedsRows = 1.0;
	       }
	       
	       //需要的高度 			(Math.floor(stringNeedsRows) - 1) * 40 为两行之间空白高度
	       double stringNeedsHeight = (double)fontHeight * stringNeedsRows;
	       if(stringNeedsHeight > maxHeight){
	       	maxHeight = stringNeedsHeight;
	       }
	       //System.out.println("字体高度 : " + fontHeight + ",    字符串宽度 : " + cellContentWidth + ",    字符串需要的行数 : " + stringNeedsRows + ",   需要的高度 : " + stringNeedsHeight);
	       //System.out.println();
	    }
	    //超过原行高三倍 则为3倍 实际应用中可
	    if(maxHeight/height > 5){
	      maxHeight = 5 * height;
	    }
	    //最后取天花板防止高度不够
	    maxHeight = Math.ceil(maxHeight);
	    sourceRow.setHeight((short)maxHeight);
	  }
	  /**
	   * 解析一个单元格得到数据
	   * @param columnNameList
	   * @param row
	   * @param ext2
	   * @param ext1
	   * @return
	   */
	  private String getCellContentAsString(HSSFCell cell) {
	    if(null == cell){
	      return "";
	    }
	    String result = "";
	    switch (cell.getCellType()) {
	    case Cell.CELL_TYPE_NUMERIC:
	      String s = String.valueOf(cell.getNumericCellValue());
	      if (s != null) {
	        if (s.endsWith(".0")) {
	          s = s.substring(0, s.length() - 2);
	        }
	      }
	      result = s;
	      break;
	    case Cell.CELL_TYPE_STRING:
	      result = String.valueOf(cell.getStringCellValue()).trim();
	      break;
	    case Cell.CELL_TYPE_BLANK:
	      break;
	    case Cell.CELL_TYPE_BOOLEAN:
	      result = String.valueOf(cell.getBooleanCellValue());
	      break;
	    case Cell.CELL_TYPE_ERROR:
	      break;
	    default:
	      break;
	    }
	    return result;
	  }
	  
	  /**
	  * 获取单元格及合并单元格的宽度
	  * @param sheet
	  * @param row
	  * @param column
	  * @return
	  */
	    private  int getCellWidth(HSSFCell cell) {
	    	int result = 0;
	    	HSSFSheet sheet = cell.getSheet();
	    	int rowIndex = cell.getRowIndex();
	    	int columnIndex = cell.getColumnIndex();
	    	
	    	boolean isPartOfRegion = false;
	    	int firstColumn = 0;
	    	int lastColumn = 0;
	    	int firstRow = 0;
	    	int lastRow = 0;
	    int sheetMergeCount = sheet.getNumMergedRegions();
	    for (int i = 0; i < sheetMergeCount; i++) {
	      Region ca = sheet.getMergedRegionAt(i);
	      firstColumn = ca.getColumnFrom();
	      lastColumn = ca.getColumnTo();
	      firstRow = ca.getRowFrom();
	      lastRow = ca.getRowTo();
	      if (rowIndex >= firstRow && rowIndex <= lastRow) {
	        if (columnIndex >= firstColumn && columnIndex <= lastColumn) {
	          isPartOfRegion = true;
	          break;
	        }
	      }
	    }
	    if(isPartOfRegion){
	      for (int i = firstColumn; i <= lastColumn; i++) {
	        result += sheet.getColumnWidth(i);
	      }
	    }else{
	      result = sheet.getColumnWidth(columnIndex);
	    }
	    return result;
	  }
}
