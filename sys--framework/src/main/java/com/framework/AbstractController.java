package com.framework;

import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;

import com.constants.InfoConstants.CodeInfo;
import com.framework.returnObj.Infos;
import com.framework.validation.EValidator;
import com.framework.validation.Validation;

/**
 * 说 明     : 抽象控制类
 * to do : Infos 对象未隐藏	
 * author: 陆湘星
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 **/
public class AbstractController {
	public Infos init(HttpServletRequest request,AbstractCondtion cond) {
		String fromUrl = request.getRequestURI();
		StackTraceElement[] stacks = new Throwable().getStackTrace(); 
		String clazzName = stacks[1].getClassName();
		String method = stacks[1].getMethodName();
		return new Infos(fromUrl,clazzName,method,cond.toString());
	}
	public Infos init(HttpServletRequest request,String condStr) {
		String fromUrl = request.getRequestURI();
		StackTraceElement[] stacks = new Throwable().getStackTrace(); 
		String clazzName = stacks[1].getClassName();
		String method = stacks[1].getMethodName();
		return new Infos(fromUrl,clazzName,method,condStr);
	}
	
	public boolean doValidate(Infos infos){
		boolean flag = true;
			Method[] methods =this.getClass().getDeclaredMethods();//返回一个包含方法对象的数组
			ms:for(Method m : methods){//循环该类的每个方法
				 if(m.getName().equals(infos.getMethod())){
					  EValidator validator = m.getAnnotation(EValidator.class);
					  if(validator!=null&&validator.value()!=null&&!"".equals(validator.value())){
						  String expression = validator.value();
						  Validation validation = new Validation(infos); 
						  validation.doValidation(expression);
						  flag = validation.getResult();
					  }
					break ms;
			     }
		  }
		return flag;
	}
	public void printException(Infos infos,CodeInfo codeInfo,String msg,Throwable e){
		infos.printLogExceptionLog(codeInfo, msg, e);
	}
	public void printException(Infos infos,CodeInfo codeInfo,Throwable e){
		printException(infos, codeInfo,"", e);
	}
	
	public void setReturnObj(Infos infos,Object data){
		infos.setReturnObj(data);
	}
	
	
	public String returnResultJson(Infos infos){
		return infos.getReturnJson();
	}
	
	
	
}
