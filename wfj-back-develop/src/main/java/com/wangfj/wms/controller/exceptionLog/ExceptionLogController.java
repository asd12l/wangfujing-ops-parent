package com.wangfj.wms.controller.exceptionLog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.framework.page.Page;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.controller.stockSearch.support.ProductPagePara;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/exceptionLog")
public class ExceptionLogController {
	/**
	 * 异常
	 * @Methods Name queryExceptionLog
	 * @Create In 2015-9-10 By chenhu
	 * @param request
	 * @param response
	 * @param uuid
	 * @param startTimeStr
	 * @param endTimeStr
	 * @param exceptionType
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/queryExceptionLog",method={RequestMethod.GET,RequestMethod.POST})
	public String queryExceptionLog(HttpServletRequest request, HttpServletResponse response, String uuid,
			String startTimeStr, String endTimeStr, String exceptionType){
		String json = "";
		Integer size = request.getParameter("pageSize") == null ? null : Integer.valueOf(Integer
				.parseInt(request.getParameter("pageSize")));
		Integer currPage = request.getParameter("page") == null ? null : Integer.valueOf(Integer
				.parseInt(request.getParameter("page")));
		if(size==null || size==0){
			size = 10;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		if(null != uuid && !"".equals(uuid)){
			map.put("uuid", uuid);
		}
		if(null != startTimeStr && !"".equals(startTimeStr)){
			map.put("startTimeStr", startTimeStr);
		}
		if(null != endTimeStr && !"".equals(endTimeStr)){
			map.put("endTimeStr", endTimeStr);
		}
		if(null != exceptionType && !"".equals(exceptionType)){
			map.put("exceptionType", exceptionType);
		}
		map.put("currentPage", currPage);
		map.put("pageSize", size);
		
		String str = JsonUtil.getJSONString(map);
		try{
			json =  HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL+"/pcmExceptionLog/queryExceptionLog.htm", str);
			map.clear();
			if (!"".equals(json)) {
				JSONObject jsonObject = JSONObject.fromObject(json);
				JSONObject jsonPage = (JSONObject) jsonObject.get("data");
				if (jsonPage != null) {
					map.put("list", jsonPage.get("list"));
					map.put("pageCount", jsonPage.get("pages") == null ? Integer.valueOf(0)
							: jsonPage.get("pages"));
				} else {
					map.put("list", null);
					map.put("pageCount", Integer.valueOf(0));
				}
			} else {
				map.put("list", null);
				map.put("pageCount", Integer.valueOf(0));
			}
		} catch (Exception e) {
			map.put("pageCount", Integer.valueOf(0));
		}

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		return gson.toJson(map);
	}

}
