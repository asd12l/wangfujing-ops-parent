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
	var channelPagination;
	var activePagination;
	var advPagination;
	var nodeId = "";
	$(function() {
		//初始化树形频道
		$.ajax({
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=utf-8",
			url : __ctxPath + "/channel/channeltree",
			async : false,
			dataType : "json",
			success : function(response) {
				$('#tree').treeview({
					data : response,
					onNodeSelected : function(event, node) {
						nodeId = node.id;
						initChannel(nodeId);
						initActive(nodeId);
						initAdv(nodeId);
					}
				});
				initChannel(0);
				initActive(0);
				initAdv(0);
			}
		});
	});
	
	//折叠面板函数
	function tab(data){
		if(data=='pro'){//基本
			if($("#pro-i").attr("class")=="fa fa-minus"){
				$("#pro-i").attr("class","fa fa-plus");
				$("#pro").css({"display":"none"});
			}else{
				$("#pro-i").attr("class","fa fa-minus");
				$("#pro").css({"display":"block"});
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
						url : __ctxPath + "/flashPageLayout/queryPageLayout?channelSid="+channelSid,
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
									"channel-list").processTemplate(data);
						}
					}
				});
	}
	
	//编辑频道栏目
	function editPageLayout(propsSid, categorySid, channelSid) {
		
	}	
	
	
	//初始化活动列表
	function initActive(channelSid) {
		activePagination = $("#activePagination").myPagination(
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
						url : __ctxPath + "/flashPageLayout/queryPromotionByChannel?channelSid="+channelSid,
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
							$("#active_tab tbody").setTemplateElement(
									"active-list").processTemplate(data);
							$('.desc').each(function(){
								$(this).html($(this).text());
							});
						}
					}
				});
	}
	
	//按钮事件-添加活动
	function addAdv(){
		bootbox.confirm("确定添加活动吗？", function(r){
			if(r){
				var url = __ctxPath+"/jsp/web/addAdv.jsp";
				$("#pageBody").load(url);
			}
		});
	}
	//删除活动
	function delActive(propsSid, categorySid, Sid) {

	}
	//初始化广告列表
	function initAdv(channelSid) {
		advPagination= $("#advPagination").myPagination(
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
						url : __ctxPath + "/channel/queryAdsByChannelSid?channelSid="+channelSid,
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
								$("#adv_tab tbody").setTemplateElement(
										"adv-list").processTemplate(data);
								/* $('.desc').each(function(){
									$(this).html($(this).text());
								});*/
							} 
						
					}});
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
							<div class="col-md-3"
								style="padding-left: 0px; width: 28%; margin-top: 2px;">
								<div class="well with-header">
									<div class="header bordered-green">频道管理</div>
									<div class=" " id="tree"></div>
								</div>
							</div>
							<div class=""
								style="float: left; width: 68%; overflow: auto; height: 550px;">
								<div class="col-xs-12 col-md-12" style="padding-left: 0px;">
									<div class="widget">
										<div class="widget-header ">
											<span class="widget-caption"><h5>选品管理</h5></span>
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

													<li class="tab-red"><a data-toggle="tab"
														href="#active"> 活动管理 </a></li>

													<li class="tab-green"><a data-toggle="tab" href="#adv">广告管理
													</a></li>

												</ul>

												<div class="tab-content">
													<!-- 频道管理 -->
													<div id="channel" class="tab-pane in active">
														<div class="widget-body" id="pro">
															<div class="btn-group pull-right">

																<span> <a href="javascript:void(0);"
																	class="btn btn-labeled btn-palegreen;"> <i
																		class="btn-label glyphicon glyphicon-ok"></i>保存选中
																</a>
																</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span> <a
																	id="editabledatatable_new" onclick="updateRole();"
																	class="btn btn-info glyphicon glyphicon-wrench">
																		页面预览 </a>
																</span>
															</div>
															<table class="table table-hover table-bordered"
																id="channel_tab;style=margin-top:10px">
																<thead>
																	<tr role="row">
																		<th width="35px;"></th>
																		<th>是否有效</th>
																		<th>编号</th>
																		<th>标题</th>
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
																							<input type="checkbox" id="tdCheckbox_{$T.Result.channelSid}" value="{$T.Result.channelSid}" >
																							<span class="text"></span>
																						</label>
																					</div>
																				</td>
																				<td align="center">
																					{#if $T.Result.pageType == 0}
													           							<span class="label label-default"> 未生效</span>
													                      			{#elseif $T.Result.pageType == 1}
													           							<span class="label label-success">已有效</span>
													                   				{#/if}
																				</td>
																				<td align="center">{$T.Result.sid}</td>
																				<td align="center">{$T.Result.title}</td>
																       		</tr>
																		{#/for}
																    {#/template MAIN}	-->
																</textarea>
															</p>
														</div>
													</div>
													<!-- 活动管理 -->
													<div id="active" class="tab-pane">
														<div class="widget-body" id="pro">
															<div class="btn-group pull-right">
																<span> <a class="btn btn-danger"
																	href="javascript:void(0);"><i class="fa fa-times"></i>
																		删除活动</a> </a>
																</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span> <a
																	class="btn btn-default purple"
																	onclick="addAdv();"><i class="fa fa-plus"></i>
																		增加活动</a>
																</span>
															</div>
															<table class="table table-hover table-bordered"
																id="active_tab">
																<thead>
																	<tr role="row">
																		<th width="35px;"></th>
																		<th>Sid</th>
																		<th>活动标题</th>
																		<th>开始时间</th>
																		<th>结束时间</th>
																		<th>活动描述</th>
																	</tr>
																</thead>
																<tbody>

																</tbody>
															</table>
															<!-- Templates -->
															<p style="display: none">
																<textarea id="active-list" rows="0" cols="0">
																	<!--
																	{#template MAIN}
																		{#foreach $T.list as Result}
																			<tr class="gradeX">
																				<td align="left">
																					<div class="checkbox">
																						<label>
																							<input type="checkbox" id="tdCheckbox_{$T.Result.activeSid}" value="{$T.Result.activeSid}" >
																							<span class="text"></span>
																						</label>
																					</div>
																				</td>
																				<td align="center">{$T.Result.sid}</td>
																				<td align="center">{$T.Result.promotionTitle}</td>
																				<td align="center">{$T.Result.promotionBeginTime}</td>
																				<td align="center">{$T.Result.promotionEndTime}</td>
																				<td align="center" class='desc'>{$T.Result.promotionDesc}</td>
																       		</tr>
																		{#/for}
																    {#/template MAIN}	-->
																</textarea>
															</p>
														</div>
													</div>
													<!-- 广告管理 -->
													<div id="adv" class="tab-pane">
														<div class="widget-body" id="pro">
															<div class="btn-group pull-right">
																<span> <a id="editabledatatable_new"
																	onclick="updateRole();"
																	class="btn btn-info glyphicon glyphicon-wrench">
																		修改广告 </a>
																</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																<span> <a href="javascript:void(0);"
																	class="btn btn-labeled btn-palegreen"> <i
																		class="btn-label glyphicon glyphicon-ok"></i>添加广告
																</a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																 <span> <a href="javascript:void(0);"
																	class="btn btn-labeled btn-darkorange"> <i
																		class="btn-label glyphicon glyphicon-remove"></i>删除广告
																</a></span>
															</div>
															<table class="table table-hover table-bordered"
																id="adv_tab">
																<thead>
																	<tr role="row">
																		<th width="35px;"></th>
																		<th>Sid</th>
																		<th>名称</th>
																		<th>图片</th>
																		<th>链接</th>
																		<th>备注</th>
																	</tr>
																</thead>
																<tbody>

																</tbody>
															</table>
															<!-- Templates -->
															<p style="display: none">
																<textarea id="adv-list" rows="0" cols="0">
																	<!--
																	{#template MAIN}
																		{#foreach $T.list as Result}
																			<tr class="gradeX">
																				<td align="left">
																					<div class="checkbox">
																						<label>
																							<input type="checkbox" id="tdCheckbox_{$T.Result.advSid}" value="{$T.Result.advSid}" >
																							<span class="text"></span>
																						</label>
																					</div>
																				</td>
																				<td align="center">{$T.Result.sid}</td>
																				<td align="center">{$T.Result.shopChannelSid}</td>
																				<td align="center">{$T.Result.positioname}</td>
																				<td align="center">{$T.Result.pic}</td>
																				<td align="center" class='desc'>{$T.Result.link}</td>
																       		</tr>
																		{#/for}
																    {#/template MAIN}	-->
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