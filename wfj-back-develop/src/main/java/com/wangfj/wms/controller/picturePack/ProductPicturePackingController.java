package com.wangfj.wms.controller.picturePack;

import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.tools.zip.ZipOutputStream;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.wms.util.DownPackZipUtil;
import com.wangfj.wms.util.HttpUtilPcm;
import com.wangfj.wms.util.JsonUtil;

@Controller
@RequestMapping(value = "/proPicPack")
public class ProductPicturePackingController {
    
    
    @ResponseBody
    @RequestMapping(value = "/picPacking", method = {RequestMethod.GET, RequestMethod.POST})
    public String execute(HttpServletRequest request, HttpServletResponse response,
    		String spuCode, String colorCode) {  
        //生成的ZIP文件名为Demo.zip    
        String tmpFileName = spuCode + "_" + colorCode + ".zip";    
        String strZipPath ="/" + tmpFileName;    
        try {
            ZipOutputStream out = new ZipOutputStream(new FileOutputStream(strZipPath));    
            Map<String, Object> proMap = new HashMap<String, Object>();
            proMap.put("spuCode", spuCode);
            proMap.put("ifDelete", 0);
            proMap.put("isThumbnail", 1);
            proMap.put("isModel", 0);
            proMap.put("color", colorCode);
            String json = HttpUtilPcm.doPost(SystemConfig.SSD_SYSTEM_URL + "/productPrcture/queryPrctureInfoByPara.htm",
                    JsonUtil.getJSONString(proMap));
            List<String> picUrls = new ArrayList<String>();
            if (!"".equals(json) && json != null) {
                JSONObject imgJson = JSONObject.fromObject(json);
                if ("true".equals(imgJson.get("success"))) {
                    JSONArray list = JSONArray.fromObject(imgJson.get("data"));
                    for (int i = 0; i < list.size(); i++) {
                    	JSONObject pic = JSONObject.fromObject(list.get(i));
                    	String picUrl = pic.getString("pictureUrl");
                    	if(picUrl != "" && picUrl != null){
                    		picUrls.add(picUrl);
                    	}
                    }    
                }
            }
            DownPackZipUtil.downFile(picUrls, out);
            out.close();    
            DownPackZipUtil.downFile(response, tmpFileName);
        } catch (Exception e) {    
            e.printStackTrace();
        }    
        return null;    
    }
}
