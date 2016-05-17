package com.wangfj.cms.utils;


import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;  
import java.io.FileInputStream;  
import java.io.FileOutputStream;  
import java.io.IOException;  
import java.io.InputStream;  
import java.io.OutputStream;  
import java.net.SocketException;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.net.ftp.FTP;  
import org.apache.commons.net.ftp.FTPClient;  
import org.apache.commons.net.ftp.FTPClientConfig;  
import org.apache.commons.net.ftp.FTPFile;  
import org.apache.commons.net.ftp.FTPReply;  
  
public class RemoteFtpProcess extends FTPClient {  
    private static FTPClient ftpClient = new FTPClient();  
  
    /** 
     * 本方法用户登录远程的FTP服务器 
     *  
     * @param url :表示FTP的IP地址 
     * @param port :FTP服务器端口，默认端口为21 
     * @param userName :登录FTP的用户名 
     * @param password :登录FTP的密码 
     *  
     * @return FTPClient:返回为FTPClient对象 
     */  
    public FTPClient loginFtp(String url, int port, String userName,  
            String password) {  
        try {  
            ftpClient.connect(url, port);  
            ftpClient.setControlEncoding("UTF-8");  
            FTPClientConfig ftpConfig = new FTPClientConfig(FTPClientConfig.SYST_NT);  
            ftpConfig.setServerLanguageCode("zh");  
            ftpClient.login(userName, password);  
            int reply = 0;  
            reply = ftpClient.getReplyCode();  
            System.out.println(reply);  
            if (FTPReply.isPositiveCompletion(reply)) {  
                System.out.println("登录成功！");  
            } else {  
                System.out.println("登录失败！");  
            }  
        } catch (SocketException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return ftpClient;  
    }  
  
    /** 
     * @param ftpc :退出FTP登录 
     * @return boolean :是否已经关闭连接 
     *  
     * @throws IOException 
     */  
    public  boolean closeConnections() throws IOException {  
        boolean bool = false;            
        if(ftpClient!=null||ftpClient.isConnected()){
        	bool = ftpClient.logout();
        }
        return bool;  
    }  
  
    /** 
     * 方法用于上传文件到FTP服务器的指定文件夹中 
     *  
     * @param fileName :上传文件的名称 
     * @param input :上传文件的输入流对象 
     * @param toFtpPath :上传到FTP的目的路径 
     *  
     * @return boolean:表示上传是否成功 
     *  
     */  
    public boolean uploadFileToFtp(String fileName, InputStream input,  
            String toFtpPath) {  
        boolean bool = false;  
        try {  
            // 使得能够处理中文编码  
            fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");  
            toFtpPath = new String(toFtpPath.getBytes("UTF-8"), "ISO-8859-1");
            //增大缓存区
            ftpClient.setBufferSize(1024*1024*10);
            // 转到上传文件的FTP目录中  
        	newFileOnFTP(toFtpPath);
        boolean b =    ftpClient.changeWorkingDirectory(toFtpPath);

            // 设置处理文件的类型为字节流的形式  
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);  
            // 如果缺省该句 传输txt正常 但图片和其他格式的文件传输出现乱码 
            ftpClient.enterLocalPassiveMode();
            BufferedInputStream bs = new BufferedInputStream(new ByteArrayInputStream(IOUtils.toByteArray(input)));
            bool = ftpClient.storeFile(fileName, bs); 
            ftpClient.getReplyString();
        } catch (IOException e) {  
            bool = false;  
            e.printStackTrace();  
        } finally {
            try {
				input.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
        }   
        return bool;  
    }  
  
    /** 
     * 方法用于从FTP服务器中下载文件 
     *  
     * @param ftpUrl :下载文件所处FTP中路径 
     * @param fileName :下载的文件名称 
     * @param outputSream :下载文件的输出流对象 
     *  
     * @return boolean :表示是否上传成功 
     *  
     */  
    public boolean downloadFileFromFtp(String ftpUrl, String fileName,  
            OutputStream outputStream) {  
        boolean bool = false;  
        try {  
            ftpClient.changeWorkingDirectory(ftpUrl);  
            FTPFile[] ftpFile = ftpClient.listFiles();  
            for (int i = 0; i < ftpFile.length; i++) {  
                if (fileName.equals(ftpFile[i].getName())) {  
                    ftpClient.retrieveFile(new String(ftpFile[i].getName()  
                            .getBytes("GBK"), "ISO-8859-1"), outputStream);  
                    outputStream.flush();  
                    outputStream.close();  
                }  
            }  
            bool = true;  
        } catch (IOException e) {  
            e.printStackTrace();  
            bool = false;  
        }  
        return bool;  
    }  
  
    /** 
     * 方法用户删除FTP上的指定的文件 
     *  
     * @param fileUrl :文件在FTP中的路径 
     * @param fileName :文件的名称 
     *  
     * @return boolean:删除是否成功 
     */  
    public boolean deleteFileOnFtp(String fileUrl, String fileName) {  
        boolean bool = false;  
        try {  
            ftpClient.changeWorkingDirectory(fileUrl);  
            FTPFile[] ftpFiles = ftpClient.listFiles();  
            System.out.println(ftpFiles.length);  
            for (int i = 0; i < ftpFiles.length; i++) {  
                if (fileName.equals(ftpFiles[i].getName())) {  
                    ftpClient.deleteFile(fileName);  
                }  
            }  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
        return bool;  
    }  
  
    /** 
     * 判断指定文件中是否存在相同名称的文件 
     *  
     * @param remotePath :FTP上的远程目录 
     * @param fileName:文件名称 
     * @return boolean :判断是否存在相同名称 
     *  
     */  
    public boolean isSameName(String remotePath, String fileName) {  
        boolean bool = false;  
        try {  
            FTPFile[] ftpFiles = ftpClient.listFiles();  
            System.out.println(ftpFiles.length);  
            ftpClient.changeWorkingDirectory(remotePath);  
            for (int i = 0; i < ftpFiles.length; i++) {  
                if (fileName.equals(ftpFiles[i].getName())) {  
                    System.out.println("存在和指定文件相同名称的文件");  
                    bool = true;  
                    break;
                } else {  
                    bool = false;  
                }  
            }  
        } catch (Exception e) {  
            bool = false;  
        }  
        return bool;  
    }  
  
    /** 
     * 更改文件名称 
     *  
     */  
    public String changeName(String remotePath, String fileName, String newName) {  
        if (isSameName(remotePath, fileName)) {  
            fileName = fileName + "." + newName;  
        }  
        return fileName;  
    }  
      
      
    public static void newFileOnFTP(String pathName){
        try {
        	String path[] = pathName.split("/");
        	StringBuffer buffer = new StringBuffer();
        	for(int i=0;i<path.length;i++){
        		if(StringUtils.isNotBlank(path[i])){
            		buffer.append("/").append(path[i]);
            		ftpClient.mkd(buffer.toString());  

        		}

        	}
         
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
     
    
    /**
     * 上传整个目录至FTP 无过滤文件传nill
     * @Methods Name uploadDirFiles
     * @Create In 2016-4-12 By chengsj
     * @param dirPath
     * @param toRemotePath
     * @param suffix
     * @throws IOException void
     */
    public void uploadDirFiles(String dirPath,String toRemotePath,String[] suffix) throws IOException{  
        if (dirPath!=null && !dirPath.equals("")) {
            //建立上传目录的File对象  
            File dirFile = new File(dirPath);  
            //判断File对象是否为目录类型  
            if (dirFile.isDirectory()) {  
                //如果是目录类型。  
                //在FTP上创建一个和File对象文件相同名称的文件夹  
                ftpClient.makeDirectory(toRemotePath+"//"+dirFile.getName());  
                //获得File对象中包含的子目录数组  
                File[] subFiles = dirFile.listFiles();  
                //路径  
                String path = toRemotePath+"//"+dirFile.getName();  
                System.out.println(path);  
                //判断数组是否为空  
                if (subFiles!=null && subFiles.length>0) {  
                    //遍历整个File数组  
                    file:for (int i = 0; i < subFiles.length; i++) {  
                        //判断是否为目录类型  
                        if (subFiles[i].isDirectory()) {  
                            //如果为目录类型  
                            //跳转到FTP的根目录层级  
                            ftpClient.changeWorkingDirectory("//");
                            //在FTP上建立相同的目录名称  
                            ftpClient.makeDirectory(path+"//"+subFiles[i].getName());  
                            //递归调用自身方法，进行到下一层级的目录循环  
                            uploadDirFiles(subFiles[i].getAbsolutePath(), path,suffix);  
                        } else {
                        	if(null != suffix && !"".equals(suffix)){
                            	for(int j=0;j<suffix.length;j++){
                            		if(subFiles[i].getName().substring(subFiles[i].getName().lastIndexOf(".")).equals(suffix[j])){
                                        continue file;
                            		}

                            	}
                                //如果为文件类型  
                                //建立一个文件输出流对象  
                                FileInputStream input = new FileInputStream(subFiles[i]);
                                //调用文件上传方法，将文件上传到FTP上  
                                uploadFileToFtp(subFiles[i].getName(), input, path+"//");  
                                //关闭文件输入流  
                                input.close();
                        	}
                        }  
                    }  
                }  
            } else {  
                //如果为文件类型  
                //建立一个文件输出流对象  
                FileInputStream input = new FileInputStream(dirFile);  
                //调用文件上传方法，将文件上传到FTP上  
                uploadFileToFtp(dirFile.getName(), input, toRemotePath);  
                //关闭文件输入流  
                input.close();  
            }  
        }  
    }  
      
    //本方法用于下载FTP上的目录结构到本地中  
    public void downloadDirFiles(String remotePath,String localPath,String fileName) throws IOException{  
        if (remotePath!=null && !remotePath.equals("")) {  
            //在本地建立一个相同的文件目录  
            File localFile = new File(localPath+"\\"+fileName);  
            localFile.mkdirs();  
            //获得目录在本地的绝对路径  
            localPath = localFile.getAbsolutePath();  
            System.out.println(localPath);  
            //获得FTPFile对象数组  
            FTPFile[] ftpFiles = ftpClient.listFiles(new String(remotePath.getBytes("GBK"),"ISO-8859-1"));  
            if (ftpFiles!=null && ftpFiles.length>0) {  
                for (int i = 0; i < ftpFiles.length; i++) {  
                    FTPFile subFile = ftpFiles[i];  
                    //判断是否为目录结构  
                    if (subFile.isDirectory()) {  
                        //如果为目录结构  
                        //调用自身方法，进行下一层级目录循环  
                        downloadDirFiles(remotePath+"//"+subFile.getName(), localPath, subFile.getName());  
                    } else {  
                        //如果不为目录结构,为文件类型  
                        FileOutputStream outputStream = new FileOutputStream(new File(localPath+"\\"+subFile.getName()));  
                        //调用下载方法对文件进行下载  
                        downloadFileFromFtp(remotePath, subFile.getName(), outputStream);  
                        //关闭文件输出流  
                        outputStream.close();  
                    }  
                }  
            }  
        }  
    }  
}
