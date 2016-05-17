/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.PromotionController.java
 * @Create By chengsj
 * @Create In 2013-8-30 下午4:35:23
 * TODO
 */
package com.wangfj.wms.controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.framework.page.Paginator;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.wangfj.wms.domain.entity.LabourDayUserInfo;
import com.wangfj.wms.domain.entity.MobileFlashPromotions;
import com.wangfj.wms.domain.view.MobileFlashPromotionsVO;
import com.wangfj.wms.service.ILabourDayUserInfoService;
import com.wangfj.wms.service.IMobileFlashPromotionService;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.HttpUtil;
import com.wangfj.wms.util.MobileFlashPromotionsKey;
import com.wangfj.wms.util.MobileFlashPromotionsUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name MobileFlashPromotionController
 * @Author chengsj
 * @Create In 2014-3-26
 */
@Controller
@RequestMapping("/mobileflashpromotions")
public class MobileFlashPromotionController {

	@Autowired
			@Qualifier("mobileflashpromotionService")
	IMobileFlashPromotionService mobileFlashPromotionService;
	@Autowired
			@Qualifier("labourdayuserinfoservice")
	ILabourDayUserInfoService labourDayUserInfoService;

	private int maxPostSize = 100 * 1024 * 1024;

	/**
	 * 说明： 分页查询活动记录
	 * 
	 * @Methods Name selectPromotions
	 * @Create In 2014-3-24 By chengsj
	 * @param key
	 */
	@ResponseBody
	@RequestMapping(value = "/selectMobileFlashPromotionListByKey", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectPromotionListByKey(MobileFlashPromotionsVO key) {
		Paginator paginator = new Paginator();
		String resultJson = "";
		try {
			paginator.setPageSize(key.getPageSize());
			paginator.setCurrentPage(key.getCurrentPage());
			paginator.setTotalRecordsBuild(this.mobileFlashPromotionService
					.selectCountByPrams(key));
			paginator.setList(this.mobileFlashPromotionService
					.selectByPrams(key));
			resultJson = ResultUtil.createSuccessResultPage(paginator);
		} catch (Exception e) {
			resultJson = ResultUtil.createFailureResult(e);
		}
		return resultJson;
	}

	/**
	 * 说明： 审核活动/作废活动
	 * 
	 * @Methods Name updateStatus
	 * @Create In 2014-3-26 By chengsj
	 * @param sid
	 * @param flag
	 *            void
	 */
	@ResponseBody
	@RequestMapping(value = "/updateMobilePromotionFlag", method = {
			RequestMethod.GET, RequestMethod.POST })
	public void updateStatus(String sid, String flag) {
		String json = "";
		MobileFlashPromotions promotion = null;
		if (sid != null && !"".equals(sid)) {
			promotion = this.mobileFlashPromotionService
					.selectByPrimaryKey(Integer.parseInt(sid));
		}
		if (promotion != null && flag != null && !"".equals(flag)) {
			promotion.setFlag(Integer.parseInt(flag));
			this.mobileFlashPromotionService
					.updateByPrimaryKeySelective(promotion);
		}

		MobileFlashPromotions pro = new MobileFlashPromotions();
		pro = this.mobileFlashPromotionService.selectByPrimaryKey(Integer
				.valueOf(sid));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String startTime = sdf.format(pro.getStartTime());

		String endTime = sdf.format(pro.getEndTime());

		String createTime = sdf.format(pro.getCreateTime());
		try {
			String resultJson = "";
			Map paramMap = new HashMap();
			paramMap.put("sid", pro.getSid());
			paramMap.put("title", pro.getTitle());
			paramMap.put("pro_desc", pro.getProDesc());
			paramMap.put("link", pro.getLink());
			paramMap.put("start_time", startTime);
			paramMap.put("end_time", endTime);
			paramMap.put("pict", pro.getPict());
			paramMap.put("seq", pro.getSeq());
			paramMap.put("create_time", createTime);
			paramMap.put("creater", pro.getCreater());
			paramMap.put("create_shop_name", pro.getCreateShopName());
			paramMap.put("create_shop_sid", pro.getCreateShopSid());
			paramMap.put("flag", pro.getFlag());
			paramMap.put("promotion_type", pro.getPromotionType());
			paramMap.put("promotion_type_sid", pro.getPromotionTypeSid());
			String parajson = new GsonBuilder().create().toJson(paramMap);
			resultJson = HttpUtil.HttpPostForLogistics(SystemConfig.WSG_SYN,
					"FlashPromotionsUpdate", parajson);
			resultJson = resultJson.replaceAll("\\\\", "");
			resultJson = resultJson.substring(1, resultJson.length() - 1);
			JsonParser parser = new JsonParser();
			JsonObject obj = parser.parse(resultJson).getAsJsonObject();
			String success = obj.get("success").toString();
			if (success.equals("\"true\"")) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("", "");
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
	}

	@ResponseBody
	@RequestMapping(value = "/saveAndUploadToFTP", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveAndUploadToFTP(String sid, HttpServletRequest request,
			HttpServletResponse response) throws FileUploadException,
			ParseException, UnsupportedEncodingException {
		String json = "";
		String name;
		String encoding = request.getCharacterEncoding();
		OutputStream out = null;
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxPostSize);

		if (sid == null || "".equals(sid)) {
			MobileFlashPromotions mfpromotions = new MobileFlashPromotions();
			mfpromotions.setFlag(0);
			this.mobileFlashPromotionService.insertSelective(mfpromotions);
			sid = this.mobileFlashPromotionService.queryMaxSid() + "";

		}

		List fileItems = upload.parseRequest(request);
		name = FtpUtil.getImagePath();
		for (int i = 0; i < fileItems.size(); i++) {
			FileItem item = (FileItem) fileItems.get(i);
			if (!item.isFormField() && item.getName() != null
					&& !"".equals(item.getName())) {
				String filename = item.getName();
				String upName = "";
				upName = name + i + "." + filename.split("\\.")[1];
				FtpUtil.saveToFtp(out, upName, item);
				MobileFlashPromotions pro = new MobileFlashPromotions();
				pro.setSid(Integer.valueOf(sid));
				if (item.getFieldName() == "pict"
						|| "pict".equals(item.getFieldName())) {
					pro.setPict("/" + SystemConfig.PROMOTION_PATH + "/"
							+ upName);
				}
				this.mobileFlashPromotionService
						.updateByPrimaryKeySelective(pro);
			} else {
				String key = item.getFieldName();
				String value = item.getString(encoding);
				MobileFlashPromotions pt = MobileFlashPromotionsUtil
						.setPromotions(key, value, sid);

				this.mobileFlashPromotionService
						.updateByPrimaryKeySelective(pt);
			}
		}

		MobileFlashPromotions pro = new MobileFlashPromotions();

		pro = this.mobileFlashPromotionService.selectByPrimaryKey(Integer
				.valueOf(sid));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String startTime = sdf.format(pro.getStartTime());

		String endTime = sdf.format(pro.getEndTime());

		String createTime = sdf.format(pro.getCreateTime());

		try {
			String resultJson = "";
			Map paramMap = new HashMap();
			paramMap.put("sid", pro.getSid());
			paramMap.put("title", pro.getTitle());
			paramMap.put("pro_desc", pro.getProDesc());
			paramMap.put("link", pro.getLink());
			paramMap.put("start_time", startTime);
			paramMap.put("end_time", endTime);
			paramMap.put("pict", pro.getPict());
			paramMap.put("seq", pro.getSeq());
			paramMap.put("create_time", createTime);
			paramMap.put("creater", pro.getCreater());
			paramMap.put("create_shop_name", pro.getCreateShopName());
			paramMap.put("create_shop_sid", pro.getCreateShopSid());
			paramMap.put("flag", pro.getFlag());
			paramMap.put("promotion_type", pro.getPromotionType());
			paramMap.put("promotion_type_sid", pro.getPromotionTypeSid());
			String parajson = new GsonBuilder().create().toJson(paramMap);
			resultJson = HttpUtil.HttpPostForLogistics(SystemConfig.WSG_SYN,
					"FlashPromotionsInsert", parajson);
			resultJson = resultJson.replaceAll("\\\\", "");
			resultJson = resultJson.substring(1, resultJson.length() - 1);
			JsonParser parser = new JsonParser();
			JsonObject obj = parser.parse(resultJson).getAsJsonObject();
			String success = obj.get("success").toString();
			if (success.equals("\"true\"")) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("", "");
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/updateAndUploadToFTP", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateAndUploadToFTP(String promotionSid, Model m,
			HttpServletRequest request, HttpServletResponse response)
			throws ParseException, IOException, FileUploadException {
		String json = "";
		String name = "";
		String encoding = request.getCharacterEncoding();
		OutputStream out = null;
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxPostSize);
		List fileItems = upload.parseRequest(request);
		for (int i = 0; i < fileItems.size(); i++) {

			FileItem item = (FileItem) fileItems.get(i);
			if (item.getFieldName() == "promotionSid"
					|| "promotionSid".equals(item.getFieldName())) {
				promotionSid = item.getString();
			}

		}

		MobileFlashPromotions promotion = this.mobileFlashPromotionService
				.selectByPrimaryKey(Integer.valueOf(promotionSid));
		name = FtpUtil.getImagePath();
		for (int i = 0; i < fileItems.size(); i++) {
			FileItem item = (FileItem) fileItems.get(i);
			if (!item.isFormField() && item.getName() != null
					&& !"".equals(item.getName())) {
				String fileName = item.getName();
				String upName = "";
				MobileFlashPromotions pro = new MobileFlashPromotions();
				pro.setSid(Integer.valueOf(promotionSid));
				if ("pict".equals(item.getFieldName())
						&& !(item.getString().equals(promotion.getPict()))) {

					upName = name + i + "." + fileName.split("\\.")[1];
					FtpUtil.saveToFtp(out, upName, item);

					pro.setPict("/" + SystemConfig.PROMOTION_PATH + "/"
							+ upName);

				}
				this.mobileFlashPromotionService
						.updateByPrimaryKeySelective(pro);
			} else {
				String key = item.getFieldName();
				String value = item.getString(encoding);
				MobileFlashPromotions p = MobileFlashPromotionsUtil
						.setPromotions(key, value, promotionSid);

				this.mobileFlashPromotionService.updateByPrimaryKeySelective(p);
			}
		}
		MobileFlashPromotions pro = new MobileFlashPromotions();
		pro = this.mobileFlashPromotionService.selectByPrimaryKey(Integer
				.valueOf(promotionSid));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String startTime = sdf.format(pro.getStartTime());

		String endTime = sdf.format(pro.getEndTime());

		String createTime = sdf.format(pro.getCreateTime());
		try {
			String resultJson = "";
			Map paramMap = new HashMap();
			paramMap.put("sid", pro.getSid());
			paramMap.put("title", pro.getTitle());
			paramMap.put("pro_desc", pro.getProDesc());
			paramMap.put("link", pro.getLink());
			paramMap.put("start_time", startTime);
			paramMap.put("end_time", endTime);
			paramMap.put("pict", pro.getPict());
			paramMap.put("seq", pro.getSeq());
			paramMap.put("create_time", createTime);
			paramMap.put("creater", pro.getCreater());
			paramMap.put("create_shop_name", pro.getCreateShopName());
			paramMap.put("create_shop_sid", pro.getCreateShopSid());
			paramMap.put("flag", pro.getFlag());
			paramMap.put("promotion_type", pro.getPromotionType());
			paramMap.put("promotion_type_sid", pro.getPromotionTypeSid());
			String parajson = new GsonBuilder().create().toJson(paramMap);
			resultJson = HttpUtil.HttpPostForLogistics(SystemConfig.WSG_SYN,
					"FlashPromotionsUpdate", parajson);
			resultJson = resultJson.replaceAll("\\\\", "");
			resultJson = resultJson.substring(1, resultJson.length() - 1);
			JsonParser parser = new JsonParser();
			JsonObject obj = parser.parse(resultJson).getAsJsonObject();
			String success = obj.get("success").toString();
			if (success.equals("\"true\"")) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("", "");
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;

	}

	@ResponseBody
	@RequestMapping(value = { "/searchBySkusAndShopSid" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String searchBySkusAndShopSid(String proSku, String createShopSid,String supplySid,
			Model m, HttpServletRequest request, HttpServletResponse response) {
		String resultJson = "";
		try {
			Map paraMap = new HashMap();
			paraMap.put("shopSid", createShopSid);
			paraMap.put("productSku", proSku);
			paraMap.put("supplySid", supplySid);
			resultJson = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/wsg/getProductBySkuBrand.html", paraMap);
		} catch (Exception e) {
			return "{success:false,result:[]}";
		}
		return resultJson;
	}

	@ResponseBody
	@RequestMapping(value = { "/outputuserinfo" }, method = {
			RequestMethod.GET, RequestMethod.POST })
	public String outPutUserInfo(String startTime, String endTime,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String resultJson = "";
		MobileFlashPromotionsKey key = new MobileFlashPromotionsKey();
		if (endTime != null && !"".equals(endTime)) {
			key.setEndDay(endTime);
		}

		if (startTime != null && !"".equals(startTime)) {
			key.setStartDay(startTime);
		}
		List<LabourDayUserInfo> list = null;
		try {
			list = this.labourDayUserInfoService.selectAllUserInfoByTime(key);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String outputFile = "D:/用户信息详情.xls";
		try {
			HSSFWorkbook workBook = new HSSFWorkbook();

			HSSFFont font0 = workBook.createFont();
			font0.setColor(HSSFFont.COLOR_RED);
			font0.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			font0.setFontHeightInPoints((short) 15);

			HSSFFont font = workBook.createFont();
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			font.setFontHeightInPoints((short) 11);

			HSSFCellStyle cellStyle = workBook.createCellStyle();
			cellStyle.setFont(font);
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			HSSFCellStyle cellStyle0 = workBook.createCellStyle();
			cellStyle0.setFont(font0);
			cellStyle0.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			//创建工作表
			HSSFSheet sheet = workBook.createSheet("用户信息表");
			sheet.setColumnWidth(0, 6000);
			sheet.setColumnWidth(1, 3000);
			sheet.setColumnWidth(2, 5000);
			sheet.setColumnWidth(3, 3000);
			sheet.setColumnWidth(4, 5000);
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 4));//合并单元格
			//创建第一行		
			HSSFRow row = sheet.createRow(0);
			row.setHeight((short) 500);
			HSSFCell cell0 = row.createCell(0);
			cell0.setCellStyle(cellStyle0);
			cell0.setCellValue("用户信息表");
			//创建第二行
			HSSFRow row1 = sheet.createRow(1);
			row1.setHeight((short) 350);
			HSSFCell cell = row1.createCell(0);
			cell.setCellStyle(cellStyle);
			cell.setCellValue("用户账号");
			cell = row1.createCell(1);
			cell.setCellStyle(cellStyle);
			cell.setCellValue("姓名");
			cell = row1.createCell(2);
			cell.setCellValue("手机号");
			cell.setCellStyle(cellStyle);
			cell = row1.createCell(3);
			cell.setCellStyle(cellStyle);
			cell.setCellValue("城市");
			cell = row1.createCell(4);
			cell.setCellStyle(cellStyle);
			cell.setCellValue("报名时间");
			//添加数据
			for (int i = 0; i < list.size(); i++) {
				row = sheet.createRow(i + 2);
				row.setHeight((short) 350);
				LabourDayUserInfo labour = list.get(i);
				row.createCell(0).setCellValue(labour.getEmail());
				row.createCell(1).setCellValue(labour.getUsername());
				row.createCell(2).setCellValue(labour.getTel());
				row.createCell(3).setCellValue(labour.getAddress());
				row.createCell(4).setCellValue(
						new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
								.format(labour.getCreateTime()));
			}

			FileOutputStream fOut = new FileOutputStream(outputFile);
			workBook.write(fOut);
			fOut.flush();
			fOut.close();
			System.out.println("文件生成");
		} catch (FileNotFoundException e) {
			System.out.println("文件已经运行");
			e.printStackTrace();
		}

		return resultJson;
	}
}
