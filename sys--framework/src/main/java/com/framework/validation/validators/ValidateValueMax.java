
/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;


import com.framework.validation.Field;

public class ValidateValueMax extends AbstractValidator{

	public void doValidator(List<Field> fields, List<String> args, boolean isAll) {
		if(args.size()>0 ){
			Integer maxVal = null;
			try {
				maxVal = Integer.parseInt(args.get(0));
			} catch (Exception e) {
				
			}
			
			if(maxVal!=null){
				for (int i = 0; i < fields.size(); i++) {
					if(i==0 || result || isAll){
						Field field = fields.get(i);
						if(field.getValue()!=null && !"".equals(field.getValue())){
							Integer val = null;
							try {
								 val = Integer.parseInt((String) field.getValue());
							} catch (Exception e) {
								result = false;
								msg +=field.getFieldDesc()+"：类型转换出错 !";	
							}
							
							if( val!=null && val>maxVal ){
								result = false;
								msg +=field.getFieldDesc()+"：值不能大于 "+maxVal+" !";	
							}
							
						}
					}
				}		
			}
		}
	}


}
