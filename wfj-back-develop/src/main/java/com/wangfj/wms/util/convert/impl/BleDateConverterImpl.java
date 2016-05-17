package com.wangfj.wms.util.convert.impl;

import java.lang.reflect.Type;
import java.util.Date;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;
import com.thoughtworks.xstream.converters.basic.DateConverter;
import com.wangfj.wms.util.convert.BleDateConverter;

/**
 * 日期格式转换,用于支持各种不同的日期转换,配合@XStreamConverter一起使用
 * 
 * @author wangchaochao
 *
 */

public class BleDateConverterImpl extends DateConverter implements
		JsonSerializer<Date>, JsonDeserializer<Date>, BleDateConverter {

	private static final String defaultDateFormat = "yyyy-MM-dd HH:mm:ss";

	private static final String[] dateFormats = new String[] {
			"yyyy-MM-dd'T'HH:mm:ss.SSSZ", "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd" };

	/**
	 * 
	 * 
	 * @XStreamConverter(value = BleDateConverter.class)
	 * 
	 * @param dateFormat
	 */
	public BleDateConverterImpl(String dateFormat) {
		super(dateFormat, dateFormats);
	}

	/**
	 * @XStreamConverter(value = BleDateConverter.class,
	 *                         strings={"yyyyMMdd'T'HH:mm:ss"})
	 */
	public BleDateConverterImpl() {
		super(defaultDateFormat, dateFormats);
	}

	@Override
	public Date deserialize(JsonElement json, Type typeOfT,
			JsonDeserializationContext context) throws JsonParseException {
		return new Date(json.getAsJsonPrimitive().getAsLong());
	}

	@Override
	public JsonElement serialize(Date date, Type typeOfSrc,
			JsonSerializationContext context) {
		return new JsonPrimitive(date.getTime());
	}

}
