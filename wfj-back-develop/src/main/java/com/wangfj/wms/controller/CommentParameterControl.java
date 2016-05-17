package com.wangfj.wms.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wangfj.wms.domain.entity.CommentParameters;
import com.wangfj.wms.service.ICommentParametersSerice;
import com.wangfj.wms.util.ResultUtil;

@Controller
@RequestMapping(value = "/commentParameter")
public class CommentParameterControl {

	@Autowired
	@Qualifier(value = "commentParametersSevice")
	private ICommentParametersSerice commentParametersSerice;

	/**
	 * 
	 * @Methods Name updateParameter
	 * @Create In 2014-8-5 By chengsj
	 * @param request
	 * @param response
	 * @param times
	 *            客户每天评论的次数
	 * @param interval
	 *            客户每次评论的时间间隔
	 * @param timesText
	 *            客户每天评论的次数(页面输入框的值)
	 * @param intervalText
	 *            客户每次评论的时间间隔(页面输入框的值)
	 * @return String
	 * 
	 */
	@ResponseBody
	@RequestMapping(value = "/setParameters", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String setParameters(HttpServletRequest request,
			HttpServletResponse response, String times, String interval,
			String timesText, String intervalText) {
		String json = "";
		int status = 0;

		if (timesText != null && !"".equals(timesText)) {
			times = timesText;
		}
		if (intervalText != null && !"".equals(intervalText)) {
			interval = intervalText;
		}
		if ((times == null || "".equals(times))
				&& (timesText == null || "".equals(timesText))) {
			return ResultUtil.createFailureResult("", "times 不能为空");
		}
		if ((interval == null || "".equals(interval))
				&& (intervalText == null || "".equals(intervalText))) {
			return ResultUtil.createFailureResult("", "interval 不能为空");
		}

		CommentParameters cp = this.commentParametersSerice
				.selectByPrimaryKey(1);
		if (cp != null) {
			cp.setCommentTimes(Integer.valueOf(times));
			cp.setInterval(Integer.valueOf(interval));
			status = this.commentParametersSerice
					.updateByPrimaryKeySelective(cp);
		} else {
			CommentParameters commentP = new CommentParameters();
			commentP.setSid(1);
			commentP.setCommentTimes(Integer.valueOf(times));
			commentP.setInterval(Integer.valueOf(interval));
			status = this.commentParametersSerice.insertSelective(commentP);
		}

		if (status > 0) {
			json = ResultUtil.createSuccessResult();
		} else {
			json = ResultUtil.createFailureResult("", "");
		}
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "/selectAllParameter", method = {
			RequestMethod.GET, RequestMethod.POST })
	public String selectAllParameter(HttpServletResponse response,
			HttpServletRequest request) {
		String json = "";
		List<CommentParameters> list = new ArrayList<CommentParameters>();
		CommentParameters record = new CommentParameters();
		try {
			list = this.commentParametersSerice.querytByselective(record);
			json = ResultUtil.createSuccessResult(list);
		} catch (Exception e) {
			json = ResultUtil.createFailureResult(e);
		}
		return json;
	}

}
