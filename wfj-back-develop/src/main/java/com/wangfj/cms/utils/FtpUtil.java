package com.wangfj.cms.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.SocketException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

import com.constants.SystemConfig;
import com.enterprisedt.net.ftp.FTPConnectMode;
import com.enterprisedt.net.ftp.FTPException;
import com.enterprisedt.net.ftp.FTPTransferType;
import com.enterprisedt.net.ftp.FileTransferClient;
import com.enterprisedt.net.ftp.WriteMode;



public class FtpUtil {
	private FTPClient ftpClient = new FTPClient();
	int index = 0;
	int ftpIndex = 0;
	int ofIndex = 0;
	private Log log = LogFactory.getLog(this.getClass());

	
    private static final SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	
	/**
	 * 说明: 
	 *     获取当前时间戳构造图片上传路径
	 * @Methods Name getImagePath
	 * @Create In 2013-9-5 By Administrator
	 * @return String
	 */
	public static String getImagePath(){
		return format.format(new Date());
	}
	
	// 上传楼层样式图片到ftp服务器
	public void saveStylelistImgToFtp(OutputStream out,String filename,FileItem item,
			String ip,String username,String password,String port,String path,String siteName){
		String ftpPath=path+"/"+siteName+SystemConfig.STYLELIST_IMAGE_PATH+"/";
		this.loginFTP(ftpPath, ip, username, password);
		try {
			ftpClient.storeFile(filename, item.getInputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			this.FtploginOut();
		}
		FileTransferClient ftp = null;
	/*	try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(ip);
			ftp.setUserName(username);
			ftp.setPassword(password);
			ftp.setRemotePort(Integer.valueOf(port));
			ftp.getAdvancedSettings().setControlEncoding("UTF-8");
			ftp.connect();
			String ftpPath=path+"/"+siteName+SystemConfig.STYLELIST_IMAGE_PATH+"/";
			boolean b = ftp.exists(ftpPath);
			if(!b){
				ftp.changeToParentDirectory();
				ftp.createDirectory(ftpPath);
			}
			ftp.changeDirectory(ftpPath);
			if(!ftp.exists(filename)){
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			if(out!=null){
				try {
					out.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			try {
				ftp.disconnect();
			} catch (FTPException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}		*/
	}
	
	// 上传模板图片到ftp服务器
		public static void saveTemplateImgToFtp(OutputStream out,String filename,FileItem item,
				String ip,String username,String password,String port,String imgPath){
			FileTransferClient ftp = null;
			try {
				ftp = new FileTransferClient();
				ftp.setRemoteHost(ip);
				ftp.setUserName(username);
				ftp.setPassword(password);
				ftp.setRemotePort(Integer.valueOf(port));
				ftp.connect();
				ftp.getAdvancedFTPSettings().setConnectMode(FTPConnectMode.PASV);
				ftp.setContentType(FTPTransferType.BINARY);  
				String ftpPath=imgPath;
				ftp.changeDirectory(ftpPath);
				if(!ftp.exists(filename)){					
					out = ftp.uploadStream(filename);
					out.write(item.get());
				}
			} catch (FTPException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				if(out!=null){
					try {
						out.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				try {
					ftp.disconnect();
				} catch (FTPException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}		
		}
	
	/**
	 * 登陆FTP
	 * 
	 * @return
	 * @throws IOException
	 * @throws SocketException
	 */
	public  boolean  loginFTP(String rootPath, String ip, String username,
			String password) {
		try {
			ftpClient.connect(ip);
			ftpClient.setControlEncoding("UTF-8");
			if (FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
				if (ftpClient.login(username, password)) {
					if (ftpClient.changeWorkingDirectory(rootPath)) {
						ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
						return true;
					}else{
						String path = "";
						String[] s = rootPath.split("/");
					
						for(int i= 1;i<s.length;i++){
							ftpClient.changeWorkingDirectory(path+s[i]);
							ftpClient.makeDirectory(new String((path+s[i])
									.getBytes("UTF-8"), "iso-8859-1"));
							path = path+"/"+s[i]+"/";
							
						}
						if (ftpClient.changeWorkingDirectory(rootPath)){
							ftpClient.setFileType(FTP.BINARY_FILE_TYPE);
							return true;
						}
					}
				}

			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 登出
	 */
	public void FtploginOut() {
		try {
			if (FTPReply.isPositiveCompletion(ftpClient.getReplyCode())) {
				ftpClient.disconnect();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*********************

	* 上传文件或文件夹

	* */
	private  void uploadFiles(String remotePath, File localFile) {
		if (localFile.isDirectory()) {	
		for (File ff : localFile.listFiles()) {	
		if (ff.isDirectory()) {	
			try {	
				ftpClient.changeWorkingDirectory(remotePath);	
			if (!ftpClient.changeWorkingDirectory(remotePath +"/"+ localFile.getName())) {	
			    log.info("FTP到目录("+ remotePath +")下创建文件夹:"+ ff.getName());	
			    ftpClient.makeDirectory(ff.getName());	
			}	
			   uploadFiles(remotePath +"/"+ ff.getName(), ff);// 递归调用，传文件夹		
			} catch (IOException e) {		
			   log.error("FTP服务器创建远程目录("+ remotePath +"/"+ ff.getName() +")失败:"+ e.getMessage());		
			}	
		} else {
		    uploadFile(remotePath, ff);
		}
		}
	
		} else {
		   uploadFile(remotePath, localFile);
		}

	}
	
	/*****************************************

	* 上传单个文件

	* */

	private void uploadFile(String remotePath, File localFile) {
		try {
		   log.info("开始上传文件到："+ remotePath +"/=="+ localFile.getName());
		   ftpClient.changeWorkingDirectory(remotePath);
		   ftpClient.storeFile(localFile.getName(), new FileInputStream(localFile));
		} catch (IOException e) {
		  log.error("FTP向服务器("+ ftpClient.getRemoteAddress().getHostAddress() +")上传文件("+ localFile.getAbsolutePath() +")失败:"+ e.getMessage());
		}

	}
	
	
	/**
	 * 单个文件上传到服务器
	 * @Methods Name uploadSingleFileToFtp
	 * @Create In 2016年3月30日 By chengsj
	 * @return boolean
	 */
	public static boolean uploadSingleFileToFtp(File localFile,String destPath,String ip, String username,String password,String port){
		boolean flag = false;
		FileTransferClient ftp = null;
		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(ip);
			ftp.setUserName(username);
			ftp.setPassword(password);
			ftp.setRemotePort(Integer.valueOf(port));
			ftp.connect();
			ftp.getAdvancedFTPSettings().setConnectMode(FTPConnectMode.PASV);
			ftp.setContentType(FTPTransferType.BINARY);
			String ftpPath = destPath;			
			ftp.changeDirectory(ftpPath);
			if(ftp.exists(localFile.getName())){
				ftp.deleteFile(localFile.getName());
			}
			ftp.uploadFile(localFile.getPath(), localFile.getName(),WriteMode.OVERWRITE);
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(ftp!=null){
				try {
					ftp.cancelAllTransfers();					
					ftp.disconnect(true);
				} catch (FTPException e) {
					
					e.printStackTrace();
				} catch (IOException e) {					
					e.printStackTrace();
				}
			}
			
		}
		return flag;
	}

	
	
	public boolean uploadFileToFtp(String srcPath,String destPath,String ip, String username,String password){
		boolean flag = true;
		try {		
			File file = new File(srcPath);
			boolean b = loginFTP(destPath, ip, username, password);
			if (b) {
				String dirName = srcPath.substring(srcPath.lastIndexOf("/")+1);
			    boolean istrue =	ftpClient.makeDirectory(new String(dirName.getBytes("UTF-8"), "iso-8859-1"));
				if(file.isDirectory()){
					uploadFiles(destPath+"/"+dirName,file);
				}else{
					FileInputStream bufferedInputStream=new FileInputStream(file);
					uploadFileOrDistor(destPath, srcPath+"/"+file.getName(),bufferedInputStream,ip,username,password);
			   }
			}
		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		}
		FtploginOut();
		return flag;
	}
	
	/**
	 * 上传文件
	 * 
	 * @param rootPath
	 * @param FilePath
	 * @param bufferedInputStream
	 * @return
	 */
	public boolean uploadFileOrDistor(String rootPath,String fileName,
			FileInputStream bufferedInputStream, String ip, String username,
			String password) {
		boolean b = loginFTP(rootPath, ip, username, password);
		boolean isUploadFile = false;
		if (b) {
			try {
				ftpClient.enterLocalPassiveMode();
				ftpClient.setControlEncoding("UTF-8");
				isUploadFile = ftpClient.storeFile(
						new String(fileName.getBytes("UTF-8"), "iso-8859-1"),
						bufferedInputStream);
			} catch (IOException e) {
				e.printStackTrace();
				try {
					bufferedInputStream.close();
				} catch (IOException e1) {
					e1.printStackTrace();
				}
				return false;
			}
			try {
				bufferedInputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		FtploginOut();
		return isUploadFile;
	}
	
}
