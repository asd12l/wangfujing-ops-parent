package com.framework.validation;

import com.constants.InfoConstants.CodeInfo;
import com.framework.AbstractCondtion;
import com.framework.returnObj.Infos;

/**
 * 说 明     : 验证器
 * author: 陆湘星
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 **/
public class Validation {
	private  Infos infos = null;
	AbstractCondtion cond = null;
	private  boolean result =  true ;
	public Validation(Infos infos) {
		this.infos = infos; 
		this.cond = infos.getCond();
	}
	/**
	 * 扩展验证框架 
	 * @return
	 */
	public void doValidation(String expression){
		if(result && cond!=null ){
			ValidationFramework validation = new ValidationFramework();
			validation.doValidation(cond, expression);
			if(!validation.getResult()){
				result = false;
				infos.printLogInfo(CodeInfo.验证没通过,validation.getMessage());
			}
		}
	}
	public boolean getResult() {
		return result;
	}
	
	
}
