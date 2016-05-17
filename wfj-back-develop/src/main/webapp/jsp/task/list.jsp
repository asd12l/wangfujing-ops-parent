<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 定时任务列表
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/jquery-1.9.1.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";
	image = "http://images.shopin.net/images";
	/* 	saleMsgImage="http://172.16.103.163/"; */
	/* 	saleMsgImage="http://172.16.200.4/images"; */
	saleMsgImage = "http://images.shopin.net/images";
	ctx = "http://www.shopin.net";

	var propsdictPagination;
	$(function() {
		initPropsdict();
		$("#pageSelect").change(propsdictQuery);
	});
	function initPropsdict() {
		var url = __ctxPath + "/task/list";
		propsdictPagination = $("#propsdictPagination").myPagination(
				{
					panel : {
						tipInfo_on : true,
						tipInfo : '&nbsp;&nbsp;跳{input}/{sumPage}页',
						tipInfo_css : {
							width : '25px',
							height : "20px",
							border : "2px solid #f0f0f0",
							padding : "0 0 0 5px",
							margin : "0 5px 0 5px",
							color : "#48b9ef"
						}
					},
					debug : false,
					ajax : {
						on : true,
						url : url,
						dataType : 'json',
						ajaxStart: function() {
							$("#loading-container").attr("class","loading-container");
						},
						ajaxStop: function() {
							//隐藏加载提示
							setTimeout(function() {
								$("#loading-container").addClass("loading-inactive")
							},300);
						},
						callback : function(data) {
							//使用模板
							$("#propsdict_tab tbody").setTemplateElement(
									"propsdict-list").processTemplate(data);
						}
					}
				});
	}
	
	function addPropsdict() {
		$("#pageBody").load(__ctxPath + "/jsp/task/add.jsp");
	}
	function editPropsdict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要修改的列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		value = checkboxArray[0];
		adspaceName = $("#adspaceName" + value).text().trim();
		adspaceDesc = $("#adspaceDesc" + value).text().trim();
		adspaceEnabled = $("#adspaceEnabled" + value).text().trim();
		if(adspaceEnabled == "是"){
			adspaceEnabled_ = 1;
		}else if(adspaceEnabled == "否"){
			adspaceEnabled_ = 0;
		}
		
		$("#pageBody").load(__ctxPath + "/jsp/task/edit.jsp");
	}
	function delPropsdict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>只能选择一列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} else if (checkboxArray.length == 0) {
			$("#model-body-warning")
					.html(
							"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>请选取要补充的列!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		}
		var value = checkboxArray[0];
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/task/del",
			dataType : "json",
			ajaxStart: function() {
				$("#loading-container").attr("class","loading-container");
			},
			ajaxStop: function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive")
				},300);
			},
			data : {
				"id" : value
			},
			success : function(response) {
				if (response.success == "true") {
					$("#modal-body-success")
							.html(
									"<div class='alert alert-success fade in'>"
											+ "<i class='fa-fw fa fa-times'></i><strong>删除成功，返回列表页!</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
				} else {
					$("#model-body-warning")
							.html(
									"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>删除失败!</strong></div>");
					$("#modal-warning").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-warning"
					});
				}
				return;
			}
		});
	} 
	
	function tab(data) {
		if (data == 'pro') {//基本
			if ($("#pro-i").attr("class") == "fa fa-minus") {
				$("#pro-i").attr("class", "fa fa-plus");
				$("#pro").css({
					"display" : "none"
				});
			} else {
				$("#pro-i").attr("class", "fa fa-minus");
				$("#pro").css({
					"display" : "block"
				});
			}
		}
	}
	//成功后确认
	function successBtn(){
		$("#modal-success").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-success fade"});
		$("#modal-warning").attr({"style":"display:none;","aria-hidden":"true","class":"modal modal-message modal-warning"});
		$("#pageBody").load(__ctxPath + "/jsp/task/list.jsp");
	}
</script>
</head>
<body>
	<input type="hidden" id="ctxPath"
		value="${pageContext.request.contextPath}" />
	<!-- Main Container -->
	<div class="main-container container-fluid">
		<!-- Page Container -->
		<div class="page-container">
			<!-- Page Body -->
			<div class="page-body" id="pageBodyRight">
				<div class="row">
					<div class="col-xs-12 col-md-12">
						<div class="widget">
							<div class="widget-header">
								<span class="widget-caption"><h5>定时任务管理</h5> </span>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="col-md-2">
										<div class="col-lg-12">
											<a id="editabledatatable_new" onclick="addPropsdict();"
												class="btn btn-primary glyphicon glyphicon-plus"
												style="width: 100%;"> 添加定时任务 </a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="col-lg-12">
											<a id="editabledatatable_new" onclick="editPropsdict();"
												class="btn btn-info glyphicon glyphicon-wrench"
												style="width: 100%;"> 修改定时任务 </a>
										</div>
									</div>
									<div class="col-md-2">
										<div class="col-lg-12">
											<a id="editabledatatable_new" onclick="delPropsdict();"
												class="btn btn-danger glyphicon glyphicon-trash"
												style="width: 100%;"> 删除定时任务 </a>
										</div>&nbsp;
									</div>
									<table class="table table-bordered table-striped table-condensed table-hover flip-content"
										id="propsdict_tab">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th width="7.5%"></th>
												<th style="text-align: center;">任务类型</th>				
												<th style="text-align: center;">任务名称</th>
												<th style="text-align: center;">创建用户</th>
												<th style="text-align: center;">创建时间</th>
												<th style="text-align: center;">状态</th>
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
									<div class="pull-left" style="margin-top: 5px;">
										<form id="propsdict_form" action="">
											<div class="col-lg-12">
												<select id="pageSelect" name="pageSize">
													<option>5</option>
													<option selected="selected">10</option>
													<option>15</option>
													<option>20</option>
												</select>
											</div>
										</form>
									</div>
									<div id="propsdictPagination"></div>
								</div>
								<!-- Templates -->
								<p style="display: none">
									<textarea id="propsdict-list" rows="0" cols="0">
										<!--
										{#template MAIN}
											{#foreach $T.list as Result}
												<tr class="gradeX">
													<td align="left">
														<div class="checkbox" style="margin-bottom: 0;margin-top: 0;padding-left: 3px;">
															<label>
																<input type="checkbox" id="tdCheckbox_{$T.Result.id}" value="{$T.Result.id}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													{#if $T.Result.type==1}
													<td align="center" id="enabled_{$T.Result.id}" value="{$T.Result.type}">
													          首页静态化
													</td>
													{#elseif $T.Result.type==2}
													<td align="center" id="enabled_{$T.Result.id}" value="{$T.Result.type}">
													          单品页静态化
													</td>
													{#elseif $T.Result.type==3}
													<td align="center" id="enabled_{$T.Result.id}" value="{$T.Result.type}">
													          分发
													</td>
													{#/if}
													<td align="center" id="name_{$T.Result.id}">{$T.Result.name}</td>
													<td align="center" id="username_{$T.Result.id}">{$T.Result.username}</td>
													<td align="center" id="creatTime_{$T.Result.id}">{$T.Result.creatTime}</td>
													{#if $T.Result.enabled==true}
													<td align="center" id="enabled_{$T.Result.id}" value="{$T.Result.enabled}">
														启用
													</td>
													{#else}
													<td align="center" id="enabled_{$T.Result.id}" value="{$T.Result.enabled}">
													          禁用
													</td>
													{#/if}
									       		</tr>
											{#/for}
									    {#/template MAIN}	-->
									</textarea>
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- /Page Body -->
			</div>
			<!-- /Page Content -->
		</div>
		<!-- /Page Container -->
		<!-- Main Container -->
	</div>
</body>
</html>