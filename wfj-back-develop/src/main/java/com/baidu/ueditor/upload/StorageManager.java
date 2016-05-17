package com.baidu.ueditor.upload;

import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.State;
import com.baidu.common.util.FileToFTP;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import org.apache.commons.io.FileUtils;

public class StorageManager {
	public static final int BUFFER_SIZE = 8192;

	public static State saveBinaryFile(byte[] data, String path) {
		File file = new File(path);
		State state = valid(file);
		if (!state.isSuccess()) {
			return state;
		}
		try {
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(file));
			bos.write(data);
			bos.flush();
			bos.close();
		} catch (IOException ioe) {
			return new BaseState(false, 4);
		}
		state = new BaseState(true, file.getAbsolutePath());
		state.putInfo("size", data.length);
		state.putInfo("title", file.getName());
		return state;
	}

	public static State saveFileByInputStream(InputStream is, String path,
			long maxSize) {
		State state = null;
		File tmpFile = getTmpFile();
		byte[] dataBuf = new byte[2048];
		BufferedInputStream bis = new BufferedInputStream(is, 8192);
		try {
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(tmpFile), 8192);
			int count = 0;
			while ((count = bis.read(dataBuf)) != -1) {
				bos.write(dataBuf, 0, count);
			}
			bos.flush();
			bos.close();
			if (tmpFile.length() > maxSize) {
				tmpFile.delete();
				return new BaseState(false, 1);
			}
			state = saveTmpFile(tmpFile, path);
			if (!state.isSuccess()) {
				tmpFile.delete();
			}
			return state;
		} catch (IOException localIOException) {
		}
		return new BaseState(false, 4);
	}

	public static State saveFileByInputStream(InputStream is, String path) {
		State state = null;
		File tmpFile = getTmpFile();
		byte[] dataBuf = new byte[2048];
		BufferedInputStream bis = new BufferedInputStream(is, 8192);
		try {
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(tmpFile), 8192);
			int count = 0;
			while ((count = bis.read(dataBuf)) != -1) {
				bos.write(dataBuf, 0, count);
			}
			bos.flush();
			bos.close();
			state = saveTmpFile(tmpFile, path);
			if (!state.isSuccess()) {
				tmpFile.delete();
			}
			return state;
		} catch (IOException localIOException) {
		}
		return new BaseState(false, 4);
	}

	private static File getTmpFile() {
		File tmpDir = FileUtils.getTempDirectory();
		double d = Math.random() * 10000.0D;
		String tmpFileName = String.valueOf(d).replace(".", "");
		return new File(tmpDir, tmpFileName);
	}

	private static State saveTmpFile(File tmpFile, String path) {
		State state = null;
		File targetFile = new File(path);
		if (targetFile.canWrite())
			return new BaseState(false, 2);
		try {
			FileUtils.moveFile(tmpFile, targetFile);
		} catch (IOException e) {
			return new BaseState(false, 4);
		}
		state = new BaseState(true);
		state.putInfo("size", targetFile.length());
		state.putInfo("title", targetFile.getName());
		return state;
	}

	private static State valid(File file) {
		File parentPath = file.getParentFile();
		if ((!parentPath.exists()) && (!parentPath.mkdirs())) {
			return new BaseState(false, 3);
		}
		if (!parentPath.canWrite()) {
			return new BaseState(false, 2);
		}
		return new BaseState(true);
	}

	/** * �ϴ�FTP�ļ� * @param is * @param path * @param maxSize * @return */
	public static State saveFtpFileByInputStream(InputStream is,
			String remoteDir, String path, long maxSize, boolean keepLocalFile) {
		State state = null;
		File tmpFile = getTmpFile();
		byte[] dataBuf = new byte[2048];
		BufferedInputStream bis = new BufferedInputStream(is, 8192);
		try {
			BufferedOutputStream bos = new BufferedOutputStream(
					new FileOutputStream(tmpFile), 8192);
			int count = 0;
			while ((count = bis.read(dataBuf)) != -1) {
				bos.write(dataBuf, 0, count);
			}
			bos.flush();
			bos.close();
			if (tmpFile.length() > maxSize) {
				tmpFile.delete();
				return new BaseState(false, 1);
			}
			state = saveFtpTmpFile(tmpFile, remoteDir, path, keepLocalFile);
			if (!state.isSuccess()) {
				tmpFile.delete();
			}
			return state;
		} catch (IOException localIOException) {
		}
		return new BaseState(false, 4);
	}

	private static State saveFtpTmpFile(File tmpFile, String remoteDir,
			String path, boolean keepLocalFile) {
		State state = null;
		File targetFile = new File(path);
		if (targetFile.canWrite())
			return new BaseState(false, 2);
		try {
			FileUtils.moveFile(tmpFile, targetFile);
		} catch (IOException e) {
			return new BaseState(false, 4);
		}
		try {
			FileToFTP t = new FileToFTP();
			t.connect("");
			if (!t.uploadWithRemoteDir(remoteDir, targetFile)) {
				return new BaseState(false, 4);
			}
		} catch (Exception e) {
			return new BaseState(false, 4);
		}
		try {
			if (!keepLocalFile)
				targetFile.delete();
		} catch (Exception e) {
		}
		state = new BaseState();
		state.putInfo("size", targetFile.length());
		state.putInfo("title", targetFile.getName());
		return state;
	}
}