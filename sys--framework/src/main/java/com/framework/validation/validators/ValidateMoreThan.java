
/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;


import com.framework.validation.Field;

public class ValidateMoreThan   extends AbstractValidator{

	public void doValidator(List<Field> fields, List<String> args, boolean isAll) {
		if(fields!=null && fields.size()>=2){
			Integer val0 = null;
			Integer val1 = null;
			try {
				String valStr0 =( (String) fields.get(0).getValue()).replace("-", "").replace("/" ,"").replace(" " ,""); 
				val0 = Integer.parseInt(valStr0);
			} catch (Exception e) {
				result = false;
				msg = fields.get(0).getFieldDesc()+"：类型转换出错！";
			}
			try {
				String valStr1 =( (String) fields.get(1).getValue()).replace("-", "").replace("/" ,"").replace(" " ,""); 
				val1 = Integer.parseInt(valStr1);
			} catch (Exception e) {
				result = false;
				msg = fields.get(1).getFieldDesc()+"：类型转换出错！";
			}
			
			if(val0!=null && val1 !=0){
				if(val0<=val1){
					result = false;
					msg = fields.get(0).getFieldDesc()+"：必须大于 "+fields.get(1).getFieldDesc()+"！";
				}
			}
		}
	}
	
}
