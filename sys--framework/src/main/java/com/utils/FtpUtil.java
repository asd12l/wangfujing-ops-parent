package com.utils;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import com.enterprisedt.net.ftp.FTPConnectMode;
import com.enterprisedt.net.ftp.FTPException;
import com.enterprisedt.net.ftp.FTPFile;
import com.enterprisedt.net.ftp.FTPTransferType;
import com.enterprisedt.net.ftp.FileTransferClient;
/**
 * desc   : Ftp handler tool
 * author : Xiangxing
 * data   : 2013-3-7
 * email  : xiangxingchina@163.com
 **/
public class FtpUtil {
	/**
     * @param host        FTP服务器地址
     * @param userName    FTP账号
     * @param password    FTP密码
     * @return
     * @throws FTPException
     * @throws IOException
     */
	public static FileTransferClient GetFtpClient(String host,String userName,String password) throws FTPException, IOException{
		//创建一个FTP client
        //官方已不推荐使用FTPClient
        FileTransferClient ftpClient = new FileTransferClient();
      //设置FTP服务器
        ftpClient.setRemoteHost(host);
        //设置FTP用户名
        ftpClient.setUserName(userName);
        //设置FTP密码
        ftpClient.setPassword(password);
        //解决中文文件名乱码
        ftpClient.getAdvancedSettings().setControlEncoding("UTF-8");
        //被动模式，数据连接由客户端发起
        ftpClient.getAdvancedFTPSettings().setConnectMode(FTPConnectMode.PASV);
        //用HTML 和文本编写的文件必须用ASCII模式上传,用BINARY模式上传会破坏文件,导致文件执行出错.
        //ftp.setContentType(FTPTransferType.ASCII);
        //BINARY模式用来传送可执行文件,压缩文件,和图片文件.
        ftpClient.setContentType(FTPTransferType.BINARY);
        //连接到FTP服务器
        ftpClient.connect();
        return ftpClient;
	}
	
	 /**
     * 从FTP Server断开连接
     * @param ftp
     * @throws FTPException
     * @throws IOException
     */
    public static void CloseFtpClient(FileTransferClient ftp) throws FTPException, IOException {
        if(ftp != null && ftp.isConnected()) {
            ftp.disconnect();
        }
    }
    
    
    /**
	 * ftp 目录遍历
	 * @param client
	 * @param localFilePath
	 * @param ftpFilePath
	 * @throws FTPException
	 * @throws IOException
	 * @throws ParseException 
	 */
    public static List<String> QueryFiles(FileTransferClient client,String ftpFilePath) throws FTPException, IOException, ParseException{
    	 FTPFile[] files = client.directoryList(ftpFilePath);
		 List<String> filePaths = new ArrayList<String>();
		 if(files!=null && files.length>0){
			 for (int i = 0; i < files.length; i++) {
				 FTPFile file = files[i];
//				 filePaths.add(ftpFilePath+ file.getName());
				 filePaths.add(file.getName());
			 }	 
		 }
		 return filePaths;
    }
    
    
	/**
     * 上传文件
     * @throws IOException 
     * @throws FTPException 
     */
    public static void UploadFile(FileTransferClient client,String localFilePath,String ftpFilePath) throws FTPException, IOException {
        client.uploadFile(localFilePath, ftpFilePath);
    }
    
    /**
     * 下载文件
     * @throws FTPException
     * @throws IOException
     */
    public static void DownloadFile(FileTransferClient client,String localFilePath,String ftpFilePath) throws FTPException, IOException {
    	client.downloadFile(localFilePath, ftpFilePath);
    }
    
    /**
     * 删除文件
     * @throws FTPException
     * @throws IOException
     */
    public static void DeleteFile(FileTransferClient client,String ftpFilePath) throws FTPException, IOException {
    	client.deleteFile(ftpFilePath);
    }
    /**
     * 移动文件
     * @throws FTPException
     * @throws IOException
     */
    public static void MoveFile(FileTransferClient client,String renameFromName,String renameToName) throws FTPException, IOException {
    	client.rename(renameFromName, renameToName);
    }
}
