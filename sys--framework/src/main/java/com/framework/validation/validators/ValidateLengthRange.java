/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;

import com.framework.validation.Field;



public class ValidateLengthRange  extends AbstractValidator{

	public void doValidator(List<Field> fields, List<String> args, boolean isAll) {
		if(args.size()>=2 ){
			int maxLen = 0;
			int minLen = 0;
			try{
				int rangeLen1 = Integer.parseInt(args.get(0));
				int rangeLen2 = Integer.parseInt(args.get(1));
				if(rangeLen1<rangeLen2){
					minLen = rangeLen1;
					maxLen = rangeLen2;
				}else{
					minLen = rangeLen2;
					maxLen = rangeLen1;
				}
			}catch (Exception e) {
			}
			
			for (int i = 0; i < fields.size(); i++) {
				if(i==0 || result || isAll){
					Field field = fields.get(i);
					if(field.getValue()!=null && !"".equals(field.getValue())){
						if( field.getValue().toString().length() < minLen || field.getValue().toString().length() > maxLen	){
							result = false;
							msg +=field.getFieldDesc()+"：长度必须在 "+minLen+"和"+maxLen+"之间 !";	
						}
					}
				}
			}	
			
		}
	
	}

	
}
