package com.baidu.ueditor.upload;

import com.baidu.ueditor.PathFormat;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.FileType;
import com.baidu.ueditor.define.State;
import com.constants.SystemConfig;
import com.utils.StringUtils;
import com.wangfj.wms.util.Constants;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.UploadUtil;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FtpUploader {
	public static final State save(HttpServletRequest request, Map<String, Object> conf) { 
		FileItemStream fileStream = null; 
		boolean isAjaxUpload = request.getHeader("X_Requested_With") != null; 
		if (!ServletFileUpload.isMultipartContent(request)) { 
			return new BaseState(false, 5); 
		} 
		ServletFileUpload upload = new ServletFileUpload( new DiskFileItemFactory()); 
		if (isAjaxUpload) { 
			upload.setHeaderEncoding("UTF-8"); 
		} 
		try { 
			FileItemIterator iterator = upload.getItemIterator(request); 
			while (iterator.hasNext()) { 
				fileStream = iterator.next(); 
				if (!fileStream.isFormField()) break; 
				fileStream = null; 
			} 
			if (fileStream == null) { 
				return new BaseState(false, 7); 
			} 
			String savePath = (String)conf.get("savePath"); 
			String originFileName = fileStream.getName(); 
			String suffix = FileType.getSuffixByFilename(originFileName); 
			originFileName = originFileName.substring(0, originFileName.length() - suffix.length()); 
			savePath = savePath + suffix; 
			long maxSize = ((Long)conf.get("maxSize")).longValue(); 
			if (!validType(suffix, (String[])conf.get("allowFiles"))) { 
				return new BaseState(false, 8); 
			} 
			savePath = PathFormat.parse(savePath, originFileName); 
			String remoteDir = ""; 
			int pos = savePath.lastIndexOf("/"); 
			if(pos > -1){ 
				remoteDir = savePath.substring(0,pos + 1); 
			} 
			String physicalPath = (String)conf.get("rootPath") + savePath; 
			boolean keepLocalFile = "false".equals(conf.get("keepLocalFile")) ? false : true; 
			InputStream is = fileStream.openStream(); 
			State storageState = StorageManager.saveFtpFileByInputStream(is, remoteDir, physicalPath, maxSize, keepLocalFile); 
			is.close(); 
			if (storageState.isSuccess()) { 
				storageState.putInfo("url", savePath); 
				storageState.putInfo("type", suffix); 
				storageState.putInfo("original", originFileName + suffix); 
			} 
			return storageState; 
		} catch (FileUploadException e) { 
			return new BaseState(false, 6); 
		} catch (IOException localIOException) {
			
		} 
		return new BaseState(false, 4); 
	}
	@SuppressWarnings("rawtypes")
	private static boolean validType(String type, String[] allowTypes) {
		List list = Arrays.asList(allowTypes);
		return list.contains(type);
	}
	
	public static final State save(HttpServletRequest request){
		// TODO Auto-generated method stub
		State state = null;
//		boolean isAjaxUpload = request.getHeader("X_Requested_With") != null; 
		if (!ServletFileUpload.isMultipartContent(request)) { 
			return new BaseState(false, 5); 
		} 
		
		Map<String, String> textMap = new HashMap<String, String>();

//		textMap.put("uploaduser", request.getSession().getAttribute("username").toString());
		textMap.put("uploaduser", CookiesUtil.getCookies(request, "username"));
		
		Map<String, byte[]> fileMap = new HashMap<String, byte[]>();

		JSONObject json = new JSONObject();
		// 请求SSDserver时封装参数
		Map<String, Object> map = new HashMap<String, Object>();
		// .jpg
		String name = "";
		// 时间
		String fileName = "";
		// fileName + name
		String uploadName = "";
		int imgWidth = 0;
		// 获取编码
		String encoding = request.getCharacterEncoding();
		// 定义输出流对象
		OutputStream outPutStream = null;
		// 创建基于文件项目的工厂对象
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		diskFileItemFactory.setSizeThreshold(1024);
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
//		if (isAjaxUpload) { 
//			servletFileUpload.setHeaderEncoding("UTF-8"); 
//		} 
		// 允许上传文件的最大范围
		// servletFileUpload.setSizeMax(maxPostSize);
		// 解析上传的请求 或许request中的请求的参数放入list
		List<FileItem> fileItem;
		// 获取当前时间戳
		fileName = FtpUtil.getImagePath();
		// 获取fileItem集合中的参数
		try {
			fileItem = servletFileUpload.parseRequest(request);
			String spuCode = "";
			String colorSid = "";
			String suffix = "";
			for (int i = 0; i < fileItem.size(); i++) {
				FileItem item = (FileItem) fileItem.get(i);
				// 判断是普通表单还是文件上传于， true是普通表单
				if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
					
				} else {
					// 非图片参数的处理
					String fieldName = item.getFieldName();
//					System.err.println(fieldName+"---"+item.getString(encoding));
					if (fieldName.equals("spuCode")) {
						spuCode = item.getString(encoding);
					} else {
						colorSid = item.getString(encoding);
					}
				}
			}
			for (int i = 0; i < fileItem.size(); i++) {
				FileItem item = (FileItem) fileItem.get(i);
				// 判断是普通表单还是文件上传于， true是普通表单
				if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
					name = item.getName();
					int point = name.lastIndexOf(".");
					if (point > -1) {
						String type = name.substring(point);
						suffix = type;
						if (".jpg".equalsIgnoreCase(type) || ".gif".equalsIgnoreCase(type)
								|| ".png".equalsIgnoreCase(type)) {
							uploadName = spuCode + "_" + colorSid + "_" + fileName + "."
									+ name.split("\\.")[1];

							fileMap.put(uploadName, item.get());
							// 获取图片的尺寸
							BufferedImage bi = ImageIO.read(item.getInputStream());
							int width = bi.getWidth();
							int height = bi.getHeight();
							textMap.put("width", width + "");
							textMap.put("height", height + "");
							textMap.put("size", item.getSize() + "");
							imgWidth = width;
						} else {
							state = new BaseState(false, 8);
						}
					} else {
						state = new BaseState(false, 8);
					}
				} else {
					// 非图片参数的处理
					if ("spuCode".equals(item.getFieldName())) {
						textMap.put("productId", item.getString(encoding));
					}
					if ("colorSid".equals(item.getFieldName())) {
						textMap.put("color_sid", item.getString(encoding));
					}
				}
			}//"http://192.168.7.181:8085/photoMan-sev/"
			if (imgWidth < Constants.PACKIMG_PIC_WIDTH) {
				String ret = UploadUtil.formUpload(
						SystemConfig.PHOTO_SERVER + "photo/uploadFinePackingPic.htm", textMap, fileMap);
				if (StringUtils.isNotEmpty(ret)) {//{"success":true,"errCode":null,"errMsg":null,"data":{"productid":"200012572","status":"true","fileName":"200012572_9_1457063365536.jpg","color_sid":"9","url":"20160304/200012572_9/finepacking/200012572_9_1457063365536.jpg"}}
					JSONObject result1 = JSONObject.fromObject(ret);
					JSONObject result = JSONObject.fromObject(result1.get("data"));
					if ("true".equals(result.get("status"))) {
						
						Map<String, Object> paramMap1 = new HashMap<String, Object>();
						paramMap1.put("spuCode", result.get("productid"));
						paramMap1.put("colorSid", result.get("color_sid"));
						paramMap1.put("pictureUrl", result.get("url"));
						String json1 = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
								+ "/proPackimgUrl/savePackimgUrl.htm", JsonUtil.getJSONString(paramMap1));
						if(JSONObject.fromObject(json1).get("success").equals("true")){
							state = new BaseState();
							state.putInfo("url", "/" + result.get("url")); 
							state.putInfo("type", suffix); 
							state.putInfo("original", result.get("fileName") + ""); 
						}
					} else {
						state = new BaseState(false, 7);
					}
				} else {
					state = new BaseState(false, 7);
				}
            } else {
            	state = new BaseState(false, 9);
            }
		} catch (FileUploadException e1) {
			state = new BaseState(false, 6);
		} catch (Exception e) {
			state = new BaseState(false, 4);
		}
		return state;
	}
}