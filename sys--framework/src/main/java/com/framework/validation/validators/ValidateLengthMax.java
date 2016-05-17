/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;

import com.framework.validation.Field;


public class ValidateLengthMax extends AbstractValidator{

	public void doValidator(List<Field> fields, List<String> args, boolean isAll) {
		if(args.size()>0 ){
			int maxLen = Integer.parseInt(args.get(0));
			for (int i = 0; i < fields.size(); i++) {
				if(i==0 || result || isAll){
					Field field = fields.get(i);
					if(field.getValue()!=null && !"".equals(field.getValue())){
						if(field.getValue().toString().length()>maxLen){
							result = false;
							msg +=field.getFieldDesc()+"：长度不能大于 "+maxLen+" !";	
						}
						
					}
				}
			}	
		}
	}


}
