/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerFlashPageLayoutController.java
 * @Create By chengsj
 * @Create In 2013-9-2 下午4:44:24
 * TODO
 */
package com.wangfj.wms.controller;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.wangfj.wms.domain.entity.Channel;
import com.wangfj.wms.domain.entity.PageLayoutBrand;
import com.wangfj.wms.domain.entity.PageLayoutContent;
import com.wangfj.wms.domain.entity.PageLayoutMql;
import com.wangfj.wms.domain.entity.Promotions;
import com.wangfj.wms.domain.view.ChannelPromotionVO;
import com.wangfj.wms.service.IChannelService;
import com.wangfj.wms.service.IPageLayoutBrandService;
import com.wangfj.wms.service.IPageLayoutContentService;
import com.wangfj.wms.service.IPageLayoutMqlService;
import com.wangfj.wms.service.IPromotionService;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.HttpUtil;
import com.wangfj.wms.util.PageLayoutMqlKey;
import com.wangfj.wms.util.PageLayoutMqlUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name FlashPageLayoutController
 * @Author chengsj
 * @Create In 2013-9-2
 */

@Controller
@RequestMapping("/flashPageLayout")
public class FlashPageLayoutController {

	@Autowired
	@Qualifier("pageLayoutMqlService")
	private IPageLayoutMqlService pageLayoutMqlService;

	@Autowired
	@Qualifier("pageLayoutBrandService")
	private IPageLayoutBrandService pageLayoutBrandService;

	@Autowired
			@Qualifier("channelService")
	IChannelService channelService;

	@Autowired
			@Qualifier("promotionService")
	IPromotionService promotionService;

	@Autowired
	@Qualifier("pageLayoutContentService")
	private IPageLayoutContentService pageLayoutContentService;

	private int maxPostSize = 100 * 1024 * 1024;

	@ResponseBody
	@RequestMapping(value = { "/tree" }, method = { RequestMethod.GET,
			RequestMethod.POST })
	public String pageLayoutTree(Model m, HttpServletRequest request,
			HttpServletResponse response, String node) throws SQLException {
		String pageLayoutSid = request.getParameter("pageLayoutSid");
		Assert.notNull(pageLayoutSid);
		JSONObject obj = new JSONObject();
		List list;
		// PageLayoutMql vo2;
		if (node == null || "".equals(node) || node.indexOf("node") > 0) {
			list = this.pageLayoutMqlService.queryChildPageLayout(Long
					.valueOf(pageLayoutSid));
			// vo2 =
			// this.pageLayoutMqlService.selectByPrimaryKey(Integer.valueOf(pageLayoutSid));
		} else {
			list = this.pageLayoutMqlService.queryChildPageLayout(Long
					.valueOf(node));
			// vo2 =
			// this.pageLayoutMqlService.selectByPrimaryKey(Integer.valueOf(node));
		}

		// if(vo2.getPageLayoutSid()!=null){
		// obj.put("parentLinktype", vo2.getProLinkType());
		// }

		JSONArray json = new JSONArray();
		// JSONObject obj = null;
		Integer isleaf = null;

		if (list != null && !list.isEmpty()) {
			for (Iterator iter = list.iterator(); iter.hasNext();) {
				PageLayoutMql vo = (PageLayoutMql) iter.next();
				String startTime = "";
				String endTime = "";
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				if (vo.getStartTime() != null && !"".equals(vo.getStartTime())) {
					startTime = df.format(vo.getStartTime());
				}
				if (vo.getEndTime() != null && !"".equals(vo.getEndTime())) {
					endTime = df.format(vo.getEndTime());
				}
				obj.put("id", vo.getSid());
				obj.put("text", vo.getTitle());
				obj.put("pageLayoutSid", vo.getPageLayoutSid());
				obj.put("seq", vo.getSeq());
				obj.put("proLinktype", vo.getProLinkType());
				obj.put("titleLink", vo.getTitleLink());
				obj.put("pageLayoutTemplateSid", vo.getPageLayoutTemplateSid());
				obj.put("startTime", startTime);
				obj.put("endTime", endTime);

				PageLayoutMql cond = new PageLayoutMql();
				cond.setPageLayoutSid(vo.getSid());
				isleaf = this.pageLayoutMqlService.queryObjsCount(cond);

				if (isleaf == 0) {
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
	@RequestMapping(value = "/dragTreeOfDifParent", method = RequestMethod.POST)
	public String dragTreeOfDifParent(PageLayoutMqlKey key, Model mode,
			HttpServletRequest request, HttpServletResponse response) {

		String json = "";
		try {

			PageLayoutMql pageLayout = PageLayoutMqlUtil
					.pageLayoutMqlResult(key);
			int count = this.pageLayoutMqlService
					.queryCountByPageLayoutSid(Integer.valueOf(key
							.getPageLayoutSid()));
			if (count > 0) {
				int seq = this.pageLayoutMqlService
						.queryMaxSeqByPageLayoutSid(Integer.valueOf(key
								.getPageLayoutSid()));
				pageLayout.setSeq((seq + 1) + "");
			} else {
				pageLayout.setSeq("1");
			}
			this.pageLayoutMqlService.updateByPrimaryKeySelective(pageLayout);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		} 
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/dragTreeOfSameParent", method = RequestMethod.POST)
	public String dragTreeOfSameParent(String pageLayoutSid, String fromSeq,
			String toSeq, Model mode, String sid, HttpServletRequest request,
			HttpServletResponse response) {

		String json = "";
		int seq = Integer.valueOf(toSeq);
		int maxSeq = Integer.valueOf(fromSeq);
		try {
			//向上拖拽
			if (seq < maxSeq) {
				for (int i = maxSeq - 1; i >= seq; i--) {
					PageLayoutMql page = new PageLayoutMql();
					page.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
					page.setSeq(i + "");
					List<PageLayoutMql> list = this.pageLayoutMqlService
							.queryByPrimaryKeySelective(page);
					for (int j = 0; j < list.size(); j++) {
						list.get(j).setSeq(i + 1 + "");
						this.pageLayoutMqlService.updateByPrimaryKey(list
								.get(j));
					}
				}

				PageLayoutMql pageLayout = new PageLayoutMql();
				pageLayout.setSid(Integer.valueOf(sid));
				pageLayout.setSeq(toSeq);
				this.pageLayoutMqlService
						.updateByPrimaryKeySelective(pageLayout);
			} else {
				//乡下拖拽
				for (int i = maxSeq + 1; i <= seq; i++) {
					PageLayoutMql page = new PageLayoutMql();
					page.setPageLayoutSid(Integer.valueOf(pageLayoutSid));
					page.setSeq(i + "");
					List<PageLayoutMql> list = this.pageLayoutMqlService
							.queryByPrimaryKeySelective(page);
					for (int j = 0; j < list.size(); j++) {
						list.get(j).setSeq(i - 1 + "");
						this.pageLayoutMqlService.updateByPrimaryKey(list
								.get(j));
					}
				}

				PageLayoutMql pageLayout = new PageLayoutMql();
				pageLayout.setSid(Integer.valueOf(sid));
				pageLayout.setSeq(toSeq);
				this.pageLayoutMqlService
						.updateByPrimaryKeySelective(pageLayout);
			}
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/insertFlashPageLayout", method = RequestMethod.POST)
	public String insertPageLayout(PageLayoutMqlKey key, Model mode,
			HttpServletRequest request, HttpServletResponse response) {

		String json = "";
		try {

			PageLayoutMql pageLayout = PageLayoutMqlUtil
					.pageLayoutMqlResult(key);
			if (key.getSeq() == null || "".equals(key.getSeq())) {
				int count = this.pageLayoutMqlService
						.queryCountByPageLayoutSid(Integer.valueOf(key
								.getPageLayoutSid()));
				if (count > 0) {
					int seq = this.pageLayoutMqlService
							.queryMaxSeqByPageLayoutSid(Integer.valueOf(key
									.getPageLayoutSid()));
					pageLayout.setSeq((seq + 1) + "");
				} else {
					pageLayout.setSeq("1");
				}
			}
			this.pageLayoutMqlService.insert(pageLayout);
			json = ResultUtil.createSuccessResult();

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/updateFlashPageLayout", method = RequestMethod.POST)
	public String updateFlashPageLayout(PageLayoutMqlKey key, Model mode,
			HttpServletRequest request, HttpServletResponse response) {

		String json = "";
		try {

			PageLayoutMql pageLayout = PageLayoutMqlUtil
					.pageLayoutMqlResult(key);
			this.pageLayoutMqlService.updateByPrimaryKeySelective(pageLayout);

			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		} 
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/delete/{sid}", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String delete(@PathVariable Integer sid, Model mode,
			HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		try {
			this.pageLayoutMqlService.deleteByPrimaryKey(sid);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/selectQueryBySid", method = RequestMethod.POST)
	public String selectQueryBySid(String sid, Model mode,
			HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		try {
			PageLayoutMql list = this.pageLayoutMqlService
					.selectByPrimaryKey(Integer.valueOf(sid));
			json = ResultUtil.createSuccessResult(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;

	}

	@ResponseBody
	@RequestMapping(value = "/queryPageLayout", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String queryPageLayout(Model m, HttpServletRequest request,
			HttpServletResponse response) {

		String json = "";
		String channelSid = request.getParameter("channelSid");

		PageLayoutMql pageLayoutMql = new PageLayoutMql();
		pageLayoutMql.setChannelSid(Integer.valueOf(channelSid));
		try {
			List list = this.pageLayoutMqlService.queryByChannel(Integer
					.valueOf(channelSid));
			json = ResultUtil.createSuccessResult(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/saveSelectPageLayout", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String saveSelectPageLayout(Model m, HttpServletRequest request,
			HttpServletResponse response, String channelSid, String pageType,
			String sid) throws SQLException {
		String json = "";
		try {
			Channel channel = new Channel();
			channel.setSid(Integer.valueOf(channelSid));
			channel.setPageLayoutSid(Integer.valueOf(sid));
			this.channelService.updateByPrimaryKeySelective(channel);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryPromotionByChannel", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryPromotionByChannel(Model m, HttpServletRequest request,
			HttpServletResponse response, String channelSid)
			throws SQLException {
		String json = "";
		try {
			List<Integer> sids = this.channelService
					.queryPromotionByChannelSid(Integer.valueOf(channelSid));
			List<Promotions> List = new ArrayList<Promotions>();
			if (sids == null || sids.size() == 0) {
				return ResultUtil.createSuccessResult(List);
			}
			List = this.promotionService.queryBySids(sids);
			json = ResultUtil.createSuccessResult(List);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/savePromotionInChannel", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String savePromotionInChannel(Model m, HttpServletRequest request,
			HttpServletResponse response, String channelSid, String promotionSid)
			throws SQLException {
		String json = "";
		try {
			String[] promotionsids = promotionSid.split(",");
			this.channelService.savePromotionBatch(Integer.valueOf(channelSid),
					promotionsids);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/deletePromotionInChannel", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deletePromotionInChannel(Model m, HttpServletRequest request,
			HttpServletResponse response, String channelSid, String promotionSid)
			throws SQLException {
		String json = "";
		try {
			ChannelPromotionVO vo = new ChannelPromotionVO();
			vo.setPromotionSid(Integer.valueOf(promotionSid));
			vo.setShopChannelSid(Integer.valueOf(channelSid));
			this.channelService.delPeomotion(vo);
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryBrandsByPageLayoutSid", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryBrandsByPageLayoutSid(Model m,
			HttpServletRequest request, HttpServletResponse response,
			String pageLayoutSid) {

		String json = "";
		StringBuffer sf = new StringBuffer();
		try {
			List<PageLayoutBrand> pageBrand = this.pageLayoutBrandService
					.selectByPageLayoutSid(Integer.valueOf(pageLayoutSid));
			if (pageBrand == null || pageBrand.size() == 0) {
				return ResultUtil.createSuccessResultJson(pageBrand);
			}
			for (int i = 0; i < pageBrand.size(); i++) {
				Integer brandSid = pageBrand.get(i).getBrandSid();
				sf.append(brandSid + ",");
			}
			Map resultMap = new HashMap();
			resultMap.put("param", sf);
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"bw/getByBrandSids.html", resultMap);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/savePageLayoutBrand", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String savePageLayoutBrand(Model m, HttpServletRequest request,
			HttpServletResponse response, String brandSid, String pageLayoutSid) {

		String json = "";
		try {
			if (brandSid != null && !"".equals(brandSid)) {
				brandSid = brandSid.substring(0, brandSid.length() - 1);
				String[] sid = brandSid.split(",");

				for (int i = 0; i < sid.length; i++) {
					PageLayoutBrand pageLayoutBrand = new PageLayoutBrand();
					pageLayoutBrand.setPageLayoutSid(Integer
							.valueOf(pageLayoutSid));
					pageLayoutBrand.setBrandSid(Integer.valueOf(sid[i]));
					this.pageLayoutBrandService.insert(pageLayoutBrand);
				}
			}

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/deletePageLayoutBrand", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deletePageLayoutBrand(Model m, HttpServletRequest request,
			HttpServletResponse response, String brandSid, String pageLayoutSid) {

		String json = "";
		try {
			if (brandSid != null && !"".equals(brandSid)) {
				brandSid = brandSid.substring(0, brandSid.length() - 1);
				String[] sidArray = brandSid.split(",");

				for (int i = 0; i < sidArray.length; i++) {
					PageLayoutBrand pageLayoutBrand = new PageLayoutBrand();
					pageLayoutBrand.setBrandSid(Integer.valueOf(sidArray[i]));
					pageLayoutBrand.setPageLayoutSid(Integer
							.valueOf(pageLayoutSid));
					this.pageLayoutBrandService.deleteBySelect(pageLayoutBrand);
				}
			}

		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/queryContentByPageLayoutSid", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryContentByPageLayoutSid(Model m,
			HttpServletRequest request, HttpServletResponse response,
			String pageLayoutSid) {

		String json = "";
		try {

			List<PageLayoutContent> list = this.pageLayoutContentService
					.queryByPageLayoutSid(Integer.valueOf(pageLayoutSid));
			json = ResultUtil.createSuccessResult(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/saveContent", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveContent(HttpServletRequest request,
			HttpServletResponse response) throws FileUploadException,
			ParseException, UnsupportedEncodingException {
		String json = "";
		String name;
		OutputStream out = null;
		String encoding = request.getCharacterEncoding();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxPostSize);

		PageLayoutContent pageLayoutContent = new PageLayoutContent();
		List fileItems = upload.parseRequest(request);
		name = FtpUtil.getImagePath();
		for (int i = 0; i < fileItems.size(); i++) {
			FileItem item = (FileItem) fileItems.get(i);
			String key = item.getFieldName();
			String value = item.getString(encoding);
			if (!item.isFormField() && item.getName() != null
					&& !"".equals(item.getName())) {
				String filename = item.getName();
				String upName = "";
				upName = name + i + "." + filename.split("\\.")[1];
				FtpUtil.saveToFtp(out, upName, item);
				if (key == "pict" || "pict".equals(key)) {
					pageLayoutContent.setPict("/" + SystemConfig.PROMOTION_PATH
							+ "/" + upName);
				}
			} else {
				if (key == "mainTitle" || "mainTitle".equals(key)) {
					pageLayoutContent.setMainTitle(value);
				}
				if (key == "link" || "link".equals(key)) {
					pageLayoutContent.setLink(value);
				}
				if (key == "subTitle" || "subTitle".equals(key)) {
					pageLayoutContent.setSubTitle(value);
				}
				if (key == "pageLayoutSid" || "pageLayoutSid".equals(key)) {
					pageLayoutContent.setPageLayoutSid(Integer.valueOf(value));
				}
				if (key == "seq" || "seq".equals(key)) {
					pageLayoutContent.setSeq(value);
				}
			}
		}
		this.pageLayoutContentService.insertSelective(pageLayoutContent);
		json = ResultUtil.createSuccessResult();
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/updateContent", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateContent(HttpServletRequest request,
			HttpServletResponse response) throws FileUploadException,
			ParseException, UnsupportedEncodingException {
		String json = "";
		String name;
		OutputStream out = null;
		String encoding = request.getCharacterEncoding();
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(maxPostSize);

		PageLayoutContent pageLayoutContent = new PageLayoutContent();
		List fileItems = upload.parseRequest(request);
		name = FtpUtil.getImagePath();
		for (int i = 0; i < fileItems.size(); i++) {
			FileItem item = (FileItem) fileItems.get(i);
			if (item.getFieldName() == "sid"
					|| "sid".equals(item.getFieldName())) {
				pageLayoutContent = this.pageLayoutContentService
						.selectByPrimaryKey(Integer.valueOf(item.getString()));
				break;
			}
		}
		for (int i = 0; i < fileItems.size(); i++) {
			FileItem item = (FileItem) fileItems.get(i);
			String key = item.getFieldName();
			String value = item.getString(encoding);
			if (!item.isFormField() && item.getName() != null
					&& !"".equals(item.getName())) {
				String filename = item.getName();
				String upName = "";
				if ("updatepict".equals(key)
						&& !(value.equals(pageLayoutContent.getPict()))) {
					upName = name + i + "." + filename.split("\\.")[1];
					FtpUtil.saveToFtp(out, upName, item);
					pageLayoutContent.setPict("/" + SystemConfig.PROMOTION_PATH
							+ "/" + upName);
				}
			} else {
				if (key == "mainTitle" || "mainTitle".equals(key)) {
					pageLayoutContent.setMainTitle(value);
				}
				if (key == "link" || "link".equals(key)) {
					pageLayoutContent.setLink(value);
				}
				if (key == "subTitle" || "subTitle".equals(key)) {
					pageLayoutContent.setSubTitle(value);
				}
				if (key == "seq" || "seq".equals(key)) {
					pageLayoutContent.setSeq(value);
				}
			}
		}
		this.pageLayoutContentService
				.updateByPrimaryKeySelective(pageLayoutContent);
		json = ResultUtil.createSuccessResult();
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/deleteContentBySid", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String deleteContentBySid(Model m, HttpServletRequest request,
			HttpServletResponse response, String sid) {

		String json = "";
		try {
			sid = sid.substring(0, sid.length() - 1);
			String[] sidArray = sid.split(",");
			for (int i = 0; i < sidArray.length; i++) {
				this.pageLayoutContentService.deleteByPrimaryKey(Integer
						.valueOf(sidArray[i]));
			}
			json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}

		return json;
	}
}
