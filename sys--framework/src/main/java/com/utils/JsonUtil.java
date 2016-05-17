package com.utils;

import java.io.IOException;
import java.text.SimpleDateFormat;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;

/**
 * 说 明     : json 工具类
 * author: 陆湘星
 * data  : 2012-12-12
 * email : xiangxingchina@163.com
 **/
public class JsonUtil {
	public static String Object2Json(Object obj){
	return Object2Json(obj, false);
	}

	public static String Object2Json(Object obj, boolean debug){
		return Object2Json(obj, true, debug);
	}

	public static String Object2Json(Object obj, boolean dateFormat,
			boolean debug){
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
		if (dateFormat)
			mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
		try {
			if (!debug)
				return mapper.writeValueAsString(obj);
			else
				return mapper.defaultPrettyPrintingWriter().writeValueAsString(
						obj);
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static <T> T  Json2Object(String jsonStr, Class<T> t){
		ObjectMapper mapper = new ObjectMapper();
		try {
			return  mapper.readValue(jsonStr, t);
		} catch (JsonParseException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
//>>jsckson去掉对象的null属性
//@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
