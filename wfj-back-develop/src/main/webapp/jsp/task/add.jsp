<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setAttribute("ctx", request.getContextPath());
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${ctx}/js/jquery-1.9.1.js"></script>
<script src="${ctx}/js/jquery.form.js"></script>
<script src="${ctx}/assets/js/validation/bootstrapValidator.js"></script>
<title>定时任务信息</title>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	
	$(function(){
  		//查询任务类型
  		var adspaceId = $("#type");
		$.ajax({
			type: "post",
			contentType: "application/x-www-form-urlencoded;charset=utf-8",
			url: __ctxPath+"/adverties/findAdspace",
			dataType: "json", 
			success: function(response) {
				var result = response.list;
				adspaceId.html("<option value='-1'>全部</option>");
				for ( var i = 0; i < result.length; i++) {
					var ele = result[i];
					var option = $("<option value='" + ele.adspaceId + "'>"
							+ ele.adspaceName + "</option>");
					option.appendTo(adspaceId);
				}
				return;
			},
			error: function() {
				$("#model-body-warning").html("<div class='alert alert-error fade in'><i class='fa-fw fa fa-times'></i><strong>系统出错!</strong></div>");
  	  			$("#modal-warning").attr({"style":"display:block;","aria-hidden":"false","class":"modal modal-message modal-error"});
			}
		});
	});
	
	
	$(function() {
		$('#theForm').bootstrapValidator({
			message : 'This value is not valid',
			feedbackIcons : {
				valid : 'glyphicon glyphicon-ok',
				invalid : 'glyphicon glyphicon-remove',
				validating : 'glyphicon glyphicon-refresh'
			},
			submitHandler : function(validator, form, submitButton) {
				// Do nothing
			},
			fields : {
				brandName : {
					validators : {
						notEmpty : {
							message : '广告名称不能为空'
						}
					}
				},
				brandSid : {
					validators : {
						notEmpty : {
							message : '广告类型不能为空'
						}
					}
				}

			}

		}).find('button[data-toggle]').on(
				'click',
				function() {
					var $target = $($(this).attr('data-toggle'));
					$target.toggle();
					if (!$target.is(':visible')) {
						$('#theForm').data('bootstrapValidator')
								.disableSubmitButtons(false);
					}
				});

		$("#save").click(function() {
			saveFrom();
		});
		$("#close").click(function() {
			$("#pageBody").load(__ctxPath + "/jsp/task/list.jsp");
		});
	});
	//保存数据
	function saveFrom() {
		if ($("#name").val() == "" || $("#link").val() == "") {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>导航必填缺失!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
		} else {
			/* $("#theForm").ajaxSubmit({ */
			$
					.ajax({
						type : "post",
						contentType : "application/x-www-form-urlencoded;charset=utf-8",
						dataType : "json",
						ajaxStart : function() {
							$("#loading-container").attr("class",
									"loading-container");
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass(
										"loading-inactive")
							}, 300);
						},
						url : __ctxPath + "/task/save",
						data : $("#theForm").serialize(),
						success : function(response) {
							if (response.success == 'true') {
								$("#modal-body-success")
										.html(
												"<div class='alert alert-success fade in'>"
														+ "<i class='fa-fw fa fa-times'></i><strong>添加成功，返回列表页!</strong></div>");
								$("#modal-success")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-success"
												});
							} else if (response.success == 'false') {
								$("#model-body-warning")
										.html(
												"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>添加失败！</strong></div>");
								$("#modal-warning")
										.attr(
												{
													"style" : "display:block;",
													"aria-hidden" : "false",
													"class" : "modal modal-message modal-warning"
												});
							}
						}
					});
		}
	}

	function selectTaskType(){
		var type=$("#type").val();
		$("#acqu").hide();
		$("#attr_acqu_id").prop("disabled","disabled");
		$("#floderTable").hide();
		$("#ftp").hide();
		$("#attr_ftp_id").prop("disabled","disabled");
		$("#attr_channel_id").parent().hide();
		$("#attr_channel_id").prop("disabled","disabled");
		if(type==1){
			$("#jobClass").val("com.dgcms.cms.task.job.IndexStaticJob");
		}else if(type==2){
			$("#jobClass").val("com.dgcms.cms.task.job.ChannelStaticJob");
			$("#attr_channel_id").parent().show();
			$("#attr_channel_id").prop("disabled","");
		}else if(type==3){
			$("#jobClass").val("com.dgcms.cms.task.job.ContentStaticJob");
			$("#attr_channel_id").parent().show();
			$("#attr_channel_id").prop("disabled","");
		}else if(type==4){
			$("#jobClass").val("com.dgcms.cms.task.job.AcquisiteJob");
			$("#acqu").show();
			$("#attr_acqu_id").prop("disabled","");
		}else if(type==5){
			$("#jobClass").val("com.dgcms.cms.task.job.DistributeJob");
			$("#floderTable").show();
			$("#ftp").show();
			$("#attr_ftp_id").prop("disabled","");
		}
	}
		
		
	function execycleSelect() {
		var execycleValue = 1;
		$("input[name='execycle']").each(function() {
			if ($(this).prop("checked")) {
				execycleValue = $(this).val();
			}
		});
		if (execycleValue == 1) {
			$("#dayOfMonthInput").prop("disabled", "");
			$("#dayOfWeekInput").prop("disabled", "");
			$("#hourInput").prop("disabled", "");
			$("#minuteInput").prop("disabled", "");
			$("#intervalHourInput").prop("disabled", "");
			$("#intervalMinuteInput").prop("disabled", "");
			$("#intervalUnit").prop("disabled", "");
			$("#cronExpression").prop("disabled", "disabled");
		} else {
			$("#dayOfMonthInput").prop("disabled", "disabled");
			$("#dayOfWeekInput").prop("disabled", "disabled");
			$("#hourInput").prop("disabled", "disabled");
			$("#minuteInput").prop("disabled", "disabled");
			$("#intervalHourInput").prop("disabled", "disabled");
			$("#intervalMinuteInput").prop("disabled", "disabled");
			$("#intervalUnit").prop("disabled", "disabled");
			$("#cronExpression").prop("disabled", "");
		}
	}

	function selectUnit() {
		var intervalUnitValue = $("#intervalUnit").val();
		controlInput(intervalUnitValue);
	}
	function controlInput(intervalUnitValue) {
		$("span[id$='Span']").each(function() {
			$(this).hide();
		});
		$("input[id$='Input']").each(function() {
			$(this).prop("disabled", "disabled");
		});
		if (intervalUnitValue == 1) {
			$("#intervalMinuteSpan").show();
			$("#intervalMinuteInput").prop("disabled", "");
		} else if (intervalUnitValue == 2) {
			$("#intervalHourSpan").show();
			$("#intervalHourInput").prop("disabled", "");
		} else if (intervalUnitValue == 3) {
			$("#hourSpan").show();
			$("#minuteSpan").show();
			$("#hourInput").prop("disabled", "");
			$("#minuteInput").prop("disabled", "");
		} else if (intervalUnitValue == 4) {
			$("#dayOfWeekSpan").show();
			$("#hourSpan").show();
			$("#minuteSpan").show();
			$("#dayOfWeekInput").prop("disabled", "");
			$("#hourInput").prop("disabled", "");
			$("#minuteInput").prop("disabled", "");
		} else if (intervalUnitValue == 5) {
			$("#dayOfMonthSpan").show();
			$("#hourSpan").show();
			$("#minuteSpan").show();
			$("#dayOfMonthInput").prop("disabled", "");
			$("#hourInput").prop("disabled", "");
			$("#minuteInput").prop("disabled", "");
		}
	}

	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#modal-warning").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-warning"
		});
		$("#pageBody").load(__ctxPath + "/jsp/task/list.jsp");
	}
</script>
</head>
<body>
	<div class="page-body">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="widget radius-bordered">
							<div class="widget-header">
								<span class="widget-caption">添加定时任务</span>
							</div>
							<div class="widget-body">
								<form id="theForm" method="post" class="form-horizontal"
									enctype="multipart/form-data">
									<input type="hidden" name="jobClass" />
									<div class="form-group">
										<label class="col-lg-3 control-label">任务类型</label>
										<div class="col-lg-6">
											<select class="form-control" id="type" name="type" data-bv-field="country">
												<option value="">全部</option>
											</select><i class="form-control-feedback" data-bv-field="country" style="display: none;"></i>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">任务名称</label>
										<div class="col-lg-2">
											<input type="text" class="form-control" id="name" name="name"
												placeholder="必填" />
										</div>
									</div>
									<!-- <div class="form-group">
										<tr><label class="col-lg-3 control-label">执行周期</label>
										<div class="col-lg-2">
											
											<td>
											<input name="execycle"  type="radio" value="1" onclick="execycleSelect()" checked="checked"/>
											<input name="execycle"  type="radio" value="2" onclick="execycleSelect()"/>
											<select style="width: 70%" id="intervalUnit" name="intervalUnit" onchange="selectUnit()">
													<option value="1">分</option>
													<option value="2">时</option>
													<option value="3">日</option>
													<option value="4">周</option>
													<option value="5">月</option>
											</select>
										    <span id="dayOfMonthSpan"><input name="dayOfMonth" id="dayOfMonthInput" vld="{range:[1,31]}"/>日</span>
											<span id="dayOfWeekSpan"><input name="dayOfWeek" id="dayOfWeekInput" vld="{range:[1,7]}"/>星期</span>
											<span id="hourSpan"><input name="hour" id="hourInput"  vld="{range:[0,23]}"/>时</span>
											<span id="minuteSpan"><input name="minute" id="minuteInput"  vld="{range:[0,59]}"/>分</span>
											<span id="intervalHourSpan">间隔<input name="intervalHour" vld="{digits:true,range:[0,23]}" id="intervalHourInput"/>小时</span>
											<span id="intervalMinuteSpan">间隔<input name="intervalMinute" vld="{digits:true,range:[0,59]}" id="intervalMinuteInput"/>分钟</span>
											</td>
												
										</div>
										</tr>
        							</div> -->
									<!-- <div class="form-group">
										<label class="col-lg-3 control-label">cron表达式</label>
										<div class="col-lg-2">
											<input name="execycle"  type="radio" value="2" onclick="execycleSelect()"/>
                                            <input name="cronExpression" id="cronExpression"/>
										</div>
        							</div> --> 
        							<div class="form-group">
										<label class="col-lg-3 control-label">执行周期分类</label>
										<div class="col-lg-6">
											<div class="radio">
												<label>执行周期 <div>
												<input name="execycle"  type="radio" value="1" onclick="execycleSelect()"/>
												<select style="width: 70%" id="intervalUnit" name="intervalUnit" onchange="selectUnit()">
														<option value="1">分</option>
														<option value="2">时</option>
														<option value="3">日</option>
														<option value="4">周</option>
														<option value="5">月</option>
												</select>
											    <span id="dayOfMonthSpan"><input name="dayOfMonth" id="dayOfMonthInput" vld="{range:[1,31]}"/>日</span>
												<span id="dayOfWeekSpan"><input name="dayOfWeek" id="dayOfWeekInput" vld="{range:[1,7]}"/>星期</span>
												<span id="hourSpan"><input name="hour" id="hourInput"  vld="{range:[0,23]}"/>时</span>
												<span id="minuteSpan"><input name="minute" id="minuteInput"  vld="{range:[0,59]}"/>分</span>
												<span id="intervalHourSpan">间隔<input name="intervalHour" vld="{digits:true,range:[0,23]}" id="intervalHourInput"/>小时</span>
												<span id="intervalMinuteSpan">间隔<input name="intervalMinute" vld="{digits:true,range:[0,59]}" id="intervalMinuteInput"/>分钟</span>
												</div>
												</label> 
												<label class="col-lg-3 control-label">cron表达式 <div>
												<input name="execycle"  type="radio" value="2" onclick="execycleSelect()"/>
                                                <input name="cronExpression" id="cronExpression"/>
												</div>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">状态</label>
										<div class="col-lg-6">
											<div class="radio">
												<label> <input class="inverted" type="radio"
													checked="checked" name="enable" value="true"> <span
													class="text">启用</span>
												</label> <label> <input class="basic" type="radio"
													name="enable" value="false"> <span class="text">禁用</span>
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">备注</label>
										<div class="col-lg-2">
											<input type="text" class="form-control" id="remark"
												name="remark" placeholder="必填" />
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-offset-4 col-lg-6">
											<input class="btn btn-success" style="width: 25%;" id="save"
												type="button" value="保存" />&emsp;&emsp; <input
												class="btn btn-danger" style="width: 25%;" id="close"
												type="button" value="取消" />
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /Page Body -->
	<script>
		
	</script>
</body>
</html>