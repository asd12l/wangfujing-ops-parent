
/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;


import com.framework.validation.Field;

public class ValidateTypeTelephone extends AbstractValidator{

	public void doValidator(List<Field> fields, List<String> args, boolean isAll) {
		for (int i = 0; i < fields.size(); i++) {
			if(i==0 || result || isAll){
				Field field = fields.get(i);
				String value = (String) field.getValue();
				if(value!=null && !"".equals(value)){
						if(!value.matches("^((0[1-9]{3})?(0[12][0-9])?[-])?\\d{6,8}$")) {
							result = false;
							msg +=field.getFieldDesc()+"：只能输入正确的固定电话号码,如:0920-29392929  ";	
						}
				}
			}
		}	
	}

}
