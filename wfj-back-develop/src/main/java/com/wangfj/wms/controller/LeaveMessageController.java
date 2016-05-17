/**
 * @Probject Name: shopin-back-demo
 * @Path: com.wangfj.wms.controllerLeaveMessageController.java
 * @Create By chengsj
 * @Create In 2013-8-15 上午9:42:16
 * TODO
 */
package com.wangfj.wms.controller;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.wms.domain.entity.LeaveMessage;
import com.wangfj.wms.domain.view.LeaveMessageKey;
import com.wangfj.wms.domain.view.LeaveMessageVO;
import com.wangfj.wms.service.ILeaveMessageService;
import com.wangfj.wms.util.CookiesUtil;
import com.wangfj.wms.util.LeaveMessageUtil;
import com.wangfj.wms.util.PageModel;
import com.wangfj.wms.util.ResultUtil;

/**
 * @Class Name LeaveMessageController
 * @Author chengsj
 * @Create In 2013-8-15
 */
@Controller
@RequestMapping(value = "/leaveMessage")
public class LeaveMessageController {
	@Autowired
			@Qualifier("leaveMessageService")
	ILeaveMessageService leaveMessageService;

	/**
	 * 说明： 留言是否显示到公共留言板
	 * 
	 * @Create In 2013-8-15 By chengsj
	 * @param msgId
	 * @param commonVisible
	 *            是否显示到公共留言板1：显示，0：不显示
	 * @param request
	 * @param response
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/updateCommonVisible", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String updateCommonVisible(String msgId, String commonVisible,
			HttpServletRequest request, HttpServletResponse response) {
		String json = "";
		String success = "false";
		String memo = "";
		try {
			LeaveMessage leaveMessage = this.leaveMessageService
					.selectByPrimaryKey(Integer.parseInt(msgId));
			if (leaveMessage != null) {
				if (!("1").equals(commonVisible)
						&& !("0").equals(commonVisible)) {
					memo = "commoVisible只能为0或1";
				} else {
					leaveMessage.setCommonvisible(Integer
							.parseInt(commonVisible));
					this.leaveMessageService.updateByPrimaryKey(leaveMessage);
					if (("1".equals(commonVisible))) {
						memo = "显示留言到公共留言板成功";
					} else {
						memo = "取消公共留言板显示成功";
					}
					success = "success";
				}
			} else {
				memo = "msgId为" + msgId + "的留言不存在";
			}
			json = ResultUtil.createCommonVisibleResult(success, memo);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

	/**
	 * 说明：
	 * 		分页查询显示留言信息
	 * @Methods Name selectLeaveMessageByParms
	 * @Create In 2013-12-11 By chengsj
	 * @param key
	 * @param request
	 * @param response
	 * @return
	 * @throws ParseException String
	 */
	@ResponseBody
	@RequestMapping(value = "/selectByParams", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String selectLeaveMessageByParms(LeaveMessageKey key,
			HttpServletRequest request, HttpServletResponse response)
			throws ParseException {
		String json = "";
		try {
			LeaveMessageVO vo = LeaveMessageUtil.resultMessage(key);
			List list = this.leaveMessageService.selectByParms(vo);
			Integer total = this.leaveMessageService.selectPageCount(vo);
			PageModel page = new PageModel();
			page.setTotal(total);
			page.setStart(vo.getStart());
			page.setPageNo(vo.getPageNo());
			page.setResult(list);
			json = ResultUtil.createSuccessResultPage(page);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
	
	/**
	 * 说明：
	 * 		回复/删除留言
	 * @Methods Name updateLeaveMsgSelective
	 * @Create In 2013-12-11 By chengsj
	 * @param record
	 * @param request
	 * @param response
	 * @return
	 * @throws ParseException String
	 */
	@ResponseBody
	@RequestMapping(value = "/updateByPrimaryKeySelective", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String updateLeaveMsgSelective(LeaveMessage record,
			HttpServletRequest request, HttpServletResponse response)
			throws ParseException {
		String json = "";
		try {
			if(record.getReplaystatu() != null && record.getReplaystatu() >0) {
				//设置留言回复时间
				record.setReplaytime(new Date());
				//获取当前登陆用户名
//				String username = request.getSession().getAttribute("username").toString();
				String username = CookiesUtil.getCookies(request, "username");
				record.setReplayer(username);
			}
			Integer id = this.leaveMessageService.updateByPrimaryKeySelective(record);
			if (id != null && id > 0) {
				json = ResultUtil.createSuccessResult();
			} else {
				json = ResultUtil.createFailureResult("", "修改失败");
			}
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}
}
