package com.baidu.ueditor.define;

import java.util.HashMap;
import java.util.Map;

public final class AppInfo
{
  public static final int SUCCESS = 0;
  public static final int MAX_SIZE = 1;
  public static final int PERMISSION_DENIED = 2;
  public static final int FAILED_CREATE_FILE = 3;
  public static final int IO_ERROR = 4;
  public static final int NOT_MULTIPART_CONTENT = 5;
  public static final int PARSE_REQUEST_ERROR = 6;
  public static final int NOTFOUND_UPLOAD_DATA = 7;
  public static final int NOT_ALLOW_FILE_TYPE = 8;
  public static final int INVALID_ACTION = 101;
  public static final int CONFIG_ERROR = 102;
  public static final int PREVENT_HOST = 201;
  public static final int CONNECTION_ERROR = 202;
  public static final int REMOTE_FAIL = 203;
  public static final int NOT_DIRECTORY = 301;
  public static final int NOT_EXIST = 302;
  public static final int ILLEGAL = 401;
  public static Map<Integer, String> info = new HashMap();
  static {
	  info.put(0, "SUCCESS");
	  info.put(1, "图片太大");
	  info.put(2, "没有权限");
	  info.put(3, "创建队列失败");
	  info.put(4, "IO流错误");
	  info.put(5, "NOT_MULTIPART_CONTENT");
	  info.put(6, "解析请求错误");
	  info.put(7, "找不到上传图片");
	  info.put(8, "图片类型错误");
	  info.put(101, "操作无效");
	  info.put(102, "配置错误");
	  info.put(201, "主机阻止");
	  info.put(202, "连接错误");
	  info.put(203, "远程连接失败");
	  info.put(301, "目录找不到");
	  info.put(302, "图片不存在");
	  info.put(401, "非法操作");
	  info.put(9, "图片尺寸不符");
  }

  public static String getStateInfo(int key)
  {
    return (String)info.get(Integer.valueOf(key));
  }
}