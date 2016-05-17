<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<html>
<head>
<script
	src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">
	
</script>
<script
	src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js">
	
</script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css" />
<style type='text/css'>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title></title>
<!--  
  <script type="text/javascript" src="${ctx}/sysjs/TreeSelector.js"></script>
  <script type="text/javascript" src="${ctx}/outh/backUserview.js"></script>
  <script type="text/javascript" src="${ctx}/outh/addBackUser.js"></script>
  <script type="text/javascript" src="${ctx}/outh/addLogisticsUser.js"></script>
 <script type="text/javascript" src="${ctx}/outh/backUserGrantRoleWindow.js"></script>
  <script type="text/javascript" src="${ctx}/outh/updateUserRole.js"></script>
  -->
<script
	src="${pageContext.request.contextPath}/assets/js/fuelux/treeview/bootstrap-treeview.js"></script>
<script type="text/javascript">
	__ctxPath = "${pageContext.request.contextPath}";

	var tree = [];
	var resourcePagination;
	var channelPagination;
	var activePagination;
	var advPagination;
	var nodeId = 1;
	$(function() {

		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/web/getAllLimitResources",
			dataType : "json",
			data : $("#theForm").serialize(),
			success : function(response) {
				$('#tree').treeview({
					data : response.list,
					
					expandIcon: 'glyphicon glyphicon-plus',
					collapseIcon: 'glyphicon glyphicon-minus',
					emptyIcon: 'glyphicon glyphicon-file',
					nodeIcon: 'success',
					onNodeSelected : function(event, node) {
						initChannel(node.id);
						nodeId=node.id;
					}
				});
			}
		});
		initChannel(1);
	});
	function resourceQuery(data) {
		if (data != '') {
			$("#cid").val(data);
		} else {
			$("#cid").val(0);
		}
		var params = $("#category_form").serialize();
		params = decodeURI(params);
		resourcePagination.onLoad(params);
	}

	//折叠面板函数
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

	//频道信息初始化
	function initChannel(channelSid) {
		channelPagination = $("#channelPagination").myPagination(
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
						contentType : "application/json;charset=utf-8",
						url : __ctxPath + "/web/queryTemplate?channelSid="  //PageLayout?channelSid="
								+ channelSid,
						dataType : 'json',
						ajaxStart : function() {
							//ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								ZENG.msgbox.hide();
							}, 300);
						},  
						callback : function(data) {
							//使用模板
							$("#channel_tab tbody").setTemplateElement(
									"channel-list")
									.processTemplate(data);
						}
					}
				});
	}

	//编辑频道栏目
	function editPageLayout(propsSid, categorySid, channelSid) {
		
	}
	//查看频道下楼层按钮
	function toFloor(){
		if(nodeId==""){
			nodeId=1;
		}
		var url = __ctxPath+"/jsp/web/floorList.jsp?sid="+nodeId;
		$("#pageBody").load(url);
	}
	
	//修改模板生效状态
	function editType(obj){
		var tplName = $(obj).attr("data");
		
		/* if(isUse=="true"){
			$("#model-body-warning")
			.html(
					"<div class='alert alert-warning fade in'><i class='fa-fw fa fa-times'></i><strong>已启用!</strong></div>");
			$("#modal-warning").attr({
				"style" : "display:block;",
				"aria-hidden" : "false",
				"class" : "modal modal-message modal-warning"
			});
			return false;
		} */
		bootbox.confirm("确定启用吗？", function(r){
			if(r){
				$.ajax({
					type : "post",
					contentType : "application/x-www-form-urlencoded;charset=utf-8",
					url : __ctxPath + "/web/modifyType",
					dataType : "json",
					data : {
						"tplName" : tplName,
						"channelSid" : nodeId
					},
					ajaxStart : function() {
						$("#loading-container").attr("class",
								"loading-container");
					},
					ajaxStop : function() {
						//隐藏加载提示
						setTimeout(function() {
							$("#loading-container")
									.addClass("loading-inactive")
						}, 300);
					},
					success : function(response) {
						if(response.success){
							var url = __ctxPath+"/jsp/web/floor.jsp";
							$("#pageBody").load(url);
						}
					}
				}); 
			}
		});
	}
</script>
</head>
<body>
	<div class="page-body" style="position: fixed;">
		<div class="row">
			<div class="col-lg-12 col-sm-12 col-xs-12">
				<div class="row">
					<div class="col-lg-12 col-sm-12 col-xs-12">
						<div class="container">
							<div class="col-md-3" style="padding-left: 0px; width: 30%">
								<div class="well with-header">
									<div class="header bordered-green">频道管理</div>
									<div id="tree"
										style="height: 500px; overflow: auto; border: 1px;"></div>
								</div>
							</div>
							<div class=""
								style="float: left; width: 68%; overflow: auto; height: 550px;">
								<div class="col-xs-12 col-md-12" style="padding-left: 0px;">
									<div class="widget">
										<div class="widget-header ">
											<span class="widget-caption"><h5>模板选择</h5></span>
											<div class="widget-buttons">
												<a href="#" data-toggle="maximize"></a> <a href="#"
													data-toggle="collapse" onclick="tab('pro');"> <i
													class="fa fa-minus" id="pro-i"></i>
												</a> <a href="#" data-toggle="dispose"></a>
											</div>
										</div>
										<form id="category_form" action="">
											<input type="hidden" id="cid" name="cid" />
										</form>
										<div class="widget-body" id="pro">
											<div class="tabbable">
												<ul class="nav nav-tabs" id="myTab">
													<li class="active"><a data-toggle="tab"
														href="#channel"> 频道管理 </a></li>
												</ul>
												<div class="tab-content">
													<!-- 频道管理 -->
													<div id="channel" class="tab-pane in active">
														<div class="widget-body" id="pro">
															<div class="btn-group pull-right">
																<a id="editabledatatable_edit" onclick="toFloor();" 
																		class="btn btn-info glyphicon glyphicon-wrench">查看</a>
																<!-- <span> <a href="javascript:void(0);"
																	class="btn btn-labeled btn-palegreen;"> <i
																		class="btn-label glyphicon glyphicon-ok"></i>保存选中
																</a>
																</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span> <a
																	id="editabledatatable_new" onclick="updateRole();"
																	class="btn btn-info glyphicon glyphicon-wrench">
																		页面预览 </a>
																</span> -->
															</div>
															<table class="table table-hover table-bordered"
																id="channel_tab" style="margin-top:10px">
																<thead>
																	<tr role="row">
																		<th width="35px;"></th>
																		<th>是否有效</th>
																		<th>模板名称</th>
																		<th>最后修改时间</th>
																		<th>操作</th>
																	</tr>
																</thead>
																<tbody>
																</tbody>
															</table>
															<!-- Templates -->
															<p style="display: none">
																<textarea id="channel-list" rows="0" cols="0">
																	<!-- 
																	{#template MAIN}
																		{#foreach $T.list as Result}
																			<tr class="gradeX">
																				<td align="left">
																					<div class="checkbox">
																						<label>
																							<input type="checkbox" id="tdCheckbox_{$T.Result.name}" value="{$T.Result.name}" >
																							<span class="text"></span>
																						</label>
																					</div>
																				</td>
																				<td align="center">
																					{#if $T.Result.isUse == "false"}
													           							<span class="label label-default"> 未生效</span>
													                      			{#else if $T.Result.isUse == "true"}
													           							<span class="label label-success">已有效</span>
													                   				{#/if}
																				</td>
																				<td align="center" id="sid_{$T.Result.name}">{$T.Result.name}</td>
																				<td align="center">{$T.Result.lastModify}</td>
																				<td align="center">
																					<span> 
																						   <button id="template_edit" 
																						   		class="temp" data="{$T.Result.name}"  onclick="editType(this)">启用模板</button>
																					</span>
																				</td>
																       		</tr>
																		{#/for}
																    {#/template MAIN}	 -->
																</textarea>
															</p>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>