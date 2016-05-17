package com.baidu.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.constants.SystemConfig;
import com.enterprisedt.net.ftp.FTPException;
import com.enterprisedt.net.ftp.FileTransferClient;
import com.utils.StringUtils;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import com.wangfj.wms.util.UploadUtil;

public class FileToFTP {

	public boolean uploadWithRemoteDir(String remoteDir, File targetFile) {
		// TODO Auto-generated method stub
		FileTransferClient ftp = null;
		OutputStream outPutStream = null;
		String filename = targetFile.getName();
		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory(SystemConfig.FTP_PROPACKIMG);
			if(!ftp.exists(filename)){
				outPutStream = ftp.uploadStream(filename);
				outPutStream.write(getByte(targetFile));
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}finally{
			if(outPutStream!=null){
				try {
					outPutStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					return false;
				}
			}
			try {
				ftp.disconnect();
			} catch (FTPException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
		}	
		return true;
	}

	public void connect(String string) {
		// TODO Auto-generated method stub
		
	}

	public byte[] getByte(File file) throws Exception {
		byte[] bytes = new byte[(int)file.length()];
		if(file!=null) {
	        FileInputStream fos = null;  //w文件包装输出流
			fos = new FileInputStream(file);
			fos.read(bytes);
            fos.close();
		}
		return bytes;
	}
	
	public List<File> getImgFromFtp(){
		List<File> files = new ArrayList<File>();
		FileTransferClient ftp = null;
		ftp = new FileTransferClient();
		try {
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory(SystemConfig.FTP_PROPACKIMG);
			String[] fileNames = ftp.directoryNameList();
			for(String p : fileNames){
				String path = "http://"+SystemConfig.FTP_HOST+"/"+SystemConfig.FTP_PROPACKIMG;
				files.add(new File(path+p));
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return files;
	}
	
	public boolean uploadWithRemoteDir(HttpServletRequest request) throws FileUploadException {
		// TODO Auto-generated method stub
		boolean isSuccess = false;
		
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
		// 获取编码
		String encoding = request.getCharacterEncoding();
		// 定义输出流对象
		OutputStream outPutStream = null;
		// 创建基于文件项目的工厂对象
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		diskFileItemFactory.setSizeThreshold(1024);
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
		// 允许上传文件的最大范围
		// servletFileUpload.setSizeMax(maxPostSize);
		// 解析上传的请求 或许request中的请求的参数放入list
		List<FileItem> fileItem = servletFileUpload.parseRequest(request);
		// 获取当前时间戳
		fileName = FtpUtil.getImagePath();
		// 获取fileItem集合中的参数
		try {
			String brandCode = "";
			String cateCode = "";
			for (int i = 0; i < fileItem.size(); i++) {
				FileItem item = (FileItem) fileItem.get(i);
				// 判断是普通表单还是文件上传于， true是普通表单
				if (!item.isFormField() && item.getName() != null && !"".equals(item.getName())) {
					
				} else {
					// 非图片参数的处理
					String fieldName = item.getFieldName();
					if (fieldName.equals("brandCode")) {
						brandCode = item.getString(encoding);
					} else {
						cateCode = item.getString(encoding);
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
						if (".jpg".equalsIgnoreCase(type) || ".gif".equalsIgnoreCase(type)
								|| ".png".equalsIgnoreCase(type)) {
							uploadName = brandCode + "_" + cateCode + "_" + fileName + "."
									+ name.split("\\.")[1];

							fileMap.put(uploadName, item.get());
							// 获取图片的尺寸
//							BufferedImage bi = ImageIO.read(item.getInputStream());
//							int width = bi.getWidth();
//							int height = bi.getHeight();
//							textMap.put("width", width + "");
//							textMap.put("height", height + "");
						} else {
							json.put("success", "false");
							json.put("data", "只能上传jpg、gif、png类型的图片！");
						}
					} else {
						json.put("success", "false");
						json.put("data", "只能上传jpg、gif、png类型的图片！");
					}
				} else {
					// 非图片参数的处理
					if ("brandCode".equals(item.getFieldName())) {
						textMap.put("brandCode", item.getString(encoding));
					}
					if ("cateCode".equals(item.getFieldName())) {
						textMap.put("categoryCode", item.getString(encoding));
					}
				}
			}
			String ret = UploadUtil.formUpload(
					SystemConfig.PHOTO_SERVER + "photo/.htm", textMap, fileMap);
			
			if (StringUtils.isNotEmpty(ret)) {
				JSONObject result = JSONObject.fromObject(ret);
				if ("true".equals(result.get("Status"))) {
					Map<String, Object> paramMap1 = new HashMap<String, Object>();
					paramMap1.put("spuCode", result.get("ProductId"));
					paramMap1.put("colorSid", result.get("color_sid"));
					paramMap1.put("pictureUrl", result.get("pictureUrl"));
					String json1 = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
							+ "/proPackimgUrl/savePackimgUrl.htm", JsonUtil.getJSONString(paramMap1));
					if(JSONObject.fromObject(json1).get("success").equals("true")){
						isSuccess = true;
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	/*public static void main(String[] args) {
		try {
			File file = new File("E:\\11.txt");
			System.err.println(new FileToFTP().getByte(file).length);
			
			File dir = new File("http://10.6.100.100:21/propackimg/images/");
			FileTransferClient ftp = null;
			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory("propackimg/images/");
			String[] files = ftp.directoryNameList();
			for(String p : files){
				System.out.println(p);
			}
			System.err.println(dir.exists());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/
	
	public List<File> getImgFromDatabase(HttpServletRequest request){
		List<File> files = new ArrayList<File>();
		
		String spuCode = request.getParameter("spuCode");
		String colorSid = request.getParameter("colorSid");
		
		Map<String, Object> proMap = new HashMap<String, Object>();
		proMap.put("spuCode", spuCode);
		proMap.put("colorSid", colorSid);
		
		// 查询图片列表
		String json = "";
		json = HttpUtilPcm.doPost(
				SystemConfig.SSD_SYSTEM_URL + "/proPackimgUrl/getAllListBySpuAndColor.htm",
				JsonUtil.getJSONString(proMap));

		try {
			if (!"".equals(json) && json != null) {
				JSONObject imgJson = JSONObject.fromObject(json);
				if ("true".equals(imgJson.get("success"))) {
					JSONArray array = JSONArray.fromObject(imgJson.get("data"));
					for(int i=0; i<array.size();i++){
						String path = "http://"+SystemConfig.FTP_HOST+"/"+JSONObject.fromObject(array.get(i)).get("pictureUrl");
						files.add(new File(path));
					}
				}
			}
		} catch (Exception e) {
			
		}		
		return files;
	}

}
