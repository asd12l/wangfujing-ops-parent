package com.wangfj.wms.controller.organization;

import com.constants.SystemConfig;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.utils.StringUtils;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by wangxuan on 2016-08-29 0029.
 */
@Controller
@RequestMapping(value = {"/storeInfo"})
public class StoreInfoController {

    /**
     * 查询门店信息list
     *
     * @param request
     * @param response
     * @param organizationCode
     * @param groupSid
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/queryListStoreInfo", method = {RequestMethod.GET,
            RequestMethod.POST})
    public String queryListOrganization(HttpServletRequest request, HttpServletResponse response,
                                        String organizationCode, String groupSid) {

        Map<String, Object> map = new HashMap<String, Object>();

        if (StringUtils.isNotEmpty(organizationCode)) {
            map.put("organizationCode", organizationCode.trim());
        }

        if (StringUtils.isNotEmpty(groupSid)) {
            map.put("groupSid", Long.parseLong(groupSid.trim()));
        }

        String json = "";
        try {
            json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL
                    + "/storeInfo/findListStoreInfo.htm", JsonUtil.getJSONString(map));
            map.clear();
            JSONObject jsonObject = JSONObject.fromObject(json);
            List<Object> list = (List<Object>) jsonObject.get("data");
            if (list != null && list.size() != 0) {
                map.put("list", list);
                map.put("success", "true");
            } else {
                map.put("success", "false");
            }

        } catch (Exception e) {
            map.put("success", "false");
        }
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
        return gson.toJson(map);
    }

}
