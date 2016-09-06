/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.back.controllerSecutityController.java
 * @Create By chengsj
 * @Create In 2013-5-10 下午4:17:58
 * TODO
 */
package com.wangfj.back.controller;

import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.framework.AbstractController;
import com.utils.StringUtils;
import com.wangfj.back.util.DataUtil;
import com.wangfj.back.util.ErrorCodeConstants.ErrorCode;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.back.util.ResultUtil;
import com.wangfj.back.view.UacRoleVO;
import com.wangfj.wms.domain.entity.BackUser;
import com.wangfj.wms.domain.entity.LimitResource;
import com.wangfj.wms.domain.entity.LimitRole;
import com.wangfj.wms.domain.entity.LimitRoleResources;
import com.wangfj.wms.service.IBackUserService;
import com.wangfj.wms.service.ILimitResourcesService;
import com.wangfj.wms.service.ILimitRoleResourceService;
import com.wangfj.wms.service.ILimitRoleService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.JsonUtil;

/**
 * @Class Name SecutityController
 * @Author wwb
 * @Create In 2014-12-10
 */
@Controller
@RequestMapping(value = "/security")
public class SecutityController extends AbstractController {

	protected final Log logger = LogFactory.getLog(SecutityController.class);

	@Autowired
	@Qualifier("limitRoleService")
	private ILimitRoleService limitRoleService;
	@Autowired
	@Qualifier(value = "limitResourceService")
	private ILimitResourcesService resourcesService;
	@Autowired
	@Qualifier("backUserService")
	private IBackUserService backUserService;// 后台用户Service
	@Autowired
	@Qualifier(value = "limitRoleResourceService")
	private ILimitRoleResourceService rolersourceService;
	@Autowired
	@Qualifier(value = "limitRoleService")
	private ILimitRoleService roleService;

	//@RequestMapping(value = { "/login" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model m, HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		// Infos infos = init(request, "uesrname = " + username + ",password = "
		// + password);
		BackUser u = new BackUser();
		u = backUserService.queryUserByName(username);// 根据用户名查询用户是否存在
		StringBuffer stringBuffer = new StringBuffer();
		if (u != null) {
			logger.info(u.getPassWord());
			if (!u.getPassWord().equals(password)) {
				request.setAttribute("error", "用户名或密码输入错误，请核对后重新输入。");
				return "forward:/login.jsp";
			}
			if (u.getStatus() == 1) {
				Map map = new HashMap();
				map = backUserService.getBackUserRoleInfo(u.getSid());
				if (map != null) {
					try {
						String roleCode = (String) map.get("roleCode");
						long roleSid = (Long) map.get("roleSid");
						LimitRoleResources limitRoleResource = new LimitRoleResources();
						limitRoleResource.setRoleSid(roleSid);
						List<LimitRoleResources> limitRoleResources = rolersourceService
								.getByParam(limitRoleResource);
						// 通过角色权限关系得到资源名称
						List<LimitResource> LOne = new ArrayList<LimitResource>();// 1级分类
						if (limitRoleResources.size() > 0) {
							for (LimitRoleResources rr : limitRoleResources) {
								LimitResource limitResource = new LimitResource();
								limitResource.setSid(rr.getRsSid());
								List<LimitResource> limitResources = resourcesService
										.getByParam(limitResource);
								if (limitResources != null && limitResources.size() != 0) {
									if (limitResources.get(0).getParentSid() == 0) {
										LOne.add(limitResources.get(0));
									}
								}
							}
						}
//						request.getSession().setAttribute("username", username);
//						request.getSession().setAttribute("password", password);
						CookiesUtil.setCookies(response, "username", username, 60*30);
						CookiesUtil.setCookies(response, "password", password, 60*30);
						request.getSession().setAttribute("LOne", LOne);
						return "redirect:/index.jsp";
					} catch (Exception e) {
						e.printStackTrace();
						request.setAttribute("error", "系统异常！");
						return "forward:/login.jsp";
					}
				} else {
					request.setAttribute("error", "该用户无权限！");
					return "forward:/login.jsp";
				}

			} else {
				request.setAttribute("error", "该用户已被禁用！");
				return "forward:/login.jsp";
			}
		} else {
			request.setAttribute("error", "用户名或密码输入错误，请核对后重新输入。");
			return "forward:/login.jsp";
		}
	}
	
	@RequestMapping(value = { "/login" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String login1(Model m, HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("username", username);
		paramMap.put("password", password);
		String ss = "";
		try {
			ss = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/validate/validateUser.do", paramMap);
			JSONObject json = JSONObject.fromObject(ss);
			if(json.get("success").equals(false)){
				request.setAttribute("error", json.get("msg").toString());
				return "forward:/login.jsp";
			}
			paramMap.clear();
			paramMap.put("uid", username);
			String userDetailJson = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/api/getUserDetailByUid.do", paramMap);
			JSONObject json1 = JSONObject.fromObject(userDetailJson);
			JSONObject userDetail = JSONObject.fromObject(json1.get("data"));
			if(!userDetail.get("status").equals("0")){
				request.setAttribute("error", "该用户已被禁用！");
				return "forward:/login.jsp";
			}
			paramMap.clear();
			paramMap.put("userId", username);
			paramMap.put("systemCN", "SYSTEM_OPS");
			String RolesJson = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/api/findRolesByUserAndSys.json", paramMap);
			JSONObject json2 = JSONObject.fromObject(RolesJson);
			if(json2.getString("success").equals("true")){
				Object o = json2.get("result");
				JSONArray Roles = JSONArray.fromObject(o);
				if(Roles != null && Roles.size() != 0){
					List<UacRoleVO> rolesList = JsonUtil.getListDTO(Roles.toString(), UacRoleVO.class);
					List<LimitResource> LOne = new ArrayList<LimitResource>();// 1级分类
					List<String> paramList = new ArrayList<String>();
					for(UacRoleVO jo : rolesList){
						paramList.add(jo.getCn());
						LimitRole role = new LimitRole();
						role.setRoleCode(jo.getCn());
						List<LimitRole> list = roleService.getByParam(role);
						if(list != null && list.size() != 0){

						} else {
							role.setRoleName(jo.getDisplayName());
							role.setCreatedTime(new Date());
							role.setDelFlag(0);
							roleService.saveLimitRole(role);
						}
					}
					paramMap.clear();
					paramMap.put("roleList", paramList);
					paramMap.put("parentSid", 0);
					List<LimitResource> resources = resourcesService.getResourcesByParentSid(paramMap);
					LOne.addAll(resources);
//					request.getSession().setAttribute("username", username);
//					request.getSession().setAttribute("password", password);
					CookiesUtil.setCookies(response, "username", username, 60*120);
//					CookiesUtil.setCookies(response, "password", password, 60*30);
					CookiesUtil.setCookies(response, "LOne", URLEncoder.encode(JsonUtil.getJSONString(LOne), "UTF-8"), 60*120);
					return "redirect:/index.jsp";
				} else {
					request.setAttribute("error", "该帐号没权限！");
					return "forward:/login.jsp";
				}
			} else {
				request.setAttribute("error", "该帐号没权限！");
				return "forward:/login.jsp";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.setAttribute("error", "系统异常！");
			return "forward:/login.jsp";
		}
	}
	
	//@RequestMapping(value = { "/login" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String login2(Model m, HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext()
                .getAuthentication()
                .getPrincipal();
		String username = userDetails.getUsername();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		try {
			paramMap.put("userId", username);
			paramMap.put("systemCN", "SYSTEM_OPS");
			String RolesJson = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/api/findRolesByUserAndSys.json", paramMap);
			JSONObject json2 = JSONObject.fromObject(RolesJson);
			if(json2.getString("success").equals("true")){
				Object o = json2.get("result");
				JSONArray Roles = JSONArray.fromObject(o);
				if(Roles != null && Roles.size() != 0){
					List<UacRoleVO> rolesList = JsonUtil.getListDTO(Roles.toString(), UacRoleVO.class);
					List<LimitResource> LOne = new ArrayList<LimitResource>();// 1级分类
					List<String> paramList = new ArrayList<String>();
					for(UacRoleVO jo : rolesList){
						paramList.add(jo.getCn());
						LimitRole role = new LimitRole();
						role.setRoleCode(jo.getCn());
						List<LimitRole> list = roleService.getByParam(role);
						if(list != null && list.size() != 0){

						} else {
							role.setRoleName(jo.getDisplayName());
							role.setCreatedTime(new Date());
							role.setDelFlag(0);
							roleService.saveLimitRole(role);
						}
					}
					paramMap.clear();
					paramMap.put("roleList", paramList);
					paramMap.put("parentSid", 0);
					List<LimitResource> resources = resourcesService.getResourcesByParentSid(paramMap);
					LOne.addAll(resources);
					CookiesUtil.setCookies(response, "username", username, 60*120);
					CookiesUtil.setCookies(response, "LOne", URLEncoder.encode(JsonUtil.getJSONString(LOne), "UTF-8"), 60*120);
					return "redirect:/index.jsp";
				} else {
					request.setAttribute("error", "该帐号没权限！");
					return "forward:/login.jsp";
				}
			} else {
				request.setAttribute("error", "该帐号没权限！");
				return "forward:/login.jsp";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.setAttribute("error", "系统异常！");
			return "forward:/login.jsp";
		}
	}

	@ResponseBody
	@RequestMapping(value = { "/loginTms" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String loginTms(HttpServletRequest request, HttpServletResponse response)
			throws SQLException {

		String json = "";

		String readerStr = (String) DataUtil.readRequest(request);
		JSONObject jo = JSONObject.fromObject(readerStr);
		String username = jo.getString("username");
		String password = jo.getString("password");
		String fromSystem = jo.getString("fromSystem");

		if (!"Logistics".equals(fromSystem)) {
			json = ResultUtil.createFailureResult(ErrorCode.CALL_SRC_ERROR.getErrorCode(),
					ErrorCode.CALL_SRC_ERROR.getMemo());
			return json;
		}

		if (!StringUtils.isNotEmpty(username)) {
			json = ResultUtil.createFailureResult(ErrorCode.USERNAME_NULL_ERROR.getErrorCode(),
					ErrorCode.USERNAME_NULL_ERROR.getMemo());
			return json;
		}

		if (!StringUtils.isNotEmpty(password)) {
			json = ResultUtil.createFailureResult(ErrorCode.PWD_NULL_ERROR.getErrorCode(),
					ErrorCode.PWD_NULL_ERROR.getMemo());
			return json;
		}

		String resources = null;

		BackUser u = new BackUser();
		u = backUserService.queryUserByName(username);// 根据用户名查询用户是否存在
		StringBuffer stringBuffer = new StringBuffer();
		if (u != null) {
			logger.info(u.getPassWord());
			if (!u.getPassWord().equals(password)) {
				json = ResultUtil.createFailureResult(ErrorCode.LOGIN_ERROR.getErrorCode(),
						ErrorCode.LOGIN_ERROR.getMemo());
				return json;
			}
			if (u.getStatus() == 1 && u.getType() == 1) {
				Map map = new HashMap();
				map = backUserService.getBackUserRoleInfo(u.getSid());
				if (map != null) {
					try {
						String roleCode = (String) map.get("roleCode");
						long roleSid = (Long) map.get("roleSid");
						LimitRoleResources limitRoleResource = new LimitRoleResources();
						limitRoleResource.setRoleSid(roleSid);
						List<LimitRoleResources> limitRoleResources = rolersourceService
								.getByParam(limitRoleResource);
						// 通过角色权限关系得到资源名称
						if (limitRoleResources.size() > 0) {
							for (LimitRoleResources rr : limitRoleResources) {
								LimitResource limitResource = new LimitResource();
								limitResource.setSid(rr.getRsSid());
								List<LimitResource> limitResources = resourcesService
										.getByParam(limitResource);
								if (limitResources != null && limitResources.size() != 0) {
									stringBuffer.append(limitResources.get(0).getRsCode() + ",");
								}
							}
						}

						resources = stringBuffer.toString();
						if (resources.endsWith(",")) {
							resources = resources.substring(0, resources.length() - 1);
						}
						;
						Map useInfo = backUserService.getBLUserInfo(u.getSid());

						Map result = new HashMap();
						result.put("user", useInfo);
						result.put("resources", resources);

						json = ResultUtil.createSuccessResult(result);

						logger.info("物流系统登录成功:" + json);
						return json;
					} catch (Exception e) {
						json = ResultUtil.createFailureResult(
								ErrorCode.SYSTEM_ERROR.getErrorCode(),
								ErrorCode.SYSTEM_ERROR.getMemo());
						return json;
					}
				} else {
					json = ResultUtil.createFailureResult(
							ErrorCode.PERMISSION_ERROR.getErrorCode(),
							ErrorCode.PERMISSION_ERROR.getMemo());
					return json;
				}

			} else {
				json = ResultUtil.createFailureResult(ErrorCode.LOGIN_ERROR.getErrorCode(),
						ErrorCode.LOGIN_ERROR.getMemo());
				return json;
			}
		} else {
			json = ResultUtil.createFailureResult(ErrorCode.LOGIN_ERROR.getErrorCode(),
					ErrorCode.LOGIN_ERROR.getMemo());
			return json;
		}
	}

	//@RequestMapping(value = { "/logoutAction" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(Model m, HttpServletRequest request, HttpServletResponse response) {
//		HttpSession session = request.getSession();
//		session.removeAttribute("username");
//		session.removeAttribute("password");
//		session.invalidate();
		CookiesUtil.delAllCookies(request, response);
		return "redirect:/login.jsp";
	}
	
	//@RequestMapping(value = { "/logoutAction" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String logout_v2(Model m, @RequestParam String error,
			HttpServletRequest request, HttpServletResponse response) {
		if(error.equals("001")){
			error = "用户名或密码不正确";
		} else if(error.equals("002")){
			error = "该用户没权限";
		} else {
			error = "";
		}
		request.setAttribute("error", error);
		CookiesUtil.delAllCookies(request, response);
		return "forward:/login.jsp";
	}
	
	@RequestMapping(value = { "/logoutAction" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String logout_v1(Model m, HttpServletRequest request, HttpServletResponse response) {
		CookiesUtil.delAllCookies(request, response);
		return "redirect:/login.jsp";
	}

	public static List getDTOList(String jsonString, Class clazz, Map map) {

		JSONArray array = JSONArray.fromObject(jsonString);
		List list = new ArrayList();
		for (Iterator iter = array.iterator(); iter.hasNext();) {
			JSONObject jsonObject = (JSONObject) iter.next();
			list.add(JSONObject.toBean(jsonObject, clazz, map));
		}
		return list;
	}

	/**
	 * index页左侧列表
	 * 
	 * @Methods Name indexLeft
	 * @Create In 2015-4-16 By wangsy
	 * @param m
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException
	 *             String
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	//@RequestMapping(value = { "/indexLeft" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String indexLeft(Model m, HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		try {
			Long sid = Long.valueOf(request.getParameter("sid"));// 主键
			LimitResource lr = new LimitResource();
			List LTwos = new ArrayList();// 2级分类
			List LThrees = new ArrayList();// 3级分类
			lr.setParentSid(sid);
			List<LimitResource> limitResources = resourcesService.getByParam(lr);
			LTwos.add(limitResources);
			/* 根据2级分类查询3级分类 */
			for (int j = 0; j < limitResources.size(); j++) {
				LimitResource lr2 = new LimitResource();
				lr2.setParentSid(limitResources.get(j).getSid());
				List<LimitResource> limitResources2 = resourcesService.getByParam(lr2);
				LThrees.add(limitResources2);
			}
			request.getSession().setAttribute("LTwos", LTwos);
			request.getSession().setAttribute("LThrees", LThrees);
			return "forward:/jsp/indexLeft.jsp";
		} catch (Exception e) {
			e.printStackTrace();
//			request.getSession().setAttribute("error", "系统异常！");
			CookiesUtil.setCookies(response, "error", "系统异常！", null);
			return "redirect:/index.jsp";
		}
	}
	
	/**
	 * index页左侧列表
	 * @Methods Name indexLeft1
	 * @Create In 2016年3月24日 By zdl
	 * @param m
	 * @param request
	 * @param response
	 * @return
	 * @throws SQLException String
	 */
	@RequestMapping(value = { "/indexLeft" }, method = { RequestMethod.GET, RequestMethod.POST })
	public String indexLeft1(Model m, HttpServletRequest request, HttpServletResponse response)
			throws SQLException {
		try {
			Long sid = Long.valueOf(request.getParameter("sid"));
//			String username = (String)request.getSession().getAttribute("username");
			String username = CookiesUtil.getCookies(request, "username");
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("userId", username);
			String RolesJson = HttpUtil.HttpPost(SystemConfig.UAC_PATH, "/api/findRolesByUserId.do", paramMap);
			JSONObject json2 = JSONObject.fromObject(RolesJson);
			JSONArray Roles = JSONArray.fromObject(json2.get("result"));
			List<UacRoleVO> rolesList = JsonUtil.getListDTO(Roles.toString(), UacRoleVO.class);
			List<String> paramList = new ArrayList<String>();
			List<LimitResource> LTwos = new ArrayList<LimitResource>();// 2级分类
			List<LimitResource> LThrees = new ArrayList<LimitResource>();// 3级分类
			for(UacRoleVO jo : rolesList){
				paramList.add(jo.getCn());
			}
			paramMap.clear();
			paramMap.put("roleList", paramList);
			paramMap.put("parentSid", sid);
			List<LimitResource> resources = resourcesService.getResourcesByParentSid(paramMap);
			LTwos.addAll(resources);
			for(LimitResource r : resources){
				paramMap.put("parentSid", r.getSid());
				List<LimitResource> resources1 = resourcesService.getResourcesByParentSid(paramMap);
				LThrees.addAll(resources1);
			}
			m.addAttribute("LTwos", LTwos);
			m.addAttribute("LThrees", LThrees);
			return "forward:/jsp/indexLeft.jsp";
		} catch (Exception e) {
			e.printStackTrace();
//			request.getSession().setAttribute("error", "系统异常！");
			CookiesUtil.setCookies(response, "error", "系统异常！", null);
			return "redirect:/index.jsp";
		}
	}
}
