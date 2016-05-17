/**
 * 说明:  
 *     图片ftp上传工具类
 * @Probject Name: shopin-back-wms
 * @Path: com.wangfj.wms.utilFtpUtil.java
 * @Create By chengsj
 * @Create In 2013-9-5 上午10:34:47
 * TODO
 */
package com.wangfj.wms.util;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.apache.commons.fileupload.FileItem;
import com.constants.SystemConfig;
import com.enterprisedt.net.ftp.FTPException;
import com.enterprisedt.net.ftp.FileTransferClient;

/**
 * @Class Name FtpUtil
 * @Author chengsj
 * @Create In 2013-9-5
 */
public class FtpUtil {

	private static final SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");

	/**
	 * 说明: 获取当前时间戳构造图片上传路径
	 * 
	 * @Methods Name getImagePath
	 * @Create In 2013-9-5 By Administrator
	 * @return String
	 */
	public static String getImagePath() {
		return format.format(new Date());
	}

	// 上传图片到ftp服务器
	public static void savePicToFtp(OutputStream out, String path, String filename, FileItem item) {
		FileTransferClient ftp = null;

		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory(path);
			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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
	 * 说明: 上传活动图片到ftp服务器
	 * 
	 * @Methods Name saveToFtp
	 * @Create In 2013-9-5 By chengsj
	 * @param out
	 * @param fileDic
	 * @param filename
	 * @param item
	 * @param host
	 * @param username
	 * @param password
	 *            void
	 */
	public static void saveToFtp(OutputStream out, String filename, FileItem item) {
		FileTransferClient ftp = null;

		try {

			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory(SystemConfig.PROMOTION_PATH);
			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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

	// 上传brand图片到ftp服务器
	public static void saveBrandToFtp(OutputStream out, String filename, FileItem item) {
		FileTransferClient ftp = null;

		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();

			String[] folderArray = SystemConfig.BRAND_IMAGE_PATH.split("/");
			for (String folder : folderArray) {
				ftp.changeDirectory(folder);
			}

			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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

	// 上传尺码对照表图片到ftp服务器
	public static void saveSizeCodeTableToFtp(OutputStream out, String filename, FileItem item) {
		FileTransferClient ftp = null;

		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory(SystemConfig.SIZECODE_IMAGE_PATH);
			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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

	// 上传广告图片到ftp服务器
	public static void saveAdvertiseImgToFtp(OutputStream out, String filename, FileItem item,
			String ip, String username, String password, String port, String path,
			String siteName) {
		FileTransferClient ftp = null;
		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(ip);
			ftp.setUserName(username);
			ftp.setPassword(password);
			ftp.setRemotePort(Integer.valueOf(port));
			ftp.connect();
			String ftpPath = path + "/" + siteName + SystemConfig.ADVERTISE_IMAGE_PATH;
			ftp.changeDirectory(ftpPath);
			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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

	// 上传广告视频到ftp服务器
	public static void saveAdvertiseFlashToFtp(OutputStream out, String filename, FileItem item,
			String ip, String username, String password, String port, String path,
			String siteName) {
		FileTransferClient ftp = null;
		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(ip);
			ftp.setUserName(username);
			ftp.setPassword(password);
			ftp.setRemotePort(Integer.valueOf(port));
			ftp.connect();
			String ftpPath = path + "/" + siteName + SystemConfig.ADVERTISE_FLASH_PATH;
			ftp.changeDirectory(ftpPath);
			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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

	// 上传product图片到ftp服务器
	public static void savePorductToFtp(OutputStream out, String filename, FileItem item) {
		FileTransferClient ftp = null;

		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory(SystemConfig.PRODUCT_IMAGE_PATH);
			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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

	public static void deleteToFtp(String fileName, String path) {
		FileTransferClient ftp = null;

		ftp = new FileTransferClient();
		try {
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.parseInt(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory(path);
			if (ftp.exists(fileName)) {
				ftp.deleteFile(fileName);
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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

	public static void saveSaleMsgToFtp(OutputStream out, String filename, FileItem item) {
		FileTransferClient ftp = null;

		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();
			ftp.changeDirectory(SystemConfig.SALEMSG_PATH);
			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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

	// 上传rerund图片到ftp服务器
	public static void saveRefundToFtp(OutputStream out, String filename, FileItem item) {
		FileTransferClient ftp = null;

		try {
			ftp = new FileTransferClient();
			ftp.setRemoteHost(SystemConfig.FTP_HOST);
			ftp.setUserName(SystemConfig.FTP_USERNAME);
			ftp.setPassword(SystemConfig.FTP_PASSWORD);
			ftp.setRemotePort(Integer.valueOf(SystemConfig.FTP_PORT));
			ftp.connect();

			String[] folderArray = SystemConfig.REFUND_IMAGE_PATH.split("/");
			for (String folder : folderArray) {
				ftp.changeDirectory(folder);
			}

			if (!ftp.exists(filename)) {
				out = ftp.uploadStream(filename);
				out.write(item.get());
			}
		} catch (FTPException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (out != null) {
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
	public static void main(String[] args) {
		/**
		 * String path = "d:\\1002"+getImagePath();
		 * System.out.println(getImagePath()); File dest = new File(path);
		 * 
		 * System.out.println("dest.getPath()=="+dest.getPath());
		 * System.out.println("dest.getParentFile()="+dest.getParentFile()); //
		 * if(!dest.getParentFile().exists()) // dest.getParentFile().mkdirs();
		 * if(!dest.exists()) dest.mkdirs(); System.out.println("wqeqweqw");
		 */
		/**
		 * //创建日期文件夹 String savePath = ""; String ymd =
		 * DateUtils.formatDate2Str(DateUtils.DATE_PATTON_3); savePath +=
		 * "D:"+"/" + ymd; System.out.println("savePath=="+savePath); File
		 * dirFile = new File(savePath); if (!dirFile.exists()) {
		 * dirFile.mkdirs(); }
		 */

	}

}
