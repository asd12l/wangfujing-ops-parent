/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.NavigationController.java
 * @Create By chengsj
 * @Create In 2013-7-23 下午2:15:14
 * TODO
 */
package com.wangfj.wms.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.back.util.HttpUtil;
import com.wangfj.wms.domain.entity.NavBrand;
import com.wangfj.wms.domain.entity.NavPromotion;
import com.wangfj.wms.domain.entity.Navigation;
import com.wangfj.wms.domain.entity.Promotions;
import com.wangfj.wms.domain.view.NavBrandKey;
import com.wangfj.wms.domain.view.NavPromotionKey;
import com.wangfj.wms.service.INavBrandService;
import com.wangfj.wms.service.INavPromotionService;
import com.wangfj.wms.service.INavigationService;
import com.wangfj.wms.service.IPromotionService;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name NavigationController
 * @Author chengsj
 * @Create In 2013-7-23
 */
@Controller
@RequestMapping(value = "/navigation")
public class NavigationController {

	@Autowired
			@Qualifier("navigationService")
	INavigationService navigationService;

	@Autowired
			@Qualifier("navBrandService")
	INavBrandService navBrandService;

	@Autowired
			@Qualifier("promotionService")
	IPromotionService promotionService;

	@Autowired
			@Qualifier("navPromotionService")
	INavPromotionService navPromotionService;

	@ResponseBody
	@RequestMapping(value = "/selectList", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findNavigations(String channelSid, String navSid,
			HttpServletRequest request, HttpServletResponse response) {
		JSONObject obj = new JSONObject();
		JSONArray json = new JSONArray();
		
		

		Navigation navigation = new Navigation();
		navigation.setChannelSid(Integer.valueOf(channelSid));
		if (navSid != null && !"".equals(navSid)) {
			if (navSid.indexOf("node") > 0) {
				navigation.setNavSid(null);
				navigation.setNavLevel(1);
			} else {
				navigation.setNavSid(Long.valueOf(navSid));
			}
		}
		List list = navigationService.selectList(navigation);
		if (list != null && !list.isEmpty()) {
			for (Iterator iter = list.iterator(); iter.hasNext();) {
				Navigation nav = (Navigation) iter.next();
				obj.put("id", nav.getSid());
				obj.put("text", nav.getName());
				obj.put("icons", nav.getIcon());
				obj.put("linkBrand", nav.getLinkBrand());
				obj.put("seq", nav.getSeq());
				obj.put("link", nav.getLink());
				obj.put("isShow", nav.getIsShow());
				obj.put("flag", nav.getFlag());
				if (nav.getNavLevel() == 3) {
					obj.put("leaf", true);
				} else {
					obj.put("leaf", false);
				}
				json.add(obj);
			}
		}
		return json.toString();

	}
	
	@ResponseBody
	@RequestMapping(value = "/selecNavTree", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String findNavigations(String channelSid, HttpServletRequest request, HttpServletResponse response) {
		JSONObject obj = new JSONObject();
		JSONArray json = new JSONArray();
		Navigation navigation = new Navigation();
		navigation.setChannelSid(Integer.valueOf(channelSid));		
		List<Navigation> list = navigationService.selectList(navigation);
		
		obj.put("id", 0);
		obj.put("text", "导航分类");		
		obj = getNavByNavSid(list,obj,null);
		json.add(obj);
		
		JSONObject result = new JSONObject();
		result.put("list", json);
		
		return json.toString();
	}
	
	//根据父类id封装子类节点
	private JSONObject getNavByNavSid(List<Navigation> navs, JSONObject json,Long navSid){
		JSONArray naves = new JSONArray();
		for (Navigation nav : navs) {
			
			if(navSid==null){
				if(nav.getNavSid()==null){
					
					JSONObject obj = new JSONObject();
					obj.put("id", nav.getSid());
					obj.put("text", nav.getName());	
					obj = getNavByNavSid(navs, obj,nav.getSid());
					naves.add(obj);
				}
			}else{
				if(navSid.equals(nav.getNavSid())){
					
					JSONObject obj = new JSONObject();
					obj.put("id", nav.getSid());
					obj.put("text", nav.getName());	
					obj = getNavByNavSid(navs, obj,nav.getSid());
					naves.add(obj);
				}
			}			
		}
		json.put("nodes", naves);
		return json;
	}
	
	
	

	@ResponseBody
	@RequestMapping(value = "/insertNav", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveNavigations(String navSid, String name, String icon,
			String linkBrand, String navLevel, String classSid,
			String channelSid, String flag, String isShow, String seq,
			String link, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			Navigation navigation = new Navigation();
			if (navSid != null && !"".equals(navSid)) {
				navigation.setNavSid(Long.valueOf(navSid));
			}
			if (icon != null && !"".equals(icon)) {
				navigation.setIcon(icon);
			}
			if (seq != null && !"".equals(seq)) {
				navigation.setSeq(Integer.valueOf(seq));
			}
			if (linkBrand != null && !"".equals(linkBrand)) {
				navigation.setLinkBrand(linkBrand);
			}
			if (name != null && !"".equals(name)) {
				navigation.setName(name);
			}
			if (classSid != null && !"".equals(classSid)) {
				navigation.setClassSid(classSid);
			}
			if (channelSid != null && !"".equals(channelSid)) {
				navigation.setChannelSid(Integer.valueOf(channelSid));
			}
			if (navLevel != null && !"".equals(navLevel)) {
				navigation.setNavLevel(Integer.valueOf(navLevel));
			}
			if (link != null && !"".equals(link)) {
				navigation.setLink(link);
			}
			if (isShow != null && !"".equals(isShow)) {
				navigation.setIsShow(Integer.valueOf(isShow));
			}
			if (flag != null && !"".equals(flag)) {
				navigation.setFlag(Integer.valueOf(flag));
			}
			this.navigationService.insertSelective(navigation);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/updateNav", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateNavigations(String sid, String icon, String linkBrand,
			String name, String flag, String isShow, String seq, String link,
			HttpServletRequest request, HttpServletResponse response) {

		String json = "";
		if (sid != null && !"".equals(sid)) {
			try {
				Navigation navigation = new Navigation();
				navigation.setSid(Long.valueOf(sid));

				if (icon != null && !"".equals(icon)) {
					navigation.setIcon(icon);
				}
				if (name != null && !"".equals(name)) {
					navigation.setName(name);
				}
				if (link != null && !"".equals(link)) {
					navigation.setLink(link);
				}
				if (seq != null && !"".equals(seq)) {
					navigation.setSeq(Integer.valueOf(seq));
				}
				if (linkBrand != null && !"".equals(linkBrand)) {
					navigation.setLinkBrand(linkBrand);
				}
				if (flag != null && !"".equals(flag)) {
					navigation.setFlag(Integer.valueOf(flag));
				}
				if (isShow != null && !"".equals(isShow)) {
					navigation.setIsShow(Integer.valueOf(isShow));
				}
				this.navigationService.updateByPrimaryKeySelective(navigation);
				json = ResultUtil.createSuccessResult();
			} catch (Exception e) {
				json = ResultUtil.createFailureResult(e);
			}
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/navigationTree", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String navigationTree(String node, HttpServletRequest request,
			HttpServletResponse response) {

		String json = "";
		JSONArray jsonArray = new JSONArray();
		if (node == null || "".equals(node.trim()))
			return "{'success':false}";
		try {
			Map paraMap = new HashMap();
			paraMap.put("node", node);
			String resultJson = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"bw/queryCategroys.html", paraMap);
			JSONArray array = JSONArray.fromObject(resultJson);
			for (int i = 0; i < array.size(); i++) {
				JSONObject m = array.getJSONObject(i);
				m.put("leaf", true);
				jsonArray.add(m);
			}
		} catch (Exception e) {
			return "{'success':false}";
		}
		return jsonArray.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/deleteNav", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteNavigations(String sid, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			this.navigationService.deleteByPrimaryKey(Long.valueOf(sid));
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryBrand", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryBrand(String brandName, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			Map paraMap = new HashMap();
			if (brandName != null && !"".equals(brandName)) {
				paraMap.put("brandName", brandName);
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"bw/getBrandByName.html", paraMap);

			} else {
				json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
						"bw/queryBrands.html", paraMap);
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryPromotion", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPromotion(String proNmae, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			Promotions pro = new Promotions();
			if (proNmae != null && !"".equals(proNmae)) {
				pro.setPromotionTitle(proNmae);
				List record = this.promotionService.selectByTitle(pro);
				json = ResultUtil.createSuccessResult(record);
			} else {
				List record = this.promotionService.selectAllPromotions();
				json = ResultUtil.createSuccessResult(record);
			}

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryNavBrand", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryNavBrand(String navSid, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			NavBrand nav = new NavBrand();
			if (navSid != null && !"".equals(navSid)) {
				nav.setNavSid(Long.valueOf(navSid));
				List record = this.navBrandService.selectNavBrandByNavSid(nav);
				json = ResultUtil.createSuccessResult(record);
			} else {
				json = ResultUtil.createSuccessResult();
			}

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryNavPromotion", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryNavPromotion(String navSid, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			NavPromotion navpro = new NavPromotion();
//			List<Promotions> promotions = new ArrayList();
			if (navSid != null && !"".equals(navSid)) {
				navpro.setNavSid(Long.valueOf(navSid));
				List<NavPromotion> record = this.navPromotionService
						.selectByNavSid(navpro);
//				for (int i = 0; i < record.size(); i++) {
//
//					Integer promotionSid = record.get(i).getPromotionSid();
//					Promotions promotion = this.promotionService
//							.selectByPrimaryKey(promotionSid);
//					promotions.add(promotion);
//				}

				json = ResultUtil.createSuccessResult(record);
			} else {
				json = ResultUtil.createSuccessResult();
			}

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/saveNavBrand", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveNavBrand(NavBrandKey navBrandKey,
			HttpServletRequest request, HttpServletResponse response) {
		String json = "";

		try {
			NavBrand navBrand = new NavBrand();
			if (navBrandKey.getBrandSid() != null
					&& !"".equals(navBrandKey.getBrandSid())) {
				navBrand.setBrandSid(Long.valueOf(navBrandKey.getBrandSid()));
			}
			if (navBrandKey.getNavSid() != null
					&& !"".equals(navBrandKey.getNavSid())) {
				navBrand.setNavSid(Long.valueOf(navBrandKey.getNavSid()));
			}
			if (navBrandKey.getBrandName() != null
					&& !"".equals(navBrandKey.getBrandName())) {
				navBrand.setBrandName(navBrandKey.getBrandName());
			}
			if (navBrandKey.getBrandPic() != null
					&& !"".equals(navBrandKey.getBrandPic())) {
				navBrand.setBrandPic(navBrandKey.getBrandPic());
			}
			if (navBrandKey.getBrandLink() != null
					&& !"".equals(navBrandKey.getBrandLink())) {
				navBrand.setBrandLink(navBrandKey.getBrandLink());
			}
			if (navBrandKey.getIsShow() != null
					&& !"".equals(navBrandKey.getIsShow())) {
				navBrand.setIsShow(Integer.valueOf(navBrandKey.getIsShow()));
			}
			if (navBrandKey.getFlag() != null
					&& !"".equals(navBrandKey.getFlag())) {
				navBrand.setFlag(Integer.valueOf(navBrandKey.getFlag()));
			}

			Integer seq = this.navBrandService.countSeq(navBrand);
			if (seq < 1) {
				navBrand.setSeq(1);
			} else {
				navBrand.setSeq(this.navBrandService.maxSeq(navBrand) + 1);
			}
			Integer number = this.navBrandService.countNavBrandRecord(navBrand);
			if (number < 1) {
				this.navBrandService.insertSelective(navBrand);
			}
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/updateNavBrandPicByBrandSid", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateNavBrandPicByBrandSid(String BrandSid, String BrandPic,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			NavBrand navBrand = new NavBrand();
			if (BrandSid != null && !"".equals(BrandSid)) {
				navBrand.setBrandSid(Long.valueOf(BrandSid));
			}
			Integer number = this.navBrandService.countNavBrandRecord(navBrand);
			if (number < 1) {
				return "{success:false,error:'此品牌不存在'}";
			}
			if (BrandPic != null && !"".equals(BrandPic)) {
				navBrand.setBrandPic(BrandPic);
			}
			this.navBrandService.updateBybrandSid(navBrand);
			return "{success:true}";
		} catch (Exception e) {
			return ResultUtil.createFailureResult(e);
		}
	}

	@ResponseBody
	@RequestMapping(value = "/saveNavPromotion", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveNavPromotion(NavPromotionKey navPromotionKey,
			HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		try {
			NavPromotion navPromotion = new NavPromotion();

			if (navPromotionKey.getNavSid() != null
					&& !"".equals(navPromotionKey.getNavSid())) {
				navPromotion
						.setNavSid(Long.valueOf(navPromotionKey.getNavSid()));
			}
			if (navPromotionKey.getPromotionSid() != null
					&& !"".equals(navPromotionKey.getPromotionSid())) {
				navPromotion.setPromotionSid(Integer.valueOf(navPromotionKey
						.getPromotionSid()));
			}
			if (navPromotionKey.getPromotionLink() != null
					&& !"".equals(navPromotionKey.getPromotionLink())) {
				navPromotion.setPromotionLink(navPromotionKey.getPromotionLink());
				}
						
			if (navPromotionKey.getPromotionName() != null
					&& !"".equals(navPromotionKey.getPromotionName())) {
				navPromotion
						.setPromotionName(navPromotionKey.getPromotionName());
			}
			if (navPromotionKey.getFlag() != null
					&& !"".equals(navPromotionKey.getFlag())) {
				navPromotion
						.setFlag(Integer.valueOf(navPromotionKey.getFlag()));
			}
			if (navPromotionKey.getIsShow() != null
					&& !"".equals(navPromotionKey.getIsShow())) {
				navPromotion
						.setIsShow(Integer.valueOf(navPromotionKey.getIsShow()));
			}
			
			if (navPromotionKey.getSeq() != null
					&& !"".equals(navPromotionKey.getSeq())) {
				navPromotion
						.setSeq(Integer.valueOf(navPromotionKey.getSeq()));
			}else{
				Integer maxSeq = this.navPromotionService.selectMaxSeq(Long
						.valueOf(navPromotionKey.getNavSid()));

				if (maxSeq < 1) {
					navPromotion.setSeq(1);
				} else {
					navPromotion.setSeq(maxSeq + 1);
				}
			}
			Integer number = this.navPromotionService
					.countNavPromotionRecord(navPromotion);
			if (number < 1) {
				this.navPromotionService.insertSelective(navPromotion);
			}

			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteNavBrand", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String deleteNavBrand(String sid, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {

			if (sid != null && !"".equals(sid)) {
				this.navBrandService.deleteByPrimaryKey(Long.valueOf(sid));
				json = ResultUtil.createSuccessResult();
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteNavPromotion", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deleteNavPromotion(String promotionSid, String navSid,String sid,
			HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		try {
			NavPromotion navpro = new NavPromotion();
//			if (promotionSid != null && !"".equals(promotionSid)) {
//				navpro.setPromotionSid(Integer.valueOf(promotionSid));
//			}
//			if (navSid != null && !"".equals(navSid)) {
//				navpro.setNavSid(Long.valueOf(navSid));
//			}
			if (sid != null && !"".equals(sid)) {
				navpro.setSid(Long.valueOf(sid));
			}
			this.navPromotionService.deleteBySid(navpro);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/updatebrandlink", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updatebrandlink(String brandName,String brandLink, String sid, String isShow,
			String flag, String seq, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			NavBrand navBrand = new NavBrand();
			if (brandName != null && !"".equals(brandName)) {
				navBrand.setBrandName(brandName);
			}
			if (brandLink != null && !"".equals(brandLink)) {
				navBrand.setBrandLink(brandLink);
			}
			if (sid != null && !"".equals(sid)) {
				navBrand.setSid(Long.valueOf(sid));
			}
			if (isShow != null && !"".equals(isShow)) {
				navBrand.setIsShow(Integer.valueOf(isShow));
			}
			if (flag != null && !"".equals(flag)) {
				navBrand.setFlag(Integer.valueOf(flag));
			}
			if (seq != null && !"".equals(seq)) {
				navBrand.setSeq(Integer.valueOf(seq));
			}
			this.navBrandService.updateByPrimaryKeySelective(navBrand);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updatepromotion", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updatepromotion(String promotionLink,String promotionName, String sid, String navSid,String isShow,
			String flag, String seq, HttpServletRequest request,
			HttpServletResponse response) {
		String json = "";
		try {
			NavPromotion navPro = new NavPromotion();
			if (promotionLink != null && !"".equals(promotionLink)) {
				navPro.setPromotionLink(promotionLink);
			}
			if (promotionName != null && !"".equals(promotionName)) {
				navPro.setPromotionName(promotionName);
			}
			if (sid != null && !"".equals(sid)) {
				navPro.setSid(Long.valueOf(sid));
			}
			if (navSid != null && !"".equals(navSid)) {
				navPro.setNavSid(Long.valueOf(navSid));
			}
			if (isShow != null && !"".equals(isShow)) {
				navPro.setIsShow(Integer.valueOf(isShow));
			}
			if (flag != null && !"".equals(flag)) {
				navPro.setFlag(Integer.valueOf(flag));
			}
			if (seq != null && !"".equals(seq)) {
				navPro.setSeq(Integer.valueOf(seq));
			}
			this.navPromotionService.updateByPrimaryKeySelective(navPro);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}


	@ResponseBody
	@RequestMapping(value = { "/dragPromotion" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public void dragPromotion(Model m, HttpServletRequest request,
			HttpServletResponse response) throws SQLException {

		String json = "";

		String navSid = request.getParameter("navSid");
		// 拖拽前的productListSid
		String selectRowPid = request.getParameter("selectRowPid");
		// 拖拽后的productListSid
		String toRowPid = request.getParameter("toRowPid");

		// 获取拖拽前的顺序号
		NavPromotion selectRow = new NavPromotion();
		selectRow.setNavSid(Long.valueOf(navSid));
		selectRow.setPromotionSid(Integer.valueOf(selectRowPid));
		NavPromotion selectNav = this.navPromotionService
				.selectByInfo(selectRow);
		Integer selectSeq = selectNav.getSeq();

		// 获取拖拽后的顺序号
		NavPromotion toRow = new NavPromotion();
		toRow.setNavSid(Long.valueOf(navSid));
		toRow.setPromotionSid(Integer.valueOf(toRowPid));
		NavPromotion toNav = this.navPromotionService.selectByInfo(toRow);
		Integer toSeq = toNav.getSeq();

		NavPromotion nav = new NavPromotion();
		nav.setNavSid(Long.valueOf(navSid));
		List<NavPromotion> list = this.navPromotionService.selectByNavSid(nav);
		for (int i = 0; i < list.size(); i++) {
			Integer orderNumber = list.get(i).getSeq();
			if (selectSeq < orderNumber && orderNumber <= toSeq) {
				list.get(i).setSeq(orderNumber - 1);
				this.navPromotionService.updateByPrimaryKeySelective(list
						.get(i));
			}
			if (toSeq <= orderNumber && orderNumber < selectSeq) {
				list.get(i).setSeq(orderNumber + 1);
				this.navPromotionService.updateByPrimaryKeySelective(list
						.get(i));
			}
		}
		// 更新选中的数据
		selectRow.setSid(selectNav.getSid());
		selectRow.setSeq(toSeq);
		selectRow.setIsShow(1);
		this.navPromotionService.updateByPrimaryKeySelective(selectRow);

	}

}
