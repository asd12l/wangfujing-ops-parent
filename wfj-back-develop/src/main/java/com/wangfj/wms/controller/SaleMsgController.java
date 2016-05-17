package com.wangfj.wms.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.util.ArrayList;
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
import com.utils.StringUtils;
import com.wangfj.wms.domain.entity.Comments;
import com.wangfj.wms.domain.entity.SalesMsg;
import com.wangfj.wms.domain.view.CommentsVO;
import com.wangfj.wms.domain.view.saleMsgVO;
import com.wangfj.wms.service.ICommentsService;
import com.wangfj.wms.service.ISaleMsgService;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.KeyWordFilter;
import com.wangfj.wms.util.ResultUtil;


@Controller
@RequestMapping("/saleMsg")
public class SaleMsgController {
	@Autowired
	@Qualifier("saleMsgService")
	private ISaleMsgService saleMsgService;
	
	private int maxPostSize = 100 * 1024 * 1024;
	
	@Autowired
	@Qualifier("commentsService")
	private ICommentsService commentsService;

	@ResponseBody
	@RequestMapping(value = "/selectByParam", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectByParam(saleMsgVO key){
		Paginator paginator = new Paginator();
		String resultJson = "";
		try {
			paginator.setPageSize(key.getPageSize());
			paginator.setCurrentPage(key.getCurrentPage());
			paginator.setTotalRecordsBuild(this.saleMsgService.selectCountByParms(key));
			paginator.setList(this.saleMsgService.selectByPrams(key));
			resultJson = ResultUtil.createSuccessResultPage(paginator);
		} catch (Exception e) {
			resultJson = ResultUtil.createFailureResult(e);
		}
		return resultJson;
	}
	
	/**
	 * 
	 * @Methods Name saveSaleMsg
	 * @Create In 2014年8月8日 By pengpu
	 * @param request
	 * @param response
	 * @return String
	 * @desc  发布消息接口
	 */
	@ResponseBody
	@RequestMapping(value = "/saveSaleMsg", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveSaleMsg(HttpServletRequest request,HttpServletResponse response){
		String resultJson = "";
		String name;
		String encoding = request.getCharacterEncoding();
		OutputStream out = null;
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxPostSize);
		
		try{
			SalesMsg slm = new SalesMsg();
			slm.setCreateTime(new Date());
			List fileItems = upload.parseRequest(request);
			name = FtpUtil.getImagePath();
			for (int i = 0; i < fileItems.size(); i++) {
				
				
				FileItem item = (FileItem) fileItems.get(i);
				if (!item.isFormField() && item.getName() != null  //FileItem.isFormField()判断是普通表单域还是文件上传域，为true的话是普通表单域
						&& !"".equals(item.getName())) {
					String filename = item.getName();
					String upName = "";
					upName = name + i + "." + filename.split("\\.")[1];
					FtpUtil.saveSaleMsgToFtp(out, upName, item);
					if (item.getFieldName() == "saleMsgPic"
							|| "saleMsgPic".equals(item.getFieldName())) {
						slm.setPic("/" + SystemConfig.SALEMSG_PATH           
								+ "/" + upName);
					}
				} else {
					String key = item.getFieldName();
					String value = item.getString(encoding);
					if ("saleMsgContent".equals(key)) {
						slm.setContent(value);
					}
					if ("saleMsgType".equals(key)) {
						if(value.equals("促销")){
							value = "1";
						}
						if(value.equals("新品")){
							value = "2";
						}
						if(value.equals("降价通知")){
							value = "3";
						}
						slm.setType(value);
					}
					if ("saleMsgTitle".equals(key)) {
						slm.setTitle(value);
					}
				}
			}
			this.saleMsgService.insertSaleMsg(slm);
		}catch(Exception e){
			e.printStackTrace();
		}
		resultJson = ResultUtil.createSuccessResult();
		return resultJson;
	}
	
	
	/**
	 * 
	 * @Methods Name saveSaleMsg
	 * @Create In 2014年8月8日 By pengpu
	 * @param request
	 * @param response
	 * @return String
	 * @desc  发布消息接口
	 */
	@ResponseBody
	@RequestMapping(value = "/saveSaleMsgForPad", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveSaleMsgForPad(HttpServletRequest request,HttpServletResponse response){

		String resultJson = "";
		String type = request.getParameter("type");
		String title = request.getParameter("title");
		String shopSid = request.getParameter("shopSid");
		String content = request.getParameter("content");
		
		String daogouName = request.getParameter("daogouName");
		String pic = request.getParameter("pic");
		
		//必填参数
		if(StringUtils.isEmpty(type)||StringUtils.isEmpty(title)||StringUtils.isEmpty(shopSid)||StringUtils.isEmpty(content)){
			resultJson = ResultUtil.createFailureResult(new Exception("参数不正确"));
		}
		SalesMsg slm = new SalesMsg();
		slm.setCreateTime(new Date());
		
		if(StringUtils.isNotEmpty(type)){
			slm.setType(type);;
		}
		if(StringUtils.isNotEmpty(title)){
			slm.setTitle(title);
		}
		if(StringUtils.isNotEmpty(shopSid)){
			slm.setShopSid(shopSid);
		}
		if(StringUtils.isNotEmpty(content)){
			slm.setContent(content);
		}
		if(StringUtils.isNotEmpty(daogouName)){
			slm.setDaogouName(daogouName);
		}
		if(StringUtils.isNotEmpty(pic)){
			slm.setPic(pic);
		}
		this.saleMsgService.insertSaleMsg(slm);
		resultJson = ResultUtil.createSuccessResult();
		return resultJson;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delSaleMsg", method = {RequestMethod.GET, RequestMethod.POST})
	public String delflashpromotion(HttpServletRequest request, HttpServletResponse response,String sid){
		
		String json = "";
		try {
			this.saleMsgService.deleteByPrimaryKey(Integer.parseInt(sid));
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json =  ResultUtil.createFailureResult("", "");
		}
		return json;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/updateSaleMsg", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateSaleMsg(String sid, Model m,
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
        	SalesMsg sm = this.saleMsgService.selectByPrimaryKey(Integer.valueOf(sid));
    		
    		List fit = upload.parseRequest(request);
			name = FtpUtil.getImagePath();
			for (int i = 0; i < fileItems.size(); i++) {
				
				
				FileItem item = (FileItem) fileItems.get(i);
				if (!item.isFormField() && item.getName() != null  //FileItem.isFormField()判断是普通表单域还是文件上传域，为true的话是普通表单域
						&& !"".equals(item.getName())) {
					String filename = item.getName();
					String upName = "";
					upName = name + i + "." + filename.split("\\.")[1];
					FtpUtil.saveSaleMsgToFtp(out, upName, item);
					if (item.getFieldName() == "saleMsgPic"
							|| "saleMsgPic".equals(item.getFieldName())) {
						sm.setPic("/" + SystemConfig.SALEMSG_PATH           
								+ "/" + upName);
					}
				} else {
					String key = item.getFieldName();
					String value = item.getString(encoding);
					if ("saleMsgContent".equals(key)) {
						sm.setContent(value);
					}
					if ("saleMsgTitle".equals(key)) {
						sm.setTitle(value);
					}
				}
			}
        	
    		this.saleMsgService.updateSaleMsg(sm);		

    		json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;

	}
	
	@ResponseBody
	@RequestMapping(value = "/selectComments", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectComments(HttpServletRequest request, HttpServletResponse response){
		
		List<CommentsVO> voList = new ArrayList();
		String json = "";
		try {
			List<Comments>  list = new ArrayList();
			list=this.commentsService.getAllComments();
			for(int i=0;i<list.size();i++){
				Comments co = new Comments();
				co=list.get(i);
				CommentsVO vo=createVolist( co);
				voList.add(vo);
			}
			json = ResultUtil.createSuccessResult(voList);
		} catch (Exception e) {
			json =  ResultUtil.createFailureResult("", "");
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delPinglun", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String delPinglun(HttpServletRequest request, HttpServletResponse response,String sid){
		
		String json = "";
		try {
			this.commentsService.deleteByPrimaryKey(Integer.parseInt(sid));
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json =  ResultUtil.createFailureResult("", "");
		}
		return json;
	}
	
	
	CommentsVO createVolist(Comments co){
		
		CommentsVO vo = new CommentsVO();
		Integer sid=co.getSalesSid();
		SalesMsg msg = new SalesMsg();
					if(co.getUser()!=null&&!"".equals(co.getUser())){
						vo.setUser(co.getUser());
					}
					if(co.getCommentTime()!=null&&!"".equals(co.getCommentTime())){
						vo.setCommentTime(co.getCommentTime());
					}
					if(co.getContent()!=null&&!"".equals(co.getContent())){
						vo.setContent(co.getContent());
					}
					if(co.getFlag()!=null&&!"".equals(co.getFlag())){
						vo.setFlag(co.getFlag());
					}
					if(co.getShopSid()!=null&&!"".equals(co.getShopSid())){
						vo.setShopSid(co.getShopSid());
					}
					if(co.getSid()!=null&&!"".equals(co.getSid())){
						vo.setSid(co.getSid());
					}
		try {
			msg=this.saleMsgService.selectByPrimaryKey(sid);
			if(msg!=null){
				
				if(msg.getSid()!=null&&!"".equals(msg.getSid())){
					vo.setSalesSid(msg.getSid());
				}
				
				if(msg.getTitle()!=null&&!"".equals(msg.getTitle())){
					vo.setTitle(msg.getTitle());
				}
				if(msg.getType()!=null&&!"".equals(msg.getType())){
					vo.setType(msg.getType());
				}
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	
	
		@ResponseBody
		@RequestMapping(value = { "/addPinglun" }, method = { RequestMethod.GET,
				RequestMethod.POST })
		public String addPinglun(Model m, String salesSid, String user,String content,String shopSid) {
		 	 Comments co=new Comments();
		 	 String str = "周恩来，江泽民";
		 	 KeyWordFilter filter=new KeyWordFilter();
		 	 filter.initPattern();
		 	 String str1=KeyWordFilter.doFilter(str);
			 try {
				co.setContent(str1);
				this.commentsService.insertSelective(co);
				return ResultUtil.createSuccessResult();
			  } catch (Exception e) {
				e.printStackTrace();
				return ResultUtil.createFailureResult("",  "添加评论失败");
			}
			
			
			
		}
	
}
