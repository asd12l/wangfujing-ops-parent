package com.wangfj.wms.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;

import com.constants.SystemConfig;

public class DownPackZipUtil {
	
	public static void downFile(List<String> picUrls, ZipOutputStream out) {
		FTPClient ftp = new FTPClient();
		int count = 0;
		try {
			int reply;    
			ftp.connect(SystemConfig.FTP_HOST, Integer.valueOf(SystemConfig.FTP_PORT));     // 下面三行代码必须要，而且不能改变编码格式  
			ftp.setControlEncoding("UTF-8");   
			FTPClientConfig conf = new FTPClientConfig(FTPClientConfig.SYST_NT);  
			conf.setServerLanguageCode("zh");    // 如果采用默认端口，可以使用ftp.connect(url) 的方式直接连接FTP服务器  
			ftp.login(SystemConfig.FTP_USERNAME, SystemConfig.FTP_PASSWORD);// 登录   
			ftp.setFileType(FTPClient.BINARY_FILE_TYPE);    
			reply = ftp.getReplyCode();  
			if (!FTPReply.isPositiveCompletion(reply)) {
				System.out.println("连接服务器失败");
				ftp.disconnect();    
				return;    
			}   
			System.out.println("登陆成功。。。。");     
			String picDir = "";
			for(String url : picUrls){
				if(!url.equals("")){
					String dirUrl = url.substring(0, url.lastIndexOf("/"));
					if(picDir != dirUrl){
						picDir = dirUrl;
						ftp.changeWorkingDirectory(picDir);// 转移到FTP服务器目录    
					}
					String picName = url.substring(url.lastIndexOf("/")+1);
					FTPFile[] fs = ftp.listFiles(); // 得到目录的相应文件列表
					for (int i = 0; i < fs.length; i++) {     
						FTPFile ff = fs[i]; 
				    	if (ff.getName().equals(picName)) {      
							count++; 
							out.putNextEntry(new ZipEntry(picName));    
			                //设置压缩文件内的字符编码，不然会变成乱码    
			                out.setEncoding("GBK");  
				     		ftp.retrieveFile(new String(ff.getName().getBytes("UTF-8"),  "ISO-8859-1"), out); 
				     		out.closeEntry();
				      		break;
				    	} 
				   	} 
				}
				
			}
		   	if (count == 1) { //下载成功    
			 	ftp.logout();     
				ftp.disconnect();    
			} else {//文件找不到    
			 	ftp.logout();    
			 	ftp.disconnect(); 
		   	} 
		} catch (Exception e) { 
			e.printStackTrace();   
		 	try {  
		 		ftp.logout();    
		 		ftp.disconnect();   
		 	} catch (IOException e1) { 
		    	e1.printStackTrace(); 
		   	} 
		} 
	}

	/**   
     * 文件下载   
     * @param response   
     * @param str   
     */    
    public static boolean downFile(HttpServletResponse response, String str) {    
        try {    
            String path = "/" + str;    
            File file = new File(path);    
            if (file.exists()) {    
                InputStream ins = new FileInputStream(path);    
                BufferedInputStream bins = new BufferedInputStream(ins);// 放到缓冲流里面    
                OutputStream outs = response.getOutputStream();// 获取文件输出IO流    
                BufferedOutputStream bouts = new BufferedOutputStream(outs);    
                response.setContentType("application/x-download");// 设置response内容的类型    
                response.setHeader("Content-disposition", 
                		"attachment;filename=" + URLEncoder.encode(str, "UTF-8"));// 设置头部信息    
                int bytesRead = 0;    
                byte[] buffer = new byte[8192];    
                // 开始向网络传输文件流    
                while ((bytesRead = bins.read(buffer, 0, 8192)) != -1) {    
                    bouts.write(buffer, 0, bytesRead);    
                }    
                bouts.flush();// 这里一定要调用flush()方法    
                ins.close();    
                bins.close();    
                outs.close();    
                bouts.close();
                file.delete();
                return true;
            } else {    
            	file.delete();
            	return false;   
            } 
        } catch (IOException e) {   
        	e.printStackTrace();
        	return false;
        }    
    }  
}
