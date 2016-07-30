package com.wangfj.edi.util;


import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;


public class PropertiesUtil extends  PropertyPlaceholderConfigurer{
	private static Map<String, Object> ctxPropertiesMap;  
	  
    @Override  
    protected void processProperties(ConfigurableListableBeanFactory beanFactoryToProcess, Properties props) throws BeansException {  
        super.processProperties(beanFactoryToProcess, props);  
        ctxPropertiesMap = new HashMap<String, Object>();  
        for (Object key : props.keySet()) {  
            String keyStr = key.toString();  
            String value = props.getProperty(keyStr);  
            ctxPropertiesMap.put(keyStr, value);  
        }  
    }  
  
    public static Object getContextProperty(String name) {  
        return ctxPropertiesMap.get(name);  
    }
    /**
     * 使用介绍
     * @param s
     */
    public static void main(String s[]){
    	PropertiesUtil.getContextProperty("jdbc.username");
    }
    public static String readValue(String filePath, String key) {
		Properties props = new Properties();
		try {
			InputStream in = new BufferedInputStream(new FileInputStream(
					filePath));
			props.load(in);
			return props.getProperty(key);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static Properties getProperties(String filePath){
		Properties props=new Properties();
		try {
			InputStream in = new BufferedInputStream(new FileInputStream(
					filePath));
			props.load(in);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return props;
	}
	/**
	 * 获取配置文件
	 * @param filePath
	 * @return
	 */
	public static Properties getProperties2(String filePath){
		Properties props = new Properties();
		ClassLoader loader = PropertiesUtil.class.getClassLoader();
		InputStream is = loader.getResourceAsStream(filePath);
		try {
			props.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (is != null) {
					is.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return props;
	}
	/**
	 * 获取指定路径下的配置文件里指定key值的value值
	 * @param filePath
	 * @param key
	 * @return
	 */
	public static String getDestValue(String filePath,String key){
		Properties props = new Properties();
		ClassLoader loader = PropertiesUtil.class.getClassLoader();
		InputStream is = loader.getResourceAsStream(filePath);
		try {
			props.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (is != null) {
					is.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return props.getProperty(key);
	}
}
