/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;


import com.framework.validation.Field;

public class ValidateValueRange extends AbstractValidator{

	public void doValidator(List<Field> fields, List<String> args, boolean isAll) {
		
		if(args.size()>=2 ){
			Integer maxVal = null;
			Integer minVal = null;
			try{
				int rangeLen1 = Integer.parseInt(args.get(0));
				int rangeLen2 = Integer.parseInt(args.get(1));
				if(rangeLen1<rangeLen2){
					minVal = rangeLen1;
					maxVal = rangeLen2;
				}else{
					maxVal = rangeLen1;
					minVal = rangeLen2;
				}
			}catch (Exception e) {
				
			}
			
			
			if(maxVal!=null&&minVal!=null){
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
							
							if( val < minVal || val > maxVal	){
								result = false;
								msg +=field.getFieldDesc()+"：值必须在 "+minVal+"和"+maxVal+"之间 !";	
							}
							
						}
					}
				}	
			}
			
		}
	}

}
