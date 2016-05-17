/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.NavigationController.java
 * @Create By chengsj
 * @Create In 2013-7-23 下午2:15:14
 * TODO
 */
package com.wangfj.wms.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.utils.httpclient.HttpClientUtil;
import com.wangfj.wms.domain.entity.SeoBrand;
import com.wangfj.wms.domain.entity.SeoHotWord;
import com.wangfj.wms.domain.entity.SeoLongKeyword;
import com.wangfj.wms.service.ISeoBrandService;
import com.wangfj.wms.service.ISeoHotWordService;
import com.wangfj.wms.service.ISeoLongKeywordService;
import com.wangfj.wms.service.ISeoToExcelService;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name ExcelImportController
 * @Author chengsj
 * @Create In 2014-6-23
 */
@Controller
@RequestMapping(value = "/excel")
public class ExcelImportController {

	private static Logger log = LoggerFactory
			.getLogger(ExcelImportController.class);

	@Autowired
	@Qualifier("seoBrandService")
	private ISeoBrandService seoBrandService;

	@Autowired
	@Qualifier("seoHotWordService")
	private ISeoHotWordService seoHotWordService;

	@Autowired
	@Qualifier("seoLongKeywordService")
	private ISeoLongKeywordService seoLongKeywordService;

	@Autowired
	@Qualifier("seoToExcelService")
	private ISeoToExcelService seoToExcelService;

	/*
	 * 导入品牌
	 */
	@ResponseBody
	@RequestMapping(value = { "/importBrand" }, method = { RequestMethod.POST })
	public String importBrand(HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		String json = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		resMap.put("success", false);
		if (isMultipart == true) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<?> items = upload.parseRequest(request);
				Iterator iter = items.iterator();
				while (iter.hasNext()) {
					String tempUrl = System.getProperty("user.home");
					FileItem item = (FileItem) iter.next();
					File fullFile = new File(tempUrl + "/" + item.getName());
					item.write(fullFile);
					List<SeoBrand> list = this.getBrandCodInfo(tempUrl + "/"
							+ item.getName());
					resMap.put("list", list);
					resMap.put("success", true);
					json = ResultUtil.createSuccessResult(list);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return json;
	}

	private List<SeoBrand> getBrandCodInfo(String path) {
		List<SeoBrand> list = new ArrayList<SeoBrand>();
		try {
			InputStream in = new FileInputStream(path);
			try {
				Workbook wb = null;
				if (path.endsWith("xls") || path.endsWith("csv")) {
					wb = new HSSFWorkbook(in);// xls
				} else {
					wb = new XSSFWorkbook(in);// xlsx
				}
				Sheet hssfSheet = wb.getSheetAt(0);
				// 遍历行
				for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
					Row hssfRow = hssfSheet.getRow(rowNum);
					if (hssfRow == null) {
						continue;
					}
					SeoBrand brand = new SeoBrand();
					Cell hssfCell = hssfRow.getCell(0);
					hssfCell.setCellType(Cell.CELL_TYPE_STRING);
					String brandName = hssfCell.getStringCellValue() + "";
					if (brandName != null && !"".equalsIgnoreCase(brandName)) {
						brand.setBrandName(brandName);
						list.add(brand);
					} else {
						continue;
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return list;
	}

	/*
	 * 导入热词
	 */
	@ResponseBody
	@RequestMapping(value = { "/importHot" }, method = { RequestMethod.POST })
	public String importUniqueHot(HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		String json = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		resMap.put("success", false);
		if (isMultipart == true) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<?> items = upload.parseRequest(request);
				Iterator iter = items.iterator();
				while (iter.hasNext()) {
					String tempUrl = System.getProperty("user.home");
					FileItem item = (FileItem) iter.next();
					File fullFile = new File(tempUrl + "/" + item.getName());
					item.write(fullFile);
					List<SeoHotWord> list = this.getHotCodInfo(tempUrl + "/"
							+ item.getName());
					resMap.put("list", list);
					resMap.put("success", true);
					json = ResultUtil.createSuccessResult(list);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return json;
	}

	private List<SeoHotWord> getHotCodInfo(String path) {
		List<SeoHotWord> list = new ArrayList<SeoHotWord>();
		try {
			InputStream in = new FileInputStream(path);
			try {
				Workbook wb = null;
				if (path.endsWith("xls") || path.endsWith("csv")) {
					wb = new HSSFWorkbook(in);// xls
				} else {
					wb = new XSSFWorkbook(in);// xlsx
				}
				Sheet hssfSheet = wb.getSheetAt(0);
				// 遍历行
				for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
					Row hssfRow = hssfSheet.getRow(rowNum);
					if (hssfRow == null) {
						continue;
					}
					SeoHotWord hot = new SeoHotWord();
					Cell hssfCell = hssfRow.getCell(0);
					hssfCell.setCellType(Cell.CELL_TYPE_STRING);
					String hotName = hssfCell.getStringCellValue() + "";
					if (hotName != null && !"".equalsIgnoreCase(hotName)) {
						hot.setHotName(hotName);
						list.add(hot);
					} else {
						continue;
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return list;
	}

	/*
	 * 导入长尾关键词
	 */
	@ResponseBody
	@RequestMapping(value = { "/importLong" }, method = { RequestMethod.POST })
	public String importLong(HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> resMap = new HashMap<String, Object>();
		String json = "";
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		resMap.put("success", false);
		if (isMultipart == true) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				List<?> items = upload.parseRequest(request);
				Iterator iter = items.iterator();
				while (iter.hasNext()) {
					String tempUrl = System.getProperty("user.home");
					FileItem item = (FileItem) iter.next();
					File fullFile = new File(tempUrl + "/" + item.getName());
					item.write(fullFile);
					List<SeoLongKeyword> list = this.getLongCodInfo(tempUrl
							+ "/" + item.getName());
					resMap.put("list", list);
					resMap.put("success", true);
					json = ResultUtil.createSuccessResult(list);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return json;
	}

	private List<SeoLongKeyword> getLongCodInfo(String path) {
		List<SeoLongKeyword> list = new ArrayList<SeoLongKeyword>();
		try {
			InputStream in = new FileInputStream(path);
			try {
				Workbook wb = null;
				if (path.endsWith("xls") || path.endsWith("csv")) {
					wb = new HSSFWorkbook(in);// xls
				} else {
					wb = new XSSFWorkbook(in);// xlsx
				}
				Sheet hssfSheet = wb.getSheetAt(0);
				// 遍历行
				for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
					Row hssfRow = hssfSheet.getRow(rowNum);
					if (hssfRow == null) {
						continue;
					}
					SeoLongKeyword longKey = new SeoLongKeyword();
					Cell hssfCell = hssfRow.getCell(0);
					hssfCell.setCellType(Cell.CELL_TYPE_STRING);
					String longKeyName = hssfCell.getStringCellValue() + "";
					if (longKeyName != null
							&& !"".equalsIgnoreCase(longKeyName)) {
						longKey.setLongName(longKeyName);
						list.add(longKey);
					} else {
						continue;
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value = { "/savedata" }, method = { RequestMethod.POST })
	public String checkMoney(HttpServletRequest request,
			HttpServletResponse response, String type)
			throws UnsupportedEncodingException {
		long startTime = System.currentTimeMillis(); // 获取开始时间
		String json = "";
		String key = "";
		int counter = 0;
		String insertime="";
		int random=0;
		long runtime = 0;
		try {
			Map<String, String> paramMap = this.createParam(request);
			String data = paramMap.get("data");
			String[] dataArray = data.substring(0, data.length() - 1).split(",");
			for (int i = 0; i < dataArray.length; i++) {
				if (dataArray[i] != null && !dataArray[i].isEmpty()) {
					String name = dataArray[i];
					if (type.equals("1")) {
						int count = this.seoBrandService
								.selectCountByBrandName(name);
						if (count > 0) {
							continue;
						}
					} else if (type.equals("2")) {
						int count = this.seoHotWordService
								.selectCountByHotName(name);
						if (count > 0) {
							continue;
						}
			//		} else if (type.equals("3")) {
					}else{
						int count = this.seoLongKeywordService
								.selectCountByLongName(name);
						if (count > 0) {
							continue;
						}
					}

					/*
					 * 调用搜索接口，判断Flag标志位
					 */
					key = URLEncoder.encode(name, "utf-8");
					String url = SystemConfig.SEARCH_URL + key + ".json?inShopin=web";
					JSONObject obj = null;
					int num = 0;
					String suc = "";
					try {
						String searchJson = HttpClientUtil.GetUrlContent(url, "");
						searchJson.contains("total");
						obj = JSONObject.fromObject(searchJson);
						num = Integer.valueOf(obj.getString("total"));
						suc = obj.getString("success");
					} catch (Exception e) {
					}
					/*
					 * 根据数据类型，插入数据库
					 */
					if (type.equals("1")) {
						SeoBrand brand = new SeoBrand();
						if (num > 0 && suc.equals("true")) {
							brand.setFlag(1);
						} else {
							brand.setFlag(0);
						}
						brand.setBrandName(name);
						brand.setBrandLink("pinpai/" + name + ".html");
						int status = this.seoBrandService.insertSelective(brand);
						if (status > 0) {
							counter++;
						}
					} else if (type.equals("2")) {
						SeoHotWord hot = new SeoHotWord();
						if (num > 0 && suc.equals("true")) {
							hot.setFlag(1);
						} else {
							hot.setFlag(0);
						}
						hot.setHotName(name);
						 insertime = Long.toString(System.currentTimeMillis());
						 //random=(int)(Math.random()*900)+100;
						hot.setHotLink("hot/" + insertime.substring(2,12)+".html");
						int status = this.seoHotWordService.insertSelective(hot);
						if (status > 0) {
							counter++;
						}
					//} else if (type.equals("3")) {
					}else{
						SeoLongKeyword longKey = new SeoLongKeyword();
						if (num > 0 && suc.equals("true")) {
							longKey.setFlag(1);
						} else {
							longKey.setFlag(0);
						}
						longKey.setLongName(name);
						 insertime = Long.toString(System.currentTimeMillis());
						// random=(int)(Math.random()*900)+100;
						longKey.setLongLink("topic/" + insertime.substring(2,12)+".html");
						int status = this.seoLongKeywordService
								.insertSelective(longKey);
						if (status > 0) {
							counter++;
						}
					}

				}
			}
			 long endTime = System.currentTimeMillis(); // 获取结束时间
			  runtime = endTime - startTime;
			 log.info("批量导入品牌所用的时间为--------" + runtime+"ms");
			 log.info("共成功导入----"+counter+"----条品牌数据");
		} catch (Exception e) {
			e.printStackTrace();
		}
		json = "导入完成，用时: "+runtime/1000+" 秒";
		return json;
	}

	@ResponseBody
	@RequestMapping("/SeoToExcelController")
	public String SeoToExcelController(HttpServletRequest request,
			HttpServletResponse response) {

		String jsons = "";

		String selectType = request.getParameter("selectType");// 查找那个表 1 品牌 2
																// 热词 3长尾
		String flag = request.getParameter("flag");// 0是无效，1是有效,为空查找全部
		String title = request.getParameter("title");

		Map<String, Object> map = new HashMap<String, Object>();

		if (selectType == null || selectType.equals("")) {
			// 提示参数不能为空
			JSONObject jso = new JSONObject();
			jso.put("memo", "selectType不能为空，请选择 查询范围");
			jsons = ResultUtil.createFailureResult(new Exception("参数不能为空!"));
		}
		try {
			map.put("flag", flag);
			map.put("selectType", selectType);

			String result = seoToExcelService.seoDataConvertToExcel(response,
					title, map);
			jsons = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			System.out.println(e);
			jsons = ResultUtil.createFailureResult(e);
			return jsons;
		}
		return jsons;
	}

	private Map<String, String> createParam(HttpServletRequest request) {
		request.removeAttribute("_method");
		Map<String, String> paramMap = new HashMap<String, String>();
		Enumeration<String> enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String paramStr = (String) enumeration.nextElement();
			paramMap.put(paramStr, request.getParameter(paramStr));
		}
		return paramMap;
	}

}
