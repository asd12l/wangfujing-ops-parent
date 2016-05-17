package com.wangfj.wms.controller.Season;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

/**
 * 季节控制器
 * 
 * @Class Name SeasonController
 * @Author wangsy
 * @Create In 2015年8月20日
 */
@Controller
@RequestMapping(value = "/season")
public class SeasonController {

	/**
	 * 查询季节列表
	 * 
	 * @Methods Name findSeasonDict
	 * @Create In 2015年8月20日 By wangsy
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/findSeasonDict", method = { RequestMethod.GET, RequestMethod.POST })
	public String findSeasonDict() {
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/season/selectList.htm",
					JsonUtil.getJSONString(map));
		} catch (Exception e) {
			map.put("list", null);
			map.put("pageCount", 0);
		}
		return json;
	}
}
