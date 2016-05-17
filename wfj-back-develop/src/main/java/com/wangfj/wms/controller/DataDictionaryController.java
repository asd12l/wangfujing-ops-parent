package com.wangfj.wms.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.order.utils.CommonProperties;
import com.wangfj.wms.domain.view.DictType;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class OrderManagementController
 * @Author chenqb
 * @Create In 2013-7-31
 */
@Controller
@RequestMapping(value = "/DataDictionary")
public class DataDictionaryController {

//	private String url = "http://localhost:8080/oms_admin";
	private String url = CommonProperties.get("oms_core_url");
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
	public static  Log logger = LogFactory.getLog(DataDictionaryController.class);
	/**
	 * 
	 * @Methods Name findBusinessType get all business type
	 * @Create In 2013-7-31 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findBusinessType(HttpServletRequest request,
			HttpServletResponse response) {

		// String json = "";
		JSONObject obj = new JSONObject();
		JSONArray json = new JSONArray();
		List<DictType> list = new ArrayList<DictType>();
		String l;
		try {
			// 得到返回的String字符串
			l = com.wangfj.back.util.HttpUtil.HttpPost(url,
					"back/dictType/selectList.json", null);
			// 对得到的Sting字符窜进行处理
			JSONObject js = JSONObject.fromObject(l);
			Object objs = js.get("list");
			// 得到JSONArray
			JSONArray arr = JSONArray.fromObject(objs);
			System.out.println(arr);
			// list = JSONArray.toList(arr,new DictType(),new JsonConfig());
			// 将JSONArray 转换为list<object>
			for (int i = 0; i < arr.size(); i++) {
				String jsonarr = arr.getString(i);
				JSONObject jsonobj = JSONObject.fromObject(jsonarr);
				DictType t = (DictType) JSONObject.toBean(jsonobj,
						DictType.class);
				list.add(t);
			}
			// 将list转换为JsonArray
			for (DictType dic : list) {
				obj.put("id", dic.getSid());
				obj.put("text", dic.getDictTypeName());
				obj.put("icons", "");
				obj.put("linkBrand", null);
				obj.put("leaf", true);
				json.add(obj);
			}

		} catch (Exception e) {
			
			e.printStackTrace();
		}
		logger.info("得到所有的业务类型"+json);
		return json.toString();
	}

	/**
	 * 
	 * @Methods Name 得到业务类型信息（如果存在参数得以参数条件进行查询）
	 * @Create In 2013-8-3 By chenqb
	 * @param name
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/dictTypeList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getAllDictType(String name, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		String sid = request.getParameter("sid");

		Map<String, String> parmMap = new HashMap<String, String>();

		if (sid != null && sid.length() > 0) {
			parmMap.put("sid", sid);
		}
		if (name != null && name.length() > 0) {

			parmMap.put("dictTypeName", name);

		}
		if (parmMap != null && !parmMap.isEmpty()) {
			try {
				json = com.wangfj.back.util.HttpUtil.HttpPost(url,
						"back/dictType/selectByParam.json", parmMap);
			} catch (Exception e) {
				
				json = ResultUtil.createFailureResult(e);
			}
		} else {
			try {
				// 得到返回的String字符串
				json = com.wangfj.back.util.HttpUtil.HttpPost(url,
						"back/dictType/selectList.json", null);

			} catch (Exception e) {
			
				json = ResultUtil.createFailureResult(e);
			}
		}

		return json;
	}

	/**
	 * 
	 * @Methods Name 得到有效类型项
	 * @Create In 2013-8-3 By chenqb
	 * @param navSid
	 * @param name
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getItemType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getItemTypeByParentCode(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		String dictTypeCode = request.getParameter("dictTypeCode");
		Map<String, String> parmMap = new HashMap<String, String>();
		if (dictTypeCode != null && dictTypeCode.length() > 0) {
			parmMap.put("dictTypeCode", dictTypeCode);
			parmMap.put("activeFlag","1");
			try {
				json = com.wangfj.back.util.HttpUtil.HttpPost(url,
						"back/dictItem/selectListByParam.json", parmMap);
			} catch (Exception e) {
				
				json = ResultUtil.createFailureResult(e);
			}
		} 
		
		return json;
	}
	/**
	 * 
	 * @Methods Name 得到所有类型项
	 * @Create In 2013-8-3 By chenqb
	 * @param navSid
	 * @param name
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/getItemTypeAll", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String getItemTypeByParentCodeAll(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";

		String name = request.getParameter("name");
		String sid = request.getParameter("navSid");
		String dictTypeCode = request.getParameter("dictTypeCode");
		Map<String, String> parmMap = new HashMap<String, String>();
		if (dictTypeCode != null && dictTypeCode.length() > 0) {
			parmMap.put("dictTypeCode", dictTypeCode);
			
		} 
		if (name != null && name.length()>0) {
			parmMap.put("dictItemName", name);
			
		}
		try {
			json = com.wangfj.back.util.HttpUtil.HttpPost(url,
					"back/dictItem/selectListByParam.json", parmMap);
		} catch (Exception e) {
			
			json = ResultUtil.createFailureResult(e);
		}
		if(sid != null && sid.length()>0) {

			parmMap.put("sid", sid);
			try {
				// 得到返回的String字符串
				json = com.wangfj.back.util.HttpUtil.HttpPost(url,
						"back/dictItem/selectItemList.json", parmMap);

			} catch (Exception e) {
				
				json = ResultUtil.createFailureResult(e);
			}
		}

		return json;
	}
	/**
	 * 
	 * @Methods Name 保存业务类型
	 * @Create In 2013-8-3 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveDictType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveDictType(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		String dictTypeCode = request.getParameter("dictTypeCode");
		String dictTypeName = request.getParameter("dictTypeName");
		String activeFlag = request.getParameter("activeFlag");

		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("dictTypeCode", dictTypeCode);
		parmMap.put("dictTypeName", dictTypeName);
		parmMap.put("activeFlag", activeFlag);

		try {
			// 得到返回的String字符串
			json = com.wangfj.back.util.HttpUtil.HttpPost(url,
					"back/dictType/saveType.json", parmMap);
			System.out.println(json + "get");
		} catch (Exception e) {
			
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	/**
	 * 
	 * @Methods Name 修改业务类型
	 * @Create In 2013-8-3 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/updateDictType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateDictType(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		String sid = request.getParameter("sid");
		String dictTypeCode = request.getParameter("dictTypeCode");
		String dictTypeName = request.getParameter("dictTypeName");
		String activeFlag = request.getParameter("activeFlag");

		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("sid", sid);
		parmMap.put("dictTypeCode", dictTypeCode);
		parmMap.put("dictTypeName", dictTypeName);
		parmMap.put("activeFlag", activeFlag);

		try {
			// 得到返回的String字符串
			json = com.wangfj.back.util.HttpUtil.HttpPost(url,
					"back/dictType/updateType.json", parmMap);

		} catch (Exception e) {
			
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	/**
	 * 删除类型项
	 * 
	 * @Methods Name deleteItemType
	 * @Create In 2013-8-2 By chenqb
	 * @param sid
	 * @param request
	 * @param response
	 *            void
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteItemType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteItemType(String sid, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		System.out.println(sid);
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("sid", sid);
		try {
			json = com.wangfj.back.util.HttpUtil.HttpPost(url,
					"back/dictItem/deleteItem.json", parmMap);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * 删除业务类型
	 * 
	 * @Methods Name deleteDictType
	 * @Create In 2013-8-2 By chenqb
	 * @param sid
	 * @param request
	 * @param response
	 *            void
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteDictType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteDictType(String sid, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		System.out.println(sid);
		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("sid", sid);
		try {
			json = com.wangfj.back.util.HttpUtil.HttpPost(url,
					"back/dictType/deleteType.json", parmMap);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * 
	 * @Methods Name 保存类型项
	 * @Create In 2013-8-3 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/saveItemType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveItemType(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";

		String dictTypeCode = request.getParameter("dictTypeCode");
		String dictItemCode = request.getParameter("dictItemCode");
		String dictItemName = request.getParameter("dictItemName");
//		String sapPayType = request.getParameter("sapPayType");
		String showSeq = request.getParameter("showSeq");
		String memo = request.getParameter("memo");
		String activeFlag = request.getParameter("activeFlag");

		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("dictTypeCode", dictTypeCode);
		parmMap.put("dictItemCode", dictItemCode);
		parmMap.put("dictItemName", dictItemName);
//		parmMap.put("sapPayType", sapPayType);
		parmMap.put("showSeq", showSeq);
		parmMap.put("memo", memo);
		parmMap.put("activeFlag", activeFlag);

		try {
			// 得到返回的String字符串
			json = com.wangfj.back.util.HttpUtil.HttpPost(url,
					"back/dictItem/saveItem.json", parmMap);

		} catch (Exception e) {
			
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	/**
	 * 
	 * @Methods Name 修改类型项
	 * @Create In 2013-8-3 By chenqb
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/updateItemType", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateItemType(HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		String sid = request.getParameter("sid");
		String dictTypeCode = request.getParameter("dictTypeCode");
		String dictItemCode = request.getParameter("dictItemCode");
		String dictItemName = request.getParameter("dictItemName");
//		String sapPayType = request.getParameter("sapPayType");
		String showSeq = request.getParameter("showSeq");
		String memo = request.getParameter("memo");
		String activeFlag = request.getParameter("activeFlag");

		Map<String, String> parmMap = new HashMap<String, String>();
		parmMap.put("sid", sid);
		parmMap.put("dictTypeCode", dictTypeCode);
		parmMap.put("dictItemCode", dictItemCode);
		parmMap.put("dictItemName", dictItemName);
//		parmMap.put("sapPayType", sapPayType);
		parmMap.put("showSeq", showSeq);
		parmMap.put("memo", memo);
		parmMap.put("activeFlag", activeFlag);

		try {
			// 得到返回的String字符串
			json = com.wangfj.back.util.HttpUtil.HttpPost(url,
					"back/dictItem/updateItem.json", parmMap);

		} catch (Exception e) {
			
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

}
