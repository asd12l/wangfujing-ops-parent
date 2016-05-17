package com.wangfj.cms.utils;

import com.alibaba.fastjson.JSONObject;
import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import common.Logger;

public class CdnHelper {

	private static final Logger logger = Logger.getLogger(CdnHelper.class);
	
	/**
     * 刷新CDN
     * 
     * @Methods Name flushCDN
     * @Create In 2016-3-26 By yangsj
     * @param ip
     * @param port
     * @param flushPath
     * @return String
     */
    public static boolean flushCdn(String cdnUrl, String[] flushPath) {
    	if(!SystemConfig.ISCDNENABLE){
    		return true;
    	}
        if (flushPath == null || flushPath.equals("") || flushPath.length < 1) {
            return false;
        }
        StringBuffer buffer = new StringBuffer();
        for (int i = 0; i < flushPath.length; i++) {
            if (i == flushPath.length - 1) {
                buffer.append(flushPath[i]);
            } else {
                buffer.append(flushPath[i]).append(" ");
            }
        }
        JSONObject json = new JSONObject();
        json.put("flushPath", buffer.toString());
        String result = "";
        try {
            result = HttpUtil.doPost(cdnUrl, json.toString());
        } catch (Exception e) {
            int length = e.getStackTrace().length - 1;
            StringBuffer errorbUffer = new StringBuffer();
            errorbUffer.append("osp请求刷新CND服务  参数   ip:").append(cdnUrl)
                    .append(" flushPath：").append(buffer).append(System.getProperty("line.separator"))
                    .append(e.getStackTrace()[length].getFileName()).append(System.getProperty("line.separator"))
                    .append(e.getStackTrace()[length].getLineNumber()).append(System.getProperty("line.separator"))
                    .append(e.getStackTrace()[length].getMethodName());
            logger.debug(errorbUffer);
            return false;
        }
        return Boolean.getBoolean(result);
    }
    
}
