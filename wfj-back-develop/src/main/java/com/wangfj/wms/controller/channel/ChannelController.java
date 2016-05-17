/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controller.ChannelController.java
 * @Create By chengsj
 * @Create In 2013-7-12 下午12:26:15
 * TODO
 */
package com.wangfj.wms.controller.channel;

import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.constants.SystemConfig;
import com.framework.validation.EValidator;
import com.wangfj.order.utils.HttpUtil;
import com.wangfj.wms.domain.entity.Channel;
import com.wangfj.wms.domain.entity.ChannelAds;
import com.wangfj.wms.service.IChannelAdsService;
import com.wangfj.wms.service.IChannelService;
import com.wangfj.wms.util.FtpUtil;
import com.wangfj.wms.util.ResultUtil;

/**
 * 渠道控制器
 * 
 * @Class Name ChannelController
 * @Author chengsj
 * @Create In 2013-7-12
 */
@Controller
@RequestMapping(value = "/channel")
public class ChannelController {

	@Autowired
			@Qualifier("channelService")
	IChannelService channelService;
	
	@Autowired
			@Qualifier("channelAdsService")
	IChannelAdsService channelAdsService;

	private int maxPostSize = 100 * 1024 * 1024;
	
	/**
	 * 调用pcm-admin系统查询所有渠道
	 * 
	 * @Methods Name findChannel
	 * @Create In 2015年8月12日 By wangsy
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/findChannel", method = {RequestMethod.GET, RequestMethod.POST})
	public String findChannel(){
		String json = "";
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			json = HttpUtil.HttpPost(SystemConfig.SSD_SYSTEM_URL,
					"/propvaluecontroller/bw/comboxlistlist.htm", map);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "/selectAllChannels", method = {RequestMethod.GET, RequestMethod.POST})
	public String selectAllChannels(HttpServletRequest request, HttpServletResponse response){
		String json = "";
		try {
			List list = this.channelService.selectAllChannles();
			json = ResultUtil.createSuccessResult(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "/channeltree", method = {RequestMethod.POST,RequestMethod.GET})
	public String querychanneltree(Model mode, HttpServletRequest request, HttpServletResponse response) {
		
		List list = this.channelService.selectAllChannles();
		
		JSONArray json = new JSONArray();
		JSONObject object;
		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				Channel channel = (Channel) list.get(i);
				object = new JSONObject();
				object.put("pageName", channel.getName());
				object.put("id", channel.getSid());
				object.put("text", channel.getDisplayName());
                object.put("leaf", true);
				json.add(object);
			}
		}
		return json.toString();
	}

	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "/channellist", method = {RequestMethod.POST,RequestMethod.GET})
	public String channellist(Model mode, HttpServletRequest request, HttpServletResponse response) {
		
		List chs = this.channelService.selectAllChannles();
		
		JSONObject res = new JSONObject();
		JSONObject data = new JSONObject();
		JSONArray list = new JSONArray();
		JSONObject object;
		if (chs != null && chs.size() > 0) {
			for (int i = 0; i < chs.size(); i++) {
				Channel shopCha = (Channel) chs.get(i);
				object = new JSONObject();
				object.put("sid", shopCha.getSid());
				object.put("cName", shopCha.getDisplayName());
				list.add(object);
			}
		}
		data.put("list", list);
		data.put("totalRecords", list.size());
		res.put("data", data);
		return res.toString();
	}
	
	@EValidator(value = "sid,主键,validate-required validate-length-max-32;")
	@ResponseBody
	@RequestMapping(value = "/{sid}", method = RequestMethod.GET)
	public String find(@PathVariable Integer sid, Model mode,HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		try {
				this.channelService.selectByPrimaryKey(sid);
				json = ResultUtil.createSuccessResult();
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json; 
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/queryAdsByChannelSid", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String queryAdsByChannelSid(Model mode, HttpServletRequest request,
			HttpServletResponse response, String channelSid) {
		String json = "";
		try {
			if (channelSid != null && !"".equals(channelSid)) {
				List<ChannelAds> list = this.channelAdsService
						.selectByChannelSid(Integer.valueOf(channelSid));
				json = ResultUtil.createSuccessResult(list);
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "/saveAds", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String saveAdsInChannel(HttpServletRequest request,
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

		ChannelAds channelAds = new ChannelAds();
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
				if (key == "pic" || "pic".equals(key)) {
					channelAds.setPic("/" + SystemConfig.PROMOTION_PATH + "/"
							+ upName);
				}
			} else {
				if (key == "positioname" || "positioname".equals(key)) {
					channelAds.setPositioname(value);
				}
				if (key == "link" || "link".equals(key)) {
					channelAds.setLink(value);
				}
				if (key == "memo" || "memo".equals(key)) {
					channelAds.setMemo(value);
				}
				if (key == "channelSid" || "channelSid".equals(key)) {
					channelAds.setShopChannelSid(Integer.valueOf(value));
				}
			}
		}
		this.channelAdsService.insertSelective(channelAds);
		json = ResultUtil.createSuccessResult();
		return json;
	}

	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "/updateAds", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateAdsInChannel(HttpServletRequest request,
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

		ChannelAds channelAds = new ChannelAds();
		List fileItems = upload.parseRequest(request);
		name = FtpUtil.getImagePath();
		for (int i = 0; i < fileItems.size(); i++) {
			FileItem item = (FileItem) fileItems.get(i);
			if (item.getFieldName() == "sid"
					|| "sid".equals(item.getFieldName())) {
				channelAds = this.channelAdsService.selectByPrimaryKey(Integer
						.valueOf(item.getString(encoding)));
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
				if ("pic".equals(key) && !(value.equals(channelAds.getPic()))) {
					upName = name + i + "." + filename.split("\\.")[1];
					FtpUtil.saveToFtp(out, upName, item);
					channelAds.setPic("/" + SystemConfig.PROMOTION_PATH + "/"
							+ upName);
				}
			} else {
				if (key == "positioname" || "positioname".equals(key)) {
					channelAds.setPositioname(value);
				}
				if (key == "link" || "link".equals(key)) {
					channelAds.setLink(value);
				}
				if (key == "memo" || "memo".equals(key)) {
					channelAds.setMemo(value);
				}
				if (key == "channelSid" || "channelSid".equals(key)) {
					channelAds.setShopChannelSid(Integer.valueOf(value));
				}
			}
		}
		this.channelAdsService.updateByPrimaryKeySelective(channelAds);
		json = ResultUtil.createSuccessResult();
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/delAdsBySid", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String delAdsBySid(Model mode, HttpServletRequest request,
			HttpServletResponse response, String sid) {
		String json = "";
		try {
			if (sid != null && !"".equals(sid)) {
				this.channelAdsService.deleteByPrimaryKey(Integer.valueOf(sid));
				json = ResultUtil.createSuccessResult();
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
}
