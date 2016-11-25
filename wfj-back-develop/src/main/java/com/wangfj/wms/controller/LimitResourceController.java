package com.wangfj.wms.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.wms.domain.entity.BackUser;
import com.wangfj.wms.domain.entity.LimitResource;
import com.wangfj.wms.domain.entity.LimitRoleResources;
import com.wangfj.wms.service.IBackUserService;
import com.wangfj.wms.service.ILimitResourcesService;
import com.wangfj.wms.service.ILimitRoleResourceService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * 资源控制管理
 * @Class Name LimitResourceController
 * @Author Administrator
 * @Create In 2013-8-9
 */
@Controller
@RequestMapping("/limitResource")
public class LimitResourceController {
	
	@Autowired
	@Qualifier(value = "limitResourceService")
	private ILimitResourcesService resourcesService;
	
	@Autowired
	@Qualifier(value = "backUserService")
	private IBackUserService backUserService;//后台用户Service
	
	@Autowired
	@Qualifier(value = "limitRoleResourceService")
	private ILimitRoleResourceService rolersService;
	/**
	 * 得到所有的根节点资源
	 * @Methods Name getAllResources
	 * @Create In 2013-8-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getAllLimitResources", method = {RequestMethod.GET, RequestMethod.POST})
	public String getAllResources(HttpServletRequest request, HttpServletResponse response){
		String parentSid = request.getParameter("node");
		JSONObject obj = new JSONObject();
		JSONObject jsonObj=new JSONObject();
		JSONArray jsonarry = new JSONArray();
		List<LimitResource> result = new ArrayList();
		try {
			//得到所有资源
//			if(!"0".equals(parentSid) && parentSid != null){
//				LimitResource resource = new LimitResource();
//				resource.setParentSid(Long.valueOf(parentSid));
//				result = resourcesService.getByParam(resource);
//			}else{
				List<LimitResource> list1 = resourcesService.getAll();
//				for(LimitResource lr:result){
//					List<LimitResource> childs=new ArrayList<LimitResource>();
//					//childs=getChildsByParam(lr.getSid(),list1);
//				}
				//遍历得到所有跟节点
				for(int i = 0;i<list1.size();i++){
					LimitResource r = new LimitResource();
					r = list1.get(i);
					if(r.getParentSid()==null ||r.getParentSid()==0){
						result.add(r);
					}
				}
//			}
			
			//将跟节点list转换为树所需要的。
			for(LimitResource r : result){
				obj.put("id", r.getSid());
				obj.put("text", r.getRsName());
				//obj.put("icons", "");
				JSONArray nodes=new JSONArray();
				List<LimitResource> list=new ArrayList<LimitResource>();
				LimitResource param=new LimitResource();
				param.setParentSid(r.getSid());
				list=resourcesService.getByParam(param);
				for(LimitResource sr:list){
					JSONObject secondObj=new JSONObject();
					secondObj.put("id", sr.getSid());
					secondObj.put("text", sr.getRsName());
					JSONArray nodes2=new JSONArray();
					List<LimitResource> list2=new ArrayList<LimitResource>();
					LimitResource param2=new LimitResource();
					param2.setParentSid(sr.getSid());
					list2=resourcesService.getByParam(param2);
					for(LimitResource sr2:list2){
						JSONObject thirdObj=new JSONObject();
						thirdObj.put("id", sr2.getSid());
						thirdObj.put("text", sr2.getRsName());
						nodes2.add(thirdObj);
					}
					if(nodes2.size()>0){
						secondObj.put("nodes", nodes2);
					}
					nodes.add(secondObj);
				}
//				obj.put("linkBrand", null);
//				obj.put("leaf", r.getIsLeaf());
				obj.put("nodes", nodes);
				jsonarry.add(obj);
				jsonObj.put("id", 0);
				jsonObj.put("text", "根节点");
				jsonObj.put("nodes", jsonarry);
				
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		JSONObject json=new JSONObject();
		JSONArray relist=new JSONArray();
		relist.add(jsonObj);
		json.put("list", relist);
		return json.toString();
	}
	
	
	/**
	 * 查找左侧树形导航菜单的数据
	 * @Methods Name getSideNavResources
	 * @Create In 2014-12-20 By KUNPENG
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getSideNavResources", method = {RequestMethod.GET, RequestMethod.POST})
	public String getSideNavResources(HttpServletRequest request, HttpServletResponse response){
		String parentSid = request.getParameter("node");
		String rsCode = request.getParameter("rsCode");
		JSONObject obj = new JSONObject();
		JSONArray jsonarry = new JSONArray();
		List<LimitResource> result = new ArrayList();
		try {
			
			//获取当前登录用户，并得到当前登录用户的角色id
			BackUser u=new BackUser();
//			u=backUserService.queryUserByName((String)request.getSession().getAttribute("username"));//根据用户名查询用户是否存在
			u=backUserService.queryUserByName(CookiesUtil.getCookies(request, "username"));//根据用户名查询用户是否存在
			Map map=new HashMap();
			map=backUserService.getBackUserRoleInfo(u.getSid());
			long roleSid= (Long) map.get("roleSid");			
			
			//定义父节点的id
			Long pSid = null;
			if(parentSid != null){
				if(!"0".equals(parentSid)){
					pSid = Long.valueOf(parentSid);
				}				
			}
			
			//根据顶部导航菜单的rsCode查找sid
			if(!"".equals(rsCode)&&rsCode!=null){
				LimitResource resource = new LimitResource();
				resource.setRsCode(rsCode);
				List<LimitResource> pResource = new ArrayList();
				pResource = resourcesService.getByParam(resource);
				for (LimitResource limitResource : pResource) {
					resource = limitResource;
				}
				pSid = resource.getSid();
			}
			//首次加载页面，左侧导航菜单为空
			if(pSid==null){
				return jsonarry.toString();
			}
			Map<String,Object> param = new HashMap<String, Object>();
			param.put("role_id", roleSid);
			param.put("parentSid", pSid);
			result = resourcesService.getSlideResourcesByparam(param);
			
			//将跟节点list转换为树所需要的。
			for(LimitResource r : result){
				obj.put("id", r.getSid());
				obj.put("text", r.getRsName());
				//obj.put("icons", "");
				obj.put("linkBrand", null);
				obj.put("leaf", r.getIsLeaf());
				obj.put("rsCode", r.getRsCode());
				obj.put("url", r.getRsUrl());
				jsonarry.add(obj);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonarry.toString();
		
	}
	
	/**
	 * 根据条件进行查找资源
	 * @Methods Name getLimitResourceByParam
	 * @Create In 2013-8-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getLimitResourceByParam", method = {RequestMethod.GET, RequestMethod.POST})
	public String getLimitResourceByParam(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitResource limitResource = toResource(request);
		limitResource.setDelFlag(0);
		JSONObject jsonObj=new JSONObject();
		try {
			List result=new ArrayList();
			String sid=request.getParameter("sid");
			if(sid!=null&&sid!="0"&&!sid.equals("0")&&!sid.equals("")&&sid!=""){
				result = resourcesService.getByParam(limitResource);
			}else{
				limitResource.setRsName("根节点");
				result.add(limitResource);
			}
			json = ResultUtil.createSuccessResult(result);
			jsonObj=JSONObject.fromObject(json);
			jsonObj.put("pageCount", 1);
			json=jsonObj.toString();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
			jsonObj.put("pageCount", 0);
			json=jsonObj.toString();
		}
		
		return json;
	}
	/**
	 * 保存资源
	 * @Methods Name saveLimitResources
	 * @Create In 2013-8-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveLimitResources", method = {RequestMethod.GET, RequestMethod.POST})
	public String saveLimitResources(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitResource limitResource = toResource(request);
		limitResource.setDelFlag(0);
		limitResource.setCreateTime(new Date());
		try {
			String result = resourcesService.saveLimitResource(limitResource).toString();
			json = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	/**
	 * 修改资源
	 * @Methods Name updateLimitResources
	 * @Create In 2013-8-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/updateLimitResources", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateLimitResources(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitResource limitResource = toResource(request);
		limitResource.setUpdateTime(new Date());
		try {
			String result = resourcesService.updateLimitResource(limitResource).toString();
			json = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	/**
	 * 删除资源
	 * @Methods Name deleteLimitResources
	 * @Create In 2013-8-9 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 * 删除资源时先删除授权关系
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteLimitResources", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteLimitResources(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitResource limitResource = toResource(request);
		String sid = request.getParameter("sid");
		try {
				//---------------------------------
				LimitRoleResources roleResource = new LimitRoleResources();
				roleResource.setRsSid(Long.valueOf(sid));
				//删除授权的limit_role_resouse中的列--------
				List<LimitRoleResources> list=rolersService.getByParam(roleResource);
				if(list!=null && list.size()>0){
					rolersService.deleteRoleResources(roleResource);
				}
				
				//删除limit_resouse中的列--------
				String result = resourcesService.deleteLimitResource(limitResource).toString();
				json = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	/**
	 * 禁用资源
	 * @Methods Name proLmitResources
	 * @Create In 2013-8-10 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/proLmitResources", method = {RequestMethod.GET, RequestMethod.POST})
	public String proLmitResources(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		LimitResource limitResource = toResource(request);
		limitResource.setDelFlag(1);
		try {
			String result = resourcesService.updateLimitResource(limitResource).toString();
			json = ResultUtil.createSuccessResult(result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			json = ResultUtil.createFailureResult(e);
		}
		
		return json;
	}
	/**
	 * 有请求参数转换为对象
	 * @Methods Name toResource
	 * @Create In 2013-8-9 By Administrator
	 * @param request
	 * @return LimitResource
	 */
	public LimitResource toResource(HttpServletRequest request){
		
		String sid = request.getParameter("sid");
		String rsName = request.getParameter("rsName");
		String rsCode = request.getParameter("rsCode");
		String delFlag = request.getParameter("delFlag");
		String parentSid = request.getParameter("parentSid");
		String isLeaf = request.getParameter("isLeaf");
		String rsUrl = request.getParameter("rsUrl");
        String orderno = request.getParameter("orderno");
		LimitResource resource = new LimitResource();
		
		if(sid != null && sid.length()>0){
			resource.setSid(Long.valueOf(sid));
		}
		if(rsName != null && rsName.length()>0){
			resource.setRsName(rsName);
		}
		if(rsUrl != null && rsUrl.length()>0){
			resource.setRsUrl(rsUrl);
		}
		if(rsCode != null && rsCode.length()>0){
			resource.setRsCode(rsCode);
		}
		if(delFlag != null && delFlag.length()>0){
			resource.setDelFlag(Integer.valueOf(delFlag));
		}
		if(parentSid != null && parentSid.length()>0){
			resource.setParentSid(Long.valueOf(parentSid));
		}
		if(isLeaf != null && isLeaf.length()>0){
			resource.setIsLeaf(Integer.valueOf(isLeaf));
		}
        if (orderno != null && !"".equals(orderno) && orderno.length() > 0){
            resource.setOrderno(Integer.parseInt(orderno));
        }
		return resource;
	}

}
