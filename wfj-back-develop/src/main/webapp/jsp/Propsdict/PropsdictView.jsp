<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--
WFJBackWeb - 属性字典列表
Version: 1.0.0
Author: WangSy
-->
<html>
<head>
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js"></script>
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var propsdictPagination;
	$(function() {
		initPropsdict();
		$("#pageSelect").change(propsdictQuery);
		$("#channelSid_select").change(propsdictQuery);
		selectAllChannel();
	});
	//查询所有渠道
	function selectAllChannel(){
		$.ajax({
			type : "post",
			url : __ctxPath + "/stock/queryChannelListAddPermission",
			dataType : "json",
			async : false,
			success : function(response) {
				var result = response.list;
				var option = "";
				for (var i = 0; i < result.length; i++) {
					var ele = result[i];
					if(ele.channelName == "全渠道"){
						option = "<option value='"+ele.channelCode+"'>" + ele.channelName + "</option>" + option;
					} else {
						option += "<option value='"+ele.sid+"'>" + ele.channelName + "</option>";
					}
				}
				$("#channelSid_select").append(option);
				return;
			}
		});
	}
	function propsdictQuery() {
		var pName =  $("#propsName_input").val();
        var sessionId = '<%=request.getSession().getId() %>';
        if(pName.indexOf("%") == -1){
            $("#propsName_from").val($("#propsName_input").val());
            $("#channelSid_from").val($("#channelSid_select").val());
            var params = $("#propsdict_form").serialize();
            LA.sysCode = '10';
            LA.log('propsdict.list', '属性字典查询：' + params, getCookieValue("username"),  sessionId);
			params = decodeURI(params);
			propsdictPagination.onLoad(params);
		}else{
			$("#propsName_from").val($("#propsName_input").val());
			$("#channelSid_from").val($("#channelSid_select").val());
			var params = $("#propsdict_form").serialize();
            LA.sysCode = '10';
            LA.log('propsdict.list', '属性字典查询：' + params, getCookieValue("username"),  sessionId);
			//params = decodeURI(params);
			propsdictPagination.onLoad(params);
		}
	}
	function reset() {
		$("#propsName_input").val("");
		$("#channelSid_select").val("");
		propsdictQuery();
	}
	function initPropsdict() {
		var url = __ctxPath + "/propsdict/list";
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
								$("#loading-container").addClass("loading-inactive");
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
		$("#pageBody").load(__ctxPath + "/jsp/Propsdict/addPropsdictView.jsp");
	}
	function editPropsdict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
		    $("#warning2Body").text("只能选择一个属性!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
		    $("#warning2Body").text("请选择要修改的属性!");
			$("#warning2").show();
			return false;
		}
		value = checkboxArray[0];
		propsName = $("#propsName" + value).text().trim();
		propsDesc = $("#propsDesc" + value).text().trim();
		channelSid = $("#channelSid" + value).text().trim();
		isKeyProp = $("#isKeyProp" + value).text().trim();
		isErpProp = $("#isErpProp" + value).text().trim();
		erpType = $("#erpType" + value).text().trim();
		status = $("#status" + value).text().trim();
		$("#pageBody").load(__ctxPath + "/jsp/Propsdict/editPropsdictView.jsp");
	}
	function delPropsdict() {
		var checkboxArray = [];
		$("input[type='checkbox']:checked").each(function(i, team) {
			var productSid = $(this).val();
			checkboxArray.push(productSid);
		});
		if (checkboxArray.length > 1) {
		    $("#warning2Body").text("只能选择一个属性!");
			$("#warning2").show();
			return false;
		} else if (checkboxArray.length == 0) {
		    $("#warning2Body").text("请选择要删除的属性!");
			$("#warning2").show();
			return false;
		}
		var value = checkboxArray[0];
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/propsdict/del",
			dataType : "json",
			ajaxStart: function() {
				$("#loading-container").attr("class","loading-container");
			},
			ajaxStop: function() {
				//隐藏加载提示
				setTimeout(function() {
					$("#loading-container").addClass("loading-inactive");
				},300);
			},
			data : {
				"id" : value
			},
			success : function(response) {
				if (response.data == "1") {
					$("#modal-body-success").html("<div class='alert alert-success fade in'><strong>禁用成功，状态改为无效!</strong></div>");
					$("#modal-success").attr({
						"style" : "display:block;",
						"aria-hidden" : "false",
						"class" : "modal modal-message modal-success"
					});
				} else {
				    $("#warning2Body").text("删除失败，该类型不能删除!");
					$("#warning2").show();
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
	function successBtn() {
		$("#modal-success").attr({
			"style" : "display:none;",
			"aria-hidden" : "true",
			"class" : "modal modal-message modal-success fade"
		});
		$("#pageBody").load(__ctxPath + "/jsp/Propsdict/PropsdictView.jsp");
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
								<h5 class="widget-caption">属性字典管理</h5>
								<div class="widget-buttons">
									<a href="#" data-toggle="maximize"></a> <a href="#"
										data-toggle="collapse" onclick="tab('pro');"> <i
										class="fa fa-minus" id="pro-i"></i>
									</a> <a href="#" data-toggle="dispose"></a>
								</div>
							</div>
							<div class="widget-body" id="pro">
								<div class="table-toolbar">
									<div class="clearfix">
										<a id="editabledatatable_new" onclick="addPropsdict();"
												class="btn btn-primary glyphicon glyphicon-plus"> 添加属性 </a>&nbsp;&nbsp;&nbsp;&nbsp;
												<a id="editabledatatable_new" onclick="editPropsdict();"
												class="btn btn-info glyphicon glyphicon-wrench"> 修改属性 </a>&nbsp;&nbsp;&nbsp;&nbsp;
												<a id="editabledatatable_new" onclick="delPropsdict();"
												class="btn btn-danger glyphicon glyphicon-trash"> 禁用属性 </a>
									</div>	
									<div class="mtb10">
										<span>属性名称:</span>
										<input type="text" id="propsName_input" />&nbsp;&nbsp;&nbsp;&nbsp;
										<span>渠道名称:</span>
										<select id="channelSid_select" style="width: 166px;">
											<option value="">全部</option>
										</select>&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="btn btn-default shiny" onclick="propsdictQuery();">查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a class="btn btn-default shiny" onclick="reset();">重置</a>
									</div>									
									<table class="table table-bordered table-striped table-condensed table-hover flip-content"
										id="propsdict_tab">
										<thead class="flip-content bordered-darkorange">
											<tr role="row">
												<th style="text-align: center;" width="5%">选择</th>
												<th style="text-align: center;">名称</th>
												<th style="text-align: center;">描述</th>
												<th style="text-align: center;">类型</th>
												<th style="text-align: center;">状态</th>
												<th style="text-align: center;">ERP属性</th>
												<th style="text-align: center;">关键属性</th>
												<th style="text-align: center;">ERP类型</th>
												<th style="text-align: center;">渠道名称</th>
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
											<input type="hidden" id="propsName_from" name="propsName" />
											<input type="hidden" id="channelSid_from" name="channelSid" />
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
															<label style="padding-left:9px;">
																<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																<span class="text"></span>
															</label>
														</div>
													</td>
													<td align="center" id="propsName{$T.Result.sid}">{$T.Result.propsName}</td>
													<td align="center" id="propsDesc{$T.Result.sid}">{$T.Result.propsDesc}</td>
													<td align="center" id="isEnumProp{$T.Result.sid}">
														{#if $T.Result.isEnumProp == 1}文本
						                      			{#elseif $T.Result.isEnumProp == 0}枚举
						                   				{#/if}
													</td>
													<td align="center" id="status{$T.Result.sid}">
														{#if $T.Result.status == 0}
						           							<span class="label label-darkorange graded">无效</span>
						                      			{#elseif $T.Result.status == 1}
						           							<span class="label label-success graded">有效</span>
						                   				{#/if}
													</td>
													<td align="center" id="isErpProp{$T.Result.sid}">
														{#if $T.Result.isErpProp == 0}
						           							<span class="label label-darkorange graded">否</span>
						                      			{#elseif $T.Result.isErpProp == 1}
						           							<span class="label label-success graded">是</span>
						                   				{#/if}
													</td>
													<td align="center" id="isKeyProp{$T.Result.sid}">
														{#if $T.Result.isKeyProp == 0}
						           							<span class="label label-darkorange graded">否</span>
						                      			{#elseif $T.Result.isKeyProp == 1}
						           							<span class="label label-success graded">是</span>
						                   				{#/if}
													</td>
													<td align="center" id="erpType{$T.Result.sid}">
														{#if $T.Result.erpType == 0}
						           							门店
						                      			{#elseif $T.Result.erpType == 1}
						           							SAP
						           						{#elseif $T.Result.erpType == 2}
						                   				{#/if}
													</td>
													<td align="center" id="channelName{$T.Result.sid}">{$T.Result.channelName}</td>
													<td align="center" id="channelSid{$T.Result.sid}" style="display:none">{$T.Result.channelSid}</td>
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