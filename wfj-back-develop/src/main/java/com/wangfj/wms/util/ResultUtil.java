package com.wangfj.wms.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.wangfj.wms.util.ErrorCodeConstants.ErrorCode;

/**
 * 说明:
 * @author chengsj
 * @date 2013-5-29 下午02:18:58
 * @modify 
 */
public class ResultUtil {
	/**
	 * 
	 * @Methods Name createKey
	 * @Create In 2013-10-25 By Administrator
	 * @param constant
	 * @return String
	 */
	public static String createKey(String constant) {
		StringBuffer sb = new StringBuffer();
		sb.append(constant);
		return Codec.encodeMd5(sb.toString());
	}
	
	/**
	 * 
	 * @Methods Name createKey
	 * @Create In 2013-10-25 By Administrator
	 * @param key
	 * @param constant
	 * @return String
	 */
	public static String createKey(String key, String constant) {
		StringBuffer sb = new StringBuffer();
		sb.append(constant).append(".").append(key);
		return Codec.encodeMd5(sb.toString());
	}

	 /**
     * 说明:
     *    构造单品主键的key-- md5(类名+方法名+参数值)
     *    根据单品主键构造getProduct(sid)方法缓存的key
     *
     * @param productSid
     * @return
     */
    public static String createProductKey(String productSid,String cacheKey){
        StringBuffer sb = new StringBuffer();
        sb.append(cacheKey)
                .append(".")
                .append(productSid);
        return Codec.encodeMd5(sb.toString());
    }
	
	
	/**
	 * 说明：
	 *      
	 * @Create In 2013-8-15 By chengsj
	 * @param success
	 * @param memo
	 * @return String
	 */
	public static String createCommonVisibleResult(String success, String memo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", success);
		resultMap.put("memo", memo);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	public static String createSuccessResult() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", "true");
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	public static String createSuccessResult(Object obj) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", "true");
		resultMap.put("obj", obj);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	public static String createSuccessResultPage(Object obj) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", "true");
		resultMap.put("result", obj);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	
	public static String createSuccessResult(List list) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", "true");
		resultMap.put("list", list);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	public static String createSuccessResultJson(List list) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", "true");
		resultMap.put("result", list);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	public static String createSuccessResult(Page page) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", "true");
		resultMap.put("page", page);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	public static String createFailureResult(String errorCode, String memo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("success", "false");
		resultMap.put("errorCode", errorCode);
		resultMap.put("memo", memo);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		String json = gson.toJson(resultMap);
		return json;
	}
	
	public static String createFailureResult(Exception e) {
		String json = "";
		String exceptionMethod = e.getClass().getName();
		if("com.shopin.core.framework.exception.ShopinException".equals(exceptionMethod)) {
			String[] errorArray = e.getMessage().trim().split("_");
			json = ResultUtil.createFailureResult(errorArray[0], errorArray[1]);
		} else if("java.lang.NumberFormatException".equals(exceptionMethod) 
				|| "java.lang.NullPointerException".equals(exceptionMethod)) {
			json = ResultUtil.createFailureResult(ErrorCode.PARAM_ERROR.getErrorCode(), e.toString());
		} else if("org.springframework.dao.DuplicateKeyException".equals(exceptionMethod)) {
			json = ResultUtil.createFailureResult(ErrorCode.DUPLICATE_KEY_ERROR.getErrorCode(), e.toString());
		} else {
			json = ResultUtil.createFailureResult(ErrorCode.SYSTEM_ERROR.getErrorCode(), e.toString());
		}
		return json;
	}
}
