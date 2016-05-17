package com.wangfj.cms.assist;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.wms.util.ResultUtil;

import common.Logger;

@Controller
@RequestMapping(value="advertisingSpace")
public class AdvertisingSpaceController {
	private Logger logger = Logger.getLogger(AdvertisingSpaceController.class);
	private String className = AdvertisingSpaceController.class.getName();
	
	//查询广告位列表
	@ResponseBody
	@RequestMapping(value = "/list", method = { RequestMethod.POST, RequestMethod.GET })
	public String list(Model model,String _site_id_param, HttpServletRequest request, HttpServletResponse response,
			Integer pageNo) {
		String methodName = "list";
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null != pageNo && !"".equals(pageNo)){
			map.put("pageNo", pageNo);
		}
		if(null != _site_id_param && !"".equals(_site_id_param)){
			map.put("_site_id_param", _site_id_param);
		}
		try {
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/v_list.do", map);
		} catch (Exception e) {
			logger.info(className+":"+methodName+" "+e.getMessage());
		}
		return json.toString();

	}
	
	//验证该位置是否能够添加广告位
	@ResponseBody
	@RequestMapping(value = "/checkSpaceEnabled", method = { RequestMethod.POST, RequestMethod.GET })
	public String checkSpaceEnabled(String enabled, String position, HttpServletRequest request, HttpServletResponse response){
		String methodName = "checkSpaceEnabled";
		String json="";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null != position && !"".equals(position)){
			map.put("position", position);
		}
		if(null != enabled && !"".equals(enabled)){
			map.put("enabled", enabled);
		}
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/checkedSpaceEnabled.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.info(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
	
	//按位置排序查询所有广告版位  (广告版位管理页面)
	@ResponseBody
	@RequestMapping(value = "/list_by_position", method = { RequestMethod.POST, RequestMethod.GET })
	public String listByPosition(Model model, HttpServletRequest request, HttpServletResponse response) {
		String methodName = "listByPosition";
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		String _site_id_param=request.getParameter("_site_id_param");
		Integer pageSize = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
                .getParameter("pageSize"));
        Integer pageNo = Integer.parseInt(request.getParameter("page"));
        if (pageSize == null || pageSize == 0) {
            pageSize = 10;
        }
        map.put("pageSize", pageSize);// 每页显示数量
		if(null != pageNo && !"".equals(pageNo)){
			map.put("pageNo", pageNo);
		}
		if(null != _site_id_param && !"".equals(_site_id_param)){
			map.put("_site_id_param", _site_id_param);
		}
		try {
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/list_by_position.do", map);
		} catch (Exception e) {
			logger.info(className+":"+methodName+" "+e.getMessage());
		}
		return json.toString();

	}
	
	//查询剩余没有启用的广告位置(添加广告版位页面)
	@ResponseBody
	@RequestMapping(value = "/queryPositionList", method = { RequestMethod.POST, RequestMethod.GET })
	public String listPosition( String _site_id_param,HttpServletRequest request, HttpServletResponse response ) {
		String methodName = "listPosition";
		String json = "";
		Map<String,Object> map = new HashMap<String,Object>();
		if(null != _site_id_param && !"".equals(_site_id_param)){
			map.put("_site_id_param", _site_id_param);
		}
		try {
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/position_list.do", map);
		} catch (Exception e) {
			logger.info(className+":"+methodName+" "+e.getMessage());
		}
		return json.toString();

	}
	//查询该站点下所有的位置(位置管理页面)
	@ResponseBody
    @RequestMapping(value = "/queryPosition", method = { RequestMethod.POST, RequestMethod.GET })
    public String listAllPosition( String _site_id_param,HttpServletRequest request, HttpServletResponse response ) {
        String methodName = "listAllPosition";
        String json = "";
        Map<String,Object> map = new HashMap<String,Object>();
        if(null != _site_id_param && !"".equals(_site_id_param)){
            map.put("_site_id_param", _site_id_param);
        }
        try {
            json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/position.do", map);
        } catch (Exception e) {
            logger.info(className+":"+methodName+" "+e.getMessage());
        }
        return json.toString();

    }
	//添加位置
	@ResponseBody
    @RequestMapping(value = "/addPosition", method = { RequestMethod.POST, RequestMethod.GET })
    public String addPosition( String _site_id_param,String name,String position,String source,HttpServletRequest request, HttpServletResponse response ) {
        String methodName = "addPosition";
        String json = "";
        Map<String,Object> map = new HashMap<String,Object>();
        if(null != _site_id_param && !"".equals(_site_id_param)){
            map.put("_site_id_param", _site_id_param);
        }
        if(null != name && !"".equals(name)){
            map.put("name", name);
        }
        if(null != position && !"".equals(position)){
            map.put("position", position);
        }
        if(null != source && !"".equals(source)){
            map.put("source", source);
        }
        try {
            json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/add_position.do", map);
        } catch (Exception e) {
            logger.info(className+":"+methodName+" "+e.getMessage());
        }
        return json.toString();

    }
	//修改位置
	@ResponseBody
    @RequestMapping(value = "/editPosition", method = { RequestMethod.POST, RequestMethod.GET })
    public String editPosition( String _site_id_param,String id,String name,String position,String source,HttpServletRequest request, HttpServletResponse response ) {
        String methodName = "editPosition";
        String json = "";
        Map<String,Object> map = new HashMap<String,Object>();
        if(null != _site_id_param && !"".equals(_site_id_param)){
            map.put("_site_id_param", _site_id_param);
        }
        if(null != id && !"".equals(id)){
            map.put("id", id);
        }
        if(null != name && !"".equals(name)){
            map.put("name", name);
        }
        if(null != position && !"".equals(position)){
            map.put("position", position);
        }
        if(null != source && !"".equals(source)){
            map.put("source", source);
        }
        try {
            json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/edit_position.do", map);
        } catch (Exception e) {
            logger.info(className+":"+methodName+" "+e.getMessage());
        }
        return json.toString();

    }
	//删除位置
	@ResponseBody
    @RequestMapping(value = "/delPosition", method = { RequestMethod.POST, RequestMethod.GET })
    public String delPosition( String ids,HttpServletRequest request, HttpServletResponse response ) {
        String methodName = "delPosition";
        String json = "";
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("ids", ids);
        try {
            json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/del_position.do", map);
        } catch (Exception e) {
            logger.info(className+":"+methodName+" "+e.getMessage());
        }
        return json.toString();

    }
    
	//查询广告列表(分页显示)
	@ResponseBody
	@RequestMapping(value = "/loadAdvertise", method = { RequestMethod.POST, RequestMethod.GET })
	public String loadAdvertise(HttpServletRequest request,Integer _site_id_param, HttpServletResponse response,
			Integer pageNo) {
		String methodName = "loadAdvertise";
		String json = "";
		String spaceId=request.getParameter("spaceId");
		Map<String,Object> map = new HashMap<String,Object>();
		Integer size = request.getParameter("pageSize") == null ? null : Integer.parseInt(request
				.getParameter("pageSize"));
		Integer currPage = Integer.parseInt(request.getParameter("page"));
		if (size == null || size == 0) {
			size = 10;
		}
		map.put("pageSize", size);// 每页显示数量
		if(null != _site_id_param && !"".equals(_site_id_param)){
			map.put("_site_id_param", _site_id_param);
		}
		
		if(spaceId==""||spaceId==null){
			spaceId="0";
		}
		map.put("queryAdspaceId", spaceId);
		if(null != currPage && !"".equals(currPage)){
			map.put("pageNo", currPage);
		}
		try {
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising/v_list.do", map);
		} catch (Exception e) {
			logger.info(className+":"+methodName+" "+e.getMessage());
		}
		return json.toString();

	}
	//添加广告版位
	@ResponseBody
	@RequestMapping(value = "/save", method = { RequestMethod.POST, RequestMethod.GET })
	public String save(HttpServletRequest request,HttpServletResponse response,
			String name,String position,String _site_id_param,String desc,String enabled){
		String methodName = "save";
		Map<String,Object> map=new HashMap<String,Object>();
		if(null != _site_id_param && !"".equals(_site_id_param)){
			map.put("_site_id_param", _site_id_param);
		}
		map.put("name", name);
		map.put("position", position);
		map.put("desc", desc);
		map.put("enabled", enabled);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/o_save.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.info(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
	//修改广告版位
	@ResponseBody
	@RequestMapping(value = "/edit", method = { RequestMethod.POST, RequestMethod.GET })
	public String edit(HttpServletRequest request, HttpServletResponse response,
			String id,String name,String position,String desc,String enabled){
		String methodName = "edit";
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("id", id);
		map.put("name", name);
		if(null != position && !"".equals(position)){
			map.put("position", position);
		}
		if(null != desc && !"".equals(desc)){
			map.put("desc", desc);
		}
		map.put("enabled", enabled);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/o_update.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.info(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
	//删除广告版位
	@ResponseBody
	@RequestMapping(value = "/del", method = { RequestMethod.POST, RequestMethod.GET })
	public String del(HttpServletRequest request, HttpServletResponse response,String id){
		String methodName = "del";
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("id", id);
		String json="";
		try{
			json=HttpUtil.HttpPost(SystemConfig.CMS_SYSTEM_URL, "/advertising_space/o_delete.do", map);
		}catch(Exception e){
			json = ResultUtil.createFailureResult(e);
			logger.info(className+":"+methodName+" "+e.getMessage());
		}
		return json;
	}
}
