package com.wangfj.cms.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;

public class FileUtil {

    /**
     * 
     * @Methods Name unZipFiles 解压zip文件
     * @Create In 2015年11月12日 By chengxp
     * @param zipFile
     * @param descDir
     *            void
     */
    public void unZipFiles(File zipFile, String destPath) {
    	ZipFile zip = null;
        try {
            File pathFile = new File(destPath);
            if (!pathFile.exists()) {
                pathFile.mkdirs();
            }
           zip = new ZipFile(zipFile);
            for (Enumeration entries = zip.getEntries(); entries.hasMoreElements();) {
                ZipEntry entry = (ZipEntry) entries.nextElement();
                String zipEntryName = entry.getName();
                InputStream in = zip.getInputStream(entry);
                String outPath = (destPath + zipEntryName).replaceAll("\\*", "/");
                File file = new File(outPath.substring(0, outPath.lastIndexOf('/')));
                if (!file.exists()) {
                    file.mkdirs();
                }
                if (new File(outPath).isDirectory()) {
                    continue;
                }
                OutputStream out = new FileOutputStream(outPath);
                byte[] buf1 = new byte[1024];
                int len;
                while ((len = in.read(buf1)) > 0) {
                    out.write(buf1, 0, len);
                }
                in.close();
                out.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
        	if(zip!=null){
        		try {
					zip.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
        	}
        }
    }

    public boolean deleteDir(File dir) {
        boolean success = false;
        try {
            if (dir.isDirectory()) {
                String[] children = dir.list();
                for (int i = 0; i < children.length; i++) {
                    success = deleteDir(new File(dir, children[i]));
                    if (!success)
                        return success;
                }
            }
            success = dir.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

}
