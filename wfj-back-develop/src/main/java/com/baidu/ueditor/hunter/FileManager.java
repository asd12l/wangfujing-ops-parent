package com.baidu.ueditor.hunter;

import com.baidu.common.util.FileToFTP;
import com.baidu.ueditor.PathFormat;
import com.baidu.ueditor.define.BaseState;
import com.baidu.ueditor.define.MultiState;
import com.baidu.ueditor.define.State;
import com.constants.SystemConfig;

import java.io.File;
import java.util.Arrays;
import java.util.Collection;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;

public class FileManager
{
  private String dir = null;
  private String rootPath = null;
  private String[] allowFiles = null;
  private int count = 0;
  private HttpServletRequest request = null;
  
  public FileManager(Map<String, Object> conf)
  {
    this.rootPath = "http://"+SystemConfig.FTP_HOST;
    this.dir = (this.rootPath + (String)conf.get("dir"));
    this.allowFiles = getAllowFiles(conf.get("allowFiles"));
    this.count = ((Integer)conf.get("count")).intValue();
  }
  
  public FileManager(Map<String, Object> conf, HttpServletRequest request)
  {
    this.rootPath = "http://"+SystemConfig.FTP_HOST;
    this.dir = (this.rootPath + (String)conf.get("dir"));
    this.allowFiles = getAllowFiles(conf.get("allowFiles"));
    this.count = ((Integer)conf.get("count")).intValue();
    this.request = request;
  }

  public State listFile(int index)
  {
    /*File dir = new File(this.dir);*/
    State state = null;

    /*if (!dir.exists()) {
      return new BaseState(false, 302);
    }

    if (!dir.isDirectory()) {
      return new BaseState(false, 301);
    }*/

    Collection list = new FileToFTP().getImgFromDatabase(request);

    if ((index < 0) || (index > list.size())) {
      state = new MultiState(true);
    } else {
      Object[] fileList = Arrays.copyOfRange(list.toArray(), index, index + this.count);
      state = getState(fileList);
    }

    state.putInfo("start", index);
    state.putInfo("total", list.size());

    return state;
  }

  private State getState(Object[] files)
  {
    MultiState state = new MultiState(true);
    BaseState fileState = null;

    File file = null;

    for (Object obj : files) {
      if (obj == null) {
        break;
      }
      file = (File)obj;
      fileState = new BaseState(true);
      fileState.putInfo("url", PathFormat.format(getPath(file)));
      state.addState(fileState);
    }

    return state;
  }

  private String getPath(File file)
  {
    String path = file.getAbsolutePath();

    return path.replace(this.rootPath, "/");
  }

  private String[] getAllowFiles(Object fileExt)
  {
    String[] exts = null;
    String ext = null;

    if (fileExt == null) {
      return new String[0];
    }

    exts = (String[])fileExt;

    int i = 0; for (int len = exts.length; i < len; i++)
    {
      ext = exts[i];
      exts[i] = ext.replace(".", "");
    }

    return exts;
  }
}