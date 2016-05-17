<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<!-- 
 <script type="text/javascript" src="${ctx}/sysjs/TreeSelector.js"></script>
  <script type="text/javascript" src="${ctx}/outh/userRoleview.js"></script>
  <script type="text/javascript" src="${ctx}/outh/addUserRole.js"></script>
  <script type="text/javascript" src="${ctx}/outh/updateUserRole.js"></script>
  <script type="text/javascript" src="${ctx}/outh/roleGrantWindow.js"></script>
 -->
<script src="${pageContext.request.contextPath}/js/pagination/myPagination/jquery.myPagination6.0.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.js">  </script> 
<script src="${pageContext.request.contextPath}/js/pagination/jTemplates/jquery-jtemplates.js" >   </script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/msgbox/msgbox.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pagination/myPagination/page.css"/>
<style type='text/css'>
#bg{ display: none; position: absolute; top: 0%; left: 0%; width: 100%; height: 100%; background-color: black; z-index:1001; -moz-opacity: 0.7; opacity:.70; filter: alpha(opacity=70);}
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
		initChannel(0);
		initActive(0);
		$("#pageSelect").change(recordsQuery);
	});
	function recordsQuery(){
        var params = $("#page_form").serialize();
        //alert("表单序列化后请求参数:"+params);
        params = decodeURI(params);
        channelPagination.onLoad(params);
   	}
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
						url : __ctxPath + "/searchIndex/brandProRecordList",
						dataType : 'json',
						ajaxStart : function() {
							ZENG.msgbox.show(" 正在加载中，请稍后...", 1, 1000);
						},
						ajaxStop : function() {
							//隐藏加载提示
							setTimeout(function() {
								ZENG.msgbox.hide();
							}, 300);
						},
						callback : function(data) {
							//alert(data.list);
							//使用模板
							$("#channel_tab tbody").setTemplateElement("channel-list").processTemplate(data);
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
						url : __ctxPath + "/searchIndex/brandProList",
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
							$("#active_tab tbody").setTemplateElement("active-list").processTemplate(data);
						}
					}
				});
	}
	function freshBrandIndex(sid){
		//alert(sid);
		var url=__ctxPath + "/searchIndex/freshBrandPro.json";
	  	$.ajax({
	  		type: "post",
	  		contentType: "application/x-www-form-urlencoded;charset=utf-8",
	  		url: url,
	  		dataType: "json",
	  		data:"brandSid="+sid,
	  		success: function(response) {
	  			if(response.success=="true"){
	  				initChannel();
	  		  		alert("操作成功！");
	  			}else{
	  				alert("操作失败！"+response.msg);
	  			}
	  			return;
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
							<div class="" style="float: left; width: 100%; overflow: auto; height: 850px;">
								<div class="col-xs-12 col-md-12" style="padding-left: 0px;">
									<div class="widget">
										<div class="widget-header ">
											<span class="widget-caption"><h5>品牌商品索引管理</h5></span>
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
														href="#channel"> 索引刷新纪录 </a></li>

													<li class="tab-red"><a data-toggle="tab"
														href="#active"> 刷新品牌商品索引 </a></li>
												</ul>

												<div class="tab-content">
												<!-- 频道管理 -->
													<div id="channel" class="tab-pane in active">
													 <div class="widget">
						                                <div class="widget-body" id="pro">
						                             		<div class="btn-group pull-right">
                                       							 <form id="page_form" action="">
	                                        						<select id="pageSelect" name="pageSize">
																		<option>5</option>
																		<option selected="selected">10</option>
																		<option>15</option>
																		<option>20</option>
																	</select>
	                                       						</form>
                                       					   </div>
						                                    <table class="table table-hover table-bordered" id="channel_tab">
						                                        <thead>
						                                            <tr role="row">
						                                            	<th width="35px;"></th>
						                                            	<th>ID</th>
						                                                <th>起动时间</th>
						                                                <th>结束时间</th>	
						                                                <th>状态</th>
						                                            </tr>
						                                        </thead>
						                                        <tbody>
						                                        </tbody>
						                                    </table>
						                                    <div id="channelPagination"></div>
						                                    </div>
						                                    <!-- Templates -->
															<p style="display:none">
																<textarea id="channel-list" rows="0" cols="0">
																	<!--
																	{#template MAIN}
																		{#foreach $T.list as Result}
																			<tr class="gradeX">
																				<td align="left">
																					<div class="checkbox">
																						<label>
																							<input type="checkbox" id="tdCheckbox_{$T.Result.sid}" value="{$T.Result.sid}" >
																							<span class="text"></span>
																						</label>
																					</div>
																				</td>
																				<td align="center">{$T.Result.sid}</td>
																				<td align="center">{$T.Result.starttime}</td>
																				<td align="center">{$T.Result.endtime}</td>
																				<td align="center">
																					{#if $T.Result.status == 0}
													           							<span class="label label-default">执行中</span>
													                      			{#elseif $T.Result.status == 1}
													           							<span class="label label-success">完成</span>
													                   				{#elseif $T.Result.status == -1}
													           							<span class="label label-success">失败</span>
													                   				{#/if}
																				</td>
																       		</tr>
																		{#/for}
																    {#/template MAIN}	-->
																</textarea>
															</p>						                                    
														</div>
													</div>
                                             	<!-- 活动管理 -->
													<div id="active" class="tab-pane">
													 <div class="widget-body" id="pro" style="height: 450px;overflow: auto;">
														<table class="table table-hover table-bordered" id="active_tab">
						                                        <thead>
						                                            <tr role="row">
						                                            	<th width="35px;"></th>
						                                            	<th>品牌SID</th>
						                                                <th>品牌名</th>
						                                                <th>操作</th>	
						                                            </tr>
						                                        </thead>
						                                        <tbody>
						                                        
						                                        </tbody>
						                                    </table>
						                                    <!-- Templates -->
															<p style="display:none">
																<textarea id="active-list" rows="0" cols="0">
																	<!--
																	{#template MAIN}
																		{#foreach $T.result as Result}
																			<tr class="gradeX">
																				<td align="left">
																					<div class="checkbox">
																						<label>
																							<input type="checkbox" id="tdCheckbox_{$T.Result.activeSid}" value="{$T.Result.activeSid}" >
																							<span class="text"></span>
																						</label>
																					</div>
																				</td>
																				<td align="center">{$T.Result.brandSid}</td>
																				<td align="center">{$T.Result.brandName}</td>
																				<td align="center"><a id="editabledatatable_new" onclick="freshBrandIndex({$T.Result.brandSid});" class="btn btn-info glyphicon glyphicon-wrench">刷新索引</a></td>
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
		</div>
		</body>
</html>