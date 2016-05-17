package com.baidu.ueditor.define;

import java.util.HashMap;
import java.util.Map;

public final class ActionMap
{
  public static final Map<String, Integer> mapping = new HashMap();
  static { 
	  mapping.put("config", 0); 
	  mapping.put("uploadimage", 1); 
	  mapping.put("uploadscrawl", 2); 
	  mapping.put("uploadvideo", 3); 
	  mapping.put("uploadfile", 4); 
	  mapping.put("cachimage", 5); 
	  mapping.put("listfile", 6);
	  mapping.put("listimage", 7); 
  } 
  public static final int CONFIG = 0;
  public static final int UPLOAD_IMAGE = 1;
  public static final int UPLOAD_SCRAWL = 2;
  public static final int UPLOAD_VIDEO = 3;
  public static final int UPLOAD_FILE = 4;
  public static final int CATCH_IMAGE = 5;
  public static final int LIST_FILE = 6;
  public static final int LIST_IMAGE = 7;

  public static int getType(String key) { return ((Integer)mapping.get(key)).intValue();
  }
}