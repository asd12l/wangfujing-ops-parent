/**
 * 说 明  :
 * author: 陆湘星
 * data  : 2011-5-19
 * email : xiangxingchina@163.com
 **/

package com.framework.validation.validators;

import java.util.List;


import com.framework.validation.Field;

public class ValidateTypeDate extends AbstractValidator{

	public void doValidator(List<Field> fields, List<String> args, boolean isAll) {
		for (int i = 0; i < fields.size(); i++) {
			if(i==0 || result || isAll){
				Field field = fields.get(i);
				String value = (String) field.getValue();
				if(value!=null && !"".equals(value) && value.length() > 0 ){
					String df  = "yyyy-MM-DD";// 默认格式 ; 
					String df1  = "yyyyMMDD";// 默认格式 ;
					String df2  = "yyyy-MM-DD HH:MM:SS";// 默认格式 ;
					
					boolean flag = false;
					try {
						new java.text.SimpleDateFormat(df).parse(value);
						flag = true;
					} catch(Exception ex) {
						flag = false;
					}

					if(!flag){
						try {
							new java.text.SimpleDateFormat(df1).parse(value);
							flag = true;
						} catch(Exception ex) {
							flag = false;
						}
					}		
					
					if(!flag){
						try {
							new java.text.SimpleDateFormat(df2).parse(value);
							flag = true;
						} catch(Exception ex) {
							flag = false;
						}
					}		
					if(!flag){
						result = false;
						 msg += field.getFieldDesc() + "：输入值不是有效的日期,正确格式为:" + df +" 或  " +df1+" 或  " + df2;
					}
							
					
					 
					 
				}
			}
		}	
	}

}
