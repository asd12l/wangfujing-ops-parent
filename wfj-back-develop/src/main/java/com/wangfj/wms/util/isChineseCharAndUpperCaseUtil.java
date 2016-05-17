package com.wangfj.wms.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class isChineseCharAndUpperCaseUtil {
	
	  // 判断是否是中文true是中文    false不是中文或者包含字母
	  public static boolean isChinese(String str){
		  char[] cha  = str.toCharArray();
		  for(int i=0;i<cha.length;i++){
			  Pattern pattern = Pattern.compile("[\u4e00-\u9fa5]");
			  Matcher matcher =  pattern.matcher(cha[i]+"");
			  if(matcher.find()){
				  continue;
			  }else{
				  return false;
			  }
		  }
		  return true;
	  }
	  //小写转换大写
	  public static String upperCase(String str){
		  String toCase = "";
		  try{
			  if(false == isChinese(str)){
				  toCase  =  str.toUpperCase();
				  }else{
					  return str.hashCode()+"";
				  }
		  }catch(Exception e){
			  return str;
		  }
		 
		  return toCase;
	  }
}
