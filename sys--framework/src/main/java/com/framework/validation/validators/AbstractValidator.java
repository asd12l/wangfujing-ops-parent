/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;

import com.framework.validation.Field;


public abstract class AbstractValidator {
	boolean result = true;
	String msg = "";
	public abstract void doValidator(List<Field> fields,List<String> args,boolean isAll);
	public  boolean getResult(){
		return result;
	}
	public  String  getMessage(){
		return msg;
	}
}
