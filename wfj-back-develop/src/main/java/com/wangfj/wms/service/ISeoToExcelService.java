package com.wangfj.wms.service;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

public interface ISeoToExcelService {
	
	public String seoDataConvertToExcel(HttpServletResponse response,
			 String title,Map<String,Object> map);
}
