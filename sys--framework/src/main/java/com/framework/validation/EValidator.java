package com.framework.validation;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 说 明     : 验证信息注解标签
 * author: 陆湘星
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 **/
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface EValidator {
	/**
	 * 验证规则的值, 编写规则为: "字段1表单名,字段1中文名,字段1规则1 字段1规则2;字段2表单名,字段2中文名,字段2规则1 字段2规则2;", 示例:
	 * username,用户名,required min-length-5;password,密码,required;password2,重复密码,required equals-password
	 * @return 验证器的详细值
	 */
	public String value() default "";
	public boolean enabled() default true;
}
