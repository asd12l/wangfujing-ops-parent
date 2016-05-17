/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.PromotionController.java
 * @Create By chengsj
 * @Create In 2013-8-30 下午4:35:23
 * TODO
 */
package com.wangfj.wms.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

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
import com.wangfj.wms.domain.entity.PageLayoutMql;
import com.wangfj.wms.domain.entity.PageTemplate;
import com.wangfj.wms.domain.entity.PromotionType;
import com.wangfj.wms.domain.entity.Promotions;
import com.wangfj.wms.domain.view.PromotionsVO;
import com.wangfj.wms.service.IPageLayoutMqlService;
import com.wangfj.wms.service.IPageTemplateService;
import com.wangfj.wms.service.IPromotionService;
import com.wangfj.wms.service.IPromotionTypeService;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.PromotionsUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name PromotionController
 * @Author chengsj
 * @Create In 2013-8-30
 */
@Controller
@RequestMapping("/promotions")
public class PromotionController {

	@Autowired
			@Qualifier("promotionService")
	IPromotionService promotionService;

	@Autowired
			@Qualifier("pageLayoutMqlService")
	IPageLayoutMqlService pageLayoutService;

	@Autowired
			@Qualifier("pageTemplateService")
	IPageTemplateService pageTemplateService;

	@Autowired
			@Qualifier("promotionTypeService")
	IPromotionTypeService promotionTypeService;

	private int maxPostSize = 100 * 1024 * 1024;

	//点击添加活动按钮时通过PageTemplateMapper.xml--queryBySelective加载的活动模型，
	//table：page_template 
	@ResponseBody
	@RequestMapping(value = "/selectPageTemplateByType", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectPageTemplateByType(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			PageTemplate pageTemplate = new PageTemplate();
			pageTemplate.setType(2);
			List list = this.pageTemplateService.queryBySelective(pageTemplate);
			json = ResultUtil.createSuccessResult(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	//获取活动类型
	@ResponseBody
	@RequestMapping(value = "/selectPromotionType", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectPromotionType(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			PromotionType promotionType = new PromotionType();
			List list = this.promotionTypeService    //或许所有活动类型。。其他，新品活动，频道活动，超值抢购，闪购活动，首页活动
					.queryBySelective(promotionType);
			json = ResultUtil.createSuccessResult(list);//转换成json格式数据
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	/**
	 * 说明： 分页查询活动记录
	 * 
	 * @Methods Name selectPromotions
	 * @Create In 2013-9-2 By chengsj
	 * @param key
	 */
	@ResponseBody
	@RequestMapping(value = "/selectPromotionListByKey", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectPromotionListByKey(PromotionsVO key) {
		Paginator paginator = new Paginator();
		String resultJson = "";
		try {
			key.setDelFlag(1);
			paginator.setPageSize(key.getPageSize());
			paginator.setCurrentPage(key.getPage());
			key.setCurrentPage(key.getPage());
			key.setStartRecords((key.getPage()-1)*key.getPageSize());
			System.out.println(+key.getPage()+"======"+key.getPageSize()+"==="+key.getStart());
			int count = this.promotionService.selectCountByParms(key);
				paginator.setTotalRecordsBuild(count);
			paginator.setList(this.promotionService.selectByPrams(key));
			resultJson = ResultUtil.createSuccessResultPage(paginator);
			int pageCount=count%key.getPageSize()==0?count/key.getPageSize():count/key.getPageSize()+1;
			JSONObject  json=new JSONObject();
			json=JSONObject.fromObject(resultJson);
			json.put("pageCount", pageCount);
			resultJson=json.toString();
	System.out.println(resultJson);
			}catch (Exception e) {
				resultJson = ResultUtil.createFailureResult(e);
			}
			return resultJson;
		}


		/**
		 * 
		 * @Methods Name selectPromotionBySid
		 * @Create In 2014年7月29日 By pengpu
		 * @param sid
		 * @return String
		 */
		//查看活动 
		//根据sid查看相应的活动
		//table：promotions
		//
		@ResponseBody
		@RequestMapping(value = "/selectPromotionBySid", method = {
				RequestMethod.GET, RequestMethod.POST })
		public String selectPromotionBySid(HttpServletRequest request,HttpServletResponse response) {
			String resultJson = "";
			String sid = request.getParameter("sid");
			try {

				Promotions prom = this.promotionService.selectByPrimaryKey(Integer.parseInt(sid));
				resultJson=ResultUtil.createSuccessResult(prom);
			} catch (Exception e) {
				resultJson = ResultUtil.createFailureResult(e);
			}
			return resultJson;
		}



		/**
		 * 说明： 审核活动/作废活动
		 * 
		 * @Methods Name updateStatus
		 * @Create In 2013-9-3 By chengsj
		 * @param sid
		 * @param promotionStatus
		 * 	 void
		 */
		@ResponseBody
		@RequestMapping(value = "/updatePromotionStatus", method = {
				RequestMethod.GET, RequestMethod.POST })
		public void updateStatus(String sid, String promotionStatus) {
			Promotions promotion = null;
			if (sid != null && !"".equals(sid)) {
				promotion = this.promotionService.selectByPrimaryKey(Integer
						.parseInt(sid));
			}
			if (promotion != null && promotionStatus != null
					&& !"".equals(promotionStatus)) {
				promotion.setPromotionStatus(Integer.parseInt(promotionStatus));
				this.promotionService.updateByPrimaryKey(promotion);
			}
		}
		@ResponseBody
		@RequestMapping(value = "/delflashpromotion", method = {RequestMethod.GET, RequestMethod.POST})
		public String delflashpromotion(HttpServletRequest request, HttpServletResponse response,String sid){

			String json = "";
			try {
				Promotions promotion=new Promotions();
				promotion.setSid(Integer.valueOf(sid));
				promotion.setDelFlag(0);
				promotion.setPromotionStatus(0);
				this.promotionService.updateByPrimaryKeySelective(promotion);
				json = ResultUtil.createSuccessResult();
			} catch (Exception e) {
				json =  ResultUtil.createFailureResult("", "");
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
			String name;
			Boolean isVIP = false;
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
			Promotions p = this.promotionService.selectByPrimaryKey(Integer
					.valueOf(sid));
			name = FtpUtil.getImagePath();
			for (int i = 0; i < fileItems.size(); i++) {
				FileItem item = (FileItem) fileItems.get(i);
				if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
					String filename = item.getName();
					String upName = "";
					Promotions pro = new Promotions();
					pro.setSid(Integer.valueOf(sid));
					if ("promotionSpict".equals(item.getFieldName())
							&& !(item.getString().equals(p.getPromotionSpict()))) {
						upName = name + i + "." + filename.split("\\.")[1];
						FtpUtil.saveToFtp(out, upName, item);
						pro.setPromotionSpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					if ("promotionBpict".equals(item.getFieldName())
							&& !(item.getString().equals(p.getPromotionBpict()))) {
						upName = name + i + "." + filename.split("\\.")[1];
						FtpUtil.saveToFtp(out, upName, item);
						pro.setPromotionBpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					if ("promotionVpict".equals(item.getFieldName())
							&& !(item.getString().equals(p.getPromotionVpict()))) {
						upName = name + i + "." + filename.split("\\.")[1];
						FtpUtil.saveToFtp(out, upName, item);
						pro.setPromotionVpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					if ("promotionCpict".equals(item.getFieldName())
							&& !(item.getString().equals(p.getPromotionCpict()))) {
						upName = name + i + "." + filename.split("\\.")[1];
						FtpUtil.saveToFtp(out, upName, item);
						pro.setPromotionCpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					if ("promotionCgpict".equals(item.getFieldName())
							&& !(item.getString().equals(p.getPromotionCgpict()))) {
						upName = name + i + "." + filename.split("\\.")[1];
						FtpUtil.saveToFtp(out, upName, item);
						pro.setPromotionCgpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}

					this.promotionService.updateByPrimaryKeySelective(pro);
				} else {
					String key = item.getFieldName();
					String value = item.getString(encoding);
					if ("promotionTypeSid".equals(key)
							&& ("5".equals(value) || value == "5")) {
						isVIP = true;
					}
					Promotions pt = PromotionsUtil.setPromotions(key, value, sid,
							isVIP);
					this.promotionService.updateByPrimaryKeySelective(pt);
				}
			}
			json = ResultUtil.createSuccessResult();
			return json;

		}

		//添加活动方法
		@ResponseBody
		@RequestMapping(value = "/saveAndUploadToFTP", method = {
				RequestMethod.GET, RequestMethod.POST })
		public String saveAndUploadToFTP(String sid, HttpServletRequest request,
				HttpServletResponse response) throws FileUploadException,
				ParseException, UnsupportedEncodingException {
			String json = "";
			String name;
			Boolean isVIP = false;
			String encoding = request.getCharacterEncoding();
			OutputStream out = null;
			//基于文件项目创建的一个工厂对象
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setSizeThreshold(1024);
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(maxPostSize);

			if (sid == null || "".equals(sid)) {
				PageLayoutMql pageLayout = new PageLayoutMql();
				pageLayout.setTitle("闪购栏目");
				pageLayout.setPageType(0);
				pageLayout.setNodeLevel(0);
				//添加活动基本信息到page_layout 
				//PageLayoutMqlMapper.xml/insertSelective    
				this.pageLayoutService.insertSelective(pageLayout);
				Promotions promotions = new Promotions();
				//获得page_layout表中最大的sid 
				//PageLayoutMqlMapper.xml/queryMaxSid    
				promotions.setPageLayoutSid(pageLayoutService.queryMaxSid());
				promotions.setPromotionStatus(0);
				//向活动表添加基本活动信息，table：promotions
				//PromotionsMapper.xml/insertSelective
				this.promotionService.insertSelective(promotions);
				//获得page_layout表中最大的sid 
				//PageLayoutMqlMapper.xml/queryMaxSid   
				sid = this.promotionService.queryMaxSid() + "";

			}

			List<FileItem> fileItems = upload.parseRequest(request);//解析上传请求。
			//获得当前的时间戳，例：20141021154236
			name = FtpUtil.getImagePath();
			for (int i = 0; i < fileItems.size(); i++) {
				FileItem item = (FileItem) fileItems.get(i);
				if (!item.isFormField() && item.getName() != null  //FileItem.isFormField()判断是普通表单域还是文件上传域，为true的话是普通表单域
						&& !"".equals(item.getName())) {
					String filename = item.getName();
					String upName = "";
					upName = name + i + "." + filename.split("\\.")[1];
					//上传图片到FTP服务器。
					FtpUtil.saveToFtp(out, upName, item);
					Promotions pro = new Promotions();
					pro.setSid(Integer.valueOf(sid));
					if (item.getFieldName() == "promotionSpict"
							|| "promotionSpict".equals(item.getFieldName())) {
						pro.setPromotionSpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					if (item.getFieldName() == "promotionBpict"
							|| "promotionBpict".equals(item.getFieldName())) {
						pro.setPromotionBpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					if (item.getFieldName() == "promotionVpict"
							|| "promotionVpict".equals(item.getFieldName())) {
						pro.setPromotionVpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					if (item.getFieldName() == "promotionCpict"
							|| "promotionCpict".equals(item.getFieldName())) {
						pro.setPromotionCpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}
					if (item.getFieldName() == "promotionCgpict"
							|| "promotionCgpict".equals(item.getFieldName())) {
						pro.setPromotionCgpict("/" + SystemConfig.PROMOTION_PATH
								+ "/" + upName);
					}

					this.promotionService.updateByPrimaryKeySelective(pro);
				} else {
					String key = item.getFieldName();
					String value = item.getString(encoding);
					if ("promotionTypeSid".equals(key)
							&& ("5".equals(value) || value == "5")) {
						isVIP = true;
					}
					Promotions pt = PromotionsUtil.setPromotions(key, value, sid,
							isVIP);
					// pt.setSid(Integer.valueOf(sid));
					this.promotionService.updateByPrimaryKeySelective(pt);
				}
			}

			JSONObject jn = new JSONObject();
			jn.put("sid", sid)	;
			json = ResultUtil.createSuccessResult(jn);
			//		json="{success:true,sid:"+sid+"}";
			return json;

		}

	}
