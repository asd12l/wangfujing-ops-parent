package com.wangfj.cms.assist;

import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.cms.utils.RequestUtils;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.ResultUtil;
import common.Logger;
import net.sf.json.JSONObject;

/**
 * 广告管理
 * @Class Name AdvertisingController
 * @Author chengsj
 * @Create In 2015年9月14日   
 */
@Controller
@RequestMapping(value="adverties")
public class AdvertisingController {
	private Logger logger = Logger.getLogger(AdvertisingController.class);
	private String className = AdvertisingController.class.getName();
	
	/**
	 * 广告列表
	 * @Methods Name list
	 * @Create In 2015年9月14日 By hongfei
	 * @param model
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST, RequestMethod.GET })
	public String list(Model model, HttpServletRequest request, HttpServletResponse response,
			Integer queryAdspaceId,Integer _site_id_param,Boolean queryEnabled ) {
		String methodName = "list";
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		map.put("pageSize", size);// 每页显示数量
		if(null != queryAdspaceId && !"".equals(queryAdspaceId)){
			map.put("queryAdspaceId", queryAdspaceId);
		}
		if(null != queryEnabled && !"".equals(queryEnabled)){
			map.put("queryEnabled", queryEnabled);
		}
		if(null != currPage && !"".equals(currPage)){
			map.put("pageNo", currPage);
		}
		if(null != _site_id_param && !"".equals(_site_id_param)){
			map.put("_site_id_param", _site_id_param);
		}
		try {
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/v_list.do", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		return json.toString();

	}
	/**
	 * 广告图片上传
	 * @Methods Name uploadImg
	 * @Create In 2015年12月2日 By hongfei
	 * @param request
	 * @param response
	 * @return String
	 * @throws FileUploadException 
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadImg-noMulti", method = { RequestMethod.POST, RequestMethod.GET })
	public String uploadImg(HttpServletRequest request, HttpServletResponse response) throws FileUploadException{
		String methodName = "uploadImg";
		JSONObject json = new JSONObject();
		String name = "";
		String fileName = "";
		String uploadName = "";
		String ip="";
		String username="";
		String password="";
		String port="";
		String path="";
		String siteName="";
		FileItem item1=null;
		// 获取编码
		String encoding = request.getCharacterEncoding();
		// 定义输出流对象
		OutputStream outPutStream = null;
		// 创建基于文件项目的工厂对象
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		diskFileItemFactory.setSizeThreshold(1024);
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
		// 解析上传的请求 或许request中的请求的参数放入list
		List<FileItem> fileItem = servletFileUpload.parseRequest(request);
		// 获取当前时间戳
		fileName = FtpUtil.getImagePath();
		// 获取fileItem集合中的参数
		try {
			for (int i = 0; i < fileItem.size(); i++) {
				FileItem item = (FileItem) fileItem.get(i);
				// 判断是普通表单还是文件上传于， true是普通表单
				if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
					name = item.getName();
					int point = name.lastIndexOf(".");
					if (point > -1) {
						String suffix = name.substring(point);
						if (".jpg".equalsIgnoreCase(suffix) || ".gif".equalsIgnoreCase(suffix)
								|| ".png".equalsIgnoreCase(suffix)) {
							uploadName = UUID.randomUUID() + suffix;
							item1=item;
						} else {
							json.put("success", "false");
							json.put("data", "只能上传jpg、gif、png类型的图片！");
							return json.toString();
						}
					} else {
						json.put("success", "false");
						json.put("data", "只能上传jpg、gif、png类型的图片！");
						return json.toString();
					}
				}else{
					if ("ip".equals(item.getFieldName())) {
					    ip=item.getString(encoding); 
					}
					if ("username".equals(item.getFieldName())) {
					    username=item.getString(encoding); 
					}
					if ("password".equals(item.getFieldName())) {
					    password=item.getString(encoding); 
					}
					if ("port".equals(item.getFieldName())) {
					    port=item.getString(encoding); 
					}
					if ("path".equals(item.getFieldName())) {
					    path=item.getString(encoding); 
					}
					if ("siteName".equals(item.getFieldName())) {
					    siteName=item.getString(encoding); 
					}
				}	
			}
			// 上传图片到ftp服务器并向数据库插入图片属性
			FtpUtil.saveAdvertiseImgToFtp(outPutStream, uploadName, item1,ip,username,password,port,path,siteName);
			logger.info("上传到ftp路径: "+path);
			String imgServer = "http://img"+ siteName.substring(siteName.indexOf("."));
            String url=imgServer+SystemConfig.ADVERTISE_IMAGE_PATH+"/"+uploadName;
			//String url=SystemConfig.CMS_IMAGE_SERVER+SystemConfig.ADVERTISE_IMAGE_PATH+"/"+uploadName;
			json.put("success", "true");
			json.put("url", url);
			json.put("data", uploadName);

		} catch (Exception e) {
			json.put("success", "false");
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		return json.toString();
	}
	
	/**
	 * 广告视频上传
	 * @Methods Name uploadFlash
	 * @Create In 2015年12月21日 By hongfei
	 * @param request
	 * @param response
	 * @return
	 * @throws FileUploadException String
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadFlash-noMulti", method = { RequestMethod.POST, RequestMethod.GET })
	public String uploadFlash(HttpServletRequest request, HttpServletResponse response) throws FileUploadException{
		String methodName = "uploadFlash";
		JSONObject json = new JSONObject();
		String name = "";
		String fileName = "";
		String uploadName = "";
		String ip="";
		String username="";
		String password="";
		String port="";
		String path="";
		String siteName="";
		FileItem item1=null;
		// 获取编码
		String encoding = request.getCharacterEncoding();
		// 定义输出流对象
		OutputStream outPutStream = null;
		// 创建基于文件项目的工厂对象
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		diskFileItemFactory.setSizeThreshold(1024);
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
		// 解析上传的请求 或许request中的请求的参数放入list
		List<FileItem> fileItem = servletFileUpload.parseRequest(request);
		// 获取当前时间戳
		fileName = FtpUtil.getImagePath();
		// 获取fileItem集合中的参数
		try {
			for (int i = 0; i < fileItem.size(); i++) {
				FileItem item = (FileItem) fileItem.get(i);
				// 判断是普通表单还是文件上传于， true是普通表单
				if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
					name = item.getName();
					int point = name.lastIndexOf(".");
					if (point > -1) {
						String suffix = name.substring(point);
						if (".flv".equalsIgnoreCase(suffix)) {
							uploadName = UUID.randomUUID() + suffix;
							item1=item;
						} else {
							json.put("success", "false");
							json.put("data", "只能上传flv类型的视频！");
							return json.toString();
						}
					} else {
						json.put("success", "false");
						json.put("data", "只能上传flv类型的视频！");
						return json.toString();
					}
				}else{
					if ("ip".equals(item.getFieldName())) {
					    ip=item.getString(encoding); 
					}
					if ("username".equals(item.getFieldName())) {
					    username=item.getString(encoding); 
					}
					if ("password".equals(item.getFieldName())) {
					    password=item.getString(encoding); 
					}
					if ("port".equals(item.getFieldName())) {
					    port=item.getString(encoding); 
					}
					if ("path".equals(item.getFieldName())) {
					    path=item.getString(encoding); 
					}
					if ("siteName".equals(item.getFieldName())) {
					    siteName=item.getString(encoding); 
					}
				}	
			}
			// 上传图片到ftp服务器并向数据库插入图片属性
			FtpUtil.saveAdvertiseFlashToFtp(outPutStream, uploadName, item1,ip,username,password,port,path,siteName);
			String url="/adverties/flash"+"/"+uploadName;
			json.put("success", "true");
			json.put("url", url);
			json.put("msg", "上传成功！");
			json.put("data", uploadName);

		} catch (Exception e) {
			json.put("success", "false");
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		return json.toString();
	}
/*	@RequestMapping("/advertising/o_upload_flash.do")
	public String uploadFlash(
			@RequestParam(value = "flashFile", required = false) MultipartFile file,
			String flashNum, HttpServletRequest request, ModelMap model) {
		WebErrors errors = validateUpload(file, request);
		if (errors.hasErrors()) {
			model.addAttribute("error", errors.getErrors().get(0));
			return "advertising/flash_iframe";
		}
		CmsSite site = CmsUtils.getSite(request);
		String origName = file.getOriginalFilename();
		String ext = FilenameUtils.getExtension(origName).toLowerCase(
				Locale.ENGLISH);
		// TODO 检查允许上传的后缀
		try {
			String fileUrl;
			if (site.getConfig().getUploadToDb()) {
				String dbFilePath = site.getConfig().getDbFileUri();
				fileUrl = dbFileMng.storeByExt(site.getUploadPath(), ext, file
						.getInputStream());
				// 加上访问地址
				fileUrl = request.getContextPath() + dbFilePath + fileUrl;
			} else if (site.getUploadFtp() != null) {
				Ftp ftp = site.getUploadFtp();
				String ftpUrl = ftp.getUrl();
				fileUrl = ftp.storeByExt(site.getUploadPath(), ext, file
						.getInputStream());
				// 加上url前缀
				fileUrl = ftpUrl + fileUrl;
			} else {
				String ctx = request.getContextPath();
				//fileUrl = fileRepository.storeByExt(site.getUploadPath(), ext,
				//		file);
				// 加上部署路径
				//fileUrl = ctx + fileUrl;
			}
			//model.addAttribute("flashPath", fileUrl);
			model.addAttribute("flashName", origName);
			model.addAttribute("flashNum", flashNum);
		} catch (IllegalStateException e) {
			model.addAttribute("error", e.getMessage());
			log.error("upload file error!", e);
		} catch (IOException e) {
			model.addAttribute("error", e.getMessage());
			log.error("upload file error!", e);
		}
		return "advertising/flash_iframe";
	}*/
	//查询广告下商品列表
	@ResponseBody
    @RequestMapping(value = "/getProductList", method = { RequestMethod.POST, RequestMethod.GET })
    public String loadAdspaceList(String advertisingId, HttpServletRequest request, HttpServletResponse response){
        String methodName = "loadAdspaceList";
        String json="";
        Map<String,Object> map = new HashMap<String,Object>();
        if(null != advertisingId && !"".equals(advertisingId)){
            map.put("advertisingId", advertisingId);
        }
        try{
            json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/v_listProduct.do", map);
        }catch(Exception e){
            json = ResultUtil.createFailureResult(e);
            logger.error(className+":"+methodName+" "+e.getMessage());
        }
        return json;
    }
	
	// 广告里添加商品
    @ResponseBody
    @RequestMapping(value = "/addProduct", method = { RequestMethod.GET, RequestMethod.POST })
    public String addProduct(String ids, String advertisingId, String prices, String picts, String smallpicts,
            String brandNames, String oldPrices, String name, HttpServletRequest request) {
        String methodName = "addProduct";
        String json = "";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("id", ids);
        resultMap.put("name", name);
        resultMap.put("prices", prices);
        resultMap.put("picts", picts);
        resultMap.put("advertisingId", advertisingId);

        resultMap.put("brandNames", brandNames);
        // resultMap.put("smallpicts", smallpicts);
        // resultMap.put("oldPrices", oldPrices);

        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/a_add_product.do", resultMap);
        } catch (Exception e) {
            json = ResultUtil.createFailureResult(e);
            logger.error(className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }

    // 广告里删除商品
    @ResponseBody
    @RequestMapping(value = "/delProduct", method = { RequestMethod.GET, RequestMethod.POST })
    public String delProduct(String sid, String advertisingId, HttpServletRequest request) {
        String methodName = "delProduct";
        String json = "";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("sid", sid);
        resultMap.put("advertisingId", advertisingId);
        try {
            json = HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/a_del_product.do", resultMap);
        } catch (Exception e) {
            json = ResultUtil.createFailureResult(e);
            logger.error(className + ":" + methodName + " " + e.getMessage());
        }
        return json;
    }
	
    //添加修改广告时查询广告版位
	@ResponseBody
	@RequestMapping(value = "/findAdspace", method = { RequestMethod.POST, RequestMethod.GET })
	public String findAdspace(String _site_id_param, HttpServletRequest request, HttpServletResponse response){
		String methodName = "findAdspace";
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null != _site_id_param && !"".equals(_site_id_param)){
			map.put("_site_id_param", _site_id_param);
		}
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/v_listSpace.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
	
	//查询是否能添加除代码类型外的其他类型广告
	@ResponseBody
	@RequestMapping(value = "/checkEnabled", method = { RequestMethod.POST, RequestMethod.GET })
	public String checkEnabled(String enabled, String spaceId, HttpServletRequest request, HttpServletResponse response){
		String methodName = "checkEnabled";
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null != spaceId && !"".equals(spaceId)){
			map.put("spaceId", spaceId);
		}
		if(null != enabled && !"".equals(enabled)){
			map.put("enabled", enabled);
		}
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/checkedEnabled.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
	
	//保存广告
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.POST, RequestMethod.GET })
	public String save(HttpServletRequest request, HttpServletResponse response,
			String name,String adspaceId,String category,String startTime,
			String endTime,String path,String tplName,Integer _site_id_param,
			String enabled,String seq){
		String methodName = "save";
		Map<String,Object> map=new HashMap<String,Object>();
		Map<String, String> attr = RequestUtils.getRequestMap(request, "attr_");
		if(null != _site_id_param && !"".equals(_site_id_param)){
			map.put("_site_id_param", _site_id_param);
		}
		if(name!=null && !name.equals("")){
			map.put("name", name);
		}
		if(adspaceId!=null && !adspaceId.equals("")){
			map.put("adspaceId", adspaceId);
		}
		if(category!=null && !category.equals("")){
			map.put("category", category);
		}
		if(startTime!=null && !startTime.equals("")){
			map.put("startTime", startTime);
		}
		if(endTime!=null && !endTime.equals("")){
			map.put("endTime", endTime);
		}
		if(path!=null && !path.equals("")){
			map.put("path", path);
		}
		if(tplName!=null && !tplName.equals("")){
			map.put("tplName", tplName);
		}
		if(enabled!=null && !enabled.equals("")){
			map.put("enabled", enabled);
		}
		if(seq!=null){
			map.put("seq", seq);
		}
		JSONObject js=new JSONObject();
		js=JSONObject.fromObject(attr);
		map.put("attr", js.toString());
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/o_save.do", map);
		}catch(Exception e){
		    JSONObject errorJson = new JSONObject();
		    errorJson.put("success", "false");
		    errorJson.put("message", "网络链接错误，请联系管理员");
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		if(!StringUtils.isNotBlank(json)){
		    JSONObject errorJson = new JSONObject();
            errorJson.put("success", "false");
            errorJson.put("message", "网络链接错误，请联系管理员");
		}
		return json;
	}
	
	//修改广告
	@ResponseBody
	@RequestMapping(value = "/edit", method = { RequestMethod.POST, RequestMethod.GET })
	public String edit(HttpServletRequest request, HttpServletResponse response,
			String id,String name,String adspaceId_,String category,
			String startTime,String endTime,String path,String tplName,
			String enabled,String seq){
		String methodName = "edit";
		Map<String, String> attr = RequestUtils.getRequestMap(request, "attr_");
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("id", id);
		if(StringUtils.isNotBlank(name)){
			map.put("name", name);
		}
		if(StringUtils.isNotBlank(adspaceId_)){
			map.put("adspaceId", adspaceId_);
		}

		if(StringUtils.isNotBlank(category)){
			map.put("category", category);
		}

		if(StringUtils.isNotBlank(startTime)){
			map.put("startTime", startTime);
		}

		if(StringUtils.isNotBlank(endTime)){
			map.put("endTime", endTime);
		}

		if(StringUtils.isNotBlank(path)){
			map.put("path", path);
		}

		if(StringUtils.isNotBlank(tplName)){
			map.put("tplName", tplName);
		}

		if(StringUtils.isNotBlank(enabled)){
			map.put("enabled", enabled);
		}

		if(StringUtils.isNotBlank(seq)){
			map.put("seq", seq);
		}
		JSONObject js=new JSONObject();
		js=JSONObject.fromObject(attr);
		map.put("attr", js.toString());

		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/o_update.do", map);
		}catch(Exception e){
			logger.error(className+":"+methodName+" "+e.getMessage());
			JSONObject message  = new JSONObject();
			message.put("success", "falses");
			message.put("message", " 网络异常"+e);
			return message.toString();
		}
		if(!StringUtils.isNotBlank(json)){
            JSONObject errorJson = new JSONObject();
            errorJson.put("success", "false");
            errorJson.put("message", "网络链接错误，请联系管理员");
        }
		return json;
	}
	
	//返回购物车代码接口,测试用
	@ResponseBody
	@RequestMapping(value = "/showCart", method = { RequestMethod.POST, RequestMethod.GET })
	public String test_showCart(HttpServletRequest request, HttpServletResponse response,String _site_id_param){
		String methodName = "test_showCart";
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("_site_id_param", _site_id_param);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/find_cart_code.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
	
	//删除广告
	@ResponseBody
	@RequestMapping(value = "/del", method = { RequestMethod.POST, RequestMethod.GET })
	public String del(HttpServletRequest request, HttpServletResponse response,String id){
		String methodName = "del";
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("ids", id);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/o_delete.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
	
	//修改广告时验证该广告位是否是购物车广告位,目前购物车广告位限制为代码类型广告位
	@ResponseBody
	@RequestMapping(value = "/checkCart", method = { RequestMethod.POST, RequestMethod.GET })
	public String check(HttpServletRequest request, HttpServletResponse response,String spaceId){
		String methodName = "check";
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("spaceId", spaceId);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/check_cart.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.error(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
}
