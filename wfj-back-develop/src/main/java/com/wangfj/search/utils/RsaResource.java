package com.wangfj.search.utils;

import java.io.IOException;

import org.apache.commons.io.IOUtils;
import org.springframework.context.ResourceLoaderAware;
import org.springframework.core.io.ResourceLoader;

public class RsaResource implements ResourceLoaderAware {
	 private ResourceLoader resourceLoader;
	@Override
	public void setResourceLoader(ResourceLoader resourceLoader) {
		 this.resourceLoader = resourceLoader;
	}
	public String get(){
		String rsa=null;
		try {
			rsa = IOUtils.toString(resourceLoader.getResource("classpath:rsaKey").getInputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rsa;
	} 
}
