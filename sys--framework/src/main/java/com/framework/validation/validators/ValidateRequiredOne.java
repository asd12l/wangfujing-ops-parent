
/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;


import com.framework.validation.Field;

public class ValidateRequiredOne extends AbstractValidator{

	public void doValidator(List<Field> fields, List<String> args, boolean isAll) {
		if(fields!=null && fields.size()>0){
			boolean  flag = false;
			String name = "";
			for (int i = 0; i < fields.size(); i++) {
					Field field = fields.get(i);
					if(field.getValue()!=null && !"".equals(field.getValue())){
						flag = true;
					}
					if(i!=0) name+=",";
					name += field.getFieldDesc();
			}
			if(!flag) {
					result = false;
					msg =name+"：至少有一个不能为空!";
			}
			
		}
		
	}

	
}
