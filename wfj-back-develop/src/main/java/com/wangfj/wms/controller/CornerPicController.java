/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.NavigationController.java
 * @Create By chengsj
 * @Create In 2013-7-23 下午2:15:14
 * TODO
 */
package com.wangfj.wms.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.framework.page.Paginator;
import com.wangfj.wms.domain.entity.PromotionCornerPic;
import com.wangfj.wms.domain.view.CornerPicVO;
import com.wangfj.wms.service.ICornerPicService;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name NavigationController
 * @Author chengsj
 * @Create In 2013-7-23
 */
@Controller
@RequestMapping(value = "/cornerPic")
public class CornerPicController {

	@Autowired
			@Qualifier("cornerPicService")
	ICornerPicService cornerPicService;

	private int maxPostSize = 100 * 1024 * 1024;

	@ResponseBody
	@RequestMapping(value = "/selectAllCorners", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectAllCorners(CornerPicVO key) {
		Paginator paginator = new Paginator();
		String resultJson = "";

		try {
			paginator.setPageSize(key.getPageSize());
			paginator.setCurrentPage(key.getCurrentPage());
			paginator.setTotalRecordsBuild(this.cornerPicService
					.selectCountByPrams(key));
			paginator.setList(this.cornerPicService.selectByPrams(key));
			resultJson = ResultUtil.createSuccessResultPage(paginator);
		} catch (Exception e) {
			resultJson = ResultUtil.createFailureResult(e);
		}

		return resultJson;

	}

	@ResponseBody
	@RequestMapping(value = "/saveAndUploadToFTP", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveAndUploadToFTP(HttpServletRequest request,
			HttpServletResponse response) throws FileUploadException,
			ParseException, UnsupportedEncodingException {
		String json = "";
		String name;
		String sid = "";
		String encoding = request.getCharacterEncoding();
		OutputStream out = null;
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxPostSize);
		try {

			if (sid == null || "".equals(sid)) {
				PromotionCornerPic pro = new PromotionCornerPic();
				pro.setCreateTime(new Date());
				this.cornerPicService.insertSelective(pro);
				sid = this.cornerPicService.queryMaxSid() + "";

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
					PromotionCornerPic proCorner = new PromotionCornerPic();
					if (item.getFieldName() == "pict"
							|| "pict".equals(item.getFieldName())) {
						proCorner.setPicLink("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					proCorner.setSid(Integer.valueOf(sid));
					this.cornerPicService
							.updateByPrimaryKeySelective(proCorner);

				} else {
					PromotionCornerPic pro = new PromotionCornerPic();
					String key = item.getFieldName();
					String value = item.getString(encoding);
					if (key.equals("cornerName") && value != null
							&& !"".equals(value)) {
						pro.setCornerName(value);
					}
					pro.setSid(Integer.valueOf(sid));
					this.cornerPicService.updateByPrimaryKeySelective(pro);

				}
			}

			json = ResultUtil.createSuccessResult();

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateAndUploadToFTP", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateAndUploadToFTP(String sid, Model m,
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
			if (item.getFieldName() == "sid"
					|| "sid".equals(item.getFieldName())) {
				sid = item.getString();
			}

		}
        try {
        	PromotionCornerPic proCorner = this.cornerPicService
    				.selectByPrimaryKey(Integer.valueOf(sid));
    		name = FtpUtil.getImagePath();
    		for (int i = 0; i < fileItems.size(); i++) {
    			FileItem item = (FileItem) fileItems.get(i);
    			if (!item.isFormField() && item.getName() != null
    					&& !"".equals(item.getName())) {
    				String fileName = item.getName();
    				;
    				String upName = "";
    				PromotionCornerPic pro = new PromotionCornerPic();
    				pro.setSid(Integer.valueOf(sid));
    				if ("pict".equals(item.getFieldName())
    						&& !(item.getString().equals(proCorner.getPicLink()))) {

    					upName = name + i + "." + fileName.split("\\.")[1];
    					FtpUtil.saveToFtp(out, upName, item);

    					pro.setPicLink("/" + SystemConfig.PROMOTION_PATH + "/"
    							+ upName);

    				}
    				this.cornerPicService
    						.updateByPrimaryKeySelective(pro);
    			} else {
    				PromotionCornerPic pro = new PromotionCornerPic();
    				String key = item.getFieldName();
    				String value = item.getString(encoding);
    				pro.setSid(Integer.valueOf(sid));
    				if (key.equals("cornerName") && value != null
    						&& !"".equals(value)) {
    					pro.setCornerName(value);
    					
        				this.cornerPicService.updateByPrimaryKeySelective(pro);

    				}
    				

    			}
    		}
    		json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;

	}
	@ResponseBody
	@RequestMapping(value = "/deleCorner", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleCorner(HttpServletRequest request, HttpServletResponse response,String sid){
		
		String json = "";
		try {
			this.cornerPicService.deleteByPrimaryKey(Integer.valueOf(sid));
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json =  ResultUtil.createFailureResult("", "");
		}
		return json;
	
       }

}
